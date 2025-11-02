local diameters = {
  7.0,
  7.5,
  8.0,
  8.5,
  9.0,
  9.5,
  10,
  11,
  12,
  13,
}

print("diameters=[")
for i = 1, #diameters, 1 do
  print(diameters[i] .. ",")
end
print("];")

-- pad
local dx_diameter = 6.5;
print("dx_diameter = " .. dx_diameter .. ";");
for i = 1, #diameters, 1 do
  diameters[i] = diameters[i] + dx_diameter
end

local x_columns = 0
for _, w in ipairs(diameters) do
  x_columns = x_columns + w
end

print("x_columns = " .. x_columns .. ";");

local columns = {}
for i = 1, #diameters, 1 do
  columns[i] = (columns[i - 1] or 0) + diameters[i] / x_columns;
end

print("columns=[")
for i = 1, #columns - 1, 1 do
  print(columns[i] .. ",")
end
print("];")

