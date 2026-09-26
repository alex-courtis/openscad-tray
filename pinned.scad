include <tray.scad>
include <util.scad>

// print at 0.6, 0.30

// y = 162.5;
// x = 255;
// z = 16;
y = 60;
x = 30;
z = 16;

t_outer = 1.8;
t_inner = 1.8;
t_bottom = 0.9;

d_pin = 3.05;
l_pin = 15;
l_pin_out = 3;

dx_pin = d_pin * 0.75;
dy_pin = d_pin * 0.75;

r_top_bevel = 7.0;

bottom_thickness = derive_bottom_thickness(bottom_thickness_desired=t_bottom, thickness=t_outer, dividers_thickness=t_inner) + 0.001;
echo(bottom_thickness=bottom_thickness);

$fn = 200;

render()
  difference() {
    tray(
      dimensions=[x, y, z],
      // n_columns=2,
      // n_rows=[2, 1],
      // columns=[0.25, 0.75],
      thickness=t_outer,
      bottom_thickness=bottom_thickness,
      dividers_thickness=is_undef(t_inner) ? undef : t_inner,
      top_bevel_radius=r_top_bevel,
      // bottom_bevel_radius=0,
      dividers_top_bevel_radius=t_inner/2,
      dividers_bottom_bevel_radius=t_inner/2,
      rows_first=false,
    );

    translate(v=[0, 0, l_pin / 2 + z - l_pin + l_pin_out]) {
      for (x = [dx_pin, x - dx_pin], y = [dy_pin, y - dy_pin])
        translate(v=[x, y, 0]) {
          cylinder(d=d_pin, h=l_pin, center=true);
        }
    }

    for (x = [0, x], y = [0, y])
      translate(v=[x, y, 0])
        rotate(a=45)
          cube(size=[(d_pin + dx_pin) * 2, (d_pin + dy_pin) * 2, l_pin_out], center=true);
  }
