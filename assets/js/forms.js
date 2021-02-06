var formSubmitted = false;
var recaptchaCompleted = false;
var code = "na7iKQolB9SFbmOCe19NPi82mHPY4ILTbQ9QR4PxHIr5SIl7p5L8Ta9ZSppZ3HHS";
var iframe = document.getElementById("iframe");
var form = document.getElementById("form");

iframe.onload = function showFormResponse() {
  if (formSubmitted) {
    document.getElementById("formResponseDiv").classList.remove("invisible");
    document.getElementById("formDiv").remove();
  };
};

form.onsubmit = function verifyRecaptcha() {
  if (recaptchaCompleted) {
    formSubmitted = true;
  } else {
    alert('Please fill out the reCAPTCHA to send a message.');
  };
};

function recaptchaCallback(verificationResponse) {
  $("#submitButton").removeAttr("disabled");
  recaptchaCompleted = true;
  document.getElementById("verification").value = verificationResponse + code + verificationResponse;
};

function recaptchaExpiredCallback() {
  $("#submitButton").attr("disabled", true);
  recaptchaCompleted = false;
  document.getElementById("verification").value = null;
};
