write,format="%s\n","悪い例"
write,format="%s\n","func Fib(n){\n \
 local ans;\n\
 if(n==0)ans=0.;\n\
 if(n==1)ans=1.;\n\
 if(n>1) ans=Fib(n-1)+Fib(n-2);\n\
 return ans;}";

func Fib(n){
 local ans;
 if(n==0)ans=0.;
 if(n==1)ans=1.;
 if(n>1) ans=Fib(n-1)+Fib(n-2);
 return  ans;};
rdline,prompt="> ";

A=array(double,3);
B=A;
write,format="%s\n","Fib(30)";
timer,A; Fib(30);timer,B;B-A;
rdline,prompt="> ";

write,format="%s\n","良い例"
write,format="%s\n","func Fib2(n){\n \
 local F0,F1,tmp;\n \
 F0=0.; F1=1.;\n \
 if(n==0) F1=F0;\n \
 for(i=2;i<=n;i++){tmp=F1; F1=F0+F1; F0=tmp;};\n \
 return(F1);};";

func Fib2(n){
 local F0,F1,tmp;
 F0=0.; F1=1.;
 if(n==0) F1=F0;
 for(i=2;i<=n;i++){tmp=F1; F1=F0+F1; F0=tmp;};
 return(F1);};


rdline,prompt="> ";
write,format="%s\n","Fib2(30)";
timer,A; Fib2(30);timer,B;B-A;
rdline,prompt="> ";

write,format="%s\n","include,\"FibMP.i\";";
include,"FibMP.i"
rdline,prompt="> ";

write,format="%s\n","setMPIDigit;";
setMPIDigit;
rdline,prompt="> ";
write,format="%s\n","printMPI(Fib2MPI(10));";
printMPI(Fib2MPI(10));
rdline,prompt="> ";
write,format="%s\n","printMPI(Fib2MPI(100));";
printMPI(Fib2MPI(100));
rdline,prompt="> ";
write,format="%s\n","printMPI(Fib2MPI(10000));";
printMPI(Fib2MPI(10000));
rdline,prompt="> ";





