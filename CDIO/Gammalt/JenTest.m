clear all
close all
cam = webcam('USB 2760 Camera')
cam.Resolution = '1280x1024';
%Skriv preview(cam) f�r att f� ig�ng och se video.
preview(cam)