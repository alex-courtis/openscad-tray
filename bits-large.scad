include <tray.scad>
include <BOSL2/std.scad>
include <BOSL2/hinges.scad>

/* [Debug] */

render_numbers = false;
render_tray = false;
render_case_top = true;
render_case_bottom = true;

explode_case_top_z = 0; // [0:1:80]
explode_case_bottom_z = 0; // [-80:1:0]

/* [Case] */

split_ratio = 0.75; // [0:0.001:1]

// 1 for auto: x_top / 4
case_cutoff_dx = -20; // [-200:1:1]

d_pin = 3.10; // [0:0.01:10]
d_knuckle = 7; // [0:0.01:15]
l_hinge = 40; // [1:0.1:10]
g_hinge = 0.2; // [0:0.001:1]
offset_hinge = 0.2; // [0:0.01:5]
segs_hinge = 7; // [2:0.01:20]

g_case_x = 0.2; // [0:0.1:5]
g_case_y = 0.2; // [0:0.1:5]
g_case_z = 0.2; // [0:0.1:5]
g_case_half = 0.2; // [0:0.1:5]

t_case_x = 2.4; // [0:0.1:5]
t_case_y = 2.4; // [0:0.1:5]
t_case_z = 1.2; // [0:0.1:5]

/* [Tray] */

t_outer = 1.2;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

y = 162.5;
x = 255;
z_bottom = 15.6;
z_top = 25.6;

y_numbers = 8.5;

font = "Inter:style=Black";
text_pt = 18;
text_pt_dec = 15;
text_size = text_pt / 3.937;
text_size_dec = text_pt_dec / 3.937;
text_depth = 0.6;
text_dy = -0.75;

// bits-large.lua
bottom = [
  7,
  7.5,
  8,
  8.5,
  9,
  9.5,
  10,
  11,
  12,
  13,
];
padding_bottom = 6.5;
total_bottom = 160.5;
columns = [
  0.08411214953271,
  0.17133956386293,
  0.26168224299065,
  0.35514018691589,
  0.45171339563863,
  0.55140186915888,
  0.65420560747664,
  0.76323987538941,
  0.8785046728972,
];
top = [
  25,
  17,
  17,
  21,
  17,
  17,
  17,
  17,
];
padding_top = 0;
total_top = 148;
rows = [
  0.16891891891892,
  0.28378378378378,
  0.39864864864865,
  0.54054054054054,
  0.65540540540541,
  0.77027027027027,
  0.88513513513514,
];

$fn = 200;

echo(x=x);
x_bottom = total_bottom + len(columns) * t_inner + 2 * t_outer;
echo(x_bottom=x_bottom);
x_top = x - x_bottom + t_outer;
echo(x_top=x_top);

echo(y=y);
y_bottom = y - y_numbers;
echo(y_bottom=y_bottom);
echo(y_numbers=y_numbers);
y_top_calc = total_top + len(rows) * t_inner + 2 * t_outer;
echo(y_top_calc=y_top_calc);
echo("delta", y_top_calc - y);

echo(z_bottom=z_bottom);
echo(z_top=z_top);

case_x = x + (t_case_x + g_case_x) * 2;
echo(case_x=case_x);
case_y = y + (t_case_y + g_case_y) * 2;
echo(case_y=case_y);
case_z = z_top + (t_case_z + g_case_z) * 2;
echo(case_z=case_z);

dx_case_front = case_cutoff_dx < 1 ? case_cutoff_dx : -x_top / 4;
echo(dx_case_front=dx_case_front);

// manually cutoff arms as rounded arm bottoms do not print well
module case_hinge(inner, gap = g_hinge) {
  intersection() {
    rotate(a=90, v=[1, 0, 0])
      knuckle_hinge(
        length=l_hinge,
        segs=segs_hinge,
        offset=d_knuckle / 2 + offset_hinge,
        arm_height=case_z,
        knuckle_diam=d_knuckle,
        pin_diam=d_pin,
        arm_angle=90,
        clear_top=false,
        fill=true,
        inner=inner,
        teardrop=UP,
        gap=gap,
      );

    cube([l_hinge, 2 * (d_knuckle + offset_hinge), case_z], center=true);
  }
}

module case_hinges(top) {

  dx = -case_x / 2;
  dy = case_y / 2 - l_hinge / 2;

  translate(v=[dx, dy, 0]) {
    mirror(v=[0, 0, top ? 1 : 0])
      rotate(a=90, v=[0, 0, -1])
        case_hinge(inner=top);
  }

  translate(v=[dx, -dy, 0]) {
    mirror(v=[0, 0, top ? 1 : 0])
      rotate(a=90, v=[0, 0, -1])
        case_hinge(inner=top);
  }
}

module case_hinge_inner_cutout() {

  dx = (d_knuckle + t_case_x - case_x) / 2;
  dy = case_y / 2 - l_hinge / 2;
  dz = case_z / 2;

  translate(v=[dx, dy, dz]) {
    hull()
      rotate(a=90, v=[0, 0, -1])
        case_hinge(inner=true, gap=0);
  }

  translate(v=[dx, -dy, dz]) {
    hull()
      rotate(a=90, v=[0, 0, -1])
        case_hinge(inner=true, gap=0);
  }
}

// half shell with front chopped off
module case_shell(top) {
  outer = [case_x, case_y, case_z];
  inner = outer - 2 * [t_case_x, t_case_y, t_case_z];

  dz_half =
    top ?
      case_z * (split_ratio - 1) + g_case_half / 2
    : case_z * (split_ratio) - g_case_half / 2;

  difference() {
    cube(outer, center=true);
    cube(inner, center=true);

    translate(v=[0, 0, dz_half])
      cube(outer, center=true);

    translate(v=[case_x + dx_case_front, 0, 0])
      cube(outer, center=true);

    if (!top)
      case_hinge_inner_cutout();
  }

  case_hinges(top=top);
}

render() {
  translate(v=[x / 2, y / 2, z_top / 2]) {
    if (render_case_bottom)
      translate(v=[0, 0, explode_case_bottom_z])
        color(c="skyblue")
          case_shell(top=false);

    if (render_case_top)
      translate(v=[0, 0, explode_case_top_z])
        color(c="lightsteelblue")
          case_shell(top=true);
  }

  if (render_tray) {
    color(c="gray") {
      tray(
        dimensions=[x_bottom, y_bottom, z_bottom],
        n_columns=len(bottom),
        columns=columns,
        thickness=t_outer,
        bottom_thickness=t_bottom,
        dividers_thickness=t_inner,
        bottom_bevel_radius=t_inner * 3,
        top_bevel_radius=t_inner * 3,
      );
    }

    color(c="lightgray") {
      translate(v=[0, y_bottom - t_outer, 0]) {
        cube([x_bottom, y_numbers + t_outer, z_bottom]);
      }
    }

    color(c="darkgray") {
      translate(v=[x_bottom - t_outer, 0, 0]) {
        tray(
          dimensions=[x_top, y, z_top],
          n_columns=1,
          n_rows=len(top),
          rows=[rows],
          thickness=t_outer,
          bottom_thickness=t_bottom,
          dividers_thickness=t_inner,
          bottom_bevel_radius=t_inner * 10.0,
          top_bevel_radius=t_inner * 7,
        );
      }
    }
  }

  if (render_numbers) {
    color(c="black") {
      for (i = [0:len(columns)]) {
        translate(
          v=[
            t_outer + (x_bottom - t_outer) * (columns[i] ? columns[i] : 1) - (bottom[i] + padding_bottom) / 2 - t_inner,
            y_bottom + text_dy,
            z_bottom - text_depth + 0.0001, // epsilon for nicer slicer rendering
          ]
        ) {
          linear_extrude(height=text_depth, center=false) {
            rotate(a=90, v=[0, 0, 1]) {
              size = floor(bottom[i]) == bottom[i] ? text_size : text_size_dec;
              text(font=font, size=size, text=str(bottom[i]), halign="left", valign="center");
            }
          }
        }
      }
    }
  }
}
