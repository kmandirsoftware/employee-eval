$("#seeAnotherField").change(function() {
  if ($(this).val() == "yes") {
    $('#otherFieldDiv').show();
    $('#otherField').attr('required', '');
    $('#otherField').attr('data-error', 'This field is required.');
  } else {
    $('#otherFieldDiv').hide();
    $('#otherField').removeAttr('required');
    $('#otherField').removeAttr('data-error');
  }
});
$("#seeAnotherField").trigger("change");


document.addEventListener('input', function (event) {

  // Only run on our select menu
  if (event.target.id !== 'employee_selection') return;

  console.log("Got New Employee!");
    // The selected value
  console.log(event.target.value);

  // The selected option element
  console.log(event.target.options[event.target.selectedIndex]);

}, false);