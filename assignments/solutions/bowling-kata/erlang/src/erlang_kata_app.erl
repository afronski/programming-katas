-module(erlang_kata_app).
-export([ game/1 ]).

-include("erlang_kata_app.hrl").

game(Rolls) ->
	score(frames(Rolls, ?NUMBER_OF_FRAMES)).

score(Frames) ->
	SumOfElements =
		fun
				({ A, B }, Acc) -> A + B + Acc;
				({ A, B, C }, Acc) -> A + B + C + Acc
		end,
	lists:foldl(SumOfElements, 0, Frames).

frames(_, 0) -> [];

frames([ A, B, C | NextRolls ], FramesLeft)
	when ?is_spare(A, B) andalso ?not_last_frame(FramesLeft) ->
		[ { A, B, C } | frames([ C | NextRolls ], FramesLeft - 1) ];

frames([ A, B, C | NextRolls ], FramesLeft)
	when ?is_spare(A, B) ->
		[ { A, B, C } | frames(NextRolls, FramesLeft - 1) ];

frames([ ?STRIKE, A, B | NextRolls ], FramesLeft)
	when ?not_last_frame(FramesLeft)->
  	[ { ?STRIKE, A, B } | frames( [ A | [ B | NextRolls ] ], FramesLeft - 1) ];

frames([ ?STRIKE, A, B | NextRolls ], FramesLeft) ->
  [ { ?STRIKE, A, B } | frames(NextRolls, FramesLeft - 1) ];

frames([ A, B | NextRolls ], FramesLeft) ->
	[ { A, B } | frames(NextRolls, FramesLeft - 1) ].