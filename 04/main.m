clear; clc;
% Read text from input
text = fileread('input.txt');
text = strsplit(text);

% === Part One ===
word = 'XMAS';

nrows = length(text);
ncols = length(text{1});

function found = findWord(ind, row, col, nrows, ncols, offset, word, text)
  found = 0;
  r = offset(1);
  c = offset(2);
  % Base cases
  % 1) If its the last letter, the word has been found.
  if ind == length(word) && text{row}(col) == word(length(word))
    found = 1;
    return

  % 2) If its not a letter in the correct index, the word has not been found.
  elseif text{row}(col) != word(ind)
    return

  % 3) The next offset would take us out of bounds, the word has not been found.
  elseif (col+c < 1) || (col+c > ncols) || (row+r < 1) || (row+r > nrows)
    return

  % 4) Otherwise, kickoff the function again in offset direction
  else
    found = findWord(ind+1, row+r, col+c, nrows, ncols, offset, word, text);
  end

end

sum = 0;
offsets = [[-1, 1]; [0, 1]; [1, 1]; [-1, 0]; [1, 0]; [-1, -1]; [0, -1]; [1, -1]];

for i=1:nrows
  for j=1:ncols
    % Kick off recursive function for each offset
    c = text{i}(j);
    if c == word(1)
      for k=1:length(offsets)
        offset = offsets(k,:);
        r = offset(1);
        c = offset(2);
        if (j+c < 1) || (j+c > ncols) || (i+r < 1) || (i+r > nrows)
          continue
        endif
        sum = sum + findWord(2, i+r, j+c, nrows, ncols, offset, word, text);
      endfor
    endif
  endfor
endfor

fprintf("Part One Answer: %d\n", sum);

% === Part Two ===
sum = 0;
offsets = [[-1, -1]; [1, 1]; [-1, 1]; [1, -1]]

for i=1:nrows
  for j=1:ncols
    c = text{i}(j);
    % Check to see if the X would be out of bounds
    if c == 'A' && (j > 1) && (j < ncols) && (i > 1) && (i < nrows)

      % Count M's and S's
      M = 0;
      S = 0;
      for k=1:length(offsets)
        c_x = text{i+offsets(k,1)}(j+offsets(k,2));
        if c_x == 'M'
          M = M + 1;
        elseif c_x == 'S'
          S = S + 1;
        else
          break
        endif
      endfor

      % If 1 of the diags makes MAS then its an X-MAS
      if M == 2 && S == 2 && text{i-1}(j-1) != text{i+1}(j+1)
        sum = sum + 1
      endif
    endif
  endfor
endfor

fprintf("Part Two Answer: %d\n", sum);

