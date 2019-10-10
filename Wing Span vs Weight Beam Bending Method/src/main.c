#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "functions.h"
#include "constants.h"

int main (void) {
	
	int span_points;
	double span_increment;
	
	int chord_points;
	double chord_increment;
	double drag, span, root_chord;


	// 0 is false in C, 1 for true
	int report = 0;
	int i, j;
	
	printf("Root Chord(m)\tSpan(m)\t\tDrag(N)\n");	
	
	chord_points = (int)((END_CHORD-START_CHORD)*CHORD_POINTS_PER_METRE);
	chord_increment = (double)((END_CHORD-START_CHORD)/chord_points);

	span_points = (int)((END_SPAN-START_SPAN)*SPAN_POINTS_PER_METRE);
	span_increment = (double)((END_SPAN-START_SPAN)/((double)span_points));
	
	//printf("%f",span_increment);
	FILE *fp;
	fp = fopen("induced_drag_landscape_results.csv", "w");
	
	
	for( j = 0; j <= chord_points; ++j ){
		root_chord = START_CHORD + j*chord_increment;
		for( i = 0; i <= span_points; ++i ){
			span = START_SPAN + i*span_increment;
			drag = FUNC_init_run(span, root_chord, report);
			printf("%f\t%f\t%f\n", root_chord, span, drag);
			fprintf(fp, "%f,%f,%f\n", span, root_chord, drag);
		}
	}
	
	fclose(fp);
	
	return 0;
}