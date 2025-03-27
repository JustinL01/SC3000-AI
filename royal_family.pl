% Parent-child relationships
parent(queen_elizabeth, prince_charles).
parent(queen_elizabeth, princess_ann).
parent(queen_elizabeth, prince_andrew).
parent(queen_elizabeth, prince_edward).

% Birth order
older(prince_charles, princess_ann).
older(princess_ann, prince_andrew).
older(prince_andrew, prince_edward).

% Gender
male(prince_charles).
male(prince_andrew).
male(prince_edward).
female(princess_ann).

% Child definition
child(X) :- parent(queen_elizabeth, X).

male_child(X) :- child(X), male(X).
female_child(X) :- child(X), female(X).

% Succession rule - OLD
succession_list_old(List) :-
    findall(M, male_child(M), Males),
    findall(F, female_child(F), Females),
    sort_by_birth(Males, MalesSorted),
    sort_by_birth(Females, FemalesSorted),
    append(MalesSorted, FemalesSorted, List).

% Define birth order
before(X, Y) :- older(X, Y).
before(X, Y) :- older(X, Z), before(Z, Y).

less_than(X, Y) :- before(X, Y).
less_than(X, Y) :- \+ before(Y, X), X @< Y.

sort_by_birth(List, Sorted) :-
    predsort(compare_birth, List, Sorted).

compare_birth(<, A, B) :- less_than(A, B).
compare_birth(>, A, B) :- less_than(B, A).
compare_birth(=, A, B) :- \+ less_than(A, B), \+ less_than(B, A).
