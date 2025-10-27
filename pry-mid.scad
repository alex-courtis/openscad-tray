include <tray.scad>

z = 13.5;

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

x_back = 162.5;
y_back = 181.5;

x_front = 255 - y_back + t_outer;
y_front = x_back;

col1 = 0.25;
col2 = col1 + (1 - col1) / 4;
col3 = col2 + (1 - col1) / 4;
col4 = col3 + (1 - col1) / 4;

render() {
  tray(
    dimensions=[x_back, y_back, z],
    n_columns=5,
	columns=[col1, col2, col3, col4],
    thickness=t_outer,
    curved=true,
    bottom_thickness=t_bottom,
    dividers_height=20,
    dividers_thickness=t_inner,
    bottom_bevel_radius=t_inner * 4,
    top_bevel_radius=t_inner * 4,
    rows_first=false
  );

  translate(v=[0, t_outer, 0])
    rotate(a=270, v=[0, 0, 1])
      tray(
        dimensions=[x_front, y_front, z],
        n_columns=1,
        thickness=t_outer,
        curved=true,
        bottom_thickness=t_bottom,
        dividers_height=20,
        dividers_thickness=t_inner,
        bottom_bevel_radius=t_inner * 4,
        top_bevel_radius=t_inner * 4,
        rows_first=false
      );
}
