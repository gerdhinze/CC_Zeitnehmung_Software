%MATLAB Code for Serial Communication between Arduino and MATLAB

esp=serial('COM3','BAUD', 115200);

fopen(esp);
go = true;

while go
                 
a= input('Press 1 to turn ON LED & 0 to turn OFF:');
fprintf(esp,a);  

if (a == 2)
  go=false;
end
end