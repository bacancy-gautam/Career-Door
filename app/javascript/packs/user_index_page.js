// var radio_value = document.getElementById("experience")
document.addEventListener("turbolinks:load", function() {

    $("input[type=radio]").change(function() {
        var radio_value = $('input:checked[name="user[experience]"]').val();
        var div_id = document.getElementById("user_experience")
        if (radio_value == 'fresher') {
            div_id.style.display = "none"
        } else {
            div_id.style.display = "block"
        }
    });
})