%% Script for calculation of area

function [result, circ]=area_calc(img, zoom)        %Input is a binary picture and zoom-value

circularity=regionprops(img, 'circularity');        %Measure circularity in binary picture
C= struct2cell(circularity);
A= cell2mat(C);
circ=A*100;                                         %Circularity in percent

num_one=[];
num_one=sum(img(:)==1);                             %How many ones i matrix


area_mole=[];

if zoom==1
    area_mole=num_one*(1/27)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==2
    area_mole=num_one*(1/29)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==3
    area_mole=num_one*(1/30)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==4
    area_mole=num_one*(1/31)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==5
    area_mole=num_one*(1/32)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==6
    area_mole=num_one*(1/33)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==7
    area_mole=num_one*(1/44)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end


if zoom==8
    area_mole=num_one*(1/46)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==9
    area_mole=num_one*(1/55)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==9.5
    area_mole=num_one*(1/87)^2;                    %Calibrated wrt pixels/cm and changed to mm^2
end

if zoom==10
    area_mole=num_one*(1/127)^2;                   %Calibrated wrt pixels/cm and changed to mm^2
end

result = area_mole;                                %Result is the area of the mole in mm^2

if zoom==0
    circ='Choose zoom';
    result='Choose zoom';
end

end


