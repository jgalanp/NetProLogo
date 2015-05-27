% Von Koch's conjecture

% Von Koch's Conjecture: Given a tree with N nodes (and hence N-1 edges).
% Find a way to enumerate the nodes from 1 to n and, accordingly, the
% edges from 1 to N-1 in such a way, that for each edge K the difference
% of its node numbers equals to K. The conjecture is that this is always
% possible.

% Example:      *      Solution:     4    Note that the node number 
%              /                    /     differences of adjacent nodes
%        * -- *               3 -- 1      are just the numbers 1,2,3,4
%        |     \              |     \     which can be used to enumerate
%        *      *             2      5    the edges.

% vonkoch(G,Enum) :- the nodes of the graph G can be enumerated
%    as described in Enum. Enum is a list of pairs [X,K], where X
%    is a node and K the corresponding number. 

vonkoch(Graph,Enum) :- 
%   is_tree(Graph),            % check before doing too much work!
   Graph = graph(Ns,_),
   length(Ns,N),
   human_gterm(Hs,Graph),
   vonkoch(Hs,N,Enum).

vonkoch([IsolatedNode],1,[[IsolatedNode,1]|_]).  % special case
vonkoch(EdgeList,N,Enum) :-
   range(1,N,NodeNumberList), 
   N1 is N-1,range(1,N1,EdgeNumberList),
   bind(EdgeList,NodeNumberList,EdgeNumberList,Enum).

% The tree is given as an edge list; e.g. [d-a,a-g,b-c,e-f,b-e,a-b].
% Our problem is to find a bijection between the nodes (a,b,c,...) and
% the integer numbers 1..N which is compatible with the condition
% cited above. In order to construct this bijection, we use an open-
% ended list Enum; and we scan the given edge list.

bind([],_,_,_) :- !.
bind([V1-V2|Es],NodeNumbers,EdgeNumbers,Enum) :-
   bind_node(V1,K1,NodeNumbers,NodeNumbers1,Enum), 
   bind_node(V2,K2,NodeNumbers1,NodeNumbers2,Enum), 
   D is abs(K1-K2), select(D,EdgeNumbers,EdgeNumbers1),
   bind(Es,NodeNumbers2,EdgeNumbers1,Enum).

% bind_node(V,K,NodeNumsIn,NodeNumsOut,Enum) :-  
% [V,K] is an element of the list Enum, and there is no V1 \= V 
% such that [V1,K] is in Enum, and there is no K1 \= K such that 
% V =:= K1 is in Enum. In the case V gets a new number, it is
% selected from the set NodeNumsIn; what remains is NodeNumsOut.
% (node,integer,integer-list,integer-list,enumeration)  (+,?,+,-,?)

bind_node(V,K,NodeNumbers,NodeNumbers,Enum) :- 
   memberchk([V,K1],Enum), number(K1), !, K = K1.
bind_node(V,K,NodeNumbers,NodeNumbers1,Enum) :- 
   select(K,NodeNumbers,NodeNumbers1), memberchk([V,K],Enum).

% range(A,B,L) :- L is the list of numbers A..B

range(B,B,[B]) :- !.
range(A,B,[A|L]) :- A < B, A1 is A+1, range(A1,B,L).

% test suite ------------------------------------------------------------

solve-von-koch(TH,X) :-
   human_gterm(TH,T),
   vonkoch(T,Enum),
   reverse(X,Enum). % To remove the undefined part of the open-ended list
   
test_tree(1,[a-b,b-c,c-d,c-e]).
test_tree(2,[d-a,a-g,b-c,e-f,b-e,a-b]).
test_tree(3,[g-a,i-a,a-h,b-a,k-d,c-d,m-q,p-n,q-n,e-q,e-c,f-c,c-a]).
test_tree(4,[a]).

% Solution for the tree given in the problem statement (picture p92b.gif):
%
% ?- solve-von-koch(2,X).
% X = [[a, 1], [b, 5], [d, 6], [g, 7], [c, 2], [e, 3], [f, 4]]
%
% Remark: In most cases, there are many different solutions.

%-------------------------------------------------------------------------
% Conversions between graph representations

% We use the following notation:
%
% adjacency-list (alist): [n(b,[c,g,h]), n(c,[b,d,f,h]), n(d,[c,f]), ...]
%
% graph-term (gterm)  graph([b,c,d,f,g,h,k],[e(b,c),e(b,g),e(b,h), ...]) or
%                     digraph([r,s,t,u],[a(r,s),a(r,t),a(s,t), ...])
%
% edge-clause (ecl):  edge(b,g).  (in program database)
% arc-clause (acl):   arc(r,s).   (in program database)
%
% human-friendly (hf): [a-b,c,g-h,d-e]  or [a>b,h>g,c,b>a]
%
% The main conversion predicates are: alist_gterm/3 and human_gterm/2 which
% both (hopefully) work in either direction and for graphs as well as
% for digraphs, labelled or not.

% alist_gterm(Type,AL,GT) :- convert between adjacency-list and graph-term
%    representation. Type is either 'graph' or 'digraph'.
%    (atom,alist,gterm)  (+,+,?) or (?,?,+)

alist_gterm(Type,AL,GT):- nonvar(GT), !, gterm_to_alist(GT,Type,AL).
alist_gterm(Type,AL,GT):- atom(Type), nonvar(AL), alist_to_gterm(Type,AL,GT).

gterm_to_alist(graph(Ns,Es),graph,AL) :- memberchk(e(_,_,_),Es), ! ,
   lgt_al(Ns,Es,AL).
gterm_to_alist(graph(Ns,Es),graph,AL) :- !, 
   gt_al(Ns,Es,AL).
gterm_to_alist(digraph(Ns,As),digraph,AL) :- memberchk(a(_,_,_),As), !,
   ldt_al(Ns,As,AL).
gterm_to_alist(digraph(Ns,As),digraph,AL) :- 
   dt_al(Ns,As,AL).

% labelled graph
lgt_al([],_,[]).
lgt_al([V|Vs],Es,[n(V,L)|Ns]) :-
   findall(T,((member(e(X,V,I),Es) ; member(e(V,X,I),Es)),T = X/I),L),
   lgt_al(Vs,Es,Ns).

% unlabelled graph
gt_al([],_,[]).
gt_al([V|Vs],Es,[n(V,L)|Ns]) :-
   findall(X,(member(e(X,V),Es) ; member(e(V,X),Es)),L), gt_al(Vs,Es,Ns).

% labelled digraph
ldt_al([],_,[]).
ldt_al([V|Vs],As,[n(V,L)|Ns]) :-
   findall(T,(member(a(V,X,I),As), T=X/I),L), ldt_al(Vs,As,Ns).

% unlabelled digraph
dt_al([],_,[]).
dt_al([V|Vs],As,[n(V,L)|Ns]) :-
   findall(X,member(a(V,X),As),L), dt_al(Vs,As,Ns).


alist_to_gterm(graph,AL,graph(Ns,Es)) :- !, al_gt(AL,Ns,EsU,[]), sort(EsU,Es).
alist_to_gterm(digraph,AL,digraph(Ns,As)) :- al_dt(AL,Ns,AsU,[]), sort(AsU,As).

al_gt([],[],Es,Es).
al_gt([n(V,Xs)|Ns],[V|Vs],Es,Acc) :- 
   add_edges(V,Xs,Acc1,Acc), al_gt(Ns,Vs,Es,Acc1). 

add_edges(_,[],Es,Es).
add_edges(V,[X/_|Xs],Es,Acc) :- V @> X, !, add_edges(V,Xs,Es,Acc).
add_edges(V,[X|Xs],Es,Acc) :- V @> X, !, add_edges(V,Xs,Es,Acc).
add_edges(V,[X/I|Xs],Es,Acc) :- V @=< X, !, add_edges(V,Xs,Es,[e(V,X,I)|Acc]).
add_edges(V,[X|Xs],Es,Acc) :- V @=< X, add_edges(V,Xs,Es,[e(V,X)|Acc]).

al_dt([],[],As,As).
al_dt([n(V,Xs)|Ns],[V|Vs],As,Acc) :- 
   add_arcs(V,Xs,Acc1,Acc), al_dt(Ns,Vs,As,Acc1). 

add_arcs(_,[],As,As).
add_arcs(V,[X/I|Xs],As,Acc) :- !, add_arcs(V,Xs,As,[a(V,X,I)|Acc]).
add_arcs(V,[X|Xs],As,Acc) :- add_arcs(V,Xs,As,[a(V,X)|Acc]).

% ---------------------------------------------------------------------------

% ecl_to_gterm(GT) :- construct a graph-term from edge/2 facts in the
%    program database.

ecl_to_gterm(GT) :-
   findall(E,(edge(X,Y),E=X-Y),Es), human_gterm(Es,GT).

% acl_to_gterm(GT) :- construct a graph-term from arc/2 facts in the
%    program database.

acl_to_gterm(GT) :-
   findall(A,(arc(X,Y),A= >(X,Y)),As), human_gterm(As,GT).

% ---------------------------------------------------------------------------

% human_gterm(HF,GT) :- convert between human-friendly and graph-term
%    representation.
%    (list,gterm) (+,?) or (?,+)

human_gterm(HF,GT):- nonvar(GT), !, gterm_to_human(GT,HF).
human_gterm(HF,GT):- nonvar(HF), human_to_gterm(HF,GT).

gterm_to_human(graph(Ns,Es),HF) :-  memberchk(e(_,_,_),Es), !, 
   lgt_hf(Ns,Es,HF).
gterm_to_human(graph(Ns,Es),HF) :-  !, 
   gt_hf(Ns,Es,HF).
gterm_to_human(digraph(Ns,As),HF) :- memberchk(a(_,_,_),As), !, 
   ldt_hf(Ns,As,HF).
gterm_to_human(digraph(Ns,As),HF) :- 
   dt_hf(Ns,As,HF).

% labelled graph
lgt_hf(Ns,[],Ns).
lgt_hf(Ns,[e(X,Y,I)|Es],[X-Y/I|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   lgt_hf(Ns2,Es,Hs).

% unlabelled graph
gt_hf(Ns,[],Ns).
gt_hf(Ns,[e(X,Y)|Es],[X-Y|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   gt_hf(Ns2,Es,Hs).

% labelled digraph
ldt_hf(Ns,[],Ns).
ldt_hf(Ns,[a(X,Y,I)|As],[X>Y/I|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   ldt_hf(Ns2,As,Hs).

% unlabelled digraph
dt_hf(Ns,[],Ns).
dt_hf(Ns,[a(X,Y)|As],[X>Y|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   dt_hf(Ns2,As,Hs).

% we guess that if there is a '>' term then it's a digraph, else a graph
human_to_gterm(HF,digraph(Ns,As)) :- memberchk(_>_,HF), !, 
   hf_dt(HF,Ns1,As1), sort(Ns1,Ns), sort(As1,As).
human_to_gterm(HF,graph(Ns,Es)) :- 
   hf_gt(HF,Ns1,Es1), sort(Ns1,Ns), sort(Es1,Es).
% remember: sort/2 removes duplicates!

hf_gt([],[],[]).
hf_gt([X-Y/I|Hs],[X,Y|Ns],[e(U,V,I)|Es]) :- !, 
   sort0([X,Y],[U,V]), hf_gt(Hs,Ns,Es).
hf_gt([X-Y|Hs],[X,Y|Ns],[e(U,V)|Es]) :- !,
   sort0([X,Y],[U,V]), hf_gt(Hs,Ns,Es).
hf_gt([H|Hs],[H|Ns],Es) :- hf_gt(Hs,Ns,Es).

hf_dt([],[],[]).
hf_dt([X>Y/I|Hs],[X,Y|Ns],[a(X,Y,I)|As]) :- !, 
   hf_dt(Hs,Ns,As).
hf_dt([X>Y|Hs],[X,Y|Ns],[a(X,Y)|As]) :- !,
   hf_dt(Hs,Ns,As).
hf_dt([H|Hs],[H|Ns],As) :-  hf_dt(Hs,Ns,As).

sort0([X,Y],[X,Y]) :- X @=< Y, !.
sort0([X,Y],[Y,X]) :- X @> Y.

% tests ------------------------------------------------------------------

testdata([b-c, f-c, g-h, d, f-b, k-f, h-g]).
testdata([s > r, t, u > r, s > u, u > s, v > u]).
testdata([b-c/5, f-c/9, g-h/12, d, f-b/13, k-f/3, h-g/7]).
testdata([p>q/9, m>q/7, k, p>m/5]).
testdata([a,b(4711),c]).
testdata([a-b]).
testdata([]).

test :- 
   testdata(H1),
   write(H1), nl,
   human_gterm(H1,G1),
   alist_gterm(Type,AL,G1), 
   alist_gterm(Type,AL,G2),
   human_gterm(H2,G2),
   human_gterm(H2,G1),
   write(G1), nl, nl,
   fail.
test.
