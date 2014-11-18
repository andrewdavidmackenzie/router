--
-- Created by IntelliJ IDEA.
-- User: andrew
-- Date: 16/11/14
-- Time: 19:26
-- To change this template use File | Settings | File Templates.
--
require "road_system"
require "optimal"

--
-- Create sets of data (distances in the road network) reading them from input filename
-- and adds them to the road system
--
-- @param n - the number of elements in each group of data
-- @param dataFileName - the input filename to read
-- @return List of groups of data as specified by the input file
--
--
function getRoadSystem(dataFileName)
    local system = RoadSystem:new();

    local group = {};

    if io.input(dataFileName) == nil then
        print("There was a problem reading the file'" .. dataFileName .. "'");
    end

    local number;
    number = io.read("*n")

    local count = 1;
    while number do
        group[count] = number;
        if count == 3 then
            section = Section:new({a = group[1], b = group[2], c = group[3]});
            system:addSection(section);
            group = {};
            count = 1;
        else
            count = count + 1;
        end

        number = io.read("*n")
    end

    return system;
end

--
-- Calculate the optimal path from the starting point to the end point through a network
-- of roads, described in an input file.
--
--
if arg[1] == nill then
    print("ERROR: No file name supplied\n");
else
    local system = getRoadSystem(arg[1]);

    if system:isEmpty() then
        print("The road system is empty");
    else
        optimal = Optimal:new();
        local optimalPath = optimal:calculate(system);
        print("The best path to take is: ");
        optimalPath:toString();
        print("\n");
        print("Time taken: " .. optimalPath.totalTime());
    end
end


