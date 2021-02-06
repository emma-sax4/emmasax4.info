var formSubmitted = false;
var recaptchaCompleted = false;
var code = "na7iKQolB9SFbmOCe19NPi82mHPY4ILTbQ9QR4PxHIr5SIl7p5L8Ta9ZSppZ3HHS";

function showFormResponse() {
  document.getElementById("formResponse").style.display = "block";
  document.getElementById("form").remove();
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

function verifyRecaptcha() {
  if (recaptchaCompleted) {
    formSubmitted = true;
  } else {
    alert('Please fill out the reCAPTCHA to send message.');
  };
};
