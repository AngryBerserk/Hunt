{I View.Pas}
Procedure Hit;
Begin
 For c:=1 to 100 do Begin Sound(random(1000));Delay(Random(500)) end; Nosound;
End;

Function Damage:Integer;
Begin
Damage:=random(Inventory.MaxDam[CW]-Inventory.MinDam[CW])+Inventory.MinDam[CW];
End;

Function Calculate_Range:Integer;
 Var Stop,st:Boolean;P1,P2,p3,co:Integer;
Begin
 Stop:=False;st:=True;Calculate_Range:=0;p1:=x1;p2:=y1;Target:=0;
 Repeat
  co:=0;
  Case Dir of
   1: Begin Inc(p1);Calculate_Range:=p1-x1;For p3:=1 to EnN Do
      If (p3 in MonstersSet)And St
             Then Begin IF((X2[p3]=p1)And(Y2[p3]=p2)) then
             Begin Inc(co,p3);St:=False;Stop:=True End End End;
   2: Begin Dec(p1);Calculate_Range:=x1-p1;For p3:=1 to EnN Do
      If (p3 In MonstersSet)And St
             Then Begin If ((X2[p3]=p1)And(Y2[p3]=p2)) then
             Begin Inc(co,p3);St:=False;Stop:=True End End End;
   3: Begin Inc(p2);Calculate_Range:=p2-y1;For p3:=1 to EnN Do
      If (p3 In MonstersSet)And St
             Then Begin If((X2[p3]=p1)And(Y2[p3]=p2)) then
             Begin Inc(co,p3);St:=False;Stop:=True End End End;
   4: Begin Dec(p2);Calculate_Range:=y1-p2;For p3:=1 to EnN Do
      If (p3 In MonstersSet)And St
             Then Begin If((X2[p3]=p1)And(Y2[p3]=p2)) then
             Begin Inc(co,p3);St:=False;Stop:=True End End End;
  End;
 Until (A[p1,p2]='#')OR Stop;
 If Stop Then Target:=co;
End;

Procedure Shoot(p3:Integer);
 Var Fault:Integer;
Begin
 If Target<>0 Then Begin
 Fault:=100-(P3+1)*Inventory.Accur[CW];
 If Fault<=random(100) Then
    If Target<>0 Then Begin EHealth[Target]:=eHealth[Target]-Damage;CheckStatus End
End
End;

Procedure Animate(p3,Note:Integer;A:Matrix);
 Var p1:Integer;P:Pointer;Size:Word;
Begin
Size := ImageSize(x1*10,y1*10,x1*10+P3*10,y1*10+10);
GetMem(P, Size);
Case Dir of
 1:Begin GetImage(x1*10+10,y1*10,x1*10+10+P3*10,y1*10+10,P^);
    For p1:=x1*10+10 to (x1+P3)*10 do
    Begin Draw_Sprite3(p1,y1*10,A,1);{Sound(Note);}Delay(100);
          Nosound;PutImage(x1*10+10,Y1*10,P^,NormalPut)
    End End;
 2:Begin GetImage(x1*10-P3*10,y1*10,x1*10,y1*10+10,P^);
   For p1:=x1*10-10 Downto x1*10-10-p3*10 do
    Begin Draw_Sprite3(p1,y1*10,Pb,2);{Sound(Note);}Delay(100);
          Nosound;PutImage(x1*10-P3*10,Y1*10,P^,NormalPut)
    End End;
 3:Begin GetImage(x1*10,y1*10+1,x1*10+10,y1*10+P3*10+10,P^);
   For p1:=y1*10 to y1*10+p3*10 do
    Begin Draw_Sprite3(x1*10,p1,A,3);{Sound(Note);}Delay(100);
          Nosound;PutImage(x1*10,Y1*10+1,P^,NormalPut)
    End End;
 4:Begin GetImage(x1*10,y1*10-P3*10,x1*10+10,y1*10,P^);
   For p1:=y1*10-6 Downto y1*10-p3*10 do
    Begin Draw_Sprite3(x1*10,p1,A,4);{Sound(Note);}Delay(100);
          Nosound;PutImage(x1*10,Y1*10-p3*10,P^,NormalPut)
    End End
End
End;

{--------PISTOL,AKM,MACHINEGUN-----------}
Procedure Weapon(Beep:Integer;Pic:Matrix);
 Var P3,par:Integer;
Begin
 For Par:=1 to Inventory.BPR[CW] do
  If Inventory.Ammo[CW]>0 Then
  Begin
   CheckStatus;
   P3:=Calculate_Range-1;
   If p3>0 Then Animate(p3,Beep,Pic);
   Shoot(p3);
   Dec(Inventory.Ammo[CW])
  End
End;

{--------SNIPER-------------}
{Procedure Sniper;
 Var p3,Par:Integer;
Begin
  If Inventory.Ammo[CW]>0 Then
  Begin
   CheckStatus;
   P3:=Calculate_Range-1;
   If p3>0 Then AnimateHi(p3,Beep,Pic);
   Shoot(p3);
   Dec(Inventory.Ammo[CW])
  End
End; }

{--------SATELITE,LANDMINE-----------}
Procedure Trap(par:Integer);
 Var Stop:boolean;
Begin
 z:=0;Stop:=False;
 Repeat
 Inc(z);
 Case Par of
  1:If YS[z]=0 Then Begin XS[z]:=x1;YS[z]:=y1;Stop:=True end;
  2:If YL[z]=0 Then Begin XL[z]:=x1;YL[z]:=y1;Stop:=True end
 End
 Until Stop
End;

{--------MEDIKIT-----------}
Procedure MediKit;
Begin
Health:=Health+Damage;
If Health>MaxHealth then Health:=MaxHealth
End;

{--------HAMMER-----------}
Function SearchMonster(p1,p2:Integer):Integer;
 Var q:Integer;
Begin
 SearchMonster:=0;
 For q:=1 to EnN do If q in MonstersSet Then
 If (x2[q]=p1)And(y2[q]=p2) then SearchMonster:=q
End;

Procedure Hammer;
Var p3:Integer;Yes:Boolean;
Begin
 Inc(Inventory.Ammo[CW]);Yes:=False;
 Case Dir of
  1:Begin p3:=SearchMonster(x1+1,y1);If p3<>0 Then Yes:=True end;
  2:Begin p3:=SearchMonster(x1-1,y1);If p3<>0 Then Yes:=True end;
  3:Begin p3:=SearchMonster(x1,y1+1);If p3<>0 Then Yes:=True end;
  4:Begin p3:=SearchMonster(x1,y1-1);If p3<>0 Then Yes:=True end
 End;
IF p3=0 Then
p3:=SearchMonster(x1,y1);
If (p3<>0)Or Yes Then Begin Ehealth[p3]:=Ehealth[p3]-Damage;Draw_Sprite(X2[p3],Y2[p3],Burn);Hit end
End;

Procedure Fire;
Begin
 If CW in Inventory.items Then
 Begin
  Dec(Inventory.Ammo[CW]);
  Case CW of
   1:Weapon(50,Pb);
   2:MediKit;
   3:Weapon(100,Pb);
   4:Trap(1);
   5:Trap(2);
  { 6:Sniper;}
   7:Weapon(20,Mb);
{  8: }
   9:Hammer;
{  10:}
  End
 End;
 IF Inventory.Ammo[CW]<=0 Then Inventory.Items:=Inventory.Items-[CW];
End;