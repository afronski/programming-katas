; P01: Find the last element of a list.

(defn another-last [ xs ] (last xs))

; P02: Find the last but one element of a list.

(defn one-but-last [ xs ]
  (if (= 2 (count xs))
      (first xs)
      (recur (rest xs))))

; P03: Find the k-th element of a list.

(defn kth [ n xs ] (nth xs n))

; P04: Find the number of elements of a list.

(defn another-length [ xs ] (count xs))

; P05: Reverse a list.

(defn another-reverse [ xs ] (reverse xs))