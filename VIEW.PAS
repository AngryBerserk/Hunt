Procedure Form;
Begin
Assign(input,'Levels\Level'+Level+'\Maze.txt');Reset(input);
For z:=1 to m do BEgin Readln(SEnt);For x:=1 to n do A[x,z]:=Sent[x] end;
End;

Procedure Surrounding(p1,p2,p3:Integer);
Begin
 Case p3 of
 1,2: Begin
     If (A[p1,p2+1]='#') Then S[p1,p2+1]:=A[p1,p2+1];
     If (A[p1,p2-1]='`')And(S[p1,p2-1]=' ') Then S[p1,p2-1]:=' ';
     If (A[p1,p2-1]='#') Then S[p1,p2-1]:=A[p1,p2-1];
     If (A[p1,p2+1]='`')And(S[p1,p2+1]=' ') Then S[p1,p2+1]:=' ';
    End;
 3,4: Begin
     If (A[p1+1,p2]='#') Then S[p1+1,p2]:=A[p1+1,p2];
     If (A[p1+1,p2]='`')And(S[p1+1,p2]=' ') Then S[p1+1,p2]:=' ';
     If (A[p1-1,p2]='#') Then S[p1-1,p2]:=A[p1-1,p2];
     If (A[p1-1,p2]='`')And(S[p1-1,p2]=' ') Then S[p1-1,p2]:=' ';
    End;
 End;
End;

Procedure Detect_View(p1,p2:Integer);
 Var z,x,y:Integer;stop:Boolean;
Begin
 For z:=1 to 4 Do
 Begin
  x:=p1;y:=p2;Stop:=false;
  Repeat
   Case Z of
   1:If (x<n)And(Not(Dir=2)) Then Inc(x) else Begin Stop:=True;IF A[x+1,y]='#' Then S[x+1,y]:='#'
        else S[x+1,y]:=' ' end;
   2:If (x>1)And(Not(Dir=1)) Then Dec(x) else Begin Stop:=True;IF A[x-1,y]='#' Then S[x-1,y]:='#'
        else S[x-1,y]:=' ' end;
   3:If (Y<m)And(Not(Dir=4)) then Inc(y) else Begin Stop:=True;IF A[x,y+1]='#' Then S[x,y+1]:='#'
        else S[x,y+1]:=' ' end;
   4:If (y>1)And(Not(Dir=3)) Then Dec(y) else Begin Stop:=True;IF A[x,y-1]='#' Then S[x,y-1]:='#'
        else S[x,y-1]:=' ' end;
   End;
 S[x,y]:=A[x,y];
  Surrounding(x,y,z);
  Until (A[x,y]='#')or Stop
 End;
End;

Procedure Detect_Satelite(p1,p2:Integer);
 Var z,x,y:Integer;stop:Boolean;
Begin
 For z:=1 to 4 Do
 Begin
  x:=p1;y:=p2;Stop:=false;
  S[p1,p2]:='`';
  Repeat
   Case Z of
    1:If x<n Then Inc(x) else Begin Stop:=True;IF A[x+1,y]='#' Then S[x+1,y]:='#'
        else S[x+1,y]:=' ' end;
    2:If x>1 Then Dec(x) else Begin Stop:=True;IF A[x-1,y]='#' Then S[x-1,y]:='#'
        else S[x-1,y]:=' ' end;
    3:If Y<m then Inc(y) else Begin Stop:=True;IF A[x,y+1]='#' Then S[x,y+1]:='#'
        else S[x,y+1]:=' ' end;
    4:If y>1 Then Dec(y) else Begin Stop:=True;IF A[x,y-1]='#' Then S[x,y-1]:='#'
        else S[x,y-1]:=' ' end;
   End;
   S[x,y]:=A[x,y];
  Surrounding(x,y,z);
  Until (A[x,y]='#')or Stop
 End;
End;

Procedure HeroR;
Begin For x:=1 to 10 do For z:=1 to 10 do Read(B[z,x]) End;

Procedure HeroL;
Begin Reset(Input);For x:=10 downto 1 do For z:=10 downto 1 do Read(B[z,x]) End;

Procedure HeroD;
Begin Reset(Input);For x:=10 downto 1 do For z:=1 to 10 do Read(B[x,z]) End;

Procedure HeroU;
Begin Reset(Input);For x:=1 to 10 do For z:=10 downto 1 do Read(B[x,z]) End;

Procedure MonsterR;
Begin For x:=1 to 10 do For z:=1 to 10 do Read(B[z,x]) End;

Procedure MonsterL;
Begin Reset(Input);For x:=10 downto 1 do For z:=10 downto 1 do Read(B[z,x]) End;

Procedure MonsterD;
Begin Reset(Input);For x:=10 downto 1 do For z:=1 to 10 do Read(B[x,z]) End;

Procedure MonsterU;
Begin Reset(Input);For x:=1 to 10 do For z:=10 downto 1 do Read(B[x,z]) End;

Procedure Sprites;
Begin
Assign(Input,'Levels\Level'+Level+'\Sprites.dat');Reset(Input);
For x:=1 to 10 do For z:=1 to 10 do Read(Floor[z,x]);
For x:=1 to 10 do For z:=1 to 10 do Read(Wall[z,x]);
For x:=1 to 10 do For z:=1 to 10 do Read(Burn[z,x]);
For x:=1 to 10 do For z:=1 to 10 do Read(Pb[z,x]);
For x:=1 to 10 do For z:=1 to 10 do Read(Mb[z,x]);
Close(Input);
End;

Procedure Hero(V:integer);
Begin
Assign(Input,'Levels\Level'+Level+'\Hero.dat');Reset(Input);
Case V of
 1: HeroR;
 2: HeroL;
 4: HeroU;
 3: HeroD
End;
Close(Input)
End;

Procedure Monster(V:integer);
Begin
Assign(Input,'Levels\Level'+Level+'\Monster.dat');Reset(Input);
Case V of
 1: MonsterR;
 2: MonsterL;
 4: MonsterU;
 3: MonsterD
End;
Close(Input)
End;

Procedure PutHero;
 Var p:Integer;
Begin
 Hero(Dir);
 For z:=1 to 10 do
  For x:=1 to 10 do
   If B[z,x]=-1 Then Putpixel(z+x1*10,x+y1*10,Floor[z,x]) Else
      Putpixel(z+x1*10,x+y1*10,B[z,x])
End;

Procedure PutMonster(p1,p2:Integer);
 Var par:Integer;
Begin
 For c:=1 to EnN Do If (x2[c]=p1)and(y2[c]=p2) then par:=c;
 Monster(Dir2[par]);
 For z:=1 to 10 do For x:=1 to 10 do If B[z,x]=0 Then Putpixel(z+p1*10,x+p2*10,Floor[z,x]) Else
  Putpixel(z+p1*10,x+p2*10,B[z,x])
End;

Procedure Draw_Sprite(P1,P2:Integer;A:MATRIX);
 Var z1,x1:Integer;
Begin
For z1:=1 to 10 do For x1:=1 to 10 do If A[z1,x1]<>0 Then Putpixel(z1+p1*10,x1+p2*10,A[z1,x1]) Else
Putpixel(z1+p1*10,x1+p2*10,Floor[z1,x1])
End;

Procedure Draw_Sprite3(P1,P2:Integer;A:MATRIX;di:Integer);
 Var z1,x1:Integer;
Begin
 Case Di of
  1:For z1:=1 to 10 do For x1:=1 to 10 do If A[z1,x1]<>0 Then Putpixel(z1+p1,x1+p2,A[z1,x1]);
  2:For z1:=10 downto 1 do For x1:=10 downto 1 do If A[z1,x1]<>0 Then Putpixel(x1+p1,z1+p2,A[z1,x1]);
  3:For z1:=10 downto 1 do For x1:=10 downto 1 do If A[z1,x1]<>0 Then Putpixel(z1+p1,x1+p2,A[z1,x1]);
  4:For z1:=1 to 10 do For x1:=10 downto 1 do If A[z1,x1]<>0 Then Putpixel(x1+p1,z1+p2,A[z1,x1]);
 End
End;

Procedure Draw_Sprite2(P1,P2,p3:Integer);
Begin
For x:=1 to 10 do For z:=1 to 10 do If Inventory.Picture[p3,z,x]<>0 Then Putpixel(x+p1*10,z+p2*10,Inventory.Picture[P3,z,x])
Else Putpixel(x+p1*10,z+p2*10,Floor[z,x])
End;

Procedure PutSprite(V:Char;p1,p2:Integer);
Begin
 Case V Of
  'H':PutHero;
  'M':PutMonster(p1,p2);
  'F':Draw_Sprite(p1,p2,Floor);
  'W':Draw_Sprite(p1,p2,Wall);
  'S':Draw_Sprite2(p1,p2,4);
  'L':Draw_Sprite2(p1,p2,5);
 End
End;

Procedure Redraw;
 Var z,x:Integer;
Begin
ClearDevice;
 Fillchar(S,Sizeof(S),' ');
Detect_View(x1,y1);
 For z:=1 to 100 Do
 If (YS[z]<>0)And(XS[z]<>0) Then Begin Detect_Satelite(XS[z],YS[z]) end;
 For z:=1 to n Do
 For x:=1 to m Do
 Begin
  Case S[z,x] of
   '`':PutSprite('F',z,x);
   '#':PutSprite('W',z,x);
  End;
 end;
  For z:=1 to 100 do If (XL[z]<>0)And(YL[z]<>0)And(S[XL[z],YL[z]]='`') Then PutSprite('L',XL[z],YL[z]);
  For z:=1 to 100 do If (YS[z]<>0)And(XS[z]<>0) Then PutSprite('S',Xs[z],Ys[z]);
  For c:=1 to EnN do
   If (c In MonstersSet)And(S[X2[c],Y2[c]]='`') Then PutSprite('M',X2[c],Y2[c]);
  Puthero;
End;

