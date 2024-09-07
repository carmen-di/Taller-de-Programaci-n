program ej2;
type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if (a <> nil) then begin 
		InformarDatosSociosOrdenCreciente (a^.HI);
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		InformarDatosSociosOrdenCreciente (a^.HD);
	end;		
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

// inciso i)
function maximo(a: arbol): integer;
begin
  if (a = nil) then
     maximo:= -1
  else
     if (a^.HD = nil) then
       maximo:= a^.dato.numero
     else
       maximo:= maximo(a^.HD);
end;

procedure InformarNumeroSocioMasGrande(a: arbol);
var
  max: integer;
begin
  max:= maximo(a);
  if (max = -1) then
     writeln ('Arbol sin elementos')
  else begin
     writeln ('Numero de socio mas grande: ', max);
     writeln;
  end;
end;

// inciso ii)
function SocioMasChico(a: arbol): arbol;
begin
  if ((a = nil) or (a^.HI = nil)) then 
     SocioMasChico:= a
  else 
     SocioMasChico:= SocioMasChico(a^.HI);
end;

procedure InformarDatosSocioNumeroMasChico(a: arbol); 
var 
  minSocio: arbol;
begin
  minSocio:= SocioMasChico(a);
  if (minSocio = nil) then 
     writeln ('Arbol sin elementos')
  else begin
     writeln ('Socio con numero mas chico: ', minSocio^.dato.numero, ' Nombre: ', minSocio^.dato.nombre, ' Edad: ', minSocio^.dato.edad); 
     writeln;
  end;
end;

// inciso iii)
function ExisteSocio(a: arbol; num: integer): boolean;
begin
  if (a = nil) then
     ExisteSocio:= false
  else
     if (a^.dato.numero = num) then
       ExisteSocio:= true
     else 
        if (num < a^.dato.numero) then 
           ExisteSocio:= ExisteSocio(a^.HI, num)
        else
           ExisteSocio:= ExisteSocio(a^.HD, num)
end;

// inciso iv)
procedure CantidadSociosEntre(a: arbol; num1, num2: integer; var cant:integer); 
begin
  if (a <> nil) then begin
	 if ((a^.dato.numero >= num1) and (a^.dato.numero <= num2)) then
		cant := cant + 1;
	 CantidadSociosEntre(a^.HI, num1, num2, cant);
	 CantidadSociosEntre(a^.HD, num1, num2, cant);
  end;
end;

var 
  a: arbol; 
  numABuscar, num1, num2, cant: integer;
Begin
  randomize;
  GenerarArbol(a);
  InformarSociosOrdenCreciente(a);
  InformarNumeroSocioConMasEdad(a);
  AumentarEdadNumeroImpar(a); 
  InformarNumeroSocioMasGrande(a);
  InformarDatosSocioNumeroMasChico(a);
  write('Ingrese numero de socio a buscar: ');
  readln(numABuscar);
  writeln;
  if (ExisteSocio(a, numABuscar)) then 
     writeln('El numero ', numABuscar, ' existe')
  else 
     writeln('El numero ', numABuscar, ' no existe');
  writeln;
  cant:= 0;
  writeln('Ingrese dos numeros de socio: ');
  readln(num1);
  readln(num2);
  CantidadSociosEntre(a, num1, num2, cant);
  writeln('Cantidad de socios entre ', num1, ' y ', num2, ': ', cant);
End.
