include <tray.scad>

z = 25;

t_outer = 2.4;
t_bottom = 1.6;

dxy = -2.5;

x = 159.3 + dxy;
y = 251.8 + dxy;

echo(x=x);
echo(y=y);
echo(z=z);

render()
  tray(
    dimensions=[x, y, z],
    n_columns=1,
    n_rows=1,
    thickness=t_outer,
    curved=true,
    bottom_thickness=t_bottom,
    bottom_bevel_radius=t_outer * 2,
    top_bevel_radius=t_outer * 12,
  );
