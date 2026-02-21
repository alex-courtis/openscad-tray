include <tray.scad>
include <../scad-models/lib/joints.scad>

/* [Debug] */

// joint waste
debug_waste_layers = false;

// joint h and v edge lines
debug_waste_lines = false;

// large gaps, edges and dowels
grd_debug = false;

// large gaps
g_debug = 1; // [0:0.1:5]

// large edges
r_edge_debug = 0.5; // [0:0.1:5]

// large dowels
d_dowel_debug = 2; // [0:0.1:5]

render_numbers = true;
render_tray = true;
render_case = true;

/* [Dimensions] */

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

// sides of case and tray
g_case_side = 0.3;

// bottom of case and tray
g_case_bottom = 0.3;

// top of case and tray
g_case_top = 0.3;

l_tail_ratio = 0.6;

w_tail = 30;
w_socket = z_top / 2 + g_case_top + g_case_bottom;
t_case = 4.8;
t_case_bottom = 1.2;
t_case_top = 1.2;
l_tail = w_socket * l_tail_ratio;

// tails each side
n_tails = 5;

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

module case_x_side() {

  x_socket = x / n_tails;
  echo(x_socket=x_socket);

  l12_socket = (x_socket - w_tail) / 2;
  echo(l12_socket=l12_socket);

  translate(v=[x_socket / 2, 0, 0]) {

    for (i = [0:1:n_tails - 1]) {
      translate(v=[i * x_socket, 0, 0]) {
        rotate(a=90, v=[0, 0, -1])
          rotate(a=90, v=[0, 1, 0])
            color(COL[i][1])
              dove_tail(
                l=w_socket,
                w=w_tail,
                w1=l12_socket,
                w2=l12_socket,
                t=t_case,
                l_tail=l_tail,
                l1=z_top / 2,
              );

        rotate(a=90, v=[-1, 0, 0])
          color(COL[i][0])
            dove_socket(
              l=w_tail,
              w=w_socket,
              t=t_case,
              l_tail=l_tail,
              l1=l12_socket,
              l2=l12_socket,
              inner=true,
            );
      }
    }
  }
}

module case_x_sides() {
  translate(v=[-g_case_side, 0, w_socket / 2 - g_case_bottom]) {
    dy = t_case / 2 + g_case_side;
    translate(v=[0, -dy, 0]) {
      case_x_side();
    }
    translate(v=[0, y + dy, 0]) {
      mirror(v=[0, 1, 0])
        case_x_side();
    }
  }
}

module case_bottom() {
  x = x;
  y = y + 2 * (t_case + g_case_side);
  z = t_case_bottom;

  translate(
    v=[
      x / 2 - g_case_side,
      y / 2 - t_case - g_case_side,
      -z / 2 - g_case_bottom + 0.001,
    ]
  )
    cube([x, y, z], center=true);
}

module case_top() {
  x = x;
  y = y + 2 * (t_case + g_case_side);
  z = t_case_top;

  translate(
    v=[
      x / 2 - g_case_side,
      y / 2 - t_case - g_case_side,
      z / 2 + z_top + g_case_top,
    ]
  )
    cube([x, y, z], center=true);
}

render() {
  if (render_case) {
    case_x_sides();
    color(c="lightblue")
      case_bottom();
    color(c="steelblue")
      case_top();
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
