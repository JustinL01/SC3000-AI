% Facts
competitor(sumsum, appy).
rival(X, Y) :- competitor(X, Y).
smart_phone_technology(galactica_s3).
developed(sumsum, galactica_s3).
boss(stevey, appy).
stole(stevey, galactica_s3).
business(X) :- smart_phone_technology(X).

% Rule
unethical(X) :- boss(X, Y), stole(X, Z), business(Z), competitor(A, Y), developed(A, Z).
