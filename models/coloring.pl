:- dynamic(vertex/1).
:- dynamic(arc/2).
:- dynamic(color/1).

%vextexColoring(+Nodos,+Colores,+Acumulador,-Coloreado).
vertexColoring([],C,R,R).
vertexColoring([N|L1],L2,R,R2) :-
	member(C,L2),
	not((member([N1,C],R),(arc(N,N1);arc(N1,N)))),
	vertexColoring(L1,L2,[[N,C]|R],R2).
