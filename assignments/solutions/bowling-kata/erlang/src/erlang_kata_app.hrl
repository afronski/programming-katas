-define(STRIKE, 10).
-define(NUMBER_OF_FRAMES, 10).
-define(is_spare(A, B), A + B =:= ?STRIKE).
-define(not_last_frame(FrameNumber), FrameNumber =/= 1).