$(document).on("turbolinks:load", function () {
  jQuery("#tabs-profile").on("tabsactivate", function (event, ui) {
    jQuery('.flexslider .slide').resize();
  });
});
