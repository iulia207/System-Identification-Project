
data=load('proj_fit_39.mat');
id=data.id;
val=data.val;
X1=data.id.X{1};
X2=data.id.X{2};
Y=data.id.Y;
mesh(X1,X2,Y)
%%
N=length(X1);
M=length(X2);
%PHI=[];
n=15;
y=Y(:);
    PHI=[];
    phi=[];
    phi1=[];
    
for i=1:N
    for j=1:M
        a=[];
      for p1=0:n
         for p2=0:n
             cond= p1+p2; 
             if cond<=n
        phi=[X1(i).^p1];
        phi1=[ X2(j).^p2];
        a=[a phi*phi1];
            end
         end
      end
        PHI=[PHI; a];
    end 
end

theta=PHI\y;
g=PHI*theta;

ghat=reshape(g,[41,41]);
s=mesh(X1,X2,ghat);hold on
s.FaceColor='flat';
mesh(X1,X2,Y);
%MSE=1/k*sum(power(ERROR,2))
for i=1:n
    ERROR=y(i)-g(i);
    MSE(i,1) = 1/i*sum(power(ERROR,2));
end

MSE_min = min(MSE)
index_min = find(MSE == MSE_min)

%% validation

Xval1=data.val.X{1};
Xval2=data.val.X{2};
Yval=data.val.Y;
y_column=Yval(:);
mesh(Xval1,Xval2,Yval);
Z=length(Xval1);
T=length(Xval2);
    PHI1=[];
    phi_0=[];
    phi_1=[];
    
for i=1:Z
    for j=1:T
        b=[];
      for p1=0:n
         for p2=0:n
             cond= p1+p2;
     if cond<=n
        phi_0=[Xval1(i).^p1];
        phi_1=[ Xval2(j).^p2];
        b=[b phi_0*phi_1];
      

    end
         end
      end
        PHI1=[PHI1; b];
    end 
end
g_val=PHI1*theta;
g_val_approx=reshape(g_val,[Z,T]);
s1=mesh(Xval1,Xval2,g_val_approx);hold on
s1.FaceColor='flat'
mesh(Xval1,Xval2,Yval);
for i=1:n
 ERROR=y_column(i)-g_val(i);
MSE1(i,1)=1/i*sum(power(ERROR,2));
end
MSE_min = min(MSE)
index_min = find(MSE == MSE_min)