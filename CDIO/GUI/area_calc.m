function [area_mole]=area_calc(ans, zoom) %% Area ber�kning 

% Alt som inte funkar �n men skulle kunna anv�nda

%area=regionprops(im, 'Area')

%circularity=regionprops(im, 'EquivDiameter')

% Alt 1, ber�knar arean av pixlar som �r vita men vet inte hur stor en pixel �r 

   
%tot_area=bwarea(ans); %total area in pixels 

num_one=sum(ans(:)==1); %how many ones i matrix
area_mole = num_one;
%[x_val y_val]=size(ans); %size of picture
%tot_num_pix=x_val*y_val;

%num_one_of_tot=num_one/tot_num_pix; %procent of how many pixels that are white

%area_mole=tot_area*num_one_of_tot %area in pixels that are white
 
if zoom==1
     area_mole=area_mole*(10/239)^2; %Calibrated wrt pixels/cm and changed to mm
end

 if zoom==10
     area_mole=area_mole*(1/127)^2; %Calibrated wrt pixels/cm and changed to mm
 end


%F�r att detta ska fungera beh�ver vi nu veta storleken av en pixel och det
%beror p� inzoomning osv.
end