$(document).on('change', '#company_country', function () {
  $.ajax({
    url: "/states?country=" + company_country.value,
    type: "GET"
  });
});

$(document).on('change', '#company_state', function () {
  $.ajax({
    url: "/cities?country=" + company_country.value + "&state=" + company_state.value,
    type: "GET"
  });
});

$(document).on('click', '#close_form', function () {
  $('#my_form').remove();
  $('#new_tech_link').show();
});

// $(document).on('change', '#company_city', function () {
//   alert("Country: "+$( "#company_country" ).text()+" State: "+$( "#company_state" ).text()+" City: "+$( "#company_city" ).text());
// });
