 program project1;

uses Unit1, libreria_Operacional;//Unit1 = Modelo

var i:integer;

begin
  generar_mazo(cartas);
    mezclar_mazo(cartas);

  with cartas do
begin
  for i:=1 to 48 do
  begin
    write(mazo[i].numero,' ',mazo[i].palo,' ',mazo[i].nombre);
    writeln;
  end;
  writeln(generado,' ',ordenado,' ',prim_mazo,' ',ult_mazo,' ',ult_descarte,' ');
  readln();
end;
  writeln(mazo_vacio(cartas),' asdsadads');
  readln;
end.

