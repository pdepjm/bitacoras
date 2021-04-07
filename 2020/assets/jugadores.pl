nacio(maru,fecha(12,09,97)).
nacio(dany,fecha(30,06,00)).

/*?- nacio(Quien,fecha(_,06,_)).
Quien = dany.
?- nacio(maru,Fecha).
Fecha = fecha(12,09,97).
?- nacio(maru,fecha(Dia,_,_)).
Dia = 12.
*/

/*
Hacer el predicado jugador. Cada uno tiene un país, su apellido y su posición en el equipo. 
Además sabemos que las posiciones en el equipo pueden ser arquero, delantero o defensor. De los arqueros se conoce la cantidad de goles que metió, que atajó, y que le metieron. De un delantero se conoce la cantidad de goles que metió y de un defensor se conoce las pelotas que robó y los goles que metió.

Construir el siguiente equipo como base de conocimiento:  argentina tiene un arquero caballero que metio 0 goles, atajo 1398 goles y no atajo 476 goles, el delantero messi que metió 1028 goles, el delantero kun que metió 426 goles y el defensor masche que robo 1024 pelotas y metió 19 goles. 
*/

%                           arquero(goles,atajadas,noatajadas)
jugador(argentina,caballero,arquero(0,1398,476)).
%                       delantero(goles)
jugador(argentina,messi,delantero(1028)).
jugador(argentina,kun,delantero(426)).
%                       defensor(robos,goles)
jugador(argentina,masche,defensor(1024,19)).

% BUEN DEFENSOR
% buenDefensor/1 se cumple para un jugador cuando su posición es defensor, ó cuando es arquero con más atajadas que goles recibidos. 
buenDefensor(Jugador):-
  jugador(_, Jugador, Posicion),
  buenaDefensa(Posicion).


buenaDefensa(defensor(_,_)).
buenaDefensa(arquero(_,Atajada,NoAtajada)) :- 
Atajada > NoAtajada.

% METE PENAL
% metePenal/2 se cumple para un jugador y un arquero si los goles convertidos del jugador son más que los goles atajados del arquero.

metePenal(Jugador,Arquero) :-
    jugador(_,Jugador,Posicion), 
    golesConvertidos(Posicion,CantGoles), 
    jugador(_,Arquero,arquero(_,Atajadas,_)),
    CantGoles > Atajadas.

golesConvertidos(defensor(_,Cant),Cant). 
golesConvertidos(delantero(Cant),Cant).


% ES MEJOR QUE
% esMejorQue/2 Para que un jugador sea mejor que otro, todos los stats sumados de uno deben ser mayores a los del otro (ojo que los goles que le metieron a un arquero restan).

esMejorQue(Jugador, Competidor) :-
    %Es inversible por:
    puntaje(Jugador, PuntajeJugador),
    puntaje(Competidor, PuntajeCompetidor),
    PuntajeJugador > PuntajeCompetidor.

%Si esta conformado por predicados inversibles
%Por lo tanto es inversible

puntaje(Jugador, Puntaje):-
  jugador(_, Jugador, Posicion),
  sumaStats(Posicion, Puntaje). %=)

%Podemos hacer esto gracias al Pattern Matching
/*
 * =(
 * \
 * V
 */
sumaStats(delantero(Goles), Goles).
sumaStats(defensor(Robos,Goles), Suma):-
    Suma is Goles + Robos.
sumaStats(arquero(Goles, Atajos, Fallidos), Suma):-
    Suma is Atajos + Goles - Fallidos.


% MEJOR JUGADOR
% mejorJugador/1 se cumple para un jugador cuando es el mejor de toooodos (hasta ahora).

mejorJugador(Player):-
jugador(_, Player,_), %Para ligar la variable 
forall( 
    %Si pasa esto entonces
    (jugador(_,AnotherPlayer,_), Player\=AnotherPlayer),
 %Pasa esto
    esMejorQue(Player, AnotherPlayer)
    ).