'''
Program to rank aerofoils for a range of aircraft masses

Uses XFOIL and ranks aerofoils from least to highest drag
Assumes lift = aircraft weight

.dat files created using xfoil
>> XFOIL >> naca XXXX >> save XXXX.dat

Uses daniel-de-vries/xfoil-python (pip install xfoil)
Tested and created on Windows 10 using Python 3.6 64bit
'''

import numpy as np

from csv import reader
from math import isnan
from math import pi
from xfoil import XFoil
from xfoil.model import Airfoil

# Reads aerofoils to analyse from TOWS ('Theory of Wing Sections') file
# .dat file for aerofoil in TOWS file must be in nacaFoils folder
def importAerofoilTOWS():
    allAerofoils_str = []
    with open('TOWS.csv', 'r') as file:
        readIn = reader(file)
        for row in readIn:
            allAerofoils_str.append(', '.join(row))
    return allAerofoils_str
        
class aerofoil:
    def __init__(self, name):
        self.name = name

    def aerofoilDat(self):
        file_data = np.genfromtxt("nacaFoils\\"+str(self.name)+".dat",\
                                  usecols=(0,1), skip_header=1, dtype=float)
        return file_data

    def aerofoilModelling(self):
        file_data = self.aerofoilDat()
        self.aerofoilModel = Airfoil(file_data[:,0], file_data[:,1])

    def computation(self, cl):
        xf.airfoil = self.aerofoilModel
        self.a, self.cl, self.cd, cm, cp = xf.cseq(*cl)

def createAerofoilObj(allAerofoils_str):
    allAerofoils_obj = []
    for i in range(len(allAerofoils_str)):
        allAerofoils_obj.append(aerofoil(allAerofoils_str[i]))
        allAerofoils_obj[i].aerofoilModelling()
    return allAerofoils_obj

def initialiseAerofoils():
    allAerofoils_str = importAerofoilTOWS()
    allAerofoils_obj = createAerofoilObj(allAerofoils_str)
    return allAerofoils_obj


def liftCoCalc ():
    massList = [massMin]
    numberMassPoints = int(((massMax-massMin)/massSpacing))
    for i in range(numberMassPoints):
        massList.append(massList[i]+massSpacing)
    massMaxAdditional = massMax + massSpacing
    mass = np.array([massMin, massMaxAdditional, massSpacing])
    cl = (((mass*g)/span)/(mean_chord*0.5*rho*velocity**2))
    cl = [ round(elem, 4) for elem in cl ]
    return cl, massList

def runAnalysis():
    for i in range(len(allAerofoils_obj)):
        print("{0: >2}. Computing naca {1.name}".format(i, allAerofoils_obj[i], width=5))
        allAerofoils_obj[i].computation(cl)

def convergenceCheck(allAerofoils_obj, i, mass):
    for x in allAerofoils_obj:
        if isnan(x.cd[i]):
            print("Aircraft mass {0: >3} kg - naca {1: >5} NOT CONVERGED - {1: >5} neglected".format(mass, x.name))
    filteredAerofoils_obj = [x for x in allAerofoils_obj if not isnan(x.cd[i])]
    return filteredAerofoils_obj

def rankAerofoils(filteredAerofoils_obj, i, mass):
    filteredAerofoils_obj.sort(key=lambda filteredAerofoils_obj: filteredAerofoils_obj.cd[i])
    return filteredAerofoils_obj

def sortResults():
    print("Error report:")
    filteredAerofoils_obj = []
    rankedAerofoils_obj = []
    for i in range(len(massList)):
        filteredAerofoils_obj.append(convergenceCheck(allAerofoils_obj, i, massList[i]))
        rankedAerofoils_obj.append(rankAerofoils(filteredAerofoils_obj[i], i, massList[i]))
    rankedAerofoils_names = []
    for i in range(len(rankedAerofoils_obj)):
        rankedAerofoils_names.append([o.name for o in rankedAerofoils_obj[i]])
    return rankedAerofoils_obj, rankedAerofoils_names

def displayResults():
    print("The best aerofoil for a given mass is shown below")
    header = "{0: >7}"
    for x in range(len(massList)):
        massList[x] = str(massList[x])+"kg"
        if x != 0:    
            header = header + " {"+str(x)+": >7}"
    print(str(header).format(*massList))
    for v in zip(*rankedAerofoils_names):
            print (str(header).format(*v))

span = 52
rho = 0.4135
velocity = 230
g = 9.81
reynolds_div_chord = 7331382
mean_chord = 3
#https://www.grc.nasa.gov/WWW/K-12/airplane/reynolds.html
massMin = 70000
massMax = 90000
massSpacing = 10000

xf = XFoil()

#Reynolds number, unit chord (see XFOIL docs UNITS section)
xf.Re = reynolds_div_chord * mean_chord
xf.max_iter = 100

print("Reynolds Number: {0}\nMax iterations: {1}\n".format(xf.Re, xf.max_iter))
      
cl, massList = liftCoCalc()
allAerofoils_obj = initialiseAerofoils()
runAnalysis()
print("\n")
rankedAerofoils_obj, rankedAerofoils_names = sortResults()
print("\n")
displayResults()
