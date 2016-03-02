extern _Px, _Py, _Q, _Pred;
_Px=1;_Py=1;_Q=1;_Pred=1;
rdline,prompt="画像ファイルを読み込みます ";
write,format="%s\n","skel=jpeg_read(\"Kodairi.jpeg\");";
skel=jpeg_read("Kodairi.jpeg");

rdline,prompt="描画ウィンドウの生成を行います";
write,format="%s\n","window,1,dpi=100;";
window,1,dpi=100;

rdline,prompt="画像の表示";
write,format="%s\n","pli,skel;"
pli,skel;

rdline,prompt="画像の縦横比を保つ様に変更します";
write,format="%s\n","limits,square=1;"
limits,square=1;

rdline,prompt="画像の表示で上下を逆にします";
write,format="%s\n","fma;pli,skel(,,::-1);"
fma;pli,skel(,,::-1);
rdline,prompt="この様に添字::-1で行えます";

rdline,prompt="正方形に表示した方が見易いので縦横比の保持を止めます";
write,format="%s\n","limits,square=0;"
limits,square=0;

rdline,prompt="述語で指定した領域を取出す函数を定義："
func getDOMAIN(image, p0, pred, option=)
{
 extern _Px, _Py, _Q, _Pred;
 local dnm,i,n,X,Y,Z;
 dnm=dimsof(image); Z=image; n=dnm(1);
 _Px=indgen(1:dnm(3))(,,-:1:dnm(4));
 _Py=transpose(indgen(1:dnm(4))(,,-:1:dnm(3)));
 _Q =p0; predx=pred+" _Px _Py _Q "+option;
 funcdef(predx);
 for(i=1;i<=n;i++) Z(i,,)=Z(i,,)*_Pred;
 return Z;};

write,format="%s\n","func getDOMAIN(image, p0, pred, option=)\n \
{\n \
 extern _Px, _Py, _Q, _Pred;\n \
 local dnm,i,n,X,Y,Z;\n \
 dnm=dimsof(image); Z=image; n=dnm(1);\n \
 _Px=indgen(1:dnm(3))(,,-:1:dnm(4));\n \
 _Py=transpose(indgen(1:dnm(4))(,,-:1:dnm(3)));\n \
 _Q =p0; predx=pred+\" _Px _Py _Q \"+option;\n \
 funcdef(predx);\n \
 for(i=1;i<=n;i++) Z(i,,)=Z(i,,)*_Pred;\n \
 return Z;};";

rdline,prompt="getDOMAIN函数ではfuncdefを用いて文字列として与えられた述語の評価を行います";
rdline,prompt="では, 次に述語を定義します.";
rdline,prompt="最初に円状の領域を取出す為の述語：";
func Pred1(Px,Py,Qxy,r)
{
 extern _Pred;
 _Pred=((Px-Qxy(1))^2+(Py-Qxy(2))^2<=r^2);};
write,format="%s\n","func Pred1(Px,Py,Qxy,r)\n \
{\n \
 extern _Pred;\n \
 _Pred=((Px-Qxy(1))^2+(Py-Qxy(2))^2<=r^2);};";

rdline,prompt="次は星型の領域を取出す為の述語：";

func Pred2(Px,Py,Qxy,r)
{
 extern _Pred;
 Px=Px-Qxy(1); Py=Py-Qxy(2); th=pi*2/5;
 L1=(1-cos(2*th))/sin(2*th)*Px+r-Py;
 L2=(cos(4*th)-cos(2*th))/(sin(2*th)-sin(4*th))*
    (Px+r*sin(2*th))+r*cos(2*th)-Py;
 L3=r*cos(th)-Py;
 L4=(cos(3*th)-cos(th))/(sin(th)-sin(3*th))*
    (Px+r*sin(th))+r*cos(th)-Py;
 L5=(1-cos(3*th))/sin(3*th)*(Px+r*sin(3*th))+r*cos(3*th)-Py;
 pL1=(L1>=0); mL1=(L1<=0); pL2=(L2>=0); mL2=(L2<=0);
 pL3=(L3>=0); mL3=(L3<=0); pL4=(L4>=0); mL4=(L4<=0);
 pL5=(L5>=0); mL5=(L5<=0); 
 R1=pL1*pL5*mL3; R2=pL3*mL4*mL1; R3=pL1*mL2*pL4;
 R4=pL2*mL4*pL5; R5=pL3*mL2*mL5; R6=pL1*pL3*pL5*mL2*mL4;
 _Pred=((R1+R2+R3+R4+R5+R6)>0);};

write,format="%s\n","func Pred2(Px,Py,Qxy,r)\n \
{\n \
 extern _Pred;\n \
 Px=Px-Qxy(1); Py=Py-Qxy(2); th=pi*2/5;\n \
 L1=(1-cos(2*th))/sin(2*th)*Px+r-Py;\n \
 L2=(cos(4*th)-cos(2*th))/(sin(2*th)-sin(4*th))*\n \
    (Px+r*sin(2*th))+r*cos(2*th)-Py;\n \
 L3=r*cos(th)-Py;\n \
 L4=(cos(3*th)-cos(th))/(sin(th)-sin(3*th))*\n \
    (Px+r*sin(th))+r*cos(th)-Py;\n \
 L5=(1-cos(3*th))/sin(3*th)*(Px+r*sin(3*th))+r*cos(3*th)-Py;\n \
 pL1=(L1>=0); mL1=(L1<=0); pL2=(L2>=0); mL2=(L2<=0);\n \
 pL3=(L3>=0); mL3=(L3<=0); pL4=(L4>=0); mL4=(L4<=0);\n \
 pL5=(L5>=0); mL5=(L5<=0); \n \
 R1=pL1*pL5*mL3; R2=pL3*mL4*mL1; R3=pL1*mL2*pL4;\n \
 R4=pL2*mL4*pL5; R5=pL3*mL2*mL5; R6=pL1*pL3*pL5*mL2*mL4;\n \
 _Pred=((R1+R2+R3+R4+R5+R6)>0);};";

rdline,prompt="では実行例を";
write,format="%s\n","Hero1=getDOMAIN(skel(,,::-1),[1500,777],\"Pred2\", option=\"200\");\n \
Hime=getDOMAIN(skel(,,::-1),[500,1300],\"Pred1\",option=\"300\")\n \
Hero=getDOMAIN(skel(,,::-1),[1500,777],\"Pred2\",option=\"200\")\n \
Maru=getDOMAIN(skel(,,::-1),[2000,500],\"Pred2\",option=\"200\")\n \
Gai=getDOMAIN(skel(,,::-1),[1750,1300],\"Pred1\",option=\"400\")\n \
fma;pli,Hime+Hero+Maru+Gai";
winkill,1;
window,1,dpi=150;
Hero=getDOMAIN(skel(,,::-1),[1500,777],"Pred2", option="200");
fma;pli,Hero;
rdline,prompt="光圀";

Hime=getDOMAIN(skel(,,::-1),[500,1300],"Pred1",option="300");
fma;pli,Hime;
rdline,prompt="滝夜叉姫";

Maru=getDOMAIN(skel(,,::-1),[2000,500],"Pred2",option="200");
fma;pli,Maru;
rdline,prompt="手下";

Gai=getDOMAIN(skel(,,::-1),[1750,1300],"Pred1",option="400");
fma;pli,Gai;
rdline,prompt="髑髏";

rdline,prompt="では,オールスターで！";
fma;pli,Hime+Hero+Maru+Gai









