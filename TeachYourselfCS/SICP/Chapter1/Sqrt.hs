
square :: Double -> Double 
square n = n * n

absoluteValue :: Double -> Double 
absoluteValue n 
  | n >= 0 =  n
  | otherwise = -n


goodEnough :: Double -> Double -> Bool
goodEnough guess x
  | absoluteValue ((square guess) - x) < 0.001 = True
  | otherwise = False

average :: Double -> Double -> Double
average x y = (x + y)/2

improveGuess :: Double -> Double -> Double
improveGuess guess x = average guess (x/guess)

tryGuess :: Double -> Double -> Double
tryGuess initialGuess x 
  | goodEnough initialGuess x = initialGuess
  | otherwise = tryGuess (improveGuess initialGuess x) x

squareRoot :: Double -> Double
squareRoot x
  | x >= 0 = tryGuess 1 x
  | otherwise = error "Cannot compute squreroot of negative number"


fixedPoint :: (Double -> Double) -> Double -> Double
fixedPoint f start = iter start (f start)
  where
    tolerance :: Double
    tolerance = 0.0001

    closeEnuf :: Double -> Double -> Bool
    closeEnuf old new = abs(old-new) < tolerance

    iter :: Double -> Double -> Double
    iter old new 
      | closeEnuf old new = old
      | otherwise = iter new (f new)

cons :: a -> a -> (Int -> a)
cons c d = \pick -> case pick of
  1 -> c
  2 -> d
  otherwise -> error "Can"

car :: (Int -> a) -> a
car f = f 1

cdr :: (Int -> a) -> a
cdr f = f 2
