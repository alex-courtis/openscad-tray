local widths = {
  15,
  15,
  15,
  15,

  30,

  25,
  25,
  25,

  30,

  25,
}
print("n_rows = " .. #widths .. ";")

local total_width = 0
for _, w in ipairs(widths) do
  total_width = total_width + w
end

local r = 0
print("rows =[[")
for i = 1, #widths - 1, 1 do
  r = r + widths[i] / total_width;
  print(r .. ",")
end
print("]];")

