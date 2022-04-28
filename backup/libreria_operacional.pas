unit Modelo_Cartas; //Libreria y modelo del mazo de cartas

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,math;

  const // Constantes
  _PRIMCARTA = 1;
  _ULTCARTA = 48;
  _POSNULA = 0;

type //Tipos de datos


     TipoNumeroCarta = 1..12;

     TipoCantCartas = 0..48;

     TipoRangoCartas = 0..48;

     PaloCarta = (oro,basto,espada,copa);

     NombreCarta = (Uno,Dos,Tres,Cuatro,Cinco,Seis,Siete,Ocho,Nueve,Sota,Caballo,Rey);

     TipoCarta = record
       Palo: PaloCarta;
       Numero:TipoNumeroCarta;
       Nombre:NombreCarta;
     end;

     TipoMazo = array[TipoRangoCartas] of TipoCarta;

     TipoCartas = record
       mazo: TipoMazo;
       descarte:TipoMazo;
       generado:boolean;
       ordenado:boolean;
       prim_mazo:TipoCantCartas;
       ult_mazo:TipoCantCartas;
       ult_descarte:TipoCantCartas;
     end;


var //Variable global de programa (Tiene que haber una sola)
_CARTAS:TipoCartas;



           //Declaracion de funciones y procedimientos
procedure generar_mazo(var _CARTAS:TipoCartas);
procedure mezclar_mazo(var _CARTAS:TipoCartas);
procedure cortar_mazo(var _CARTAS:TipoCartas);
function mazo_vacio(var _CARTAS:TipoCartas):boolean;
function dar_carta(var _CARTAS:TipoCartas; arriba:boolean):TipoCarta;
function primera_carta(var _CARTAS:TipoCartas):TipoRangoCartas;
function ultima_carta(var _CARTAS:TipoCartas):TipoRangoCartas;
function proxima_carta(var _CARTAS:tipoCartas; poscarta:TipoRangoCartas):TipoRangoCartas;
function pos_nula(var cartas:TipoCartas):TipoRangoCartas;

implementation

procedure generar_mazo(var _CARTAS:TipoCartas); //Genera el mazo y le pone un valor a todas las variables
var _I,_J,_K:TipoRangoCartas;
begin
    _K:=1;
  for _J:=1 to 4 do //4 Ciclos, 1 por cada palo de las _CARTAS
  begin
    for _I:=1 to 12 do //12 por la cantida de _CARTAS posibles por cada palo.Puede haber juegos que no usen las 12 _CARTAS de cada palo
    begin
      _CARTAS.mazo[_K].Numero:=_I;

       case _I of  //Le pone el nombre a cada carta
      1:_CARTAS.mazo[_K].Nombre:=Uno;
      2:_CARTAS.mazo[_K].Nombre:=Dos;
      3:_CARTAS.mazo[_K].Nombre:=Tres;
      4:_CARTAS.mazo[_K].Nombre:=Cuatro;
      5:_CARTAS.mazo[_K].Nombre:=Cinco;
      6:_CARTAS.mazo[_K].Nombre:=Seis;
      7:_CARTAS.mazo[_K].Nombre:=Siete;
      8:_CARTAS.mazo[_K].Nombre:=Ocho;
      9:_CARTAS.mazo[_K].Nombre:=Nueve;
      10:_CARTAS.mazo[_K].Nombre:=Sota;
      11:_CARTAS.mazo[_K].Nombre:=Caballo;
      12:_CARTAS.mazo[_K].Nombre:=Rey;
       end;

      _K:=_K+1;

       if (_K>=1) and (_K<13) then
      _CARTAS.mazo[_K].Palo:=oro
      else
      if (_K>=13) and (_K<25) then
      _CARTAS.mazo[_K].Palo := basto
      else
      if (_K>=25) and (_K<37) then
      _CARTAS.mazo[_K].Palo := espada
      else
      if (_K>=37) and (_K<49) then
      _CARTAS.mazo[_K].Palo := copa;
    end;//For numero carta

  end;//For palo

  _CARTAS.generado:= True;
  _CARTAS.ordenado:= True;
  _CARTAS.prim_mazo:=_PRIMCARTA;
  _CARTAS.ult_mazo:=_ULTCARTA;
  _CARTAS.ult_descarte:=_PRIMCARTA-1;
end; //Fin de generar mazo

procedure mezclar_mazo(var _CARTAS:TipoCartas); //Mezcla las _CARTAS
var _I,_J:TipoRangoCartas; _AUX:TipoCarta;
begin
  randomize();
  for _I:=1 to _ULTCARTA div 2 do
  begin
    _J:=RandomRange(_CARTAS.prim_mazo,_CARTAS.ult_mazo);
    _AUX:=_CARTAS.mazo[_I];
    _CARTAS.mazo[_I]:=_CARTAS.mazo[_J];
    _CARTAS.mazo[_J]:=_AUX;
  end;
  _CARTAS.ordenado:=False;
end;//Fin de mezclar mazo

procedure cortar_mazo(var _CARTAS:TipoCartas);      //REVISAR ESTE <---------------------------------
var p,k,i,j:TipoRangoCartas; aux1,aux2:TipoMazo; cont1,cont2,cont3:integer;
begin
   cont1:=1;
   cont2:=1;
   cont3:=1;
   randomize;
   k:=RandomRange(_CARTAS.prim_mazo,_CARTAS.ult_mazo+1);

   //se separa el mazo en 2 desde la carta nro k
        for j:=k to _ULTCARTA do
        begin
             aux1[cont1]:=_CARTAS.mazo[j];
             cont1:= cont1+1;
        end; // for j
        for p:=1 to k-1 do
        begin
          aux2[cont2]:= _CARTAS.mazo[p];
          cont2:=cont2+1;
        end;//for p
    writeln();
   //da vuelta el mazo
   for i:=1 to _ULTCARTA do
   begin
     if i<=49-k then
       begin
       _CARTAS.mazo[i]:=aux1[i];
       end

     else
     if i>49-k then
     begin
     _CARTAS.mazo[i]:=aux2[cont3];
     cont3 := cont3+1;
     end;
   end;
  _CARTAS.ordenado:=False;
end; //End cortar mazo

function mazo_vacio(var _CARTAS:TipoCartas):boolean;  //Da verdadero si descarte esta lleno
var _I:TipoCantCartas;
begin
      mazo_vacio:=True;
      writeln(_CARTAS.descarte[0].Numero,' ', _CARTAS.descarte[0].Palo,' ',_CARTAS.descarte[0].Nombre);
     for _I:=0 to _CARTAS.ult_mazo do
     begin

       if _CARTAS.descarte[_I].Numero <> 0 then
       mazo_vacio:=False;
     end;
end;//Mazo vacio

function dar_carta(var _CARTAS:TipoCartas; arriba:boolean):TipoCarta;
begin
if arriba = True then
begin
_CARTAS.descarte[_CARTAS.ult_descarte]:= _CARTAS.mazo[_CARTAS.ult_mazo];
_CARTAS.ult_mazo:=Pred(_CARTAS.ult_mazo);
_CARTAS.ult_descarte:=Succ(_CARTAS.ult_descarte);
dar_carta:= _CARTAS.mazo[_CARTAS.ult_mazo];
end
else
begin
  _CARTAS.descarte[_CARTAS.ult_descarte]:= _CARTAS.mazo[_CARTAS.prim_mazo];
   _CARTAS.prim_mazo:=Succ(_CARTAS.prim_mazo);
   _CARTAS.ult_descarte:=Succ(_CARTAS.ult_descarte);
   dar_carta:= _CARTAS.mazo[_CARTAS.prim_mazo];
  end;

end;

function primera_carta(var _CARTAS:TipoCartas):TipoRangoCartas; //Devuelve la POSICION de la primera carta del mazo
  begin
  primera_carta := _CARTAS.prim_mazo;
  end;

function ultima_carta(var _CARTAS:TipoCartas):TipoRangoCartas;
begin
ultima_carta := _CARTAS.ult_mazo;
end;

function proxima_carta(var _CARTAS:tipoCartas; poscarta:TipoRangoCartas):TipoRangoCartas;
begin
 if poscarta<_CARTAS.ult_mazo then
 proxima_carta := poscarta +1
 else
 proxima_carta:= pos_nula(_CARTAS);
end;

function pos_nula(var cartas:TipoCartas):TipoRangoCartas;
begin
pos_nula := _POSNULA;
end;

end. //FINAL DE LA LIBRERIA
