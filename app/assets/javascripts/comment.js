$(document).on('turbolinks:load', function () {
  bindEvent();
});

function bindEvent() {
  $('.delete-reply').each(function () {
    $(this).on('click', function () {
      $(this).parents('.comment').fadeOut();
    });
  });

  $('.delete-comment').each(function () {
    $(this).on('click', function () {
      $(this).parents('.reply-list').fadeOut();
    });
  });

  $('.reply').each(function () {
    $(this).on('click', function () {
      $(this).parents('.reply-list').find('.reply-form').slideToggle();
    });
  });
}
