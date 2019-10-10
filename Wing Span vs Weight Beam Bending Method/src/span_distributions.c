#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "constants.h"

double *FUNC_spanLocations(double dz,
					       int number_of_points){

	// Program required
	int i;
	
	// Create spanwise distances array
	double *z = malloc(number_of_points*sizeof(double));
	
	// Raises exception incase something goes horribly wrong
	if(!z)
      return NULL;
		
	// Fill spanwise distances array
	// The matrix (from 0 to whatever) represents root to tip
	for( i = 0; i < number_of_points; ++i ){
		// z - spanwise locations
		z[i] = dz * i;
	}
	
	return z;
}


double *FUNC_lift_moment_distribution(double weight,
								 double span,
								 double root_chord,
								 int number_of_points,
								 double *z){	
	
	// Program required
	int i;
	
	double global_CL;
	global_CL = weight/(0.5*AIR_DENSITY*pow(VELOCITY,2)*span*(M_PI/4)*root_chord);
	
	// Calculates the required central sectional lift coefficient to attain the desired global CL
	double centre_lift_2d = global_CL * 4/(span*M_PI/2);
	//printf("Centre sectional lift coefficient: %f\n", centre_lift_2d);
	
	// Creates memory space for distributed_moment array to be returned
	double *distributed_moment = malloc(number_of_points*sizeof(double));
	  
	// Raises exception incase something goes horribly wrong
	if(!distributed_moment)
      return NULL;
	
	weight = 1000;
	for( i = 0; i < number_of_points; ++i ){
	  //distributed_moment[i] = ((16*weight)/(pow(M_PI, 2)*pow(span,2))) * (pow(z[i],2)/2 - (pow(z[i],4))/(3*pow(span,2)) - (span*z[i])/3 + pow(span,2)/16);
	  distributed_moment[i] = (weight*(z[i]*M_PI*3.0-span*sqrt(1.0/(span*span)*(z[i]*z[i])*-4.0+1.0)*3.0+span*pow(1.0/(span*span)*(z[i]*z[i])*-4.0+1.0,3.0/2.0)-z[i]*asin((z[i]*2.0)/span)*6.0)*(-1.0/6.0))/M_PI;
	}
	
	// Return the gold..
	return distributed_moment;
}

double *FUNC_weight_moment_distribution(int number_of_points, double *wing_weight, double *z, double dz){	
	int i;
	
	// Creates memory space for distributed_moment array to be returned
	double *distributed_moment = malloc(number_of_points*sizeof(double));
	double distributed_shear_force[number_of_points];
	  
	// Raises exception incase something goes horribly wrong
	if(!distributed_moment)
      return NULL;
  
  
	
	distributed_shear_force[number_of_points-1] = wing_weight[number_of_points-1];
	distributed_moment[number_of_points-1] = z[number_of_points-1] * wing_weight[number_of_points-1];
	//printf("i: %i, location: %f, distributed shear: %f, distributed moment: %f\n", number_of_points-1, z[number_of_points-1], distributed_shear_force[number_of_points-1], distributed_moment[number_of_points-1]);
	
	for( i = number_of_points-1; i > 0; --i ){
		distributed_shear_force[i-1] = distributed_shear_force[i] + wing_weight[i-1] * dz;
		//distributed_moment[i-1] = distributed_moment[i] + (span/2 - z[i-1]) * load[i-1] * dz;
		distributed_moment[i-1] = distributed_moment[i] + distributed_shear_force[i] * dz;
		//printf("i: %i, location: %f, distributed shear: %f, distributed moment: %f\n", i-1, z[i-1], distributed_shear_force[i-1], distributed_moment[i-1]);
	}
	
	// Return the gold..
	return distributed_moment;
}


double *FUNC_total_moment_distribution(int number_of_points, double total_weight, double span, double root_chord, double *wing_weight, double *z, double dz){	
	int i;
	
	double *wing_moment, *lift_moment;
	//put in main function req.
	// Creates memory space for distributed_moment array to be returned
	double *distributed_moment = malloc(number_of_points*sizeof(double));
	  
	// Raises exception incase something goes horribly wrong
	if(!distributed_moment)
      return NULL;
  
	lift_moment = FUNC_lift_moment_distribution(total_weight, span, root_chord, number_of_points, z);
	wing_moment = FUNC_weight_moment_distribution(number_of_points, wing_weight, z, dz);
	
	for( i = 0; i < number_of_points; ++i ){
	  distributed_moment[i] = lift_moment[i]; - wing_moment[i];
	}
	
	// Free memory
	free(wing_moment);
	free(lift_moment);
	
	// Return the gold..
	return distributed_moment;
}
