% --- Parent-child relationships ---
parent(queen_elizabeth, prince_charles).
parent(queen_elizabeth, princess_ann).
parent(queen_elizabeth, prince_andrew).
parent(queen_elizabeth, prince_edward).

% --- Birth order (older(A, B): A is older than B) ---
older(prince_charles, princess_ann).
older(princess_ann, prince_andrew).
older(prince_andrew, prince_edward).

% --- Define child ---
child(X) :- parent(queen_elizabeth, X).

% --- Succession rule (new rule: birth order only) ---
succession_list_new(SortedList) :-
    findall(C, child(C), Children),
    sort_by_birth(Children, SortedList).

% --- Sorting by birth order ---
before(X, Y) :- older(X, Y).
before(X, Y) :- older(X, Z), before(Z, Y).

less_than(X, Y) :- before(X, Y).
less_than(X, Y) :- \+ before(Y, X), X @< Y.

sort_by_birth(List, Sorted) :-
    predsort(compare_birth, List, Sorted).

compare_birth(<, A, B) :- less_than(A, B).
compare_birth(>, A, B) :- less_than(B, A).
compare_birth(=, A, B) :- \+ less_than(A, B), \+ less_than(B, A).
