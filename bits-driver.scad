include <tray.scad>

x = 255;
y = 162.5;
z = 12;

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

render()
  tray(
    dimensions=[x, y, z],
    n_columns=5,
    columns=[
      160 / x,
      180 / x,
      200 / x,
      227.5 / x,
    ],
    n_rows=[
      6,
      2,
      2,
      3,
      3,
    ],
    rows=[
      false,
      false,
      false,
      [70 / y, 115 / y],
      [70 / y, 115 / y],
    ],
    thickness=t_outer,
    bottom_thickness=t_bottom,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner * 4,
    top_bevel_radius=t_inner * 6,
  );
