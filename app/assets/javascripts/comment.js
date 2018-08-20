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

  $('.respond').each(function () {
    $(this).on('click', function () {
      $('textarea').val('');
      $(this).parents('.reply-list').find('.reply-form').slideToggle();
    });
  });

  $('.reply').each(function () {
    $(this).on('click', function () {
      $(this).parents('.reply-to-list').find('.reply-to').slideToggle();
    });
  });
}
