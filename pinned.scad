include <BOSL2/std.scad>
include <tray.scad>
include <util.scad>

d_filament = 0.6;
z_layer = 0.3;

// x = 162.5; // 220 max
// y = 255; // 255 max
// z = 20;

// x = 162.5;
// y = 255;
// z = 20;
// n_columns = 3;
// n_rows = [2, 3, 1];
// columns = [0.2, 0.6];
// rows = [[0.25], [0.7, 0.2], false];
// t_outer = 1.8;
// t_inner = 1.8;
// t_bottom = 1.2;

// x = 162.5;
// y = 255;
// z = 20;
// n_columns = 3;
// n_rows = [1, 2, 2];
// columns = [0.2, 0.575];
// rows = [false, [0.6], [0.35]];
// t_outer = 1.8;
// t_inner = 1.8;
// t_bottom = 1.2;

// x = 220;
// y = 255;
// z = 20;
// n_columns = 2;
// n_rows = [2, 3];
// columns = [0.6, ];
// rows = [[0.4], [0.4, 0.2]];
// t_outer = 2.4;
// t_inner = 2.4;
// t_bottom = 1.5;

// from spanner-allen.scad
x = 255;
y = 162.5;
z = 20;
n_columns = 6;
columns = [0.459459, 0.58816, 0.67396, 0.77692, 0.88846, 1];
n_rows = [6, 1, 1, 1, 1, 1];
rows = [[0.146667, 0.293333, 0.46, 0.626667, 0.813333, 1], false, false, false, false, false];
t_outer = 1.8;
t_inner = 1.8;
t_bottom = 1.2;

d_pin = 2.30;
l_pin = 12;
l_pin_out = 6;
l_pin_clearance = 0.6;

pin_inset = d_pin * 0.5 + d_filament * 2;

slot_clearance = 0.4;

bottom_thickness = derive_bottom_thickness(bottom_thickness_desired=t_bottom, thickness=t_outer, dividers_thickness=t_inner) + 0.001;
echo(bottom_thickness=bottom_thickness);

$fn = 200;

module pinned_corners() {
  xy_corner = sqrt(pin_inset ^ 2 * 2) + d_pin / 2 + slot_clearance + d_filament * 2;
  xy_slot = sqrt(pin_inset ^ 2 * 2) + d_pin / 2 + slot_clearance;

  module corner(xy) {
    intersection() {
      cube(size=[x, y, z]);
      for (x = [0, x], y = [0, y])
        translate(v=[x, y, z / 2])
          rotate(a=45)
            cube(size=[2 * xy, 2 * xy, z], center=true);
    }
  }

  difference() {
    union() {
      children();
      corner(xy=xy_corner);
    }

    translate(v=[0, 0, -z + l_pin_out + l_pin_clearance])
      corner(xy=xy_slot);

    translate(v=[0, 0, l_pin / 2 + z - l_pin + l_pin_out]) {
      for (x = [pin_inset, x - pin_inset], y = [pin_inset, y - pin_inset])
        translate(v=[x, y, 0])
          #cylinder(d=d_pin, h=l_pin, center=true);
    }
  }
}

render() {
  rotate(a=90, v=[0, 0, 1])
    pinned_corners()
      tray(
        dimensions=[x, y, z],
        n_columns=n_columns,
        n_rows=n_rows,
        columns=columns,
        rows=rows,
        thickness=t_outer,
        bottom_thickness=bottom_thickness,
        dividers_thickness=is_undef(t_inner) ? undef : t_inner,
        dividers_top_bevel_radius=t_inner / 2,
        dividers_bottom_bevel_radius=t_inner / 2,
        rows_first=false,
        curved=false,
      );
}
