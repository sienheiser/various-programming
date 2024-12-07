repeatV2 :: (a -> a) -> Int -> (a -> a)
repeatV2 f 1 = f
repeatV2 f n = repeatV2 (f . f) (n-1)


smoothen :: Fractional a => (a -> a) -> (a -> a)
smoothen f = (\x -> (f (x-dx) + f x + f (x+dx))/3)
  where
    dx = 0.0001

nFoldSmoothen :: Fractional a => (a->a) -> Int -> (a -> a)
nFoldSmoothen f 1 = f
nFoldSmoothen f n = smoothen (nFoldSmoothen f (n - 1))


fixedPoint :: Fractional a => (a -> a) -> a -> a
fixedPoint f firstGuess = tryGuess firstGuess
  where
     tol :: Double
     tol = 0.001

     goodEnough :: Double -> Double -> Bool
     goodEnough a b = abs(a-b)<tol

     tryGuess :: a
     tryGuess guess = 
      let 
        next = f guess
      in 
        if (goodEnough guess next)
        then guess
        else tryGuess (f guess)
