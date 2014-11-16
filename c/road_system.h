/* For printing enum values */
#define str(x) #x
#define enumstr(x) str(x)

typedef struct {
	int a;
	int b;
	int c;
} Section;

typedef struct {
	Section *sections;
	int     numSections;
} System;

enum Label { A, B, C };

typedef struct {
	enum Label  label;
	int         distance;
} Point;

typedef struct {
	Point   *points;
	int     numPoints;
} Path;

int totalTime(Path *pPath);
void printPath(Path *pPath);
void addSection(System *pSystem, Section *pSection);
Section * newSection(int numbers[3]);
Path *newPath();
Point *newPoint(enum Label l, int d);
Path *clonePath(Path *pPath);
void addToPath(Path *pPath, Point *pPoint);

