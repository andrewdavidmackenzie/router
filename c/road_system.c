#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include "road_system.h"

/**
 Implement as a list?
**/
void addSection(System *pSystem, Section *pSection) {
	/* Allocate new array one bigger */
	Section *pNew = (Section *)malloc((pSystem->numSections + 1) * sizeof(Section));

	/* Copy over all current sections */
	memcpy(pNew, pSystem->sections, pSystem->numSections * sizeof(Section));

	/* include the new set */
	pSystem->sections = pNew;

	/* set the new one added */
	pSystem->sections[pSystem->numSections] = *pSection;

	/* Increment size counter */
	pSystem->numSections++;
}

bool isEmpty(System system) {
	return system.sections = 0;
}

Point *newPoint(enum Label l, int d) {
	Point *pPoint = (Point *)malloc(sizeof(Point));
	pPoint->label = l;
	pPoint->distance = d;
	return pPoint;
}

Path *newPath() {
	Path *pNewPath = (Path *)malloc(sizeof(Path));
	pNewPath->points = 0;
	pNewPath->numPoints = 0;

	return pNewPath;
}

Section * newSection(int numbers[3]) {
	Section *pNewSection = (Section *)malloc(sizeof(Section));
    pNewSection->a = numbers[0];
    pNewSection->b = numbers[1];
    pNewSection->c = numbers[2];

    return pNewSection;
}

/* Used?
Path(Path *pOther) {
	this.points.addAll(other.points);
}
*/

void addToPath(Path *pPath, Point *pPoint) {
	/* Allocate new array of Points one bigger */
	Point *pNew = (Point *)malloc((pPath->numPoints + 1) * sizeof(Point));

	/* Copy over all current Points */
	memcpy(pNew, pPath->points, pPath->numPoints * sizeof(Point));

	/* Set to use the new bigger set */
	pPath->points = pNew;

	/* set the new one added */
	pPath->points[pPath->numPoints] = *pPoint;

	/* Increment size counter */
	pPath->numPoints++;
}

Path *clonePath(Path *pPath) {
	Path *pNewPath = (Path *)malloc(sizeof(Path));

	/* Allocate new array of Points */
	pNewPath->points = (Point *)malloc(pPath->numPoints * sizeof(Point));

	/* Copy over all current Points */
	memcpy(pNewPath->points, pPath->points, pPath->numPoints * sizeof(Point));

	/* set counter */
	pNewPath->numPoints = pPath->numPoints;

	return pNewPath;
}

char * enumToString(enum Label label) {
	switch (label) {
	case A: return "A";
	case B: return "B";
	case C: return "C";
	default: return "X";
	}
}

void printPath(Path *pPath) {
	for (int i = 0; i < pPath->numPoints; i++) {
		printf("%s", enumToString(pPath->points[i].label));
	}
}

int totalTime(Path *pPath) {
	int total = 0;

	for (int i = 0; i < pPath->numPoints; i++) {
		total += pPath->points[i].distance;
	}

	return total;
}

