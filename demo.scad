include <tray.scad>

render()
  tray(
    dimensions=[60, 100, 30],
    n_columns=3,
    n_rows=[4, 3, 2],
    columns=[0.25, 0.75],
    rows=[false, [0.25, 0.5], false],
    thickness=2,
    curved=true,
    bottom_thickness=1.2,
    dividers_height=25,
    dividers_thickness=1.2,
    bottom_bevel_radius=undef,
    top_bevel_radius=undef,
    dividers_bottom_bevel_radius=undef,
    dividers_top_bevel_radius=undef,
    rows_first=false
  );
