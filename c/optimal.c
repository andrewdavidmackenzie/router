#include "road_system.h"
#include "optimal.h"


void roadStep(Path * paths[2], Section *pSection) {
	int timeA = totalTime(paths[0]);
	int timeB = totalTime(paths[1]);
	int forwardTimeToA = timeA + pSection->a;
	int crossTimeToA = timeB + pSection->b + pSection->c;
	int forwardTimeToB = timeB + pSection->b;
	int crossTimeToB = timeA + pSection->a + pSection->c;

	Path * oldA = clonePath(paths[0]);

	if (forwardTimeToA <= crossTimeToA)
		addToPath(paths[0], newPoint(A, pSection->a));
	else {
		paths[0] = clonePath(paths[1]);
		addToPath(paths[0], newPoint(B, pSection->b));
		addToPath(paths[0], newPoint(C, pSection->c));
	}

	if (forwardTimeToB <= crossTimeToB)
		addToPath(paths[1], newPoint(B, pSection->b));
	else {
		paths[1] = clonePath(oldA);
		addToPath(paths[1], newPoint(A, pSection->a));
		addToPath(paths[1], newPoint(C, pSection->c));
	}
}

Path * calculateOptimalPath(System *pSystem) {
	Path * bestPaths[2];
	bestPaths[0] = newPath();
	bestPaths[1] = newPath();

	for (int i = 0; i < pSystem->numSections; i++) {
		roadStep(bestPaths, &(pSystem->sections[i]));
	}

	if (totalTime(bestPaths[0]) < totalTime(bestPaths[1]))
		return bestPaths[0];
	else
		return bestPaths[1];
}
