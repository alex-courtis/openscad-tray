// thickness - dividers_thickness is added when dividers_thickness is set
// cannot set bottom_thickness_desired to be less than the difference between thickness and dividers_thickness
function derive_bottom_thickness(bottom_thickness_desired, thickness, dividers_thickness) =
  is_undef(dividers_thickness) ?
    t_bottom
  : t_bottom - abs(thickness - dividers_thickness);
