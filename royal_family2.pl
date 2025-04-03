% Parent-child relationships
parent(queen_elizabeth, prince_charles).
parent(queen_elizabeth, princess_ann).
parent(queen_elizabeth, prince_andrew).
parent(queen_elizabeth, prince_edward).

% Birth order
older(prince_charles, princess_ann).
older(princess_ann, prince_andrew).
older(prince_andrew, prince_edward).

% Gender (not needed for new rule, but kept for completeness)
male(prince_charles).
male(prince_andrew).
male(prince_edward).
female(princess_ann).

% Define children
child(X) :- parent(queen_elizabeth, X).

% Birth comparison logic (unchanged)
before(X, Y) :- older(X, Y).
before(X, Y) :- older(X, Z), before(Z, Y).

sort_by_birth(List, Sorted) :- predsort(compare_birth, List, Sorted).

compare_birth(<, A, B) :- before(A, B).
compare_birth(>, A, B) :- before(B, A).
compare_birth(=, A, B) :- \+ before(A, B), \+ before(B, A).

% New succession rule (gender-neutral)
succession_list_new(List) :-
    findall(C, child(C), Children),
    sort_by_birth(Children, List).
