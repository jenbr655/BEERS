function varargout = Startmenu(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Startmenu_OpeningFcn, ...
                   'gui_OutputFcn',  @Startmenu_OutputFcn, ...
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


% --- Executes just before Startmenu is made visible.
function Startmenu_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for Startmenu
handles.output = hObject
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Startmenu_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in startmole.
function startmole_Callback(hObject, eventdata, handles)
 myCameraGUI2



% --- Executes on button press in usermanual.
function usermanual_Callback(hObject, eventdata, handles)
Usermanual



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)



% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
closereq();



% --- Executes on button press in startvessel.
function startvessel_Callback(hObject, eventdata, handles)
vesselGUI


% --- Executes on button press in history.
function history_Callback(hObject, eventdata, handles)
History



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
logo=imread('logo_frame.png');
image(logo);
axis off;
axis image;




