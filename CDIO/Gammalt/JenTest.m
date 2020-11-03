clear all
close all
cam = webcam('USB 2760 Camera')
cam.Resolution = '1280x1024';
%Skriv preview(cam) för att få igång och se video.
preview(cam)