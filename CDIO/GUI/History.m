function varargout = History(varargin)
% HISTORY MATLAB code for History.fig
%      HISTORY, by itself, creates a new HISTORY or raises the existing
%      singleton*.
%
%      H = HISTORY returns the handle to a new HISTORY or the handle to
%      the existing singleton*.
%
%      HISTORY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTORY.M with the given input arguments.
%
%      HISTORY('Property','Value',...) creates a new HISTORY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before History_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to History_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help History

% Last Modified by GUIDE v2.5 06-Nov-2020 14:01:16

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to History (see VARARGIN)

% Choose default command line output for History
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes History wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = History_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function historyName_Callback(hObject, eventdata, handles)
% hObject    handle to historyName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of historyName as text
%        str2double(get(hObject,'String')) returns contents of historyName as a double


% --- Executes during object creation, after setting all properties.
function historyName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to historyName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
historyname = get(handles.historyName, 'String');
base = 'C:\Users\marhu961\Desktop\BEERS\CDIO\GUI\SAVEDIMAGES';   % Assumed to be existing
cd(base);
cd(historyname);

source_dir=pwd;
d=dir([source_dir, '\*.mat'])
n=length(d);
a=ls
a=string(a)
set(handles.listbox1, 'string', a)
%historyframe = 'C:\Users\marhu961\Desktop\BEERS\CDIO\GUI\SAVEDIMAGES/' + historyname;
% a = load('20201104T140158.mat');
% imwrite(a.frame, 'hist_pic.jpg');
% axes(handles.historyAxes) %G�r in till picture axes, s�tter som aktiv (figure)
% pic=imread('hist_pic.jpg');
% imshow(pic);



historyname
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
imagename = get(handles.listbox1, 'Value');

source_dir=pwd;
d=dir([source_dir, '\*.mat'])
n=length(d);
current_list=ls
current_list=string(current_list)
image_string = current_list(imagename,:)

historyname = get(handles.historyName, 'String');
base = 'C:\Users\marhu961\Desktop\BEERS\CDIO\GUI\SAVEDIMAGES';   % Assumed to be existing
cd(base);
cd(historyname);

% historyframe = 'C:\Users\marhu961\Desktop\BEERS\CDIO\GUI\SAVEDIMAGES/' + historyname;
current_pic = load(image_string);
imwrite(current_pic.frame, 'current_pic.jpg');
axes(handles.historyAxes) %G�r in till picture axes, s�tter som aktiv (figure)
pic=imread('current_pic.jpg');
imshow(pic);

% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
Startmenu

% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Quit.
function Quit_Callback(hObject, eventdata, handles)
closereq();
% hObject    handle to Quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
