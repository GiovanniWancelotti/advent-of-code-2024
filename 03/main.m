clear; clc;
% Read text from input
text = fileread('input.txt');

% === Part One ===
expression = 'mul\((\d+),(\d+)\)';

% Process regex
[tokens,ext] = regexp(text,expression,'tokens','tokenExtents');

sum = 0;
for i=1:length(tokens)
  sum = sum + str2num(tokens{i}{1}) * str2num(tokens{i}{2});
endfor

fprintf("Part One Answer: %d\n", sum);

% === Part Two ===

% Find do() and don't(). Add a buffer value to vector at the end which will be
% greater than any possible index which appears in the regex.
% Because do is initially enabled, give it a starting index of 1 as well.
do_index = [1, regexp(text,'do\(\)'), length(text)+1];
dont_index = [0, regexp(text,"don't\(\)"), length(text)+1];

% Initialize looping variables
curr_do = 1;
curr_dont = 1;
sum = 0;

for i=1:length(tokens)
  first_index = ext{i}(1);

  % Increase indeces up to index before they are greater than token index
  while(not(do_index(curr_do+1) > first_index))
    curr_do = curr_do + 1;
  endwhile
  while(not(dont_index(curr_dont+1) > first_index))
    curr_dont = curr_dont + 1;
  endwhile

  % Whichever index is greater is the block we are currently in
  if do_index(curr_do) > dont_index(curr_dont)
    sum = sum + str2num(tokens{i}{1}) * str2num(tokens{i}{2});
  endif
endfor

fprintf("Part Two Answer: %d\n", sum);
