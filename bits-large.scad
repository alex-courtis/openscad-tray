include <tray.scad>
include <BOSL2/std.scad>
include <BOSL2/hinges.scad>

/* [Debug] */

render_numbers = false;
render_tray = false;
render_case = true;

/* [Case] */

g_case_x = 0.2; // [0:0.1:5]
g_case_y = 0.2; // [0:0.1:5]
g_case_z = 0.2; // [0:0.1:5]
g_case_half = 0.2; // [0:0.1:5]

t_case_x = 2; // [0:0.1:5]
t_case_y = 2; // [0:0.1:5]
t_case_z = 0.8; // [0:0.1:5]

d_pin = 3.05; // [0:0.01:10]
l_hinge = 40; // [1:0.1:10]

// added to d_pin
hinge_offset = 2; // [0:0.01:5]

hinge_segs = 7; // [2:0.01:20]

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

module case_hinge(inner, teardrop) {
  rotate(a=90, v=[1, 0, 0])
    knuckle_hinge(
      length=l_hinge,
      segs=hinge_segs,
      offset=d_pin + hinge_offset,
      arm_height=0,
      knuckle_diam=d_pin * 2,
      pin_diam=d_pin,
      arm_angle=45,
      clear_top=false,
      fill=false,
      inner=inner,
      teardrop=teardrop,
    );
}

module case_hinges(dy) {
  translate(v=[0, dy, 0]) {
    rotate(a=90, v=[0, 0, -1])
      case_hinge(inner=false);
    mirror(v=[0, 0, 1])
      rotate(a=90, v=[0, 0, -1])
        case_hinge(inner=true);
  }

  translate(v=[0, -dy, 0]) {
    rotate(a=90, v=[0, 0, -1])
      case_hinge(inner=false, teardrop=UP);
    mirror(v=[0, 0, 1])
      rotate(a=90, v=[0, 0, -1])
        case_hinge(inner=true, teardrop=UP);
  }
}

module case() {
  inner = [
    x + g_case_x * 2,
    y + g_case_y * 2,
    z_top + g_case_z * 2,
  ];
  echo(inner=inner);

  outer = inner + 2 * [t_case_x, t_case_y, t_case_z];
  echo(outer=outer);

  // TODO remove * 2 after test print
  front = [x_top * 2 + t_case_x + g_case_x, outer[1], outer[2]];
  echo(front=front);

  middle = [outer[0], outer[1], g_case_half];
  echo(middle=middle);

  // shell with front chopped off
  difference() {
    cube(outer, center=true);
    cube(inner, center=true);

    cube(middle, center=true);

    translate(v=[( -front[0] + outer[0]) / 2, 0, 0])
      cube(front, center=true);
  }

  translate(v=[-outer[0] / 2, 0, 0]) {
    case_hinges(dy=outer[1] / 2 - l_hinge / 2);
  }
}

render() {
  if (render_case) {
    translate(v=[x / 2, y / 2, z_top / 2])
      case();
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
