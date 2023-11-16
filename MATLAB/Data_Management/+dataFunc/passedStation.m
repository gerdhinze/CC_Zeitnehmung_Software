function passedStation(Station)

load('Car1.mat')

name = 'Car1';
%Gate1 = [name,': passed Station 1 ','(',dout1,')'];
%Gate2 = [name,': passed Station 2 ','(',dout1,')'];
%Gate3 = [name,': passed Station 3 ','(',dout1,')'];

Gate1 = [name,': passed Station 1 '];
Gate2 = [name,': passed Station 2 '];
Gate3 = [name,': passed Station 3 '];

      if Station == 1
                disp(Gate1)
          
      elseif Station == 2
                disp(Gate2)
              
      elseif Station == 3
                disp(Gate3)
      end

end