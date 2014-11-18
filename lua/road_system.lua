--
-- Created by IntelliJ IDEA.
-- User: andrew
-- Date: 16/11/14
-- Time: 19:26
-- To change this template use File | Settings | File Templates.
--
RoadSystem = {}

function RoadSystem:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    self.sections = {};
    return o
end

function RoadSystem:addSection(section)
    self.sections[#self.sections+1] = section;
end

function RoadSystem:getSections()
    return self.sections;
end

Point = {}

function Point:new(l, d)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    label = l;
    distance = d;
    return o;
end

function Point:clone()
    copy = Point:new{self.label, self.distance};
    return copy;
end

Path = {}

function Path:new()
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    points = {};
    return o
end

function Path:add(p)
    self.points[#self.points +1] = p;
end

function Path:clone()
    copy = Path:new();
    for point in self.point do
        copy[#copy +1] = point.clone();
    end
    return copy;
end

function Path:toString()
    for index,point in pairs(points) do
        print(point.label);
    end
end

function Path:totalTime()
    local total = 0;
    for index, point in pairs(points) do
        total = total + point.distance;
    end

    return total;
end

Section = {}

function Section:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    self.a = o.a;
    self.b = o.b;
    self.c = o.c;
    return o
end

function RoadSystem:isEmpty()
    return next(self.sections);
end

