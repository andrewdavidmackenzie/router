package net.mackenzie_serres.router;

public class Optimal {
	static RoadSystem.Path calculate(RoadSystem system) {
		RoadSystem.Path[] bestPaths = new RoadSystem.Path[2];
		bestPaths[0] = new RoadSystem.Path();
		bestPaths[1] = new RoadSystem.Path();

		for (RoadSystem.Section section : system.getSections()) {
			roadStep(bestPaths, section);
		}

		if (bestPaths[0].totalTime() < bestPaths[1].totalTime())
			return bestPaths[0];
		else
			return bestPaths[1];
	}

	static void roadStep(RoadSystem.Path[] paths, RoadSystem.Section section) {
		int timeA = paths[0].totalTime();
		int timeB = paths[1].totalTime();
		int forwardTimeToA = timeA + section.a;
		int crossTimeToA = timeB + section.b + section.c;
		int forwardTimeToB = timeB + section.b;
		int crossTimeToB = timeA + section.a + section.c;

		RoadSystem.Path oldA = paths[0].clone();

		if (forwardTimeToA <= crossTimeToA)
			paths[0].add(new RoadSystem.Point(RoadSystem.Label.A, section.a));
		else {
			paths[0] = paths[1].clone();
			paths[0].add(new RoadSystem.Point(RoadSystem.Label.B, section.b));
			paths[0].add(new RoadSystem.Point(RoadSystem.Label.C, section.c));
		}

		if (forwardTimeToB <= crossTimeToB)
			paths[1].add(new RoadSystem.Point(RoadSystem.Label.B, section.b));
		else {
			paths[1] = oldA.clone();
			paths[1].add(new RoadSystem.Point(RoadSystem.Label.A, section.a));
			paths[1].add(new RoadSystem.Point(RoadSystem.Label.C, section.c));
		}
	}
}
