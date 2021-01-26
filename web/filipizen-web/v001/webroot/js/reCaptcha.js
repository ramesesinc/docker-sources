var onloadCallback = function() {
  grecaptcha.render('g-recaptcha');
};
onloadCallback();

$('form').on('submit', function(e) {
  if(grecaptcha.getResponse() == "") {
    e.preventDefault();
    alert("You can't proceed!");
  } else {
    alert("Thank you");
  }
});