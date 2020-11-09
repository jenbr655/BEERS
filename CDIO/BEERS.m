clear neostrip;
clear a;

a=arduino('COM4', 'Uno','Libraries', 'Adafruit/NeoPixel')
neostrip=addon(a,'Adafruit/NeoPixel', 'D6', 12)
%neostrip.Brightness=0.2;
neostrip.Brightness=1;
writeColor(neostrip, 1:12, [0.4, 0, 1]);

% for n = 1:100
%     neostrip.Brightness=0.5+0.5*sin(n*0.1);
% end
% 
% neostrip.Brightness=0.2;
% while 1==1
% myCameraGUI2
% 
% myCameraGUI2
% end
% 
%  myCameraGUI2
 


