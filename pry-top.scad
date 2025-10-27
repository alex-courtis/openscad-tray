include <tray.scad>

z = 15;

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

x_back = 162.5;
y_back = 190;

x_front = 255 - y_back + t_outer;
y_front = x_back;

render() {
  tray(
    dimensions=[x_back, y_back, z],
    n_columns=6,
    thickness=t_outer,
    curved=true,
    bottom_thickness=t_bottom,
    dividers_height=20,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner * 3,
    top_bevel_radius=t_inner * 3,
    rows_first=false
  );

  translate(v=[0, t_outer, 0])
    rotate(a=270, v=[0, 0, 1])
      tray(
        dimensions=[x_front, y_front, z],
        n_columns=3,
        thickness=t_outer,
        curved=true,
        bottom_thickness=t_bottom,
        dividers_height=20,
        dividers_thickness=t_inner,
        bottom_bevel_radius=t_inner * 3,
        top_bevel_radius=t_inner * 3,
        rows_first=false
      );
}
