-module(erlang_kata_app).
-export([ fizzbuzz/1 ]).

fizzbuzz(List) ->
	Replacer =
		fun
			(A) when A rem 15 =:= 0 -> "FizzBuzz";
			(A) when A rem 5 =:= 0 -> "Buzz";
			(A) when A rem 3 =:= 0 -> "Fizz";
			(A) -> A
		end,
	lists:map(Replacer, List).