vid = videoinput('tisimaq_r2013_64', 1, 'BY8 (1024x768)');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

preview(vid);
