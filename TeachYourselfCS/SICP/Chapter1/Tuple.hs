--data Tuple a b = Tuple a b
--
--car :: Tuple a b -> a
--car Tuple x y = x
--
--cdr :: Tuple a b -> b
--cdr Tuple x y = y

cons :: a -> b -> (Int -> Either a b)
cons x y = \pick -> case pick of
  1 ->  Left x
  2 ->  Right y
  _ -> error "Input can only be 1 or 2"

unpackLeft :: Either a b -> a
unpackLeft Left x = x

unpackRight :: Either a b -> b
unpackRight Right y = y

car :: (Int->Either a b) -> (Int -> a)
car f = unpackLeft . f 

cdr :: (Int -> Either a b) -> (Int -> b)
cdr f = unpackRight . f 
