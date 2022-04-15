unit libreria_Operacional;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,Unit1,math;
           //DEclaracion de funciones y procedimientos
procedure generar_mazo(var cartas:Tipocartas);
procedure mezclar_mazo(var cartas:Tipocartas);
procedure cortar_mazo(var cartas:Tipocartas);
function mazo_vacio(var cartas:Tipocartas):boolean;

implementation

procedure generar_mazo(var cartas:Tipocartas); //Genera el mazo y le pone un valor a todas las variables
var i,j,k:TiporangoCartas;
begin
    k:=1;
  for j:=1 to 4 do //4 Ciclos, 1 por cada palo de las cartas
  begin
    for i:=1 to 12 do //12 por la cantida de cartas posibles por cada palo.Puede haber juegos que no usen las 12 cartas de cada palo
    begin
      cartas.mazo[k].numero:=i;

       case i of  //Le pone el nombre a cada carta
      1:cartas.mazo[k].nombre:=Uno;
      2:cartas.mazo[k].nombre:=Dos;
      3:cartas.mazo[k].nombre:=Tres;
      4:cartas.mazo[k].nombre:=Cuatro;
      5:cartas.mazo[k].nombre:=Cinco;
      6:cartas.mazo[k].nombre:=Seis;
      7:cartas.mazo[k].nombre:=Siete;
      8:cartas.mazo[k].nombre:=Ocho;
      9:cartas.mazo[k].nombre:=Nueve;
      10:cartas.mazo[k].nombre:=Sota;
      11:cartas.mazo[k].nombre:=Caballo;
      12:cartas.mazo[k].nombre:=Rey;
       end;

      k:=k+1;

       if (k>=1) and (k<13) then
      cartas.mazo[k].palo:=oro
      else
      if (k>=13) and (k<25) then
      cartas.mazo[k].palo := basto
      else
      if (k>=25) and (k<37) then
      cartas.mazo[k].palo := espada
      else
      if (k>=37) and (k<49) then
      cartas.mazo[k].palo := copa;
    end;//For numero carta

  end;//For palo

  cartas.generado:= True;
  cartas.ordenado:= True;
  cartas.prim_mazo:=primCarta;
  cartas.ult_mazo:=ultCarta;
  cartas.ult_descarte:=primCarta-1;
end; //Fin de generar mazo

procedure mezclar_mazo(var cartas:Tipocartas); //Mezcla las cartas
var i,j:TiporangoCartas; aux:Tipocarta;
begin
  for i:=1 to ultCarta div 2 do
  begin
    j:=Random(ultCarta);
    aux:=cartas.mazo[i];
    cartas.mazo[i]:=cartas.mazo[j];
    cartas.mazo[j]:=aux;
  end;
  cartas.ordenado:=False;
end;//Fin de mezclar mazo

procedure cortar_mazo(var cartas:Tipocartas);
var p,k,i,j:TiporangoCartas; aux1,aux2:Tipomazo; cont1,cont2,cont3:integer;
begin
   cont1:=1;
   cont2:=1;
   cont3:=1;
   randomize;
   k:=RandomRange(cartas.prim_mazo,cartas.ult_mazo+1);

   //se separa el mazo en 2 desde la carta nro k
        for j:=k to ultCarta do
        begin
             aux1[cont1]:=cartas.mazo[j];
             cont1:= cont1+1;
        end; // for j
        for p:=1 to k-1 do
        begin
          aux2[cont2]:= cartas.mazo[p];
          cont2:=cont2+1;
        end;//for p
    writeln();
   //da vuelta el mazo
   for i:=1 to ultCarta do
   begin
     if i<=49-k then
       begin
       cartas.mazo[i]:=aux1[i];
       end

     else
     if i>49-k then
     begin
     cartas.mazo[i]:=aux2[cont3];
     cont3 := cont3+1;
     end;
   end;
  cartas.ordenado:=False;
end; //End cortar mazo


function mazo_vacio(var cartas:Tipocartas):boolean;  //Da verdadero si descarte esta lleno
var i:TipocantCartas;
begin
      mazo_vacio:=True;
     for i:=0 to cartas.ult_mazo do
     begin
       writeln(cartas.descarte[i].numero);
       if cartas.descarte[i].numero <> 0 then
       mazo_vacio:=False;
     end;
end;//Mazo vacio

end.
