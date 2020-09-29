function outT = mid_way(histo, startT)
%MID_WAY Calculates a threshold value from a histogram using the mid-way method. 
%   Args:
%       histo: A 1D array histogram. The histogram bins must correspond to gray value 0, 1, 2,...
%       startT: Start threshold
%   Returns: 
%       outT: the calculated threshold (integer)
%
% Programmed by Maria Magnusson 2018-08

    num = length(histo);
    current_T = -1;%-1 just to make sure we get into the loop
    new_T = floor(startT);
    % Calculate the threshold
    %------------------------
    while abs(current_T-new_T) > 0.5
      current_T = new_T;
      % Calculate mean for the lower part of the histogram
      %---------------------------------------------------
      lowersum1 = sum(histo(1:current_T+1).*(0:current_T));
      lowersum2 = sum(histo(1:current_T+1));
      if lowersum2 ~= 0
        mean0 = lowersum1/lowersum2;
      else
        error('Cannot calculate new threshold');
      end
      % Calculate mean for the upper part of the histogram
      %---------------------------------------------------
      uppersum1 = sum(histo(current_T+2:num).*(current_T+1:num-1));
      uppersum2 = sum(histo(current_T+2:num));
      if uppersum2 ~= 0
        mean1 = uppersum1/uppersum2;
      else
        error('Cannot calculate new threshold');
      end
      % Calculate new threshold
      %------------------------
      new_T = floor((mean0+mean1)/2);
    end

    outT = new_T;
end
