require_relative "road_system"
require_relative "optimal"

# Create sets of data (distances in the road network) reading them from input filename
# and adds them to the road system
#
# @param data_file_name - the input filename to read
# @return road system built from the data in the input file
def get_road_system(data_file_name)
    system = RoadSystem.new

    puts "There was a problem reading the file '#{data_file_name}'" unless File.exists? data_file_name

    count = 0
    group = []
    File.readlines(data_file_name).each do |line|
        group[count] = line.to_i
        if count == 2
            system.add_section group[0..2]
            group = []
            count = 0
        else
            count += 1
        end
    end

    system
end

# Calculate the optimal path from the starting point to the end point through a network
# of roads, described in an input file.
system = get_road_system(ARGV[0])

optimal_path = Optimal.calculate system
puts "The best path to take is: #{optimal_path}"
puts "Time taken: #{optimal_path.total_time}"
