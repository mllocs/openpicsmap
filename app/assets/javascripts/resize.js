(function ($) {

  // on pics gallery (index)
  function set_max_width() {
    var window_width = $(window).width()
      , gallery_width = 1481;

    if (window_width < 800) {
      gallery_width = 371;
    } else if (window_width < 1110) {
      gallery_width = 741;
    } else if (window_width < 1481) {
      gallery_width = 1110;
    }
    $("#grid").css("max-width", gallery_width);
  }

  $(document).ready(function () {
    set_max_width();
    $(window).resize(function () {
      set_max_width();
    });
  });

})(jQuery);

