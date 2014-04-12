-module(erlang_kata_tests).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

passing_test() ->
	?assertEqual(4, erlang_kata_app:assignment(2)).

failing_test() ->
	?assertEqual(8, erlang_kata_app:assignment(2)).