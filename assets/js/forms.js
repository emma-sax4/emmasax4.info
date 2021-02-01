var submitted=false;
var code="na7iKQolB9SFbmOCe19NPi82mHPY4ILTbQ9QR4PxHIr5SIl7p5L8Ta9ZSppZ3HHS";

function showFormResponse() {
  document.getElementById("formResponse").style.display = "block";
  document.getElementById("form").remove();
};

function recaptchaCallback() {
  $('#submitButton').removeAttr('disabled');
  document.getElementById("verification").value = code;
};

function recaptchaExpiredCallback() {
  $('#submitButton').attr('disabled', true);
  document.getElementById("verification").value = null;
};
