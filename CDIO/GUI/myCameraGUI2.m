function varargout = myCameraGUI2(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myCameraGUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @myCameraGUI2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before myCameraGUI2 is made visible.
function myCameraGUI2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.output = hObject; %BEH�VS DENNA?
%%%%%%%%%%%%%%%%%%%%%%%%%%%EGET MIKROSKOP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear neostrip;
% clear a;
% a=arduino('COM4', 'Uno','Libraries', 'Adafruit/NeoPixel')
% neostrip=addon(a,'Adafruit/NeoPixel', 'D6', 12)
% %neostrip.Brightness=0.2;
% neostrip.Brightness=1;
% writeColor(neostrip, 1:12, [1, 1, 1]);
% 
% cam = videoinput('tisimaq_r2013_64', 1, 'BY8 (1024x768)');
% src = getselectedsource(cam);
% cam.FramesPerTrigger = 1;
% imWidth=640;
% imHeight=480;
% axes(handles.cameraAxes);
% hImage=image(zeros(imHeight,imWidth,3),'Parent',handles.cameraAxes);
% preview(cam,hImage)
% DateString = datestr(now, 23);
% set(handles.dateTimeEdit, 'string',DateString);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%USB MIKROSKOP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cam=webcam('USB 2760 Camera')
cam=webcam('USB2.0 Digital Camera')
imWidth=640;
imHeight=480;
axes(handles.cameraAxes);
hImage=image(zeros(imHeight,imWidth,3),'Parent',handles.cameraAxes);
preview(cam,hImage)
DateString = datestr(now, 23);
set(handles.dateTimeEdit, 'string',DateString);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes myCameraGUI2 wait for user response (see UIRESUME)
 uiwait(handles.MyCameraGUI); %%%EGET TAGIT BORT KOMMENTAR


% --- Outputs from this function are returned to the command line.
function varargout = myCameraGUI2_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
handles.output=hObject;%%%Lagt till
varargout{1} = handles.output;


% --- Executes on button press in captureImage.
function captureImage_Callback(hObject, eventdata, handles)
frame = get(get(handles.cameraAxes,'children'),'cdata'); % The current displayed frame
DateString = datestr(now, 30);
name = get(handles.name, 'String');
if (isempty(name)||strcmp(name,'Enter name...'))
    name = 'anonymous';
end
base = 'C:\Users\marhu961\Desktop\BEERS\CDIO\GUI\SAVEDIMAGES';   % Assumed to be existing
cd(base);
mkdir(name);
save(name + "/" + DateString + ".mat", 'frame');
%setappdata(handles.pictureAxes, 'newest', frame)
cd('C:\Users\marhu961\Desktop\BEERS\CDIO\GUI')
axes(handles.pictureAxes) %G���r in till picture axes, s���tter som aktiv (figure)
imshow(frame)
%imwrite(frame, 'current_pic', 'JPEG');
save('current_pic.mat', 'frame');
disp("Frame saved to file: " + name + "/" + DateString + ".mat");


% --- Executes when user attempts to close MyCameraGUI.
function MyCameraGUI_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);
delete(imaqfind);


% --- Executes during object creation, after setting all properties.
function pictureAxes_CreateFcn(hObject, eventdata, handles)
load('testframe.mat');
imshow(frame)


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)


% --- Executes on selection change in zoommenu.
function zoommenu_Callback(hObject, eventdata, handles)
contents= get(hObject, 'String');
chosen_zoom = contents{get(hObject, 'Value')};


% --- Executes during object creation, after setting all properties.
function zoommenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)


function name_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on name and none of its controls.
function name_KeyPressFcn(hObject, eventdata, handles)
%F��RS��K TILL ATT F�� UPP NAMNET P�� PARAMETERPANELEN D�� MAN TRYCKER P�� ENTER
% if strcmpi(eventdata.Key, 'return')
%    setappdata(hObject, 'name', get(hObject, 'String'))
% end
% x = getappdata(hObject, 'name')
% set(handles.editName, 'string',x);

% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
name = get(handles.name, 'String');
set(handles.editName, 'string',name);


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
closereq();
delete(webcam('USB 2760 Camera'))

function parameters_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function parameters_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function molesizeval_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function molesizeval_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
closereq();
Startmenu

% --- Executes on button press in acquisition.
function acquisition_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%AREA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
choise = get(handles.zoommenu,'Value'); %get selected band
zoom=0; %Initialize zoom-parameter
switch choise
     case 1
       disp('You got no ZOOM')
     case 2
       zoom=1;
     case 3 
      zoom=2;
      case 4 
      zoom=3;
      case 5 
      zoom=4;
      case 6
      zoom=5;
      case 7 
      zoom=6;
      case 8 
      zoom=7;
      case 9 
      zoom=8;
      case 10
      zoom=9;
      case 11 
      zoom=9.5;
      case 12
      zoom=10;
    end
disp(zoom)
 s = load('current_pic.mat');
imwrite(s.frame, 'current_pic.jpg');
a = area_calc(Seg_mole(), zoom); %Area_calc r��knar ut arean (i pixlar) fr��n den bin��ra bilden som f��s fr��n hairGone.
axes(handles.axes3)
pic=imread('boundary_pic.jpg');
imshow(pic);
set(handles.molesizeval, 'string',a);

function editName_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dateTimeEdit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function dateTimeEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function SizeEdit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function SizeEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
logo=imread('logo_frame.png')
image(logo)
axis off;
axis image
% Hint: place code in OpeningFcn to populate axes4

function RoundnessEdit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function RoundnessEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
