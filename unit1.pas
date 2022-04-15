unit Unit1;  //modelo de juego de cartas general

{$mode ObjFPC}{$H+}

interface

uses
Classes, SysUtils;

const // Constantes
  primCarta = 1;
  ultCarta = 48;

type //Tipos de datos


     TiponumeroCarta = 1..12;

     TipocantCartas = 0..48;

     TiporangoCartas = 1..48;

     Palocarta = (oro,basto,espada,copa);

     NombreCarta = (Uno,Dos,Tres,Cuatro,Cinco,Seis,Siete,Ocho,Nueve,Sota,Caballo,Rey);

     Tipocarta = record
       palo: Palocarta;
       numero:TiponumeroCarta;
       nombre:NombreCarta;
     end;

     Tipomazo = array[TiporangoCartas] of Tipocarta;

     Tipocartas = record
       mazo: Tipomazo;
       descarte:Tipomazo;
       generado:boolean;
       ordenado:boolean;
       prim_mazo:TipocantCartas;
       ult_mazo:TipocantCartas;
       ult_descarte:TipocantCartas;
     end;


var //Variable global de programa (Tiene que haber una sola)
cartas:Tipocartas;


implementation



end.
