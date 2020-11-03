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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myCameraGUI2 (see VARARGIN)

% Choose default command line output for myCameraGUI2
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SKRIV H��R%%%%%%%%%%%%%%%%%%%%
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to align_GUI (see VARARGIN)
% Choose default command line output for align_GUI
handles.output = hObject;
cam=webcam('USB 2760 Camera')
imWidth=640;
imHeight=480;
axes(handles.cameraAxes);
hImage=image(zeros(imHeight,imWidth,3),'Parent',handles.cameraAxes);
preview(cam,hImage)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes myCameraGUI2 wait for user response (see UIRESUME)
 uiwait(handles.MyCameraGUI); %%%EGET TAGIT BORT KOMMENTAR


% --- Outputs from this function are returned to the command line.
function varargout = myCameraGUI2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output=hObject;%%%Lagt till
varargout{1} = handles.output;


% % --- Executes on button press in startStopCamera.
% function startStopCamera_Callback(hObject, eventdata, handles)
% % hObject    handle to startStopCamera (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EGET%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Start/stop camera
% if strcmp(get(handles.startStopCamera,'String'),'Start Camera')
%       % Camera is off. Change button string and start camera.
%       set(handles.startStopCamera,'String','Stop Camera')
%       start(handles.video)
%       set(handles.startAcquisition,'Enable','on');
%       set(handles.captureImage,'Enable','on');
% else
%       % Camera is on. Stop camera and change button string.
%       set(handles.startStopCamera,'String','Start Camera')
%       stop(handles.video)
%       set(handles.startAcquisition,'Enable','off');
%       set(handles.captureImage,'Enable','off');
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in captureImage.
function captureImage_Callback(hObject, eventdata, handles)
% hObject    handle to captureImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EGET%%%%%%

frame = get(get(handles.cameraAxes,'children'),'cdata'); % The current displayed frame


DateString = datestr(now, 30);

name = get(handles.name, 'String');
if (isempty(name)||strcmp(name,'Enter name...'))
    name = 'anonymous';
end
mkdir(name);
save(name + "/" + DateString + ".mat", 'frame');
%setappdata(handles.pictureAxes, 'newest', frame)

axes(handles.pictureAxes) %G�r in till picture axes, s�tter som aktiv (figure)
imshow(frame)

%imwrite(frame, 'current_pic', 'JPEG');
save('current_pic.mat', 'frame');
disp("Frame saved to file: " + name + "/" + DateString + ".mat");


% --- Executes when user attempts to close MyCameraGUI.
function MyCameraGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to MyCameraGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
delete(imaqfind);


% --- Executes during object creation, after setting all properties.
function pictureAxes_CreateFcn(hObject, eventdata, handles)
%load('testframe.mat')
%var=frame
% hObject    handle to pictureAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load('testframe.mat');
imshow(frame)
%load('testframe.mat');
%imshow(frame)
%newest = getappdata(hObject, 'newest')
%imshow(newest)
% Hint: place code in OpeningFcn to populate pictureAxes


% Hint: place code in OpeningFcn to populate pictureAxes
% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in zoommenu.
function zoommenu_Callback(hObject, eventdata, handles)

% hObject    handle to zoommenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents= get(hObject, 'String');
chosen_zoom = contents{get(hObject, 'Value')};
% Hints: contents = cellstr(get(hObject,'String')) returns zoommenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from zoommenu


% --- Executes during object creation, after setting all properties.
function zoommenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zoommenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



%zoom = get(handles.zoommenu, 'string')


% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on name and none of its controls.
function name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
%if strcmpi(eventdata.Key, 'return')
 %   setappdata(hObject, 'name', get(hObject, 'String'))
%end
%x = getappdata(hObject, 'name')


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
closereq();
delete(webcam('USB 2760 Camera'))

% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function parameters_Callback(hObject, eventdata, handles)
% hObject    handle to parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parameters as text
%        str2double(get(hObject,'String')) returns contents of parameters as a double


% --- Executes during object creation, after setting all properties.
function parameters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function molesizeval_Callback(hObject, eventdata, handles)
% hObject    handle to molesizeval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of molesizeval as text
%        str2double(get(hObject,'String')) returns contents of molesizeval as a double


% --- Executes during object creation, after setting all properties.
function molesizeval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to molesizeval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
closereq();
Startmenu
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
      zoom=10;
  end
zoom
s = load('current_pic.mat');
imwrite(s.frame, 'current_pic.jpg');
a = area_calc(Seg_mole(), zoom); %Area_calc räknar ut arean (i pixlar) från den binära bilden som fås från hairGone.
set(handles.molesizeval, 'string',a);


%=3;
%set(handles.molesizeval, 'string',x);
% hObject    handle to acquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
