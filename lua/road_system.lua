--
-- Classes to represent a "Road System", with "Sections" of road between two "Points"
-- and a "Path" from one "Point" to another "Point" consisting of a series of intermediate "Points".
--
-- See the docs in the /doc folder that describe the problem and how the road system is described in
-- the input data
-- User: andrew
-- Date: 16/11/14
-- Time: 19:26
--

require "utils"

-- RoadSystem class
RoadSystem = {}

function RoadSystem:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    o.sections = {};
    return o;
end

function RoadSystem:addSection(section)
    table.insert(self.sections, section);
end

function RoadSystem:getSections()
    return self.sections;
end

-- Point class
-- Has a "Label" to identify it, and a distance from the previous "Point"
Point = {}

function Point:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o;
end

function Point:clone()
    local newPoint = Point:new{};
    newPoint.label = self.label;
    newPoint.distance = self.distance;
    return newPoint;
end

function Point:toString()
    return "(" .. self.label .. ", " .. self.distance .. ")";
end

-- Path class
-- Consists of a collection of "Points" to describe a "Path" through the "RoadSystem"
Path = {}

function Path:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    o.points = {};
    return o;
end

function Path:clone()
    local copy = Path:new{};
    for index,point in pairs(self.points) do
        table.insert(copy.points, point);
    end
    return copy;
end

function Path:add(point)
    table.insert(self.points, point:clone());
end

function Path:toString()
    local string = "";
    for index,point in pairs(self.points) do
        string = string .. point.label;
    end
    return string;
end

function Path:totalTime()
    local total = 0;
    for index, point in pairs(self.points) do
        total = total + point.distance;
    end

    return total;
end

-- Section class, used to describe a RoadSystem
-- Consists of three distances:
--    - 'a' the distance along the "top" route to the next point on the top route
--    - 'b' the distance along the "bottom" route to the next point on the bottom route
--    - 'c' the distance between the next point on the top route and next point on the bottom route
Section = {}

function Section:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o;
end

