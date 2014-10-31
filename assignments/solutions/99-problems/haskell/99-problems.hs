-- P01: Find the last element of a list.

last' xs = last xs

-- P02: Find the last but one element of a list.

lastButOne xs = last $ init xs

-- P03: Find the k-th element of a list.

kth k xs = xs !! k

-- P04: Find the number of elements of a list.

length' xs = length xs

-- P05: Reverse a list.

reverse' xs = reverse xs