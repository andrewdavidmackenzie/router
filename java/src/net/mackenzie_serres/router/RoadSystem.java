package net.mackenzie_serres.router;

import java.util.ArrayList;
import java.util.List;

public class RoadSystem {
	enum Label { A, B, C }

	public static class Point {
		Label   label;
		int     distance;

		public Point(Label l, int d) {
			this.label = l;
			this.distance = d;
		}
	}

	public static class Path {
		List<Point> points = new ArrayList<Point>();

		public Path() {
		}

		public Path(Path other) {
			this.points.addAll(other.points);
		}

		public void add(Point p) {
			points.add(p);
		}

		@Override
		public Path clone() {
			return new Path(this);
		}

		@Override
		public String toString() {
			StringBuilder sb = new StringBuilder();
			for(Point point : points) {
				sb.append(point.label);
			}
			return sb.toString();
		}

		public int totalTime() {
			int total = 0;
			for(Point point : points) {
				total += point.distance;
			}
			return total;
		}
	}

	public static class Section {
		int a;
		int b;
		int c;

		public Section(int[] numbers) {
			this.a = numbers[0];
			this.b = numbers[1];
			this.c = numbers[2];
		}
	}
}