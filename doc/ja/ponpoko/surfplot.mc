/* MAXIMA */

/* 属性の設定.*/
/* surfgの属性設定

   surfgには平面曲線と空間曲面を描く際に用いる共通の設定を入れます. 
   root_finder 零点を計算する際の解法の指定.
               d_chain_bisectionを用いると自己交差も綺麗に描きます.
   iterations: 零点を計算する際の繰返しの上限を設定
   width:      画像の横幅
   height:     画像の高さ
*/
put(surfg, d_chain_bisection,root_finder);
put(surfg, 0.0000000001,epsilon);
put(surfg, 20000,iterations);
put(surfg, 500,width);
put(surfg, 500,height);

/* surfの属性設定

   surfには空間曲面を描く際に用いる設定を入れます.
   surfでは色の指定はRGBで行い, 0から255までの整数を指定します.
   do_background:    背景色
   background_red:   背景色の指定(赤)
   background_green: 背景色の指定(緑)
   background_blue:  背景色の指定(青)
   rot_x:            X軸回りの回転角度(rad)
   rot_y:            Y軸回りの回転角度(rad)
   rot_z:            Z軸回りの回転角度(rad)
   scale_x:          X軸方向の倍率
   scale_y:          Y軸方向の倍率
   scale_z:          Z軸方向の倍率
   transparence:     透明度0-100, 0でsolid, 100で透明

*/
put(surf, yes,do_background);
put(surf, 0,background_red);
put(surf, 0,background_green);
put(surf, 0,background_blue);
put(surf, 0.14,rot_x);
put(surf,-0.3, rot_y);
put(surf, 0.0, rot_z);
put(surf, 1.0, scale_x);
put(surf, 1.0, scale_y);
put(surf, 1.0, scale_z);
put(surf, 0, transparence);
put(surf, ambient_light+diffuse_light+reflected_light+transmitted_light,
          illumination);

/* surfplot  

   引数は多項式. 多項式の変数は2個か3個でなければエラーになります.
   描画はsurfを用いますが,こ の函数では臨時ファイルとしてsurf.tmpに
   surfのスクリプトを書込み, system函数で画像の生成を行います.
   猶, 曲面をsurferで生成と描画を行い, 曲線はsurfで生成した画像を
   Viewerで表示させます.
*/
surfplot(f):=block(
[
 poly,poly0,vars,lls1:0,lls2:0,
 f:ratsimp(expand(f)),tmp,
 str,target,j,sl,obj,
 ls1:properties(surfg),
 ls2:properties(surf),
 delcmd,drwcmd,cnvcmd,execmd,dspcmd
],
vars:showratvars(float(f)),
n:length(vars),
display2d:false,
if n=2 or n=3 then
  (lls1:length(ls1[1])-1,
   for i:1 thru lls1 do
      (str:ls1[1][i+1],
       (if str=epsilon then tmp:rat(get(surfg,str)) 
           else tmp:get(surfg,str)),
       surf_settings[i]:str=tmp
       ),
   if n=3 then
     (lls2:length(ls2[1])-1,
      for i:1 thru lls2 do
          (str:ls2[1][i+1],
           j:i+lls1,
           surf_settings[j]:str=get(surf,str)
           ),
       /* 半透明表示の為の設定 */
       /* 変数の入換を行います.*/
       poly0:subst([vars[1]=surf_tmp_x,vars[2]=surf_tmp_y,
                    vars[3]=surf_tmp_z],f),
       poly:subst([surf_tmp_x=x,surf_tmp_y=y,surf_tmp_z=z],poly0),
       /* 曲面を描く為の設定 */
       target:surface,
       obj:draw_surface)
   else
      (
       /* 変数の入換を行います.*/
       poly0:subst([vars[1]=surf_tmp_x,vars[2]=surf_tmp_y],f),
       poly:subst([surf_tmp_x=x,surf_tmp_y=y],poly0),
       /* 曲線を描く為の設定 */
       target:curve,
       obj:draw_curve),
  /* 配列slを定義し,描画設定と曲線/曲面の方程式と描画命令を入れます */
   j:lls1+lls2,
   array(sl,j+2),
  (for i:0 thru j-1 do
       sl[i]:surf_settings[i+1]),
   sl[j]:target=poly,
   sl[j+1]:obj,
   /* 只今,描画中… */
   print("Surf is now drawing ", poly,". Please wait ...."),
   /* stringout函数で,スクリプトの式を書込みます. */
   if n=2 then
     (stringout("surf.tmp",clear_screen,sl[0],sl[1],sl[2],sl[3],
                                        sl[4],sl[5],sl[6]))
   else
     (stringout("surf.tmp",clear_screen,sl[0],sl[1],sl[2],sl[3],
              sl[4],sl[5],sl[6],sl[7],sl[8],sl[9],sl[10],sl[11],
                 sl[12],sl[13],sl[14],sl[15],sl[16],sl[17],sl[18])),
   if n=3 then 
   /* system函数でsurferを起動します.surfのGUI付が動作するのであれば, 
      "surf -x surf.tmp"としても構いません. */
      system("surfer surf.tmp >surf.log&")
   else
   /* MS-Windowsであるかは, 大域変数gnuplot_commandの値で判断します 
    このプログラムをMS-Windows上で動作させるためには
    NetPbm for WindowsかImageMagickのどちらかと,
    surferのインストールが必要です. そして.これらのアプリケーションへの
    環境変数Pathの設定が不可欠です. なお, ここではImageMagickを
    使う事を前提にしていますが, NetPbmの場合はcnvcmdを
    cnvcmd:"ppmtojpeg surf.ppm>surf.jpg"
    に変更するだけで大丈夫です.
   */
      (if gnuplot_command="wgnuplot" then 
        (delcmd:"del surf.ppm surf.jpg",
         drwcmd:"echo color_file_format=ppm;\
filename=\"surf.ppm\";save_color_image;>>surf.tmp",
         execmd:"surf surf.tmp>surf.log",
         /* ImageMagickの場合 */
         cnvcmd:"convert surf.ppm surf.jpg",
         /* NetPbmの場合 */
/*       cnvcmd:"ppmtojpeg surf.ppm>surf.jpg", */
         dspcmd:"explorer surf.jpg")
       else 
        (delcmd:"rm surf.jpeg",
         drwcmd:"echo \"color_file_format=jpg;\
filename=\\\"surf.jpeg\\\";save_color_image;\">>surf.tmp",
         execmd:"surf --no-gui surf.tmp>surf.log",
         cnvcmd:"",
         dspcmd:"display surf.jpeg&"),
     /* system函数による準備 
        surfがGUI付きで利用可能であれば, 以下のsystem函数を
        全て削除し, system("surf -x surf.tmp>surf.log&")で
        置換します.
     */
       system(delcmd),
       system(drwcmd),
       system(execmd),
       system(cnvcmd),
       system(dspcmd)
        )
      )
else
/* 多項式が,2変数でも3変数でもなければエラーを表示します. */
print("Error!"))$
