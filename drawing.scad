include <tray.scad>

z_outer = 18;
z_inner = 13;

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

x = 162.5;
y = 255;

render()
  tray(
    dimensions=[x, y, z_outer],
    n_columns=3,
	columns=[0.08, 0.92],
    n_rows=[3, 3, 3],
    rows=[
      [0.08, 0.92],
      [0.08, 0.92],
      [0.08, 0.92],
    ],
    thickness=t_outer,
    curved=true,
    bottom_thickness=t_bottom,
    dividers_height=z_inner,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner * 2,
    top_bevel_radius=t_inner * 2,
    rows_first=false
  );
