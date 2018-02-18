mod optimal;
mod roads;
mod reader;

use std::env;

/*
 * Calculate the optimal path from the starting point to the end point through a network
 * of roads, described in an input file.
 */
fn main() {
    match run() {
        Ok(message) => println!("\n{}", message),
        Err(e) => println!("{}", e)
    }
}

fn run() -> Result<String, String> {
    match env::args().nth(1) {
        Some(arg1) => {
            let rs = reader::get_road_system(arg1)
                .map_err(|e| e.to_string())?;
            let optimal_path = optimal::calculate(&rs);
            Ok(format!("The best path to take is: {}\n", optimal_path))
        }
        None => Err("No filename for input data supplied".to_string())
    }
}