clear; clc;
% Read values from input
% Because input may be of different sizes, store into cells
fid = fopen('input.txt');
tline = fgetl(fid);
A = {};
i = 1;
while ischar(tline)
    A(i) = textscan(tline,"%d");
    tline = fgetl(fid);
    i = i + 1;
end

function unsafe = checkReport(report)
  unsafe = false;
  index = 0;

  increasing = false;
  if report(1) - report(2) < 0
    increasing = true;
  endif

  for j=2:length(report)
    diff = report(j) - report(j-1);
    if increasing && (diff < 1 || diff > 3)
      index = j;
      unsafe = true;
      return
    elseif not(increasing) && (diff > -1 || diff < -3)
      index = j;
      unsafe = true;
      return
    endif
  endfor
end

% === Part One ===
unsafe_sum = 0;

for i=1:length(A)
  report = A(1,i){1};
  unsafe = checkReport(report);
  unsafe_sum = unsafe_sum + unsafe;
endfor

safe = length(A) - unsafe_sum;
fprintf("Part One Answer: %d\n", safe);

% === Part Two ===
unsafe_sum = 0;
for i=1:length(A)
  report = A(1,i){1};
  unsafe = checkReport(report);

  % If the report is unsafe, try again but remove the unsafe index
  if unsafe
    for j=1:length(report)
      temp_report = report;
      temp_report(j) = [];
      unsafe = checkReport(temp_report);
      if not(unsafe)
        break
      endif
     endfor
  endif

  unsafe_sum = unsafe_sum + unsafe;
endfor

safe = length(A) - unsafe_sum;
fprintf("Part Two Answer: %d\n", safe);
