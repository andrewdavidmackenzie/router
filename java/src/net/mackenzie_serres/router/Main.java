package net.mackenzie_serres.router;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		List<int[]> groups = groupsOf(3);
		List<RoadSystem.Section> system = new ArrayList<RoadSystem.Section>();

		for (int[] group : groups) {
			system.add(new RoadSystem.Section(group));
		}

		RoadSystem.Path optimalPath = Optimal.calculate(system);

		System.out.println("The best path to take is: " + optimalPath);
		System.out.println("Time taken: " + optimalPath.totalTime());
	}

	static List<int[]> groupsOf(int n) {
		List<int[]> groups = new ArrayList<int[]>();
		int count = 0;
		int[] group = new int[n];
		InputStream input = System.in;

/*		try {
			input = new FileInputStream(new File("/workspace/router/data/heathrow-london.in"));
		} catch (IOException ex) {
		}
*/

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
		}

		return groups;
	}
}