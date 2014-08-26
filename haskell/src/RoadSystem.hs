module RoadSystem where

data Section = Section { getA :: Int, getB :: Int, getC :: Int }
	deriving (Show)

type RoadSystem = [Section]

data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]