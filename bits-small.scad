include <tray.scad>

render_numbers = true;
render_tray = true;

t_outer = 1.6;
t_inner = 1.2;
t_bottom = 1.2 - t_outer + t_inner; // t_outer - t_inner is added
echo(t_bottom=t_bottom);

x = 172.4;
y = 162.5;
z = 9.8;

y_numbers = 8.5;

font = "Inter:style=Bold";
text_pt = 17;
text_size = text_pt / 3.937;
text_depth = 0.6;

$fn = 200;

echo(x=x);

echo(y=y);
y_bottom = y - 2 * y_numbers;
echo(y_bottom=y_bottom);
y_bottom_inner = y_bottom - 2 * t_outer;
echo(y_bottom_inner=y_bottom_inner);
echo(y_numbers=y_numbers);

echo(z=z);

row_min = 31;
row_max = 72;
row_delta = row_max - row_min;
rows = [
  [(row_min + row_delta * 10 / 10) / y_bottom_inner],
  [(row_min + row_delta * 9 / 10) / y_bottom_inner],
  [(row_min + row_delta * 8 / 10) / y_bottom_inner],
  [(row_min + row_delta * 7 / 10) / y_bottom_inner],
  [(row_min + row_delta * 6 / 10) / y_bottom_inner],
  [(row_min + row_delta * 5 / 10) / y_bottom_inner],
  [(row_min + row_delta * 4 / 10) / y_bottom_inner],
  [(row_min + row_delta * 3 / 10) / y_bottom_inner],
  [(row_min + row_delta * 2 / 10) / y_bottom_inner],
  [(row_min + row_delta * 1 / 10) / y_bottom_inner],
  [(row_min + row_delta * 0 / 10) / y_bottom_inner],
  false,
];
echo(rows=rows);

text_left = [
  "",
  "3  ",
  "2.5",
  "2  ",
  "1.5",
  "1  ",
];

text_right = [
  "",
  "3.2",
  "3.5",
  "4",
  "4.2",
  "4.5",
  "4.8",
  "5",
  "5.5",
  "6",
  "6.5",
];

if (render_tray) {
  color(c="gray") {
    translate(v=[0, y_numbers, 0]) {
      tray(
        dimensions=[x, y_bottom, z],
        n_columns=len(rows),
        n_rows=[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1],
        rows=rows,
        thickness=t_outer,
        bottom_thickness=t_bottom,
        dividers_thickness=t_inner,
        bottom_bevel_radius=t_inner * 3,
        top_bevel_radius=t_inner * 3,
      );
    }
  }

  color(c="lightgray") {
    cube([x, y_numbers, z]);
    translate(v=[0, y_bottom + y_numbers, 0]) {
      cube([x, y_numbers, z]);
    }
  }
}

if (render_numbers) {
  color(c="blue") {
    for (i = [0:len(text_left) - 1]) {
      translate(
        v=[
          t_outer / 2 + (x - t_outer) * (i + 0.5) / len(rows),
          t_inner / 3,
          z - text_depth + 0.005, // epsilon for nicer slicer rendering
        ]
      ) {
        linear_extrude(height=text_depth, center=false) {
          rotate(a=90, v=[0, 0, 1]) {
            text(
              font=font,
              size=text_size,
              text=text_left[i],
              halign="left",
              valign="center"
            );
          }
        }
      }
    }
  }
  color(c="red") {
    for (i = [0:len(text_right) - 1]) {
      translate(
        v=[
          t_outer / 2 + (x - t_outer) * (i + 0.5) / len(rows),
          y - y_numbers - t_inner,
          z - text_depth + 0.005, // epsilon for nicer slicer rendering
        ]
      ) {
        linear_extrude(height=text_depth, center=false) {
          rotate(a=90, v=[0, 0, 1]) {
            text(
              font=font,
              size=text_size,
              text=text_right[i],
              halign="left",
              valign="center"
            );
          }
        }
      }
    }
  }
}
