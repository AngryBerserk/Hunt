
PROCEDURE SOLVE;
CONST DIRX:ARRAY [1..4] OF INTEGER=(0,1,0,-1);
      DIRY:ARRAY [1..4] OF INTEGER=(-1,0,1,0);
VAR XP:ARRAY[1..1000] OF INTEGER;
    YP:ARRAY[1..1000] OF INTEGER;
    HEAD,TAIL,par1,par2:INTEGER;
BEGIN
 Fillchar(Way,Sizeof(Way),0);
 Fillchar(xp,Sizeof(XP),0);
 Fillchar(YP,Sizeof(YP),0);
 FOR Z:=1 TO N DO
  FOR X:=1 TO M DO
   CASE A[x,z] OF
   '#': WAY[x,z]:=-1 ELSE WAY[x,z]:=0;
   END;
 HEAD:=1;TAIL:=1;
 XP[HEAD]:=X1;YP[HEAD]:=Y1;
 WAY[X1,Y1]:=1;
 REPEAT
  FOR Z:=1 TO 4 DO
   IF WAY[XP[HEAD]+DIRX[Z],YP[HEAD]+DIRY[Z]]=0 THEN
      BEGIN
       WAY[XP[HEAD]+DIRX[Z],YP[HEAD]+DIRY[Z]]:=WAY[XP[HEAD],YP[HEAD]]+1;
       INC(TAIL);
       XP[TAIL]:=XP[HEAD]+DIRX[Z];
       YP[TAIL]:=YP[HEAD]+DIRY[Z]
      END;
  INC(HEAD);
 { CLEARDEVICE;
  FOR PAR1:=1 TO N DO FOR PAR2:=1 TO M DO BEGIN
  STR(WAY[PAR1,PAR2],SENT);iF SENT<>'-1' THEN OUTTEXTXY(PAR1*15,PAR2*15,SENT) END;
  STR(TAIL,SENT);OUTTEXTXY(200,280,SENT);
  STR(HEAD,SENT);OUTTEXTXY(200,300,SENT);
  READKEY;CLEARDEVICE; }
 UNTIL {((XP[HEAD]=n-1)AND(YP[HEAD]=m-1))OR}(HEAD>TAIL);
END;

Procedure Stealth(z:Integer);
Begin
If way[x2[z],y2[z]]>2 Then
   Begin
    A[x2[z],y2[z]]:='`';
    IF way[x2[z]+1,y2[z]]=way[x2[z],y2[z]]-1 then
    Begin
     IF S[x2[z]+1,y2[z]]=S[x2[z],y2[z]] Then
      Begin Inc(x2[z]);Dir2[z]:=1 End
    end
       Else IF way[x2[z]-1,y2[z]]=way[x2[z],y2[z]]-1 then
            Begin
             IF S[x2[z]-1,y2[z]]=S[x2[z],y2[z]] Then
              Begin Dec(x2[z]);Dir2[z]:=2 End
            end
              Else IF way[x2[z],y2[z]+1]=way[x2[z],y2[z]]-1 then
                   Begin
                    IF S[x2[z],y2[z]+1]=S[x2[z],y2[z]] Then
                     Begin Inc(y2[z]);Dir2[z]:=3 End
                   end
                      Else IF way[x2[z],y2[z]-1]=way[x2[z],y2[z]]-1 then
                           Begin
                            IF S[x2[z],y2[z]-1]=S[x2[z],y2[z]] Then
                             Begin Dec(y2[z]);Dir2[z]:=4 End
                           End
  End
End;

Procedure Agressive_Coward(z,p:Integer);
 Var Stop:Boolean;
Begin
{--Look for scanner to destroy--}
If p=-1 Then
   Begin
   c:=0;Stop:=False;
   Repeat
    Inc(c);
    If (x2[z]=xs[c])and(y2[z]=ys[c]) then
       Begin
        x:=random(10 div difficulty);
        If x=0 Then Begin xS[c]:=0;yS[c]:=0;S[x2[z],y2[z]]:='`' end
       End
   until(c=100)or(stop)
   End;
{--Perform Movement--}
If way[x2[z],y2[z]]>2 Then
      Begin
      A[x2[z],y2[z]]:='`';
      IF way[x2[z]+1,y2[z]]=way[x2[z],y2[z]]+p then
       Begin Inc(x2[z]);Dir2[z]:=1 End
       Else
        IF way[x2[z]-1,y2[z]]=way[x2[z],y2[z]]+p then
         Begin Dec(x2[z]);Dir2[z]:=2 End
         Else
         IF way[x2[z],y2[z]+1]=way[x2[z],y2[z]]+p then
         Begin Inc(y2[z]);Dir2[z]:=3 End
          Else
          IF way[x2[z],y2[z]-1]=way[x2[z],y2[z]]+p then
           Begin Dec(y2[z]);Dir2[z]:=4 End
      End;
End;

Procedure Explosion(x:Integer);
Begin
 If S[Xl[x],Yl[x]]='`' Then Draw_Sprite(Xl[x],Yl[x],Burn);
 For c:=1 to 500 do Begin Sound(random(1000));Delay(Random(500)) end; Nosound;
End;

Procedure Check_Landmines(z:Integer);
Begin
 For x:=1 to 100 do
 If (X2[z]=Xl[x])And(Y2[z]=Yl[x])Then
    Begin
     C:=random(10 div difficulty);
     If (C<>0)or(Eagression[z]<>1) Then
        Begin
        EHealth[z]:=Ehealth[z]-Random(Inventory.MaxDam[5]-Inventory.MinDam[5])-Inventory.MinDam[5];
        Explosion(x);
        Xl[x]:=0;Yl[x]:=0
        End
    End
End;

Procedure CheckStatus;
Begin
 For z:=1 to EnN do
 If (EHealth[z]<=0)And(z In MonstersSet) Then Begin MonstersSet:=MonstersSet-[z];
 If S[X2[z],Y2[z]]='`' Then Begin Draw_Sprite(X2[z],Y2[z],Burn);Delay(10000);Score:=Score+10 end end
End;

Procedure Go;
Begin
 CheckStatus;
 For z:=1 to EnN Do
 If z in MonstersSet Then
  Begin
  If EAgression[z]=1 Then Stealth(z) Else
   If EAgression[z]=2 Then Agressive_Coward(z,-1) Else
    Agressive_Coward(z,1);
  Check_Landmines(z);
 End;
End;