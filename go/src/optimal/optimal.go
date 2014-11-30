package optimal

import "roads"

func Calculate(rs * roads.System) (path * roads.Path) {
	bestPaths := make([]roads.Path, 2)

	for _, section := range rs.GetSections() {
		roadStep(bestPaths, section)
	}

	if bestPaths[0].TotalTime() < bestPaths[1].TotalTime() {
		return &bestPaths[0]
	} else {
		return &bestPaths[1]
	}
}

func roadStep(paths []roads.Path, section roads.Section) {
	var timeA = paths[0].TotalTime()
	var timeB = paths[1].TotalTime()
	var forwardTimeToA = timeA + section.A
	var crossTimeToA = timeB + section.B + section.C
	var forwardTimeToB = timeB + section.B
	var crossTimeToB = timeA + section.A + section.C

	var oldA = paths[0]

	if (forwardTimeToA <= crossTimeToA) {
		paths[0].AddPoint(roads.NewPoint("A", section.A))
	} else {
		paths[0] = paths[1]
		paths[0].AddPoint(roads.NewPoint("B", section.B))
		paths[0].AddPoint(roads.NewPoint("C", section.C))
	}

	if (forwardTimeToB <= crossTimeToB) {
		paths[1].AddPoint(roads.NewPoint("B", section.B))
	} else {
		paths[1] = oldA
		paths[1].AddPoint(roads.NewPoint("A", section.A))
		paths[1].AddPoint(roads.NewPoint("C", section.C))
	}
}
