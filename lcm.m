%% Least Cost Method
clear
clc %% Basic Configuration done
c = [2 10 4 5 ; 6 12 8 11 ; 3 9 5 7];
a = [12 25 20];
b = [25 10 15 5];
i = size(a,2);
j = size(b,2);
if sum(a) == sum(b)
   fprintf('Balanced\n');
else
   fprintf('Unbalanced\n');
       if(sum(b)<sum(a))
           c(:,end+1) = zeros(1,i);
           b(end+1) = sum(a) - sum(b);
       else
       c(end+1,:) = zeros(1,j);
       a(end+1) = sum(b) - sum(a);
       end
end
m = size(a,2);
n = size(b,2);
x=zeros(m,n);
cost=c;
for i=1:m*n
       cpq = min(c(:)); %disp(cpq);
       if(cpq == inf)
           break;
       end
       [p1,q1] = find(cpq==c);
       xpq = min(a(p1),b(q1));
       [x1,ind]=max(xpq);
       p=p1(ind);
       q=q1(ind);
       x(p,q)=min(a(p),b(q));
       if(x(p,q)==a(p))
           b(q)=b(q)-x(p,q);
           a(p)=a(p)-x(p,q);
           c(p,:)= inf;
       else
           b(q)=b(q)-x(p,q);
           a(p)=a(p)-x(p,q);
           c(:,q)= inf;
       end
end
disp(x); disp(c); z=cost.*x;
units_table = array2table(x); variables={'1','2','3','4','5'};
units_table.Properties.VariableNames(1:size(units_table,2))=variables;
disp(units_table); cost=sum(z(:));
fprintf("The Minimum cost: %d", cost);
