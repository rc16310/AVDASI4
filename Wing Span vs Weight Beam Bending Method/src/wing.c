#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "functions.h"
#include "constants.h"

double *FUNC_chord(double root_chord,
				   int number_of_points,
				   double *z){
	
	// Program required
	int i;
	
	// Create sectional chord array
	double *chord = malloc(number_of_points*sizeof(double));
	
	// Raises exception incase something goes horribly wrong
	if(!chord)
      return NULL;
		
	// Fill spanwise distances array
	// The matrix (from 0 to whatever) represents root to tip
	for( i = 0; i < number_of_points; ++i ){
		// chord - spanwise chord sections
		chord[i] = root_chord * pow(1-pow(z[i]/z[number_of_points-1], 2), 0.5);
	}
	
	return chord;
}