 f = figure;
        disp('This will print immediately');
        keydown = waitforbuttonpress;
        if (keydown == 0)
            disp('Mouse button was pressed');
        else
            disp('Key was pressed');
        end
        close(f);