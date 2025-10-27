include <tray.scad>

z = 20;

t_outer = t_outer;
t_inner = t_inner;

y = 255;
x = 162.5;

render()
  tray(
    dimensions=[x, y, z],
    n_columns=4,
    n_rows=[4, 2, 2, 2],
    rows=[
      [1 / 6, 2 / 6, 3 / 6],
      [5 / 12],
      [120 / y],
      [120 / y],
    ],
    thickness=t_outer,
    curved=true,
    bottom_thickness=t_inner,
    dividers_height=20,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner * 3,
    top_bevel_radius=t_inner * 3,
    rows_first=false
  );
