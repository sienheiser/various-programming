
--time complexity = n
--space complextity = n
fact :: Int -> Int
fact 0 = 0
fact 1 = 1
fact n = n * fact (n-1)

--time complexity = n
--space comlexity = const
factV2 :: Int -> Int 
factV2 n = factIter 1 1 n 
  where
    factIter :: Int -> Int -> Int -> Int
    factIter x y z 
      | y <= z = factIter (x*y) (y+1) z
      | otherwise = x



f :: Int -> Int 
f n 
  | n < 2 = n
  | otherwise = f (n-1) + f (n-2)

fV2 :: Int -> Int
fV2 n 
  | n < 2 = n
  | otherwise = iter 2 1 0
    where
      iter :: Int -> Int -> Int -> Int
      iter i f1 f2
        | i == n+1 = f1
        | otherwise = iter (i + 1) (f1+f2) f1
  
