$(document).on("turbolinks:load", function () {
  $('#post_upload_type_picture').checked = true;
  $('.pic-form').fadeIn("fast");
  $('input[type="radio"]').click(function () {
    if ($('#post_upload_type_picture').is(':checked')) {
      $('.vid-form').fadeOut("fast");
      $('.pic-form').fadeIn("fast");
    }
    else if ($('#post_upload_type_video').is(':checked')) {
      $('.pic-form').fadeOut("fast");
      $('.vid-form').fadeIn("fast");
    }
  });
});
