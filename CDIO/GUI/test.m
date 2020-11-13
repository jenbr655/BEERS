function align_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to align_GUI (see VARARGIN)
% Choose default command line output for align_GUI
handles.output = hObject;
handles.cam=webcam;
imWidth=640;
imHeight=480;
axes(handles.axes1);
handles.hImage=image(zeros(imHeight,imWidth,3),'Parent',handles.axes1);
preview(handles.cam, handles.hImage)
guidata(hObject, handles)