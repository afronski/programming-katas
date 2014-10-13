% Test helper:

test(Summary, Predicate) :-
  string_concat('\n Test "', Summary, Buf),
  string_concat(Buf, '" is running ... ', Message),

  write(Message),
    call(Predicate),
  write('Done.\n\n').

% Facts:

force(anakin, 9).
force(luke, 10).

% Relations:

stronger(X, Y) :-
  force(X, FX),
  force(Y, FY),
  FX > FY.

% Tests:

test_suite :-
  test('Luke is stronger than Anakin', (
    stronger(luke, anakin)
  )).

% Run tests on compile.

:-
  test_suite,
  write('All tests finished.\n\n').