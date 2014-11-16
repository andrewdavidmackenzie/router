package net.mackenzie_serres.router;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * Calculate the optimal path from the starting point to the end point through a network
 * of roads, described in an input file.
 *
 */
public class Main {
	public static void main(String[] args) {
		if (args.length != 1) {
			System.out.print("ERROR: No file name supplied\n");
		} else {
			RoadSystem system = getRoadSystem(args[0]);

			if (system.isEmpty()) {
				System.out.println("The road system is empty");
			} else {
				RoadSystem.Path optimalPath = Optimal.calculate(system);

				System.out.println("The best path to take is: " + optimalPath);
				System.out.println("Time taken: " + optimalPath.totalTime());
			}
		}
	}

	/**
	 * Create a road system from an input file
	 *
	 * @param dataFileName - file to which to read the description of the system from
	 * @return RoadSystem - which maybe empty with no sections in it
	 */
	static RoadSystem getRoadSystem(String dataFileName) {
		RoadSystem system = new RoadSystem();

		try {
			List<int[]> groups = groupsOf(3, dataFileName);

			for (int[] group : groups) {
				system.addSection(new RoadSystem.Section(group));
			}
		} catch (IOException ex) {
			System.out.println("There was a problem reading the file'" + dataFileName + "'");
		}

		return system;
	}

	/**
	 * Create sets of data (distances in the road network) reading them from input filename
	 *
	 * @param n - the number of elements in each group of data
	 * @param dataFileName - the input filename to read
	 * @return List of groups of data as specified by the input file
	 *
	 * @throws IOException
	 * @throws NoSuchElementException
	 */
	static List<int[]> groupsOf(int n, final String dataFileName) throws IOException, NoSuchElementException {
		List<int[]> groups = new ArrayList<int[]>();
		int count = 0;
		int[] group = new int[n];
		InputStream input = new FileInputStream(new File(dataFileName));

		Scanner in = new Scanner(input);
		int number;
		try {
			while (true) {
				number = in.nextInt();
				group[count++] = number;
				if (count == n) {
					groups.add(group);
					group = new int[n];
					count = 0;
				}
			}
		} catch (NoSuchElementException ex) {
			// Hacky way to end the input!
		}

		return groups;
	}
}