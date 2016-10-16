module Main where

import System.IO
import System.Environment

import RoadSystem
import Optimal

main :: IO ()
main = do
-- TODO move all these functions out of main and try and do a generic call to function

--  import MyPureViskellModule
--  import FrobnicateLibrary (frob)
--  main = interact $ myViskellLambda frob

    (filename:_) <- getArgs
    contents <- readFile filename
    let roads = parseRoads contents
    let path = optimalPath roads
    printPath path