$(document).on("turbolinks:load", function () {
  $(".unfollow").each(function () {
    $(this).on("click", function (event) {
      $(this).parents('.connection').fadeOut();
    });
  });
});
