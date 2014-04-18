% Concurrency excersises in Erlang.
%
% All assignments are taken from:
%   http://www.erlang.org/course/exercises.html

-module(concurrency).
-compile(export_all).

% P01:  Write a function which starts 2 processes, and sends a message M times forewards
%       and backwards between them. After the messages have been sent the processes should
%       terminate gracefully.

startBidirectionalMessenger() ->
  FirstPid = spawn(fun bidirectionalMessenger/0),
  SecondPid = spawn(fun bidirectionalMessenger/0),
  FirstPid ! { "Beep!", 5, SecondPid }.

bidirectionalMessenger() ->
  receive
    { Message, 0, From } ->
      To = self(),
      From ! { Message, 0, To },
      exit(done);

    { Message, M, From } ->
      To = self(),
      io:format("[from (~w)] ~s [to (~w)] Boop! (left ~w)~n", [ From, Message, To, M ]),
      From ! { Message, M - 1, self() },
      bidirectionalMessenger();

    _ ->
      bidirectionalMessenger()
  end.

% P02:  Write a function which starts N processes in a ring, and sends a message M times
%       around all the processes in the ring. After the messages have been sent the processes
%       should terminate gracefully.

startRingMessenger(N, M) ->
  Ring = createRing(N),

  io:format("Created ring with: ~w", [ hd(Ring) ]),
  lists:foreach(fun(Node) ->
                  io:format(" -> ~w", [ Node ])
                end, lists:reverse(Ring)),
  io:format("~n"),

  EntryPoint = hd(Ring),
  EntryPoint ! { message, M }.

createRing(N) when N > 1                -> createRingPart(N, empty, []).

createRingPart(0, _, Members)           ->
  First = hd(Members),
  First ! { set_previous, lists:last(Members) },
  Members;

createRingPart(Count, Pid, Members)     ->
  Node =  case Pid of
            empty -> spawn(fun firstPartOfRing/0);
            _     -> spawn(fun() -> handle(Pid) end)
          end,
  createRingPart(Count - 1, Node, Members ++ [ Node ]).

firstPartOfRing() ->
  receive
    { set_previous, Pid } -> handle(Pid);
    _                     -> firstPartOfRing()
  end.

handle(Pid) ->
  receive
    { message, 1 } ->
      io:format("Message from ~w to ~w (last one)~n", [ self(), Pid ]),
      Pid ! { finish },
      exit(done);

    { message, Count } ->
      io:format("Message from ~w to ~w (left ~w)~n", [ self(), Pid, Count ]),
      Pid ! { message, Count - 1 },
      handle(Pid);

    { finish } ->
      Pid ! { finish },
      exit(done);

    _ ->
      handle(Pid)
  end.

% P03:   Write a function which starts N processes in a star, and sends a message to each of
%        them M times. After the messages have been sent the processes should terminate gracefully.

startStar(N, M) ->
  Pid = spawn(fun() -> starElement(N * M, 0) end),
  io:format("Star created with: ~w.~n", [ Pid ]),
  Pid ! { start, N, M }.

starElement(Limit, Current) when Limit == Current ->
  io:format("All done.~n"),
  exit(done);

starElement(Limit, Current) ->
  receive
    { start, N, M } ->
      Children = createStarNode(self(), N),
      io:format("Amount of children created: ~w.~n", [ length(Children) ]),
      sendMessageToStar(Children, M),
      starElement(Limit, Current);

    { message, Pid } ->
      io:format("Received message ~w from ~w.~n", [message, Pid]),
      starElement(Limit, Current + 1);

    _ ->
      starElement(Limit, Current)
  end.

createStarNode(Message, N) ->
  First = spawn(fun() -> handleStarMessage(Message) end),
  createStarNode(Message, N - 1, [ First ]).

createStarNode(Message, 1, Children) ->
  Child = spawn(fun() -> handleStarMessage(Message) end),
  Children ++ [ Child ];

createStarNode(Message, N, Children) ->
  Child = spawn(fun() -> handleStarMessage(Message) end),
  createStarNode(Message, N - 1, Children ++ [Child]).

handleStarMessage(Message) ->
  receive
    { stop } ->
      exit(done);

    { message } ->
      Message ! { message, self() },
      handleStarMessage(Message);

    _ ->
      handleStarMessage(Message)
  end.

sendMessageToStar(Children, 0) ->
  io:format("Stopping children.~n", []),
  lists:foreach(fun(Child) -> io:format("."), Child ! { stop } end, Children);

sendMessageToStar(Children, M) ->
  io:format("Sending message ~w.~n", [ M ]),
  lists:foreach(fun(Child) -> io:format("."), Child ! { message } end, Children),
  sendMessageToStar(Children, M - 1).