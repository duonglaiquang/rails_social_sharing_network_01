$(document).on("turbolinks:load", function () {
  $(".button-like").each(function () {
    $(this).on("click", function () {
      if ($(this).hasClass("green")) {
        $(this).removeClass("green");
      } else {
        $(this).addClass("green");
      }
    });
  });
});
