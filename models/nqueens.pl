% N-Queens problem

queens(N,Sol) :- findall(X,between(1,N,X),L),
		 aux(L,[],Sol).

aux([],Sol,Sol) :- !.
aux(L1,L2,Sol) :- select(X,L1,L3),no_attack(X,L2),aux(L3,[X|L2],Sol).
	
       

no_attack(Y,E) :-
    no_attack(Y,E,1).
no_attack(_,[],_).
no_attack(Y,[Y1|L],D) :-
       Y1-Y =\= D,
       Y-Y1 =\= D,
       D1 is D+1,
       no_attack(Y,L,D1).
