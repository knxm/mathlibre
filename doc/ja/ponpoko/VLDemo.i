rdline,prompt="Volterra-Lotkaの微分方程式を解くプログラム"

func Volterra(A, B, K1,K2, X0, Y0, t1, h){
     local X, Y, Xt, Yt, i, n;
     n = ceil(t1*1/h);
     X=X0; Y=Y0;
     for(i=1;i<n;i++){
        X=h*(A-K1*Y)*X+X;
        Y=h*(K2*X-B)*Y+Y;};
     return([X,Y]);};

write,format="%s\n","func Volterra(A, B, K1,K2, X0, Y0, t1, h){\n \
     local X, Y, Xt, Yt, i, n;\n \
     n = ceil(t1*1/h);\n \
     X=X0; Y=Y0;\n \
     for(i=1;i<n;i++){\n \
        X=h*(A-K1*Y)*X+X;\n \
        Y=h*(K2*X-B)*Y+Y;};\n \
     return([X,Y]);};"

write,format="%s\n","Volterra(1,2,1,1,4,6,0,0.01)"
Volterra(1,2,1,1,4,6,0.0,0.01)
write,format="%s\n","Volterra(1,2,1,1,4,6,0.1,0.01)"
Volterra(1,2,1,1,4,6,0.1,0.01)
write,format="%s\n","Volterra(1,2,1,1,4,6,0.2,0.01)"
Volterra(1,2,1,1,4,6,0.2,0.01)
write,format="%s\n","Volterra(1,2,1,1,4,6,0.3,0.01)"
Volterra(1,2,1,1,4,6,0.3,0.01)
rdline,prompt="これでは面白くないので軌道を300点描かせて,グラフ表示にしましょう："

func drawVolterra(A, B, K1, K2, X0, Y0, h, color=)
{
 local i;
 X=X0; Y=Y0;
 for(i=1;i<301;i++){
     X=h*(A-K1*Y)*X+X;
     Y=h*(K2*X-B)*Y+Y;
     pldj,X0,Y0,X,Y,color=color;
     X0=X;
     Y0=Y;};
}

write,format="%s\n","func drawVolterra(A, B, K1, K2, X0, Y0, h, color=)\n \
{\n \
 local i;\n \
 X=X0; Y=Y0;\n \
 for(i=1;i<301;i++){\n \
     X=h*(A-K1*Y)*X+X;\n \
     Y=h*(K2*X-B)*Y+Y;\n \
     pldj,X0,Y0,X,Y,color=color;\n \
     X0=X;\n \
     Y0=Y;};\n \
}";

window,10,dpi=100;
write,format="%s\n","drawVolterra(1,2,1,1,4,6,0.05,color=\"red\")}}"
drawVolterra(1,2,1,1,4,6,0.05,color="red")
rdline,prompt="初期値に1次元配列を与えると解が一度に沢山計算できます";
write,format="%s\n","fma;drawVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color=\"red\")"
fma;drawVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color="red")

rdline,prompt="pause函数を使って安易なアニメーションも出来ます:"
func animVolterra(A, B, K1, K2, X0, Y0, h, color=)
{
 local i;
 X=X0; Y=Y0;
 for(i=1;i<301;i++){
     X=h*(A-K1*Y)*X+X;
     Y=h*(K2*X-B)*Y+Y;
     pause,50;
     pldj,X0,Y0,X,Y,color=color;
     X0=X;
     Y0=Y;};
}

write,format="%s\n","func drawVolterra(A, B, K1, K2, X0, Y0, h, color=)\n \
{\n \
 local i;\n \
 X=X0; Y=Y0;\n \
 for(i=1;i<301;i++){\n \
     X=h*(A-K1*Y)*X+X;\n \
     Y=h*(K2*X-B)*Y+Y;\n \
     pause,50;\n \
     pldj,X0,Y0,X,Y,color=color;\n \
     X0=X;\n \
     Y0=Y;};\n \
}";

write,format="%s\n","fma;animVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color=\"green\")"
fma;animVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color="green")






