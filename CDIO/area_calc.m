%% Area ber�kning 

%% Alt som inte funkar �n men skulle kunna anv�nda

%area=regionprops(im, 'Area')

%circularity=regionprops(im, 'EquivDiameter')

%% Alt 1, ber�knar arean av pixlar som �r vita men vet inte hur stor en pixel �r 
tot_area=bwarea(BWfill) %total area in pixels 

num_one=sum(BWfill(:)==1) %how many ones i matrix

[x_val y_val]=size(BWfill); %size of picture
tot_num_pix=x_val*y_val;

num_one_of_tot=num_one/tot_num_pix; %procent of how many pixels that are white

area_mole=tot_area*num_one_of_tot %area in pixels that are white

%F�r att detta ska fungera beh�ver vi nu veta storleken av en pixel och det
%beror p� inzoomning osv. 
