clear
clc %% Basic Configuration done
% Z= 3x1+5x2
% x1 + 3x2 >= 3 , x1 + x2 >= 2
%% Problem Setup :-
C = [3 5 0 0 0];
A = [-1 -3 1 0 -3;-1 -1 0 1 -2];
BV = [3 4];
variables = {'x1','x2','s1','s2','sol'};
ZjCj= C(BV) * A - C;
ZCj = [ZjCj;A];
simp_table = array2table(ZCj);
simp_table.Properties.VariableNames(1:size(simp_table,2))=variables;
disp(simp_table);
run=1;
while(run)
b=A(:,end);
if any(b<0)
   fprintf('Not a Feasible Solution\n');
   [Leaving,pivot_row]=min(b);
   fprintf("The leaving variable is %d\n",pivot_row);
   Ratio=[];
   if all(A(pivot_row,1:end-1)>=0)
       fprintf("Infeasible Solution\n");
       run=0;
   else
   ZC=ZjCj(1:end-1);
   for i=1:size(A,2)-1
       if(A(pivot_row,i)<0)
           Ratio(i)=abs(ZC(i)/A(pivot_row,i));
       else
           Ratio(i)=inf;
       end
   end
   [Entering, pivot_col]=min(Ratio);
   fprintf("The Entering variable is %d\n",pivot_col);
   BV(pivot_row)=pivot_col;
   disp('The New Basic Variables are');
   disp(BV);
   pvt_key=A(pivot_row,pivot_col);
   A(pivot_row,:)=A(pivot_row,:)./pvt_key;
   for i=1:size(A,1)
       if i~=pivot_row
       A(i,:)=A(i,:) - A(i,pivot_col).*A(pivot_row,:);
       end
   end
   ZjCj = ZjCj - ZjCj(pivot_col).*A(pivot_row,:);
   ZCj=[ZjCj;A];
   simp_table = array2table(ZCj);
   simp_table.Properties.VariableNames(1:size(simp_table,2))=variables;
   disp(simp_table);
   end
else
   fprintf('Feasible Solution\n');
   BFS=zeros(1,size(ZCj,2));
   BFS(BV)=A(:,end);
   BFS(end)=sum(C*BFS');
   Optimal_table=array2table(BFS);
   Optimal_table.Properties.VariableNames(1:size(Optimal_table,2))=variables;
   disp(Optimal_table);
   run=0;
end
end
