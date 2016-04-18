module Main where

import System.IO
import System.Environment
import RoadSystem
import Optimal

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)

main :: IO ()
main = do
-- TODO move all these functions out of main and try and do a generic call to function

--  import MyPureViskellModule
--  import FrobnicateLibrary (frob)
--  main = interact $ myViskellLambda frob

    (filename:_) <- getArgs
    handle <- openFile filename ReadMode
    contents <- hGetContents handle
    let threes = groupsOf 3 (map read $ lines contents)
        roadSystem = map (\[a,b,c] -> Section a b c) threes
        path = optimalPath roadSystem
    let pathString = concat $ map (show . fst) path
    let pathTime = sum $ map snd path
    putStrLn $ "The best path to take is: " ++ pathString
    putStrLn $ "Time taken: " ++ show pathTime