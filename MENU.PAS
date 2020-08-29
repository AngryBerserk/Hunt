Procedure Display_Weapon(z:integer);
 Var p1,p2:Integer;
Begin
 For p2:=1 to 10 do For p1:=1 to 10 do Putpixel(p2+z*20+397,p1+425,Inventory.Picture[z,p1,p2])
End;

Procedure Display_Ammo(p:Integer);
 Var par,par2:Integer;
Begin
 SetColor(White);
 x:=0;par:=inventory.ammo[p];
 If par>99 Then
 Repeat
 par2:=par mod 10;
 par:=par div 10;
 str(par2,sent);
 OutTextXY(400+p*20,456-x*8,sent);
 Inc(x);
 Until par=0 else
       If par <10 then
       Begin Str(par,sent);
       OutTextXY(400+p*20,440,sent)
       end Else
       Begin
       Repeat
       par2:=par mod 10;
       par:=par div 10;
       str(par2,sent);
       OutTextXY(400+p*20,448-x*8,sent);
       Inc(x);
       Until par=0
       End
End;

Procedure Menu;
Begin
SetColor(LightRed);
SetLinestyle(0,1,2);
Line(0,400,639,400);line(639,400,639,479);
line(639,479,0,479);line(0,479,0,400);
SetColor(White);
OutTextXY(22,407,'SHIELD');
Line(20,410,5,410);Line(5,410,5,430);Line(5,430,225,430);Line(225,430,225,410);Line(225,410,70,410);
OutTextXY(22,437,'SCORE');
Line(20,440,5,440);Line(5,440,5,460);Line(5,460,225,460);Line(225,460,225,440);Line(225,440,62,440);
Str(Score,sent);
OutTextXY(62,447,Sent);
SetTextStyle(DefaultFont, HorizDir, 5);
Str(Inventory.ammo[CW],sent);
While Length(sent)<3 do Sent:='0'+sent;
OutTextXY(275,420,Sent);
SetTextStyle(DefaultFont, VertDir, 1);
OutTextXY(260,420,'AMMO');
SetTextStyle(DefaultFont, HorizDir, 1);
Line(255,419,255,410);Line(255,410,400,410);Line(400,410,400,465);Line(400,465,255,465);Line(255,465,255,453);
For z:=1 to Health Do
 Begin
 Case z of
  1:SetColor(Red);
  50:SetColor(Yellow);
  120:SetColor(Green)
 End;
 Line(z+9,416,z+19,426)
 End;
SetColor(White);
 For z:=1 to 10 do
 Begin
 If (z=CW)And(Z in Inventory.Items) then Begin Display_Ammo(z);SetColor(Red);Display_Weapon(z) end Else
  If z in Inventory.Items Then Begin Display_Ammo(z);SetColor(White);Display_Weapon(z) end Else
   SetColor(7);
 Str(z,Sent);OutTextXY(400+z*20,410,sent);
 End;
End;