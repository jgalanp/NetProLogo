/* Programa en prolog para resolver Sudokus
por ejemplo si queremos saber la solucion del siguiente sudoku :  */
/*	|_ 6 _|1 7 _|_ 5 _|
	|_ _ 8|3 _ 5|6 _ _|
	|2 _ _|_ _ _|_ _ 1|
	___________________
	|8 _ _|4 _ 7|_ _ 6|
	|_ _ 6|_ _ _|3 _ _|
	|7 _ _|9 _ 1|_ _ 4|
	___________________
	|5 _ 9|_ _ _|_ _ 2|
	|_ _ 7|2 _ 6|9 _ _|
	|_ 4 _|5 _ 8|_ 7 _|
	___________________

debemos poner : 
sudoku([_,6,_,1,7,_,_,5,_,_,_,8,3,_,5,6,_,_,2,_,_,_,_,_,_,_,1,8,_,_,4,_,7,_,_,6,_,_,6,_,_,_,3,_,_,7,_,_,9,_,1,_,_,4,5,_,9,_,_,_,_,_,2,_,_,7,2,_,6,9,_,_,_,4,_,5,_,8,_,7,_],Sol).
*/


/* Se Carga la Libreria bounds */
:-use_module(library(bounds)).
/*Se valida una fila si los elementos de la lista X son todos diferentes y su dominio son los numeros del 1 al 9*/
valida_fila(X):-all_different(X), X in 1..9.
/*Una columna es valida si los elementos de dicha columna X son todos distintos*/
valida_columna(X):-all_different(X).
/*Un cuadro va a ser valido si los elementos de dicho cuadro X son todos distintos*/
valida_cuadro(X):-all_different(X).

sudoku(
        [A1, A2, A3, A4, A5, A6, A7, A8, A9,
	B1, B2, B3, B4, B5, B6, B7, B8, B9,
	C1, C2, C3, C4, C5, C6, C7, C8, C9,
	D1, D2, D3, D4, D5, D6, D7, D8, D9,
	E1, E2, E3, E4, E5, E6, E7, E8, E9,
	F1, F2, F3, F4, F5, F6, F7, F8, F9,
	G1, G2, G3, G4, G5, G6, G7, G8, G9,
	H1, H2, H3, H4, H5, H6, H7, H8, H9,
	I1, I2, I3, I4, I5, I6, I7, I8, I9],Sol) :-
	/*Para cada una de las filas del sudoku se deben validar las filas , al pedir que sea valida la fila ademas estamos indicando
	que el dominio de cada numero es el (1,9)*/
	valida_fila([A1, A2, A3, A4, A5, A6, A7, A8, A9]),
	valida_fila([B1, B2, B3, B4, B5, B6, B7, B8, B9]),
	valida_fila([C1, C2, C3, C4, C5, C6, C7, C8, C9]),
	valida_fila([D1, D2, D3, D4, D5, D6, D7, D8, D9]),
	valida_fila([E1, E2, E3, E4, E5, E6, E7, E8, E9]),
	valida_fila([F1, F2, F3, F4, F5, F6, F7, F8, F9]),
	valida_fila([G1, G2, G3, G4, G5, G6, G7, G8, G9]),
	valida_fila([H1, H2, H3, H4, H5, H6, H7, H8, H9]),
	valida_fila([I1, I2, I3, I4, I5, I6, I7, I8, I9]),
	/*Se Validan Las columnas del sudoku*/
	valida_columna([A1, B1, C1, D1, E1, F1, G1, H1, I1]),
	valida_columna([A2, B2, C2, D2, E2, F2, G2, H2, I2]),
	valida_columna([A3, B3, C3, D3, E3, F3, G3, H3, I3]),
	valida_columna([A4, B4, C4, D4, E4, F4, G4, H4, I4]),
	valida_columna([A5, B5, C5, D5, E5, F5, G5, H5, I5]),
	valida_columna([A6, B6, C6, D6, E6, F6, G6, H6, I6]),
	valida_columna([A7, B7, C7, D7, E7, F7, G7, H7, I7]),
	valida_columna([A8, B8, C8, D8, E8, F8, G8, H8, I8]),
	valida_columna([A9, B9, C9, D9, E9, F9, G9, H9, I9]),
	/*Se Validan los cuadros del sudoku*/
	valida_cuadro([A1, A2, A3, B1, B2, B3, C1, C2, C3]),
	valida_cuadro([A4, A5, A6, B4, B5, B6, C4, C5, C6]),
	valida_cuadro([A7, A8, A9, B7, B8, B9, C7, C8, C9]),
	valida_cuadro([D1, D2, D3, E1, E2, E3, F1, F2, F3]),
	valida_cuadro([D4, D5, D6, E4, E5, E6, F4, F5, F6]),
	valida_cuadro([D7, D8, D9, E7, E8, E9, F7, F8, F9]),
	valida_cuadro([G1, G2, G3, H1, H2, H3, I1, I2, I3]),
	valida_cuadro([G4, G5, G6, H4, H5, H6, I4, I5, I6]),
	valida_cuadro([G7, G8, G9, H7, H8, H9, I7, I8, I9]),
	/*label, perteneciente a la libreria bound , devuelve los valores cumpliendo con las condiciones del dominio y las restricciones establecidas por el sudoku*/
	label([A1, A2, A3, A4, A5, A6, A7, A8, A9]),
	label([B1, B2, B3, B4, B5, B6, B7, B8, B9]),
	label([C1, C2, C3, C4, C5, C6, C7, C8, C9]),
	label([D1, D2, D3, D4, D5, D6, D7, D8, D9]),
	label([E1, E2, E3, E4, E5, E6, E7, E8, E9]),
	label([F1, F2, F3, F4, F5, F6, F7, F8, F9]),
	label([G1, G2, G3, G4, G5, G6, G7, G8, G9]),
	label([H1, H2, H3, H4, H5, H6, H7, H8, H9]),
	label([I1, I2, I3, I4, I5, I6, I7, I8, I9]),

	/*imprimir, imprimira por pantalla el sudoku*/
	Sol = [A1, A2, A3, A4, A5, A6, A7, A8, A9,
	B1, B2, B3, B4, B5, B6, B7, B8, B9,
	C1, C2, C3, C4, C5, C6, C7, C8, C9,
	D1, D2, D3, D4, D5, D6, D7, D8, D9,
	E1, E2, E3, E4, E5, E6, E7, E8, E9,
	F1, F2, F3, F4, F5, F6, F7, F8, F9,
	G1, G2, G3, G4, G5, G6, G7, G8, G9,
	H1, H2, H3, H4, H5, H6, H7, H8, H9,
	I1, I2, I3, I4, I5, I6, I7, I8, I9].

/*pato_ponys@gmail.com*/
