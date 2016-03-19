package main

import ("fmt"
	"os"
	"io"
	"roads"
	"optimal")

/**
 * Calculate the optimal path from the starting point to the end point through a network
 * of roads, described in an input file.
 *
 */
func main() {
	if len(os.Args) != 2 {
		fmt.Printf("ERROR: No file name supplied\n");
	} else {
		system, err := getRoadSystem(os.Args[1])

		if err != nil {
			fmt.Printf("Error reading road system\n")
		} else {
			optimalPath := optimal.Calculate(system)

			fmt.Printf("The best path to take is: %s\n", optimalPath.ToString())
			fmt.Printf("Time taken: %d\n", optimalPath.TotalTime())
		}
	}
}

/**
 * Create a road system from an input file
 *
 * @param dataFileName - file to which to read the description of the system from
 * @return RoadSystem - which maybe empty with no sections in it
 */
func getRoadSystem(dataFileName string) (s * roads.System, err error) {
	fd, err := os.Open(dataFileName)
	if err != nil {
		panic(fmt.Sprintf("open %s: %v", dataFileName, err))
	}

	s = roads.NewSystem()
	for {
		var section, err = readSection(fd)

		if err == nil {
			s.AddSection(section)
		} else {
			break
		}
	}

	return s, err
}

/*
	Read a section three integers from standard input.
	Return an error if EOF or not three found before EOF
 */
func readSection(fd io.Reader) (section * roads.Section, err error) {
	var number int
	var numbers = make([]int, 3)

	for i := 0; i < 3; i++ {
		_, err := fmt.Fscanf(fd, "%d", &number)

		if err != nil {
			return nil, err
		}

		numbers[i] = number
	}

	return roads.NewSection(numbers), nil
}
