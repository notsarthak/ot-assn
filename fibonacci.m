clear
clc %% Basic Configuration done
%% Fibonacci Search Technique
% If function defined over interval say x<1.5 f(x)= x else x>=1.5 f(x)=2x
% then f= @(x) (x<1.5).(x) + (x>=1.5).(2*x);
f= @(x) (x<0.5)*((1-x)/2) + (x>=0.5)*(x.^2);
L=0;
R=1;
% Fn>=4 as Ln/L0=1/Fn and Ln/L0<=0.25 Therefore, 1/Fn<=0.25
n=7;
fib=ones(1,n);
for i=3:n+1
   fib(i)=fib(i-1)+fib(i-2);
end
fib;
for k=1:n
   ratio=fib(n+1-k)./fib(n+2-k);
   x2=L+ratio*(R-L);
   x1=L+R-x2;
   fx1=f(x1);
   fx2=f(x2);
   rsl(k,:)=[L R x1 x2 fx1 fx2];
   if fx1<fx2
       R=x2;
   elseif fx1>fx2
       L=x1;
   else
           if min(abs(x1),abs(L))==abs(L)
               R=x2;
           else
               L=x1;
           end
   end
end
rsl(k,:)=[L R x1 x2 fx1 fx2];
var ={'L','R','x1','x2','fx1','fx2'};
res=array2table(rsl);
res.Properties.VariableNames(1:size(res,2))=var;
disp(res);
xopt=(L+R)/2;
fopt=f(xopt);
disp(xopt);
disp(fopt);
