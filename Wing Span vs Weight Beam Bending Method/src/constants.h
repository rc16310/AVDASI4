// Constants used throughout the analysis

// Aerodynamics
#define VELOCITY 230       // m/s
#define AIR_DENSITY 0.01841     // kg/m^3

// Materials - Al 6061
#define SIGMA_MAX 290e6        // N/m^2
#define IB_MATERIAL_DENSITY 2700    // kg/m^3
// Allowable stress saftey factor
#define SAFTEY_FACTOR 1.5     // unitless
// Limit load due to banking/turning etc
#define LIMIT_LOAD 3

// Structures - I-Beam
// I-Beam dimensions - see latex report for diagram
// A is web thickness
#define A 0.001
// C*(t/c)*c is height (where c is aerofoil chord, t is aerofoil thickness)
#define C 0.9375
// D*c is width (where c is aerofoil chord)
#define D 0.133
// Flange minimum thickness (for manufacturability)
#define MIN_FLANGE 0.002

// Structures - Wing Skin
// Cap length is the amount shorter the I-beam is than the wing
// Special cap structure used for the rest of the wing
#define CAP_LENGTH 0.6         // m
// Wing skin properties
#define SKIN_DENSITY 1780		// kg/m3
#define SKIN_THICKNESS 0.0005
// These coeffients estimate the aerofoil perimeter in terms of (SKIN_COEFFICIENT_1)chord + SKIN_COEFFICIENT_2
#define SKIN_COEFFICIENT_1 2.123
#define SKIN_COEFFICIENT_2 -0.039525


/* How many spanwise "points" are used for the calculation,
   defines "dz" size, a higher POINTS_PER_METRE --> lower dz --> greater accuracy
   Getting numberical errors when POINTS_PER_METRE is too small, minimum value examples shown below
   38 for 4m span
   30 for 5m span
   25 for 6m span*/
#define POINTS_PER_METRE 500   // 


// Wing setup
// Chord variable testing
#define START_CHORD 3.0
#define END_CHORD 5.0
#define CHORD_POINTS_PER_METRE 10
// Span variable testing
#define START_SPAN 30
#define END_SPAN 80
#define SPAN_POINTS_PER_METRE 1

// I-Beam Printer
// Produces file of I-beam dimensions for values given below
#define ICHORD 4
#define ISPAN 40






