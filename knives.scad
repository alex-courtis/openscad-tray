include <tray.scad>

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

x = 162.5;
y = 255;
z = 12.5;

n_columns = 1;

n_rows = 10;
rows = [
  [
    0.068181818181818,
    0.13636363636364,
    0.20454545454545,
    0.27272727272727,
    0.38636363636364,
    0.5,
    0.61363636363636,
    0.72727272727273,
    0.86363636363636,
  ],
];

render()
  tray(
    dimensions=[x, y, z],
    n_columns=n_columns,
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
