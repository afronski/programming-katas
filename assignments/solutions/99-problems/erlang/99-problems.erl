-module('99-problems').
-compile(export_all).

% P01: Find the last element of a list.

last(L) ->
  lists:last(L).

% P02: Find the last but one element of a list.

lastButOne(L) ->
  hd(lists:nthtail(length(L) - 2, L)).

% P03: Find the k-th element of a list.

kthElement(K, L) ->
  lists:nth(K, L).

% P04: Find the number of elements of a list.

listLength(L) ->
  length(L).

% P05: Reverse a list.

reverse(L) ->
  lists:reverse(L).

% P06: Find out whether a list is a palindrome.

isPalindrome(L) ->
  lists:reverse(L) == L.

% P07: Flatten a nested list structure.

flatten(L) ->
  lists:flatten(L).

% P08: Eliminate consecutive duplicates of list elements.

compress(H, [ H | T ]) -> [ H | T ];
compress(H, L)         -> [ H | L ].

compress(L) ->
  lists:foldr(fun compress/2, [], L).

% P09: Pack consecutive duplicates of list elements into sublists.

pack(H, [ [ H | T ] | TT ]) -> [ [ H, H | T ] | TT ];
pack(H, L)                  -> [ [ H ] | L ].

pack(L) ->
  lists:foldr(fun pack/2, [], L).

% P10: Run-length encoding of a list.

encode(H, [])                       -> [ [ 1, H ] ];
encode(H, [ [ N, H ] | T ])         -> [ [ N + 1, H ] | T ];
encode(H, [ [ _, _ ] | _ ] = L)     -> [ [ 1, H ] | L ].

encode(L) ->
  lists:foldr(fun encode/2, [], L).

% P11: Modified run-length encoding.

encodeWithoutDuplicates(H, [])                       -> [ H ];
encodeWithoutDuplicates(H, [ H | T ])                -> [ [ 2, H ] | T ];
encodeWithoutDuplicates(H, [ [ N, H ] | T ])         -> [ [ N + 1, H ] | T ];
encodeWithoutDuplicates(H, [ [ _, _ ] | _ ] = L)     -> [ H | L ];
encodeWithoutDuplicates(H, [ _ | _ ] = L)            -> [ H | L ].

encodeWithoutDuplicates(L) ->
  lists:foldr(fun encodeWithoutDuplicates/2, [], L).

% P12: Decode a run-length encoded list.

decode([ N, C ], L) -> lists:duplicate(N, C) ++ L;
decode(C, L)        -> [ C | L ].

decode(L) ->
  lists:foldr(fun decode/2, [], L).

% P13: Run-length encoding of a list (direct solution).

encodeDirect(L) ->
  encodeWithoutDuplicates(L).

% P14: Duplicate the elements of a list.

duplicate(H, []) -> [ H, H ];
duplicate(H, L)  -> [ H, H ] ++ L.

duplicate(L) ->
  lists:foldr(fun duplicate/2, [], L).

% P15: Duplicate the elements of a list a given number of times.

multiplicate(N, H, []) -> lists:duplicate(N, H);
multiplicate(N, H, L)  -> lists:duplicate(N, H) ++ L.

multiplicate(L, N) ->
  lists:foldr(fun(H, T) ->
                multiplicate(N, H, T)
              end, [], L).

% P16: Drop every n-th element from a list.

drop([], _) -> [];
drop(L, N)  -> drop(L, N, 1, []).

drop([], _, _, Result)                                  -> lists:reverse(Result);
drop([ _ | T ], N, Count, Result) when Count rem N == 0 -> drop(T, N, Count + 1, Result);
drop([ H | T ], N, Count, Result)                       -> drop(T, N, Count + 1, [ H | Result ]).

% P17: Split a list into two parts - the length of the first part is given.

split([], _)                    -> [];
split(L, 0)                     -> [L,[]];
split(L, N) when length(L) < N  -> [];
split([ H | T ], N)             -> split(T, N, 1, [ H ]).

split(L, N, Count, Result) when Count >= N  -> [ lists:reverse(Result), L ];
split([ H | T ], N, Count, Result)          -> split(T, N, Count + 1, [ H | Result ]).

% P18: Extract a slice from a list, by given indexes (result should contain values from both indexes).

slice(L, I, K) when I =< K, I >= 1, K >= 1 -> slice(L, 1, 1, I, K, []).

slice(_, _, _, I, K, Result) when length(Result) >= K - I + 1 -> lists:reverse(Result);
slice([ _ | T ], II, KK, I, K, Result) when II < I            -> slice(T, II + 1, KK + 1, I, K, Result);
slice([ H | T ], II, KK, I, K, Result) when II >= I, KK =< K  -> slice(T, II + 1, KK + 1, I, K, [ H | Result ]).

% P19: Rotate a list N places to the right (negative number means rotation to the left).

rotate(L, N) when N =:= 0 -> L;
rotate(L, N) when N < 0   -> rotateLeft(L, -N, []);
rotate(L, N) when N > 0   -> rotateRight(lists:reverse(L), N, []).

rotateLeft([ H | T ], N, Result) when N > 0 -> rotateLeft(T, N - 1, Result ++ [ H ]);
rotateLeft(L, N, Result) when N =:= 0       -> L ++ Result.

rotateRight([ H | T ], N, Result) when N > 0 -> rotateRight(T, N - 1, [ H | Result ]);
rotateRight(L, N, Result) when N =:= 0       -> Result ++ lists:reverse(L).

% P20: Remove the k-th element from a list (index of first element is 1).

remove(L, K)                                  -> remove(L, 1, K, []).

remove([ _ | T ], I, K, Result) when I =:= K  -> Result ++ T;
remove([ H | T ], I, K, Result) when I < K    -> remove(T, I + 1, K, Result ++ [ H ]).

% P21: Insert an element at a given position into a list.

insert(L, K, E)                                       -> insert(L, 1, K, E, []).

insert([], I, K, E, Result) when I =:= K              -> Result ++ [ E ];
insert([ H | T ], I, K, E, Result) when I =:= K       -> Result ++ [ E | [ H | T ] ];
insert([ H | T ], I, K, E, Result) when I < K, I > 0  -> insert(T, I + 1, K, E, Result ++ [ H ]).

% P22: Create a list containing all integers within a given range (and will contain both limits).

sequence(Start, End) when Start =< End  -> sequence(Start, End, []).

sequence(I, E, Result) when I =< E      -> sequence(I + 1, E, Result ++ [ I ]);
sequence(I, E, Result) when I > E       -> Result.

% P23: Extract a given number of randomly selected elements from a list (without using the same value many times).

selectRandom(_, N) when N =:= 0               -> [];
selectRandom(L, N) when N > 0, N =< length(L) -> selectRandom(L, N, []).

selectRandom(_, N, Result) when N =:= 0       -> Result;
selectRandom(L, N, Result) when N > 0         ->
  RandomizedIndex = random:uniform(length(L)),
  Element = lists:nth(RandomizedIndex, L),
  selectRandom(remove(L, RandomizedIndex), N - 1, Result ++ [ Element ]).

% P24: Lotto: Draw 'N' different random numbers from the set '1 .. M'.

lotto(N, M) when N =< M ->
  selectRandom(sequence(1, M), N).

% P25: Generate a random permutation of the elements of a list.

permutation(L) ->
  selectRandom(L, length(L)).

% P26: Generate the combinations of 'K' distinct objects chosen from the 'N' elements of a list.

combinations(0, _) -> [];
combinations(1, L) -> [ [ X ] || X <- L ];
combinations(N, L) -> [ [ H | Res ] || H <- L, Res <- combinations(N - 1, L), false == lists:member(H, Res) ].

% P27: Group the elements of a set into disjoint subsets.
%
%      a) In how many ways can a group of 9 people work in 3 disjoint subgroups 
%         of 2, 3 and 4 persons? Write a predicate that generates all the 
%         possibilities via backtracking.

combinationWithoutRepetition(0, Xs) -> [ { [], Xs } ];
combinationWithoutRepetition(_, []) -> [];
combinationWithoutRepetition(N, [ X | Xs ]) -> 
    Ts = [ { [ X | Ys ], Zs } || { Ys, Zs } <- combinationWithoutRepetition(N - 1, Xs) ],
    Ds = [ { Ys, [ X | Zs ] } || { Ys, Zs } <- combinationWithoutRepetition(N, Xs) ],
    Ts ++ Ds.

group3(L) ->
    [ [ Twos, Threes, Fours ] || { Twos, L2 } <- combinationWithoutRepetition(2, L), 
                                 { Threes, L3 } <- combinationWithoutRepetition(3, L2), 
                                 { Fours, _ } <- combinationWithoutRepetition(4, L3) ].                           

%      b) Generalize the above predicate in a way that we can specify a 
%         list of group sizes and the predicate will return a list of groups.

group([], _) -> [[]];
group([ N | Ns ], Xs) -> 
    [ [ G | Gs ] || { G, Rs } <- combinationWithoutRepetition(N, Xs),
                    Gs <- group(Ns, Rs) ].

% P28: Sorting a list of lists according to length of sublists.
%
%      a) We suppose that a list (InList) contains elements that are lists themselves. 
%         The objective is to sort the elements of InList according to their length. 
%         E.g. short lists first, longer lists later, or vice versa.

lsort([])                                                    -> [];
lsort([ H | T ])                                             -> lsort(H, T, [], []).

lsort(P, [], Left, Right)                                    -> lsort(Left) ++ [ P ] ++ lsort(Right);
lsort(P, [ H | T ], Left, Right) when length(H) >= length(P) -> lsort(P, T, Left, [ H | Right ]);
lsort(P, [ H | T ], Left, Right)                             -> lsort(P, T, [ H | Left ], Right).

%      b) Again, we suppose that a list (InList) contains elements that are lists 
%         themselves. But this time the objective is to sort the elements of InList 
%         according to their length frequency; i.e. in the default, where sorting 
%         is done ascendingly, lists with rare lengths are placed first, others 
%         with a more frequent length come later.

groupBy(F, L) -> lists:foldr(fun({ K, V }, D) -> dict:append(K, V, D) end, dict:new(), [ { F(X), X } || X <- L ]).

lfsort(L) ->
    Sorted = lsort(L),
    GrouppedEqualLengthDict = groupBy(fun (A) -> length(A) end, Sorted),
    GrouppedEqualLength = dict:fold(fun (_K, V, Acc) -> [ V | Acc ] end, [], GrouppedEqualLengthDict),
    lists:append(lsort(GrouppedEqualLength)).
