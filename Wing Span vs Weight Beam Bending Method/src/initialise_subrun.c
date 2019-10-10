#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "functions.h"
#include "constants.h"

double FUNC_init_run (double span, double root_chord, int report) {

	double *z, *ib_dim_B, *chord, *ib_dim_C, *ib_dim_D, *ib_area, *wing_weight, *total_moment;
	
	int i, iter;
	
	
	// Empty no wing enw_weight
	double enw_weight = 61103*9.81;
	double total_weight, total_wing_weight, drag, total_weight_old, relative_error;
	//double span = 10;
	//double root_chord = 0.4;
	double thick_over_chord = 0.08;
	int ib_cutoff;

	// Display run specific information
	//printf("\nTotal span: %fm\tRoot Chord: %f\t\nEmpty no wing mass %fN\n", span, root_chord, enw_weight/9.81);

	// Pre processing of useful/repetitive variables
	int number_of_points = (int)(((span/2)*POINTS_PER_METRE)+1);
	
	// Displays how many points (understanding purposes)
	//printf("Numer of points (including zero): %i \n", number_of_points);
	
	// Calculates step incremen
	double dz = 1/(double)POINTS_PER_METRE;
	
	// Setup wing geometry
	z = FUNC_spanLocations(dz, number_of_points);
	chord = FUNC_chord(root_chord, number_of_points, z);
	
	// Setup I-Beam geometry
	ib_cutoff = (int)(number_of_points -CAP_LENGTH*POINTS_PER_METRE);
	ib_dim_C = FUNC_ibeam_C(number_of_points, z, chord, thick_over_chord, ib_cutoff);
	ib_dim_D = FUNC_ibeam_D(number_of_points, z, chord, ib_cutoff);
	
	// Setup initial conditions
	wing_weight = FUNC_wing_weight_initial(number_of_points);
	total_weight = enw_weight;
	total_weight_old = total_weight;
	relative_error = 10;
	
	
	
	while(relative_error > 1 ){
	total_moment = FUNC_total_moment_distribution(number_of_points, total_weight, span, root_chord, wing_weight, z, dz);
	total_moment[number_of_points-1] = 0;
	ib_dim_B = FUNC_ibeam_B(number_of_points, total_moment, z, ib_dim_C, ib_dim_D, ib_cutoff);
	ib_area = FUNC_ibeam_area(number_of_points, ib_dim_C, ib_dim_D, ib_dim_B, ib_cutoff);
	wing_weight = FUNC_wing_weight(number_of_points, ib_area, dz, chord, ib_cutoff);
	
	total_wing_weight = FUNC_total_wing_weight(number_of_points, wing_weight, dz);
	
	total_weight = enw_weight+2*total_wing_weight;
	drag = FUNC_drag(total_weight, span);
	
	// Relative error in grams
	relative_error = fabs(total_weight - total_weight_old)*1000;
	total_weight_old = total_weight;
	
	/*
	printf("\nSpan Loc(m)\tChord(m)\tIB Height(m)\tIB Width(m)\tMoment(Nm)\tWeb Height(m)\tIB Area(m2)\tWing Weight(N)\n");
	for( i = 0; i < number_of_points; ++i ){
		printf("%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n", z[i], chord[i], ib_dim_C[i], ib_dim_D[i], total_moment[i], ib_dim_B[i], ib_area[i], wing_weight[i]);
	}
	*/
	
	
	if(report) {
	printf("\nThe total mass is:\t%f kg\n", (total_weight/9.81));
	printf("The induced drag is:\t%f N\n", drag);
	printf("The relative error is:\t%f g\n", relative_error);
	}
	}
	
	
	if (ib_dim_B[0] < 0){
		drag = 999;
	}
	
	// Print I-Beam information to a file
	if (span == ISPAN && root_chord == ICHORD){
		FILE *fp;
		fp = fopen("IBeam_sizing.csv", "w");
		fprintf(fp, "Span Loc(m)\tChord(m)\tIB Height(m)\tIB Width(m)\tWeb Height(m)\tWeb Width(m)\tIB Area(m2)\tMoment(Nm)\tWing Weight(N/m)\n");
		
		for( i = 0; i < number_of_points; ++i ){
			fprintf(fp, "%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n", z[i], chord[i], ib_dim_C[i], ib_dim_D[i], ib_dim_B[i], A, ib_area[i], total_moment[i], wing_weight[i]);
		}	
		fclose(fp);
	}

	
	// Free memory n that
	free(total_moment);
	free(wing_weight);
	free(ib_area);
	free(ib_dim_B);
	free(ib_dim_D);
	free(ib_dim_C);
	free(chord);
	free(z);
	
return drag;

}