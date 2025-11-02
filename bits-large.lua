local bottom = {
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
local padding_bottom = 6.5;

local top = {
  20,
  12,
  12,
  20,
  15,
  15,
  12,
  12,
  12,
}
local padding_top = 3;

local function render(t, padding, part, dimension)
  print(part .. "=[")
  for i = 1, #t, 1 do
    print(t[i] .. ",")
  end
  print("];")

  -- pad
  local x = padding;
  print("padding_" .. part .. " = " .. x .. ";");
  for i = 1, #t, 1 do
    t[i] = t[i] + x
  end

  x = 0
  for _, w in ipairs(t) do
    x = x + w
  end

  print("total_" .. part .. " = " .. x .. ";");

  local y = {}
  for i = 1, #t, 1 do
    y[i] = (y[i - 1] or 0) + t[i] / x;
  end

  print(dimension .. "=[")
  for i = 1, #y - 1, 1 do
    print(y[i] .. ",")
  end
  print("];")
end

render(bottom, padding_bottom, "bottom", "columns");
render(top, padding_top, "top", "rows");
