#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include "road_system.h"
#include "optimal.h"

/**
 * Read in groups of three and add each as a section to the road system
 *
 */
void readGroupsOf3(System *pSystem, FILE *pFile) {
	int count = 0;
	int group[3];
	int i;

    while (!feof (pFile)) {
		fscanf (pFile, "%d", &i);
		group[count++] = i;

		if (count == 3) {
			addSection(pSystem, newSection(group));
			count = 0;
		}
    }

	fclose (pFile);
}

/**
 * Create a road system from an input file
 *
 * @param dataFileName - file to which to read the description of the system from
 * @return RoadSystem - which maybe empty with no sections in it
 */
System * getRoadSystem(char * dataFileName) {
	System *pSystem = (System *)malloc(sizeof(System));
	pSystem->sections = 0;
	pSystem->numSections = 0;

	/* Try to get the file */
	FILE *pFile = fopen(dataFileName, "r");

	if (pFile == 0) {
		printf("There was a problem opening the file %s\n", dataFileName);
		return pSystem;
	}

	readGroupsOf3(pSystem, pFile);

	return pSystem;
}

int main(int argc, char *argv[]) {
	if (argc != 2) {
		printf("ERROR: No file name supplied\n");
		exit(-1);
	} else {
		System *pSystem = getRoadSystem(argv[1]);

		if (pSystem->numSections == 0) {
			printf("The road system is empty");
			exit (-1);
		} else {
			Path *pOptimalPath = calculateOptimalPath(pSystem);

			printf("The best path to take is: ");
			printPath(pOptimalPath);
			printf("\n");
			printf("Time taken: %d\n",totalTime(pOptimalPath));
			exit(0);
		}
	}
}
