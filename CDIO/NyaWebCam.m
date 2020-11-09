cam=webcam('USB2.0 Digital Camera')
imWidth=640;
imHeight=480;
%axes(handles.cameraAxes);
%hImage=image(zeros(imHeight,imWidth,3),'Parent',handles.cameraAxes);
preview(cam)
%DateString = datestr(now, 23);
%set(handles.dateTimeEdit, 'string',DateString);

%%
% Display a list of installed cameras.
webcamlist
% Get an object linked to the webcam.
mycam = webcam
% Show what things this camera can do
methods(mycam)
properties(mycam)
% Open live video window.
mycam.preview
% Prompt user to snap a photo.
promptMessage = sprintf('Do you want to snap a photo,\nor Quit?');
titleBarCaption = 'Continue?';
buttonText = questdlg(promptMessage, titleBarCaption, 'Snap', 'Quit', 'Snap');
if contains(buttonText, 'Quit', 'IgnoreCase', true)
	return;
end
% Snap the photo.
rgbImage = mycam.snapshot;
% Close live video window.
mycam.closePreview
% Display image
imshow(rgbImage);
caption = sprintf('Here is the photo you snapped at %s', datestr(now));
title(caption, 'FontSize', 20);
% Maximize figure.
g = gcf;
g.WindowState = 'maximized';