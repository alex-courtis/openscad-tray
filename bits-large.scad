include <tray.scad>

render_numbers = true;
render_tray = true;

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

y = 162.5;
x = 255;
z_bottom = 15.6;
z_top = 25.6;

y_numbers = 8.5;

font = "Inter:style=Bold";
text_pt = 17;
text_size = text_pt / 3.937;
text_depth = 0.6;

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
  20,
  12,
  12,
  20,
  15,
  15,
  12,
  12,
  12,
];
padding_top = 3;
total_top = 157;
rows = [
  0.14649681528662,
  0.24203821656051,
  0.33757961783439,
  0.48407643312102,
  0.59872611464968,
  0.71337579617834,
  0.80891719745223,
  0.90445859872611,
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

render() {
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
          bottom_bevel_radius=t_inner * 6,
          top_bevel_radius=t_inner * 6,
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
            y_bottom - t_inner,
            z_bottom - text_depth + 0.0001, // epsilon for nicer slicer rendering
          ]
        ) {
          linear_extrude(height=text_depth, center=false) {
            rotate(a=90, v=[0, 0, 1]) {
              text(font=font, size=text_size, text=str(bottom[i]), halign="left", valign="center");
            }
          }
        }
      }
    }
  }
}
