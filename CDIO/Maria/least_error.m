function outT = least_error(histo,startT)
%LEAST_ERROR Calculates a threshold value from a histogram using the least error method.
%   Args:
%       histo: A 1D array histogram. The histogram bins must correspond to gray value 0, 1, 2,...
%       startT: Start threshold
%   Returns: 
%       outT: the calculated threshold (integer)

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
      % Calculate the variance for the lower part
      %------------------------------------------
      lowersumSQ = sum(histo(1:current_T+1).*([0:current_T] - mean0).^2);
      lowersum2 = sum(histo(1:current_T +1));
      if lowersum2 ~= 0
        var0 = lowersumSQ/lowersum2;
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
      % Calculate the variance for the upper part
      %------------------------------------------
      uppersumSQ = sum(histo(current_T+2:num).*([current_T+1:num-1]-mean1).^2);
      if uppersum2 ~= 0
        var1 = uppersumSQ/uppersum2;
      else
        error('Cannot calculate new threshold');
      end

      % Calculate the overall probability of the lower and upper part
      %--------------------------------------------------------------
      P0 = sum(histo(1:current_T+1))/sum(histo);
      P1 = sum(histo(current_T+2:num))/sum(histo);

      % Solve for threshold
      %--------------------
      a = (var0*var1)/(var1-var0);
      b = 2*(-(mean0/var0)+(mean1/var1));
      c = -2*log(P0/P1) + log(var0/var1) + (mean0^2/var0) - (mean1^2/var1);

      T = roots([1 a*b a*c]);

      % Choose the solution that is between the mean values
      %----------------------------------------------------
      if (T(1)>=mean0) && (T(1)<=mean1)
        new_T = floor(T(1));
      else
        new_T = floor(T(2));
      end
    end

    outT = new_T;
end

