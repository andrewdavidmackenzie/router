use std::io::BufReader;
use std::io::BufRead;
use std::fs::File;
use roads::{System, Section};
use std::io;

/**
 * Create a road system reading distances from an input file
 */
pub fn get_road_system(path: String) -> Result<System, io::Error> {
    let file = File::open(&path)?;
    let reader = BufReader::new(&file);
    let mut system: System = Default::default();
    let mut numbers: [u32; 3] = [0;3];
    let mut count = 0;

    for line in reader.lines() {
        numbers[count] = line.unwrap().parse::<u32>().unwrap();
        count += 1;

        if count == 3 {
			system.add(Section {distances: numbers});
            count = 0;
        }
    };

    Ok(system)
}
