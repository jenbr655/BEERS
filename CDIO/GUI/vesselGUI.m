function varargout = vesselGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vesselGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @vesselGUI_OutputFcn, ...
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


% --- Executes just before vesselGUI is made visible.
function vesselGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.output = hObject; %BEH�VS DENNA?
%%%%%%%%%%%%%%%%%%%%%%%%%%EGET MIKROSKOP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear neostrip;
% clear a;
% a=arduino('COM4', 'Uno','Libraries', 'Adafruit/NeoPixel')
% neostrip=addon(a,'Adafruit/NeoPixel', 'D6', 12)
% %neostrip.Brightness=0.2;
% neostrip.Brightness=1;
% writeColor(neostrip, 1:12, [0.05, 1, 0.05]);
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

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%USB MIKROSKOP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cam=webcam('USB 2760 Camera')
%cam=webcam('USB2.0 Digital Camera')
imWidth=640;
imHeight=480;
axes(handles.cameraAxes);
hImage=image(zeros(imHeight,imWidth,3),'Parent',handles.cameraAxes);
preview(cam,hImage)
DateString = datestr(now, 23);
set(handles.dateTimeEdit, 'string',DateString);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes myCameraGUI2 wait for user response (see UIRESUME)
 uiwait(handles.figure1); %%%EGET TAGIT BORT KOMMENTAR


% --- Outputs from this function are returned to the command line.
function varargout = vesselGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function cameraAxes_CreateFcn(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function pictureAxes_CreateFcn(hObject, eventdata, handles)
%load('testframe.mat');
%imshow(frame)

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
logo=imread('logo_frame.png')
image(logo)
axis off;
axis image


function name_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in zoommenu.
function zoommenu_Callback(hObject, eventdata, handles)
contents= get(hObject, 'String');
chosen_zoom = contents{get(hObject, 'Value')};



% --- Executes during object creation, after setting all properties.
function zoommenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on button press in acquisition.
function acquisition_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%AREA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
choise = get(handles.zoommenu,'Value'); %get selected band
area=0; %Initialize zoom-parameter
switch choise
     case 1
      % disp('You got no ZOOM')
       set(handles.molesizeval, 'string','Choose area');
       set(handles.edit12, 'string','Choose area');
       area=0;
     case 2
       area=1;
     case 3 
      area=2;
    end
disp(area)
 s = load('current_pic.mat');
imwrite(s.frame, 'current_pic.jpg');
[vessel_dens, ves_num] = Seg_ves_func(area); %Area_calc r��knar ut arean (i pixlar) fr��n den bin��ra bilden som f��s fr��n hairGone.
axes(handles.axes3)
pic=imread('boundary_pic.jpg');
imshow(pic);
set(handles.molesizeval, 'string',vessel_dens);
set(handles.edit12, 'string',ves_num);


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
closereq();
Startmenu


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
closereq();
delete(webcam('USB 2760 Camera'))


function edit4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


function molesizeval_Callback(hObject, ~, handles)


% --- Executes during object creation, after setting all properties.
function molesizeval_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
name = get(handles.name, 'String');
set(handles.editName, 'string',name);
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
