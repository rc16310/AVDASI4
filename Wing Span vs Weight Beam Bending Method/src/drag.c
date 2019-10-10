#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "constants.h"

double FUNC_drag(double total_weight, double span){
	double drag;
	drag = (pow(total_weight,2))/(0.5*AIR_DENSITY*pow(VELOCITY,2)*M_PI*pow(span,2));
	return drag;
}