use std::fmt;

#[derive(Clone)]
pub struct Point {
    label: String,
    distance: u32,
}

#[derive(Default, Clone)]
pub struct Path {
    points: Vec<Point>,
    pub total_time: u32,
}

pub struct Section {
    pub distances: [u32; 3]
}

#[derive(Default)]
pub struct System {
    pub sections: Vec<Section>
}

impl Point {
    pub fn new(label: String, distance: u32) -> Self {
        Point {
            label,
            distance,
        }
    }
}

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.label)
    }
}

impl Path {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn add(&mut self, point: Point) {
        self.total_time += &point.distance;
        self.points.push(point);
    }
}

impl fmt::Display for Path {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        for point in &self.points {
            write!(f, "{}", point)?;
        }
        write!(f, "\nTime taken: {}", self.total_time)?;

        Ok(())
    }
}

impl fmt::Display for Section {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        for distance in self.distances.iter() {
            write!(f, "{}, ", distance)?;
        }
        Ok(())
    }
}

impl System {
    pub fn add(&mut self, section: Section) {
        self.sections.push(section);
    }
}

impl fmt::Display for System {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        for section in &self.sections {
            write!(f, "[{}], ", section)?;
        }

        Ok(())
    }
}