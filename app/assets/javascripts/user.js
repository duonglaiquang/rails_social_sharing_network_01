$(document).on("turbolinks:load", function () {
  $(".unfollow").each(function () {
    $(this).on("click", function () {
      $(this).parents('.connection').fadeOut();
    });
  });
});
