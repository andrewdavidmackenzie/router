use roads::{System, Path, Section, Point};

pub fn calculate(system: &System) -> Path {
    let mut paths : Vec<Path> = Vec::with_capacity(2);
    paths.push(Path::new());
    paths.push(Path::new());

	for section in &system.sections {
		road_step(&mut paths, section);
	}

	if paths[0].total_time < paths[1].total_time {
		paths[0].clone()
	} else {
		paths[1].clone()
	}
}

fn road_step(paths: &mut Vec<Path>, section: &Section) {
	let time_a = paths[0].total_time;
	let time_b = paths[1].total_time;
	let forward_time_to_a = time_a + section.distances[0];
	let cross_time_to_a = time_b + section.distances[1] + section.distances[2];
	let forward_time_to_b = time_b + section.distances[1];
	let cross_time_to_b = time_a + section.distances[0] + section.distances[2];

	let old_a = paths[0].clone();

	if forward_time_to_a <= cross_time_to_a {
		paths[0].add(Point::new("A".to_string(), section.distances[0]));
	} else {
		paths[0] = paths[1].clone();
		paths[0].add(Point::new("B".to_string(), section.distances[1]));
		paths[0].add(Point::new("C".to_string(), section.distances[2]));
	}

	if forward_time_to_b <= cross_time_to_b {
		paths[1].add(Point::new("B".to_string(), section.distances[1]));
	} else {
		paths[1] = old_a;
		paths[1].add(Point::new("A".to_string(), section.distances[0]));
		paths[1].add(Point::new("C".to_string(), section.distances[2]));
	}
}
