data = transpose(dlmread('input.txt'));

list_lft = data(1,:);
list_rgt = data(2,:);


% === Part One ===
list_dist = abs(sort(list_lft) - sort(list_rgt));
fprintf("Part One Answer: %i\n", sum(list_dist));

% === Part Two ===

% Create dictionary of values for right list
d = containers.Map('KeyType','int32','ValueType','int32');
for i=1:length(list_rgt)
  val = list_rgt(i);
  if not(d.isKey(val));
    d(val) = 0;
  endif
  d(val) = d(val) + 1;
end

% Loop over values in left list and find "similarity score"
total = 0;

for i=1:length(list_lft)
  val = list_lft(i);
  if d.isKey(val);
    total = total + val * d(val);
  endif
end

fprintf("Part Two Answer: %i\n", total);
