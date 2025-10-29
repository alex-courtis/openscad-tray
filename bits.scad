include <tray.scad>

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

x = 162.5;
y = 255;
z = 21 + 2.4;

render()
  tray(
    dimensions=[x, y, z],
    n_columns=7,
    n_rows=[4, 4, 4, 3, 3, 3, 3],
    rows=[
      [0.31, 0.44, 0.67],
      [0.31, 0.44, 0.67],
      [0.31, 0.44, 0.67],
      [0.25, 0.38],
      [0.25, 0.38],
      [0.25, 0.38],
      [0.25, 0.38],
      [0.25, 0.38],
    ],
    thickness=t_outer,
    curved=true,
    bottom_thickness=t_bottom,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner * 6,
    top_bevel_radius=t_inner * 6,
    rows_first=false,
  );
