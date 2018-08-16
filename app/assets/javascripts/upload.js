$(document).on("turbolinks:load", function () {
  $('input[type="radio"]').click(function () {
    if ($('#post_upload_type_pic').is(':checked')) {
      $('.vid-form').fadeOut("fast");
      $('.pic-form').fadeIn("fast");
    }
    else if ($('#post_upload_type_vid').is(':checked')) {
      $('.pic-form').fadeOut("fast");
      $('.vid-form').fadeIn("fast");
    }
  });
});
