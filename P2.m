%%
clear all;
%project part 2
load('iddata-21.mat')
u=id.u;
y=id.y;
Ts=id.Ts;
plot(id)
N=length(u);

%Validation dataset
u_val=val.u;
y_val=val.y;
Ts_val=val.Ts;
figure
plot(val)
M=length(u_val);


na=20;
nb=20;
nk=1;
m=2;
X=[];
phi1=[];
phi2=[];
for k = 1:N
    a=[];
     for p1=0:m
         for p2=0:m
             cond= p1+p2;
             if cond<=m
       for i = 1:na     
           if (k-i) <= 0
               phi1 = 0;  
           else
               phi1 = (-y(k-i).^p1);
           end
        
              
       end
             
    
        for j = 1:nb
            if (k-j) <= 0
               phi2 = 0; 
            
            else    
                phi2= (u(k-j).^p2);  
            end
          
        end  
        a=[a phi1*phi2];
             end 
         end
     end
    X=[X; a];
end
theta = X\y;
y_approx= X*theta;%predicted output


%%
%validation
X_val=[];
X_simulation=[];
phi3=[];
phi4=[];
phi5=[];
for k = 1:N
    a_val=[];
    a_simulation=[];
     for p1=0:m
         for p2=0:m
             cond= p1+p2;
             if cond<=m
       for i = 1:na     
           if (k-i) <= 0
               phi3 = 0; 
               phi5=0;
           else
               phi3 = (-y_val(k-i).^p1);
               phi5=(-yhat_prediction(k-i).^p1);
           end
        
              
        end
             
    
        for j = 1:nb
            if (k-j) <= 0
               phi4 = 0; 
            
            else   
                %        !!!!!! nk=??????
                phi4= (u_val(k-j).^p2);  
            end
          
        end  
        a_val=[a_val phi3*phi4];
        a_simulation=[a_simulation phi5*phi4];
             end 
         end
     end
    X_val=[X_val; a_val];
    X_simulation=[X_simulation; a_simulation];
    yhat_prediction=X_val*theta;
    yhat_simulation=X_simulation*theta;
end
    model=arx(id, [na, nb, nk]);
    figure
    compare(model,val)
    figure
    plot(yhat_simulation);hold on
    plot(y_val)
    legend('y simulation','y val');     
    hold off
   
    plot(yhat_prediction);hold on
    plot(y_val)
    legend('y prediction','y val');







