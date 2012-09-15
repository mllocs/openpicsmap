// on pics gallery (index)

$(document).ready(function() {
  set_max_width();
  $(window).resize(function() {
    set_max_width();
  });
});

function set_max_width() {
  ww = $(window).width();
  if(ww < 800) {
    $("#grid").css("max-width", 371);
  } else if(ww < 1110) {
    $("#grid").css("max-width", 741);
  } else if(ww < 1481) {
    $("#grid").css("max-width", 1110);
  } else {
    $("#grid").css("max-width", 1481);
  }
}
