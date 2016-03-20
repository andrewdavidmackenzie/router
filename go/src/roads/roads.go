package roads

import ("fmt"
	"bytes")

type System struct {
	sections []Section
}

func NewSystem() (rs * System) {
	rs = new(System)
	rs.sections = make([]Section, 0)
	return rs
}

func (rs * System) ToString() string {
	var buffer bytes.Buffer

	for _,section := range rs.sections {
		buffer.WriteString(section.ToString())
	}

	return buffer.String()
}

func (rs * System) GetSections() []Section {
	return rs.sections
}

/*
TODO Not sure this appending is the best way to go about it for performance
 */
func (rs * System) AddSection(section * Section) {
	rs.sections = append(rs.sections, *section)
}

const (
	A string = "A"
	B string = "B"
	C string = "C"
)

type Point struct {
	label string
	distance int
}

func NewPoint(label string, distance int) (p * Point) {
	p = new(Point)
	p.label = label
	p.distance = distance
	return p
}

type Path struct {
	points []Point
}

func NewPath() (p * Path) {
	p = new(Path)
	p.points = make([]Point, 100)
	return p
}

func (p * Path) Clone() (np * Path) {
	np = NewPath()
	np.AddPath(p)
	return np
}

func (path * Path) AddPoint(point * Point) {
	path.points = append(path.points, *point);
}

func (path * Path) AddPath(otherPath * Path) {
	for _, point := range otherPath.points {
		path.points = append(path.points, point)
	}
}

func (path * Path) ToString() string {
	var buffer bytes.Buffer

	for _,point := range path.points {
		buffer.WriteString(point.label)
	}

	return buffer.String()
}

func (path * Path) TotalTime() int {
	var total int = 0

	for _,point := range path.points {
		total += point.distance
	}

	return total
}

type Section struct {
	A, B, C int
}

func (s * Section) ToString() string {
	return fmt.Sprintf("A = %d, B = %d, C = %d", s.A, s.B, s.C)
}

func NewSection(numbers []int) (s * Section) {
	s = new(Section)
	s.A = numbers[0]
	s.B = numbers[1]
	s.C = numbers[2]

	return s
}
