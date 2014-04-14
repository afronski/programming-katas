-module(erlang_kata_tests).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

-include("erlang_kata_app.hrl").

% Helpers.

listOf(What, Times) ->
	lists:duplicate(Times, What).

% Tests.

all_missed_test() ->
	?assertEqual(0, erlang_kata_app:game(listOf(0, 20))).

all_ones_test() ->
	?assertEqual(20, erlang_kata_app:game(listOf(1, 20))).

first_spare_test() ->
	?assertEqual(16, erlang_kata_app:game([ 5, 5, 3 ] ++ listOf(0, 17))).

all_spares_test() ->
	?assertEqual(150, erlang_kata_app:game(listOf(5, 21))).

last_before_last_spare_test() ->
	?assertEqual(18, erlang_kata_app:game(listOf(0, 16) ++ [ 5, 5, 3, 2 ])).

last_spare_test() ->
	?assertEqual(15, erlang_kata_app:game(listOf(0, 18) ++ [ 5, 5, 5 ])).

first_strike_test() ->
	?assertEqual(24, erlang_kata_app:game([ ?STRIKE, 3, 4 ] ++ listOf(0, 16))).

last_strike_test() ->
	LastStrikes = [ ?STRIKE, ?STRIKE, ?STRIKE ],
	?assertEqual(30, erlang_kata_app:game(listOf(0, 18) ++ LastStrikes)).

last_before_last_strike_test() ->
	?assertEqual(20, erlang_kata_app:game(listOf(0, 16) ++ [ ?STRIKE, 3, 2 ])).

all_strikes_test() ->
	?assertEqual(300, erlang_kata_app:game(listOf(?STRIKE, 20))).