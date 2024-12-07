fastExpt :: Int -> Int -> Int
fastExpt b n = iter b n 1
  where
    iter :: Int -> Int -> Int -> Int
    iter b counter product
      | counter == 1 = product
      | even counter = iter b (div counter 2) (product * (b * b))
      | otherwise = iter b (counter - 1) (product * b)


mult :: Int -> Int -> Int
mult a n
  | n == 0 = 0
  | otherwise = a + mult a (n-1)

multV2 :: Int -> Int -> Int
multV2 a n = multIter 0 a n
  where
    multIter :: Int -> Int -> Int -> Int
    multIter sum a n
      | n == 0 = sum
      | otherwise = multIter (sum + a) a (n-1)


fastMult :: Int -> Int -> Int
fastMult a n
  | n == 0 = 0
  | even n = (2*a) + fastMult a (n-2)
  | otherwise = a + fastMult a (n-1)


fastMultV2 :: Int -> Int -> Int
fastMultV2 a n = fastMultIter 0 a n
  where
  fastMultIter :: Int -> Int -> Int -> Int
  fastMultIter c d n
    | n <= 0 = c + d
    | even n = fastMultIter c (2*d) (n-2)
    | otherwise = fastMultIter (c + d) d (n - 1)


fastGenOp :: Int -> Int -> (Int -> Int -> Int) -> (Int -> Int -> Int) -> Int
fastGenOp b n op1 op2 = fastGenOpIter 0 b n
  where
    fastGenOpIter :: Int -> Int -> Int -> Int
    fastGenOpIter a b n
      | n <= 0 = a
      | even n = fastGenOpIter a (op1 b b) (op2 n 2)
      | otherwise = fastGenOpIter (op1 a b) b (n-1)

fastMultV3 :: Int -> Int -> Int
fastMultV3 b n = fastGenOp b n (+) (-)
