$(document).on('click', '.remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').children().removeAttr('required');
    $(this).closest('fieldset').hide();
    event.preventDefault();
  });



$(document).on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data("fields").replace(regexp, time));
    event.preventDefault();
  });
