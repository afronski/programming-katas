-module(erlang_kata_tests).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

% Helpers.

listFromTo(From, To) ->
	lists:seq(From, To).

% Tests.

fizz_for_3_test() ->
	Result = erlang_kata_app:fizzbuzz(listFromTo(1, 3)),
	?assertEqual("Fizz", lists:nth(3, Result)).

buzz_for_5_test() ->
	Result = erlang_kata_app:fizzbuzz(listFromTo(1, 5)),
	?assertEqual("Buzz", lists:nth(5, Result)).

fizzbuzz_for_15_test() ->
	Result = erlang_kata_app:fizzbuzz(listFromTo(1, 15)),
	?assertEqual("FizzBuzz", lists:nth(15, Result)).

fizzbuzz_for_100_test() ->
	Result = erlang_kata_app:fizzbuzz(listFromTo(1, 100)),
	?assertEqual(27, length(lists:filter(fun(A) -> A =:= "Fizz" end, Result))),
	?assertEqual(14, length(lists:filter(fun(A) -> A =:= "Buzz" end, Result))),
	?assertEqual(6, length(lists:filter(fun(A) -> A =:= "FizzBuzz" end, Result))).