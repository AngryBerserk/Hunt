{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

Uses Crt,graph;
Const n=15;m=15;MaxEn=2;MaxHealth=200;
Type Matrix=Array[1..10,1..10]Of integer;
VAR A,S                     :Array[1..n,1..m] of Char;
    Wall,Floor,B,Burn,Pb,Mb :MATRIX;
    XS,YS                   :Array[1..100] of Integer;
    XL,YL                   :Array[1..100] of Integer;

{ ---- Monsters ----}
    MonstersSet             :SET OF 1..MaxEn;
    WAY                     :ARRAY[1..N,1..M]OF INTEGER;
    EHealth                 :Array[1..MaxEn] of integer;
    EAgression              :Array[1..MaxEn] of integer;
    EDamage                 :Array[1..MaxEn] of integer;
    Dir2                    :Array[1..MaxEn] of integer;
    X2,Y2                   :Array[1..MaxEn] of integer;
{ ---- Inventory ----}
    Inventory:Record
     Name           :Array[1..10] of String;
     Picture        :Array[1..10,1..10,1..10]OF INTEGER;
     Items          :Set of 1..10;
     MaxAmmo        :array[1..10] of integer;
     Ammo           :array[1..10] of integer;
     Accur          :array[1..10] of integer;
     MinDam         :array[1..10] of integer;
     MaxDam         :array[1..10] of integer;
     BPR            :array[1..10] of integer
    End;

    Difficulty,
    Z,X,C,Rng,gd,gm,Health,Score,EnN,En,
    Dir,x1,y1,CW,Target                 :Integer;
    Count,ew                            :longint;
    Key                                 :char;
    Sent,Level                          :string;
{$I menu.pas}
{$I view.pas}
{$I path.pas}
{$I shoot.pas}
Procedure Game_Over;
Begin
 Halt;
End;

Procedure Collision;
Begin
 For z:=1 to EnN Do
 If (EHealth[z]>0)And(Way[x2[z],y2[z]]<=2)Then
  Health:=Health-RANDOM(EDamage[z])
End;

Procedure Movement(dir1:Integer);
Begin
If (Dir1=4)And(y1>1) Then IF (A[x1,y1-1]<>'#')And(SearchMonster(x1,y1-1)=0) Then Dec(y1);
If (Dir1=3)And(y1<n) Then IF (A[x1,y1+1]<>'#')And(SearchMonster(x1,y1+1)=0)Then Inc(y1);
If (Dir1=1)And(x1<m) Then IF (A[x1+1,y1]<>'#')And(SearchMonster(x1+1,y1)=0)Then Inc(x1);
If (Dir1=2)And(x1>1) Then IF (A[x1-1,y1]<>'#')And(SearchMonster(x1-1,y1)=0)Then Dec(x1);
Dir:=Dir1
End;

Procedure Change_Weapon(Qwe:String);
Begin
 If Qwe='0' Then Qwe:='10';
 Val(Qwe,z,x);
 If z in Inventory.Items then CW:=z
End;

Procedure KillEmAll;
Begin
 If MonstersSet=[] Then Halt;
End;

Procedure Control;
Var p:integer;
Begin
 Key:=Readkey;
 CheckStatus;
 KillemAll;
 Case Key Of
     #72        :Movement(4);
     #80        :Movement(3);
     #77        :Movement(1);
     #75        :Movement(2);
     '0'..'9'   :Change_Weapon(Key);
     ' '        :Fire;
 End;
 Case Key of
  #72,#75,#77,#80,'0'..'9',' ':
                               Begin
                               Collision;
                               Solve;
                               go;
                               Redraw;
                               Menu
                               End
 End;
If Health<=0 Then Game_Over
End;

Procedure Items;
Begin
Assign(Input,'Levels\Level'+Level+'\Guns.Dat');Reset(Input);
For CW:=1 to 10 do
Begin
 readln(Inventory.Name[CW]);
 For x:=1 to 10 do For z:=1 to 10 do Read(Inventory.picture[CW,x,z]);
 Readln;
 Readln;
 READLN(Inventory.MaxAmmo[CW]);
 Readln;
 READLN(Inventory.Accur[CW]);
 Readln;
 READ(Inventory.MinDam[CW]);
 READLN(Inventory.MaxDam[CW]);
 Readln;
 READLN(Inventory.BPR[CW]);
 Readln;
End
End;

Procedure Set_Monsters;
Begin
 MonstersSet:=[1..EnN];
 For z:=1 to EnN Do
  Begin
  EHealth[z]    :=random(100*difficulty)+1;
  EDamage[z]    :=random(50*difficulty)+1;
  EAgression[z] :={random(3)+1}1;
  Dir2[z]       :=random(4)+1;
  Repeat
   X:=Random(n+1)+1;
   C:=Random(n+1)+1;
   X2[z]:=x;
   Y2[z]:=c
  Until (A[X,C]='`')And((x<>x1)And(c<>y1));
  A[x,c]:='@'
  End
End;

Procedure Startup;
Begin
Randomize;
Textbackground(Black);
gd:=detect;gm:=1;
initgraph(gd,gm,'c:\tp7\bin');
Cleardevice;
Level:='1';
Sprites;
Items;
Form;

x1:=2;y1:=2;Dir:=3;CW:=1;
Score:=0;health:=MaxHealth;EnN:=MaxEn;Difficulty:=1;
Inventory.Items:=[1..10];CW:=1;
For z:=1 to 10 Do
 If Z In Inventory.Items Then Inventory.Ammo[z]:=Inventory.MaxAmmo[z]*10;
Set_Monsters;
Solve;
Redraw;
Menu;
End;

Begin
 Nosound;
 Startup;
Repeat
 If Keypressed Then Control
Until key=#27
End.