% Facts
parent(queen_elizabeth, prince_charles).
parent(queen_elizabeth, princess_ann).
parent(queen_elizabeth, prince_andrew).
parent(queen_elizabeth, prince_edward).

older(prince_charles, princess_ann).
older(princess_ann, prince_andrew).
older(prince_andrew, prince_edward).

male(prince_charles).
male(prince_andrew).
male(prince_edward).
female(princess_ann).

% Transitive older
before(X, Y) :- older(X, Y).
before(X, Y) :- older(X, Z), before(Z, Y).

% All children
child(X) :- parent(queen_elizabeth, X).

male_child(X) :- child(X), male(X).
female_child(X) :- child(X), female(X).

% Sorting by birth
sort_by_birth(List, Sorted) :- predsort(compare_birth, List, Sorted).

compare_birth(<, A, B) :- before(A, B).
compare_birth(>, A, B) :- before(B, A).
compare_birth(=, A, B) :- \+ before(A, B), \+ before(B, A).

% Succession list (old rule)
succession_list_old(List) :-
    findall(M, male_child(M), Males),
    findall(F, female_child(F), Females),
    sort_by_birth(Males, SortedMales),
    sort_by_birth(Females, SortedFemales),
    append(SortedMales, SortedFemales, List).
