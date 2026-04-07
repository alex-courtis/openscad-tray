include <tray.scad>

function sum_range(v, from, to) =
  from <= min(to, len(v) - 1) ?
    v[from] + sum_range(v, from + 1, to)
  : 0;

function sumv(v, i = 0) = i < len(v) ? v[i] + sumv(v, i + 1) : 0;

d_filament = 0.6;
z_layer = 0.3;

t_outer = d_filament * 3;
t_inner = d_filament * 3;
t_bottom = z_layer * 3; // t_outer - t_inner is added and accounted for

bottom_thickness = t_bottom - t_outer + t_inner;
echo(bottom_thickness=bottom_thickness);

y = 162.5;
x = 255;
z = 16;

//
// cols, x
//

col_ratios_back = [
  15,
  10,
  12,
  13,
  13,
];

// multiple of total col_ratios_back
col_ratio_front = 0.85;

col_ratios = concat(sumv(col_ratios_back) * col_ratio_front, col_ratios_back);

total_col_ratios = sumv(col_ratios);

columns = [
  for (i = [0:1:len(col_ratios) - 1]) sum_range(col_ratios, 0, i) / total_col_ratios,
];

//
// rows, y
//
row_ratios = [
  22,
  22,
  25,
  25,
  28,
  28,
];

total_row_ratios = sumv(row_ratios);

rows = [
  [for (i = [0:1:len(row_ratios) - 1]) sum_range(row_ratios, 0, i) / total_row_ratios],
  false,
  false,
  false,
  false,
  false,
];

n_rows = [
  len(rows),
  1,
  1,
  1,
  1,
  1,
];

render()
  tray(
    dimensions=[x, y, z],
    dividers_height=z - t_bottom,
    n_columns=len(columns),
    columns=columns,
    n_rows=n_rows,
    rows=rows,
    thickness=t_outer,
    curved=false,
    bottom_thickness=bottom_thickness,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner / 2,
    top_bevel_radius=t_outer / 2,
    rows_first=false,
  );
