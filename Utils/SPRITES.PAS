Uses Graph,Crt;
Var Gm,Gd,z,x:integer;
    a:array[1..10,1..10] of integer;
    stri:string;

BEGIN
gd:=detect;gm:=1;
initgraph(gd,gm,'c:\bp\bgi');
Assign(Input,'sprites.dat');Reset(Input);
repeat
For x:=1 to 10 do For z:=1 to 10 do Read(A[x,z]);
For z:=1 to 10 do For x:=1 to 10 do Putpixel(x,z,A[z,x]);
readkey;
cleardevice;
rEADLN(stri);
until stri=' '
End.