--
-- Created by IntelliJ IDEA.
-- User: andrew
-- Date: 16/11/14
-- Time: 21:34
-- To change this template use File | Settings | File Templates.
--
require "utils"

Optimal = {}

function Optimal:calculate(system)
    local bestPaths = {Path:new(), Path:new()};

    for index,section in pairs(system:getSections()) do
        roadStep(bestPaths, section);
    end

    if (bestPaths[1]:totalTime() < bestPaths[2]:totalTime()) then
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

    local oldA = paths[1]:clone();

    if (forwardTimeToA <= crossTimeToA) then
        -- We take the "forward" direct path
        paths[1]:add(Point:new{label = "A", distance = section.a});
    else
        -- else we will take the route that crosses over
        paths[1] = paths[2]:clone();
        paths[1]:add(Point:new{label = "B", distance = section.b});
        paths[1]:add(Point:new{label = "C", distance = section.c});
    end

    if (forwardTimeToB <= crossTimeToB) then
        -- We take the "forward" direct path
        paths[2]:add(Point:new{label = "B", distance = section.b});
    else
        -- else we will take the route that crosses over
        paths[2] = oldA;
        paths[2]:add(Point:new{label = "A", distance = section.a});
        paths[2]:add(Point:new{label = "C", distance = section.c});
    end
end

