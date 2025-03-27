padre(abraham, [herbert, homero]).
padre(clancy, [marge, patty, selma]).
padre(homero, [bart, lisa, maggie]).

madre(mona, [herbert, homero]).
madre(jackeline, [marge, patty, selma]).
madre(marge, [bart, lisa, maggie]).
madre(selma, [ling]).

genero(mujeres, [mona, jackeline, marge, patty, selma, lisa, maggie, ling]).
genero(hombres, [abraham, herbert, homero, clancy, bart]).


% Reglas para verificar parentesco  

es_mujer(X) :- genero(mujeres, Lista), member(X, Lista).
es_hombre(X) :- genero(hombres, Lista), member(X, Lista).

abuelo(X, Y) :-  padre(X, Hijos),      
    member(Hijo, Hijos),  
    (madre(Hijo, Nietos); padre(Hijo, Nietos)), 
    member(Y, Nietos),!. 
abuela(X, Y) :-
    madre(X, Hijos),      
    member(Hijo, Hijos),  
    (madre(Hijo, Nietos); padre(Hijo, Nietos)), 
    member(Y, Nietos),!. 

hijo(X, Y) :- (padre(Y, Hijos), member(X, Hijos), es_hombre(X),!);
              (madre(Y, Hijos), member(X, Hijos), es_hombre(X),!).

hija(X, Y) :- (padre(Y, Hijos), member(X, Hijos), es_mujer(X),!);
              (madre(Y, Hijos), member(X, Hijos), es_mujer(X),!).

hermano(X, Y) :- (madre(_, Hijos), member(X, Hijos), member(Y, Hijos), X \= Y, es_hombre(X),!).
hermana(X, Y) :- (madre(_, Hijos), member(X, Hijos), member(Y, Hijos), X \= Y, es_mujer(X),!).

tio(X, Y) :- (hermano(X, A), (hijo(Y, A); hija(Y, A)), es_hombre(X),!).
tia(X, Y) :- (hermana(X, A), (hijo(Y, A); hija(Y, A)), es_mujer(X),!).

primos(X, Y) :- ((madre(A, Hijos), member(X, Hijos),!); (padre(A, Hijos), member(X, Hijos))),
                ((madre(B, Hijos), member(Y, Hijos),!); (padre(B, Hijos), member(Y, Hijos))),
                (hermano(A, B);hermana(A, B)).