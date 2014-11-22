Representing the Road System in Haskell
=======================================

How do we represent this road system with Haskell’s data types? 
Thinking back to our solution by hand, we checked the durations of three road parts at once: the road part on the A road, its opposite part on the B road, and part C, which touches those two parts and connects them. 

When we were looking for the quickest path to A1 and B1, we dealt with the durations of only the first three parts, which were 50, 10, and 30. 

We’ll call that one section. So the road system that we use for this example can be easily represented as four sections:
* 50, 10, 30
* 5, 90, 20
* 40, 2, 25
* 10,8,0

It’s always good to keep our data types as simple as possible (although not any simpler!). 

Here’s the data type for our road system:
data Section = Section { getA :: Int, getB :: Int, getC :: Int }
    deriving (Show)
type RoadSystem = [Section]

This is as simple as it gets, and I have a feeling it will work perfectly for implementing our solution.

Section is a simple algebraic data type that holds three integers for the durations of its three road parts. 

We introduce a type synonym as well, say- ing that RoadSystem is a list of sections.

NOTE We could also use a triple of (Int, Int, Int) to represent a road section. 
Using tuples instead of making your own algebraic data types is good for some small, localized stuff, but it’s usually better to make a new type for more complex representations. 
It gives the type system more information about what’s what. We can use (Int, Int, Int) to represent a road section or a vector in 3D space, and we can operate on those two, but that allows us to mix them up. 

If we use Section and Vector data types, then we can’t accidentally add a vector to a section of a road system.

Our road system from Heathrow to London can now be represented like this:
          heathrowToLondon :: RoadSystem
          heathrowToLondon = [ Section 50 10 30
                             , Section 5 90 20
                             , Section 40 2 25
                             , Section 10 8 0
                             ]

All we need to do now is implement the solution in Haskell.

Writing the Optimal Path Function
---------------------------------
What should the type declaration for a function that calculates the quickest path for any given road system be? 
It should take a road system as a parameter and return a path. 
We’ll represent a path as a list as well.

Let’s introduce a Label type that’s just an enumeration of A, B, or C. We’ll also make a type synonym called Path.
          data Label = A | B | C deriving (Show)
          type Path = [(Label, Int)]

Our function, which we’ll call optimalPath, should have the following type: optimalPath :: RoadSystem -> Path

If called with the road system heathrowToLondon, it should return the fol- lowing path:
          [(B,10),(C,30),(A,5),(C,20),(B,2),(B,8)]

We’re going to need to walk over the list with the sections from left to right and keep the optimal path on A and optimal path on B as we go along.

We’ll accumulate the best path as we walk over the list, left to right. 
What does that sound like? Ding, ding, ding! That’s right, a left fold!

When doing the solution by hand, there was a step that we repeated over and over. 
It involved checking the optimal paths on A and B so far and the current section to produce the new optimal paths on A and B. For in- stance, at the beginning, the optimal paths were [] and [] for A and B, re- spectively. 

We examined the section Section 50 10 30 and concluded that the new optimal path to A1 was [(B,10),(C,30)] and the optimal path to B1 was [(B,10)]. 

If you look at this step as a function, it takes a pair of paths and a section and produces a new pair of paths. So its type is this:
roadStep :: (Path, Path) -> Section -> (Path, Path)

Let’s implement this function, because it’s bound to be useful:
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
    in  (newPathToA, newPathToB)

What’s going on here? 
First, we calculate the optimal time on road A based on the best so far on A, and we do the same for B. 
We do sum (map snd pathA), so if pathA is something like [(A,100),(C,20)], timeA becomes 120.

forwardTimeToA is the time that it would take to get to the next crossroads on A if we went there directly from the previous crossroads on A. It equals the best time to our previous A plus the dura- tion of the A part of the current section.
crossTimeToA is the time that it would take if we went to the next A by go- ing forward from the previous B and then crossing over. It’s the best time to the previous B so far plus the B duration of the section plus the C duration of the section.

We determine forwardTimeToB and crossTimeToB in the same manner. Functionally Solving Problems 213
￼￼￼￼￼
Now that we know the best way to A and B, we just need to make the new paths to A and B based on that. If it’s quicker to go to A by just going forward, we set newPathToA to be (A, a):pathA. Basically, we prepend the Label A and the section duration a to the optimal path on A so far. We say that the best path to the next A crossroads is the path to the previous A crossroads and then one section forward via A. Remember that A is just a label, whereas a has a type
of Int.

Why do we prepend instead of doing pathA ++ [(A, a)]? Well, adding an element to the beginning of a list is much faster than adding it to the end. 

This means that the path will be the wrong way around once we fold over a list with this function, but it’s easy to reverse the list later.
If it’s quicker to get to the next A crossroads by going forward from road B and then crossing over, newPathToA is the old path to B that then goes for- ward and crosses to A. We do the same thing for newPathToB, except that every- thing is mirrored.

Finally, we return newPathToA and newPathToB in a pair.

Let’s run this function on the first section of heathrowToLondon. Because it’s the first section, the best paths on A and B parameter will be a pair of empty lists.
          ghci> roadStep ([], []) (head heathrowToLondon)
          ([(C,30),(B,10)],[(B,10)])

Remember that the paths are reversed, so read them from right to left. From this, we can read that the best path to the next A is to start on B and then cross over to A. The best path to the next B is to just go directly forward from the starting point at B.
NOTE When we do timeA = sum (map snd pathA), we’re calculating the time from the path on every step. We wouldn’t need to do that if we implemented roadStep to take and return the best times on A and B, along with the paths themselves.

Now that we have a function that takes a pair of paths and a section, and produces a new optimal path, we can easily do a left fold over a list of sections. roadStep is called with ([], []) and the first section, and returns a pair of optimal paths to that section. Then it’s called with that pair of paths and the next section, and so on. 

When we’ve walked over all the sections, we’re left with a pair of optimal paths, and the shorter of them is our answer. With this in mind, we can implement optimalPath:
          optimalPath :: RoadSystem -> Path
          optimalPath roadSystem =
              let (bestAPath, bestBPath) = foldl roadStep ([], []) roadSystem
              in  if sum (map snd bestAPath) <= sum (map snd bestBPath)
                      then reverse bestAPath
                      else reverse bestBPath

We left fold over roadSystem (remember that it’s a list of sections) with
the starting accumulator being a pair of empty paths. The result of that fold is a pair of paths, so we pattern match on the pair to get the paths themselves. Then we check which one of these was quicker and return it. Before return- ing it, we also reverse it, because the optimal paths so far were reversed due to us choosing prepending over appending.
Let’s test this!

ghci> optimalPath heathrowToLondon

[(B,10),(C,30),(A,5),(C,20),(B,2),(B,8),(C,0)]

This is the result that we were supposed to get! It differs from our ex- pected result a bit, because there’s a step (C,0) at the end, which means that we cross over to the other road once we’re in London. But because that crossing doesn’t take any time, this is still the correct result.

Getting a Road System from the Input
------------------------------------
We have the function that finds an optimal path, so now we just need to read a textual representation of a road system from the standard input, convert it into a type of RoadSystem, run that through our optimalPath function, and print the resulting path.

First, let’s make a function that takes a list and splits it into groups of the same size. We’ll call it groupsOf:

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)

For a parameter of [1..10], groupsOf 3 should result in the following: [[1,2,3],[4,5,6],[7,8,9],[10]]

As you can see, it’s a standard recursive function. Doing groupsOf 3 [1..10] equals the following:
[1,2,3] : groupsOf 3 [4,5,6,7,8,9,10]

When the recursion is done, we get our list in groups of three. And here’s our main function, which reads from the standard input, makes a RoadSystem out of it, and prints out the shortest path:

import Data.List
main = do
    contents <- getContents
    let threes = groupsOf 3 (map read $ lines contents)
￼￼￼￼￼￼￼￼￼Functionally Solving Problems 215
roadSystem = map (\[a,b,c] -> Section a b c) threes
        path = optimalPath roadSystem
        pathString = concat $ map (show . fst) path
        pathTime = sum $ map snd path
    putStrLn $ "The best path to take is: " ++ pathString
    putStrLn $ "Time taken: " ++ show pathTime

First, we get all the contents from the standard input. Then we apply lines to our contents to convert something like "50\n10\n30\n ... to some- thing cleaner, like ["50","10","30" .... We then map read over that to convert it to a list of numbers. We apply groupsOf 3 to it so that we turn it to a list of lists of length 3. We map the lambda (\[a,b,c] -> Section a b c) over that list of lists.

As you can see, the lambda just takes a list of length 3 and turns it into a section. So roadSystem is now our system of roads, and it even has the correct type: RoadSystem (or [Section]). We apply optimalPath to that, get the path and the total time in a nice textual representation, and print it out.

We save the following text in a file called paths.txt:
50
10
30
5
90
20
40
2
25
10
8
0

$ runhaskell heathrow.hs < paths.txt

The best path to take is: BCACBBC
Time taken: 75

Works like a charm!

You can use your knowledge of the Data.Random module to generate a much longer system of roads, which you can then feed to the code we just wrote. 

If you get stack overflows, you can change foldl to foldl' and sum to foldl' (+) 0. Alternatively, try compiling it like this before running it:
$ ghc --make -O heathrow.hs

Including the O flag turns on optimizations that help prevent functions such as foldl and sum from causing stack overflows.