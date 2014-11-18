--
-- Created by IntelliJ IDEA.
-- User: andrew
-- Date: 16/11/14
-- Time: 21:34
-- To change this template use File | Settings | File Templates.
--

Optimal = {}

function Optimal:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function Optimal:calculate(system)
    local bestPaths = {Path:new(), Path:new()};

    for index,section in pairs(system:getSections()) do
        roadStep(bestPaths, section);
    end

    if (bestPaths[1]:totalTime() < bestPaths[1]:totalTime()) then
        return bestPaths[1];
    else
        return bestPaths[2];
    end
end

function roadStep(paths, section)
    local timeA = paths[1]:totalTime();
    local timeB = paths[2]:totalTime();
    local forwardTimeToA = timeA + section.a;
    local crossTimeToA = timeB + section.b + section.c;
    local forwardTimeToB = timeB + section.b;
    local crossTimeToB = timeA + section.a + section.c;

    oldA = paths[1]:clone();

    if (forwardTimeToA <= crossTimeToA) then
        paths[1].add(Point:new("A", section.a));
    else
        paths[1] = paths[1].clone();
        paths[1].add(Point:new("B", section.b));
        paths[1].add(Point:new("C", section.c));
    end

    if (forwardTimeToB <= crossTimeToB) then
        paths[2].add(Point:new("B", section.b));
    else
        paths[2] = oldA.clone();
        paths[2].add(Point:new("A", section.a));
        paths[2].add(Point:new("C", section.c));
    end
end

