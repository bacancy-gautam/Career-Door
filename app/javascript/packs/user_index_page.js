document.addEventListener("turbolinks:load", function () {
  $("#experience").on("change", function () {
    var radio_value = $('input:checked[name="user[experience]"]').val();
    var div_id = $("#user_experience")
    if (radio_value == 'fresher') {
      div_id.hide()
    } else {
      div_id.show()
    }
  });
})
