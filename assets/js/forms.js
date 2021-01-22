var submitted=false;

function showFormResponse() {
  document.getElementById("formResponse").style.display = "block";
  document.getElementById("form").remove();
};

function recaptchaCallback() {
  $('#submitButton').removeAttr('disabled');
};

function recaptchaExpiredCallback() {
  $('#submitButton').attr('disabled', true);
};
