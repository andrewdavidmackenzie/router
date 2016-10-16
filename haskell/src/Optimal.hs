module Optimal (optimalPath) where

import RoadSystem

optimalPath :: RoadSystem -> Path
optimalPath roadSystem =
        let (bestAPath, bestBPath) = foldl roadStep ([], []) roadSystem
        in if sum (map snd bestAPath) <= sum (map snd bestBPath)
           then reverse bestAPath
           else reverse bestBPath

roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) =
    let timeA = sum (map snd pathA)
        timeB = sum (map snd pathB)
        forwardTimeToA = timeA + a
        crossTimeToA = timeB + b + c
        forwardTimeToB = timeB + b
        crossTimeToB = timeA + a + c
        newPathToA = if forwardTimeToA <= crossTimeToA
                     then (A, a):pathA
                     else (C, c):(B, b):pathB
        newPathToB = if forwardTimeToB <= crossTimeToB
                     then (B, b):pathB
                     else (C, c):(A, a):pathA
    in (newPathToA, newPathToB)
