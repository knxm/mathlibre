/*
 * 有理数Ratioの定義
 *
 * 有理数は構造体Ratioで定義する.
 * 
 */
struct Ratio{
       int  sgn;
       long num, den; };
               
/* 
 * 重要なRatioの定義
 *
 */
_Zero=array(Ratio);
_Zero.den=1;
_One=array(Ratio);
_One.num=1;
_One.den=1;

/*
 * 必要なライブラリ
 *
 */
require,"FibMP.i";

func is_Ratio(a)
/* DOCUMENT is_Ratio -- Ratioの真理函数
 *
 * Ratioであれば1を返すが, それ以外は全て0を返す.
 *
 */
{
   if(catch(-1)) return(0);
   local ans,b;
   ans=1;
   if(typeof(a)=="struct_instance"){
         b=a.sgn;
         b=a.num;
         b=a.den;}
   else  ans=0;
   return(ans);
};
    

func is_RI(a)
/* DOCUMENT is_RI -- 有理数の真理函数
 * 
 * Yorickの整数であるか, Ratioであれば1, 
 * それ以外は全て0を返す函数.
 */
{
  return(is_Ratio(a) || is_integer(a));
};

func I2Ratio(a)
/* DOCUMENT I2Ratio --  Yorickの整数をRatioに変換.
 *  
 * 引数が整数であれば有理数に変換し,
 * 引数が有理数の場合はそのまま返し,　
 * それ以外はnilを返却する. 
 */
{
    local c,b;
    if(is_integer(a)){ 
       c=_One;
       if(a<0){
          c.num=-a; 
          c.sgn=1;}
       else c.num=a;}
    else if(is_Ratio) c=a;
    else c=nil;
    return(c);
};
    
func R2Integer(a)
/* DOCUMENT R2Integer --- Ratioから整数に変換.
 * 
 * 分子が0のものと約分によって分母が1になったもの
 * に対してのみ変換を行う.
 *
 */
{
   local ans;
   if(is_integer(a)) ans=a;
   else if(is_Ratio(a)){
      if(a.num==0) ans=0;
      else if(a.den==1) ans=(1-2*a.sgn)*a.num;};
    return(ans);
};

func R2Double(a)
/* DOCUMENT R2Double -- 浮動小数点数に変換する函数.
 *
 */
{
   local ans;
   if(is_Ratio(a)) ans=a.num*1.0/a.den;
   else if(is_integer(a)) ans=a*1.0;
   return(ans);
};

func printRATIO(a)
/* DOCUMENT printRATIO -- Ratioを文字を使って表示.
 *
 */
{
    local n,k1,k2,dv,nd,b,g;
    if(is_Ratio(a)){
       if(a.num==0){
          write,format="     %d\n",linesize=0,0;}
       else{
          g=gcd(a.num,a.den);
          a.num=a.num/g;
          a.den=a.den/g;
          if(a.sgn!=0) b="- ";
          else b="";
          n=ifloor(log10(max(a.num,a.den))+1+2*a.sgn);
          k2=num2str(n+1);
          nd="     %"+k2+"hd\n";
          if(a.den==1){
             write,format=nd,linesize=0,(1-2*a.sgn)*a.num;}
          else{
             k1=num2str(n);
             dv="     %"+k1+"hs\n";
             for(i=1;i<n+2;i++){
                 b=b+"-";};
             write,format=nd,linesize=0,a.num;
             write,format=dv,linesize=0,b;
             write,format=nd,linesize=0,a.den;};};}
     else if(is_integer(a)){
          write,format="     %d\n",linesize=0,a;};
};

func RSimp(a)
/* DOCUMENT RSimp -- 有理数の約分を実行.
 *
 * 有理数の約分を実行するが, それ以外の対象は
 * そのまま返却する.
 */
{
   local g,b;
   if(is_Ratio(a)){
      b=_Zero;
      if(a.num!=0){
        g=gcd(a.num,a.den);
        b.sgn=a.sgn;
        b.num=a.num/g;
        b.den=a.den/g;};}
   else b=a;
   return(b);
};

func REq(a,b)
/* DOCUMENT REq -- 有理数の同値性を検証
 *
 * 
 */
{
  local ans,a1,b1;
  ans=0;
  if(is_RI(a) && is_RI(b)){
     a1=RSimp(a); b1=RSimp(b);
     if(a1==b1) ans=1;};
  return(ans);
};

func RGr(a,b)
/* DOCUMENT RSimp -- 有理数の大小関係を判定.
 *
 * RGr(a,b) ==1 <-> a>b の場合
 * RGr(a,b) ==0 <-> a<=bの場合
 */
{
  local ans,a1,b1;
  ans=0; a1=a; b1=b;
  if(is_integer(a) && is_integer(b)) return(a>b);
  else if(is_integer(a)) a1=I2Ratio(a);
  else if(is_integer(b)) b1=I2Ratio(b);
  if(is_Ratio(a1)&& is_Ratio(b1)){
     if(a1.sgn+b1.sgn==1){
        if(a1.sgn==0) ans=1;}
     else{
          ans=(1-2*a1.sgn)*a1.num*b1.den>
              (1-2*b1.sgn)*a1.den*b1.num;};}
  return(ans);
};


func RLs(a,b)
/* DOCUMENT RSimp -- 有理数の大小関係を判定.
 *
 * RLs(a,b) ==1 <-> a<b の場合
 * RLs(a,b) ==0 <-> a>=bの場合
 */
{
  local ans,a1,b1;
  ans=0; a1=a; b1=b;
  if(is_integer(a) && is_integer(b)) return(a<b);
  else if(is_integer(a))a1=I2Ratio(a);
  else if(is_integer(b))b1=I2Ratio(b);
  if(is_Ratio(a1)&& is_Ratio(b1)){
     if(a1.sgn+b1.sgn==1){
       if(a1.sgn==0) ans=1;}
     else{
          ans=(1-2*a1.sgn)*a1.num*b1.den<
              (1-2*b1.sgn)*a1.den*b1.num;};}
  return(ans);
};

func RAdd(a,b)
/* DOCUMENT RAdd -- 有理数の和を計算
 *
 */
{
   local c,a1,b1,g,g1,g2;
   a1=RSimp(a); b1=RSimp(b);
   if(is_integer(a)&& is_integer(b)) c=a+b;
   else if(is_integer(a)) a1=I2Ratio(a);
   else if(is_integer(b)) b1=I2Ratio(b);
   if(is_Ratio(a1)&& is_Ratio(b1)){
      c=_Zero;
      g1=gcd(a1.num,b1.num);
      g2=gcd(a1.den,b1.den);
      if(g1==0)g1=1;
      c.num=(1-2*a1.sgn)*(a1.num/g1)*(b1.den/g2)+
            (a1.den/g2)*(1-2*b1.sgn)*(b1.num/g1);
      c.den=(a1.den/g2)*(b1.den/g2);
      c.num=c.num*g1;
      c.den=c.den*g2;
      if(c.num<0){
         c.sgn=1;
         c.num=-c.num;};};
   return(RSimp(c));
};

func RNeg(a)
/* DOCUMENT RNeg -- 有理数の和の逆元を計算
 *
 */
{
   local c;
   if(is_Ratio(a)){
      c=a; c.sgn=(a.sgn+1)%2;}
   else if(is_integer(a)) c=-a;
   return(c);
};

func RRev(a)
/* DOCUMENT RRev -- 有理数の逆数を計算
 *
 * 0に対してはnilを返す.
 *
 */
{
   local c,a1;
   a1=a;
   if(is_integer(a)) a1=I2Ratio(a);
   if(is_Ratio(a1)){
      c=_One;
      if(c.num==0) c=nil;
      else{
         c=a1;
         c.num=a1.den;
         c.den=a1.num;};};
   return(c);
};

func RSub(a,b)
/* DOCUMENT RSub -- 有理数の減算
 *
 * 内部的にRNegとRAddを利用
 *
 */
{
   local c,b1;
   b1=RNeg(b);
   return(RAdd(a,b1));
};

func RTimes(a,b)
/* DOCUMENT RTimes -- 有理数の積
 *
 */
{
    local c,a1,b1,g1,g2;
    a1=RSimp(a); b1=RSimp(b);
    if(is_integer(a) && is_integer(b)) c=a*b;
    else if(is_integer(a)) a1=I2Ratio(a);
    else if(is_integer(b)) b1=I2Ratio(b);
    if(a1==_Zero || b1==_Zero) c=_Zero;
    else if(is_Ratio(a1)&& is_Ratio(b1)){
       c=_Zero;
       if(a1!=c && b1!=c){
          g1=gcd(a1.num,b1.den);
          g2=gcd(a1.den,b1.num);
          c.sgn=(a1.sgn+b1.sgn)%2;
          c.num=(a1.num/g1)*(b1.num/g2);
          c.den=(a1.den/g2)*(b1.den/g1);};};
    return(c);
};
    
func RDiv(a,b)
/* DOCUMENT RDiv -- 有理数の商を計算
 *
 * 内部的にRTimesとRRevを利用.
 * 第2引数が0に等しい場合はnilを返す.
 *
 */
{
    local c;
    if(is_RI(a)&& is_RI(b)){
       if(RSimp(b)==_Zero || b==0) c=nil;
       else c=RTimes(a,RRev(b));};
    return(c);
};
   
