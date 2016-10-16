module RoadSystem where

data Section = Section { getA :: Int, getB :: Int, getC :: Int }
    deriving (Show)

type RoadSystem = [Section]

data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]

printPath :: Path -> IO ()
printPath path = do
    let pathString = concat $ map (show . fst) path
        pathTime = sum $ map snd path
    putStrLn $ "The best path to take is: " ++ pathString
    putStrLn $ "Time taken: " ++ show pathTime

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)

parseRoads :: String -> RoadSystem
parseRoads roads =
    let threes = groupsOf 3 (map read $ lines roads)
    in map (\[a,b,c] -> Section a b c) threes