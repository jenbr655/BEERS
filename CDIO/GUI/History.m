function varargout = History(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @History_OpeningFcn, ...
                   'gui_OutputFcn',  @History_OutputFcn, ...
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


% --- Executes just before History is made visible.
function History_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for History
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = History_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function historyName_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function historyName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
historyname = get(handles.historyName, 'String')


base = 'C:\Users\marhu961\Desktop\BEERS\CDIO\GUI\SAVEDIMAGES';   % Assumed to be existing
cd(base);
cd(historyname);

source_dir=pwd;
d=dir([source_dir, '\*.mat'])
%n=length(d);
a=ls
a=string(a)
set(handles.listbox1, 'string', a)
historyname



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
imagename = get(handles.listbox1, 'Value');

source_dir=pwd;
d=dir([source_dir, '\*.mat'])
%n=length(d); 
current_list=ls
current_list=string(current_list)
image_string = current_list(imagename,:)

historyname = get(handles.historyName, 'String');
base = 'C:\Users\marhu961\Desktop\BEERS\CDIO\GUI\SAVEDIMAGES';   % Assumed to be existing
cd(base);
cd(historyname);

current_pic = load(image_string);
imwrite(current_pic.frame, 'current_pic.jpg');
axes(handles.historyAxes) %G�r in till picture axes, s�tter som aktiv (figure)
pic=imread('current_pic.jpg');
imshow(pic);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
Startmenu

% --- Executes on button press in Quit.
function Quit_Callback(hObject, eventdata, handles)
closereq();
