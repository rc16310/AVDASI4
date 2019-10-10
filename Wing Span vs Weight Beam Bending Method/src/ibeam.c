#include <math.h>
#include <stdlib.h>
#include "constants.h"
#include "functions.h"

// Height of I-Beam along span
double *FUNC_ibeam_C(int number_of_points, double *z, double *chord, double thick_over_chord, int ib_cutoff){
	
	// Program required
	int i;	
	
	//ib_dim stands for I-Beam Dimension
	// Creates memory space for distributed_moment array to be returned
	double *ib_dim_C = malloc(number_of_points*sizeof(double));
	  
	// Raises exception incase something goes horribly wrong
	if(!ib_dim_C)
		return NULL;
	
	// Creates height dimension array upto cutoff point
	for( i = 0; i < ib_cutoff; ++i ){
		ib_dim_C[i] = chord[i]* thick_over_chord * C;	
	}
	
	for( i = ib_cutoff; i < number_of_points; ++i ){
		ib_dim_C[i] = 0;	
	}
	return ib_dim_C;
}

// Width of I-Beam along span
double *FUNC_ibeam_D(int number_of_points, double *z, double *chord, int ib_cutoff){
	
	// Program required
	int i;	
	
	//ib_dim stands for I-Beam Dimension
	// Creates memory space for distributed_moment array to be returned
	double *ib_dim_D = malloc(number_of_points*sizeof(double));
	  
	// Raises exception incase something goes horribly wrong
	if(!ib_dim_D)
		return NULL;
	
	// Creates width dimension array upto cutoff point
	for( i = 0; i < ib_cutoff; ++i ){
		ib_dim_D[i] = chord[i] * D;	
	}
	
	for( i = ib_cutoff; i < number_of_points; ++i ){
		ib_dim_D[i] = 0;	
	}
	return ib_dim_D;
}

// Height of web along span
double *FUNC_ibeam_B(int number_of_points, double *M, double *z, double *ib_dim_C, double *ib_dim_D, int ib_cutoff){
	
	// Program required
	int i;	
	
	//ib_dim stands for I-Beam Dimension (the one we are optimising)
	// Creates memory space for distributed_moment array to be returned
	double *ib_dim_B = malloc(number_of_points*sizeof(double));
	  
	// Raises exception incase something goes horribly wrong
	if(!ib_dim_B)
		return NULL;


	double sig;
	sig = SIGMA_MAX / (SAFTEY_FACTOR*LIMIT_LOAD);
	
	// Calculates web height dimension array upto cutoff point
	for( i = 0; i < ib_cutoff; ++i ){
		ib_dim_B[i] = pow(sqrt((ib_dim_C[i]*ib_dim_C[i])*1.0/(sig*sig)*1.0/pow(A*4.0-ib_dim_D[i]*7.0,4.0)*((A*A)*(M[i]*M[i])*5.76E2+(ib_dim_D[i]*ib_dim_D[i])*(M[i]*M[i])*1.764E3+(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*(sig*sig)*6.4E1-A*ib_dim_D[i]*(M[i]*M[i])*2.016E3+(A*A)*(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i])*(sig*sig)*4.9E1-(ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*M[i]*sig*6.24E2-A*(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*(sig*sig)*1.04E2+A*(ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i])*M[i]*sig*8.52E2-(A*A)*(ib_dim_C[i]*ib_dim_C[i])*ib_dim_D[i]*M[i]*sig*3.36E2))*2.0+(ib_dim_C[i]*M[i]*2.4E1-(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*ib_dim_D[i]*sig*7.0)/(sig*(A*4.0-ib_dim_D[i]*7.0)*2.0)-(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i])*1.0/pow(A*4.0-ib_dim_D[i]*7.0,2.0)*(2.7E1/2.0)-(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*1.0/pow(A*4.0-ib_dim_D[i]*7.0,3.0)*2.7E1,1.0/3.0)-(ib_dim_C[i]*ib_dim_D[i]*3.0)/(A*4.0-ib_dim_D[i]*7.0)+(ib_dim_C[i]*ib_dim_C[i])*ib_dim_D[i]*(A-ib_dim_D[i])*1.0/pow(A*4.0-ib_dim_D[i]*7.0,2.0)*1.0/pow(sqrt((ib_dim_C[i]*ib_dim_C[i])*1.0/(sig*sig)*1.0/pow(A*4.0-ib_dim_D[i]*7.0,4.0)*((A*A)*(M[i]*M[i])*5.76E2+(ib_dim_D[i]*ib_dim_D[i])*(M[i]*M[i])*1.764E3+(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*(sig*sig)*6.4E1-A*ib_dim_D[i]*(M[i]*M[i])*2.016E3+(A*A)*(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i])*(sig*sig)*4.9E1-(ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*M[i]*sig*6.24E2-A*(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*(sig*sig)*1.04E2+A*(ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i])*M[i]*sig*8.52E2-(A*A)*(ib_dim_C[i]*ib_dim_C[i])*ib_dim_D[i]*M[i]*sig*3.36E2))*2.0+(ib_dim_C[i]*M[i]*2.4E1-(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*ib_dim_D[i]*sig*7.0)/(sig*(A*4.0-ib_dim_D[i]*7.0)*2.0)-(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i])*1.0/pow(A*4.0-ib_dim_D[i]*7.0,2.0)*(2.7E1/2.0)-(ib_dim_C[i]*ib_dim_C[i]*ib_dim_C[i])*(ib_dim_D[i]*ib_dim_D[i]*ib_dim_D[i])*1.0/pow(A*4.0-ib_dim_D[i]*7.0,3.0)*2.7E1,1.0/3.0)*1.2E1;
		// If B has increased so much in an attempt to reduce Ixx so that it is greater than C then make B = C
		if(ib_dim_B[i] > ib_dim_C[i]){
			ib_dim_B[i] = ib_dim_C[i];
		}
		// If B is getting closer to C so that it would be impossible to manufacture then set each flange to 1mm height
		else if (ib_dim_B[i] > (ib_dim_C[i] - 2*MIN_FLANGE)){
			ib_dim_B[i] = ib_dim_C[i] - 2*MIN_FLANGE;
		}
	}
	
	
	// Sorts out cap area
	for( i = ib_cutoff; i < number_of_points; ++i ){
		ib_dim_B[i] = 0.0;	
	}
	return ib_dim_B;
}


double *FUNC_ibeam_area(int number_of_points, double *ib_dim_C, double *ib_dim_D, double *ib_dim_B, int ib_cutoff){
	int i;
	
	// Creates memory space for distributed_moment array to be returned
	double *ib_area = malloc(number_of_points*sizeof(double));
	  
	// Raises exception incase something goes horribly wrong
	if(!ib_area)
		return NULL;
	
		// Creates width dimension array upto cutoff point
	for( i = 0; i < ib_cutoff; ++i ){
		ib_area[i] = (ib_dim_C[i] * ib_dim_D[i]) - (ib_dim_B[i]*(ib_dim_D[i]-A));
	}
	

	for( i = ib_cutoff; i < number_of_points; ++i ){
		ib_area[i] = 0.0;
	}

	
	return ib_area;
}
