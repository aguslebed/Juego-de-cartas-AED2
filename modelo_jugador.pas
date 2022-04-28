unit Modelo_Jugador;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,libreria_Operacional;

const
  _POSNULA = 0;
  _MAX_JUGADORES = 48;
  _MIN_JUGADORES = 1;

  type

    estado_Jugador = 0..3;
     cant_Jugadores = 1..48;

    _modelo_jugador = record
     nick : string[20];
     saldo : longint;
     gandos : integer;
     mis_cartas : TipoMazo;
     ultima_carta : TipoRangoCartas;
     apuesta_actual:integer;
     estado : estado_Jugador;
    end;

    jugadores = array[cant_Jugadores] of _modelo_Jugador;

    var
      jugador:jugadores;


  procedure crear_jugador(var jugador:jugadores; nick:string; saldo:longint; pos:cant_Jugadores);
  procedure crear_jugadores(var jugador:jugadores);
  procedure mostrar_jugadores(var jugador:jugadores);
  function Jugadores_en_partida(var jugador):cant_Jugadores;

implementation

procedure crear_jugador(var jugador:jugadores; nick:string; saldo:longint; pos:cant_Jugadores);
  begin
    jugador[pos].nick := nick;
    jugador[pos].saldo := saldo;
    end;

procedure crear_jugadores(var jugador:jugadores);
  var nick:string; saldo:longint;
    _I,opcion:cant_Jugadores;
    begin
      opcion:=Jugadores_en_partida(jugador);
       for _I:=_MIN_JUGADORES  to  opcion do
        begin
          writeln('Ingresar nick de jugador ',_I);
          readln(nick);
          writeln('Ingresar saldo del jugador ',_I);
          readln(saldo);
          crear_jugador(jugador,nick,saldo,_I);
          jugador[_I].ultima_carta:=_POSNULA;
        end;
    end;

function Jugadores_en_partida(var jugador):cant_Jugadores;
var opcion:cant_Jugadores;
begin
      readln(opcion);
      jugadores_en_partida := opcion;
end;

procedure mostrar_jugadores(var jugador:jugadores);
var  i: cant_jugadores;
  begin
    for i:=1 to _MAX_JUGADORES do
     begin
       if jugador[i].nick='' then
       Continue
       else
       writeln('Nombre: ',jugador[i].nick,' Saldo:',jugador[i].saldo);
     end;

  end;

procedure partida_nueva(var jugador:jugadores);  //FALTA LA CARTA DESCUBIERTA
var jugadores_actuales:cant_Jugadores; i:cant_Jugadores;
begin
   jugadores_actuales:=Jugadores_en_partida(jugador);
      for i:=1 to jugadores_actuales do
       begin
         jugador[i].ultima_carta:=_POSNULA;
         jugador[i].apuesta_actual:=0;
         jugador[i].estado:=0;
       end;
end;

end.

