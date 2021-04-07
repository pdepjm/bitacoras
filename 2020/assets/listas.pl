%cuantoMasGrandeEs/3: Relaciona dos mascotas y un número y me dice cuántos "saltos"
%de animales intermedio en tamaño hay. Por ejemplo, percy a alekai es 3 

%unidades más grande que alekai 

%esMasGrande(Grande,Chico)
%percy->reina->lola->alekai

esMasGrande(percy,reina).  
esMasGrande(reina,lola).
esMasGrande(lola, alekai).
esMasGrande(scott, alekai).
esMasGrande(percy, sofi).
esMasGrande(lola, sofi).
esMasGrande(scott, sofi).

%Caso Recursivo
cuantoMasGrandeEs(Grande, Chiquito, Saltos):-
	esMasGrande(Grande, SegundoGrande),
	%cuantoMasGrandeEs(ChiquitoTemporal,Chiquito,Saltos+1). + es un functor!
	cuantoMasGrandeEs(SegundoGrande,Chiquito,SaltosAnteriores), 
	Saltos is SaltosAnteriores + 1. %No asignacion!! is = es

%Caso Base
cuantoMasGrandeEs(Chiquito, Chiquito, 0).

%%%%%%%%% LISTAS %%%%%%%%%%%

%Vamos a usar una lista de los owners 
[fran, tomi, caro, marcio]

segundo([_, Segundo|_], Segundo). %Prolog
%segundo (_:seg:_) = seg Haskell

%concatena(Lista1, Lista2, Concatenada):-

%concatena(Lista1, Lista2, [X???|Lista2]). 
%X es ... el primer elemento de Lista 1 


concatena([], Lista2, Lista2).
concatena([Head|Tail], Lista2, [Head|Lista3]):-    
	concatena(Tail, Lista2, Lista3).

%[1,2], [3] -> [1, ....]
	
	%[2], [3] -> [2, ...]
 		
		%[], [3] ->[3]



%[1,2], [3] -> [1, 2, 3]
	
	%[2], [3] -> [2, 3]
 		
		%[], [3] ->[3]

