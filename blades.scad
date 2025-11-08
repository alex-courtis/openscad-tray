include <tray.scad>

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

x = 162.5;
y = 255;
z = 16;

n_columns = 6;

col_wide = 0.2;
col_narrow = (1 - col_wide) / 5;

columns = [
  col_narrow * 1,
  col_narrow * 2,
  col_narrow * 3,
  col_narrow * 4,
  col_narrow * 5,
];
echo(columns=columns);

n_rows = [
  3,
  4,
  4,
  4,
  5,
  3,
];

rows = [
  false,
  false,
  false,
  false,
  false,
  [0.42, 0.75],
];

render()
  tray(
    dimensions=[x, y, z],
    n_columns=n_columns,
    columns=columns,
    n_rows=n_rows,
    rows=rows,
    thickness=t_outer,
    curved=true,
    bottom_thickness=t_bottom,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner * 6,
    top_bevel_radius=t_inner * 6,
    rows_first=false,
  );
