<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>    
<script src="https://www.google.com/recaptcha/api.js"></script>
 <style>
  #error-message {
  color: #B31942;
  font-size: 16px;
  display: none; /* Hide by default */
}
.error{
 color: #B31942 !important;
}
.text-mt-2
{
color:green;
}
#otpTimer{
display: block !important;
color: black;
}
.otp-valid {
 color: green;
}
.btn-four w-100 mt-2
{
width:30%;
}
.widthbutton
{
width:40% !important;												
}
.text-color{
	color:#19352D !important;
}
#checkbox-error{
	color: #B31942;
	font-size: 16px;
	display: none; 
}
.er-sz{
	color: #B31942;
	font-size: 16px;
	display: none; 
}
 </style>
 
 
 
<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
<div class="modal-dialog modal-fullscreen modal-dialog-centered">
<div class="container">
<div class="user-data-form modal-content">
<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
<div class="form-wrapper m-auto">
<ul class="nav nav-tabs border-0 w-100" role="tablist">
<li class="nav-item" role="presentation">
 <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#fc1" role="tab" id="loginBtn">Login</button>
</li>
<li class="nav-item" role="presentation">
<button class="nav-link" data-bs-toggle="tab" data-bs-target="#fc2" role="tab" id="signUpBtn">Register</button>
</li>
</ul>
<div class="tab-content mt-30">
<div class="tab-pane show active" role="tabpanel" id="fc1">
<div class="text-center mb-20">
<h2>Hi, Welcome!</h2>
<span>Login to continue managing your BOIR filings.</span>
</div>
 <form method="post" action="/login" role="form" id="ValidateForm">
<div class="row">
<div class="col-12">
<div class="input-group-meta position-relative mb-25">
<label for="username">Email<em style="color: #ff0000;">*</em></label>
<input type="email" placeholder="Youremail@gmail.com" id="username" name="username" class="text-color">
</div>
</div>
<div class="col-12">
 <div class="input-group-meta position-relative mb-20">
<label for="password">Password<em style="color: #ff0000;">*</em></label>
<input type="password" placeholder="Enter Password" class="pass_log_id text-color" id="password" name="password">
<span class="placeholder_icon"><span class="passVicon"><img src="/images/icon/icon_13.svg" alt=""></span></span>
</div>
 </div>
<span id="error-message"></span>
<div class="col-12">
<div class="agreement-checkbox d-flex justify-content-between align-items-center">
<div>
<input type="checkbox" id="remember-me" name="remember-me">
<label for="remember-me">Keep me logged in</label>
</div>
<a href="/forgotpwd">Forgot password?</a>
</div>
</div>

<!-- div class="col-12">
<div class="agreement-checkbox d-flex justify-content-between align-items-center">
<div>
<a href="/oauth2/authorization/google">Login with Google</a>
</div>
<a href="/oauth2/authorization/apple">Login with Apple</a>
</div>
</div-->

<div class="col-12">
<button class="btn-four w-100 tran3s d-block mt-20" type="submit" value="submit">Login</button>
</div>
 </div>
 </form>
</div>
                  
  <!-- Signup Tab -->
 <div class="tab-pane" role="tabpanel" id="fc2">
<div class="text-center mb-20">
 <h2>Register</h2>
 <span>Register to manage BOIR filings securely & effortlessly.</span>
 </div>
<form method="post" action="/register/save" role="form" id="ValidateForm1" onsubmit="return validateForm()">
	<div class="<div class="col-12">
		<div class="input-group-meta position-relative mb-25">
			<label for="email">Email<em style="color: #ff0000;">*</em></label>
			<div class="input-group">
				<input type="email" placeholder="johnsmith@gmail.com" id="email" name="email" class="form-control text-color" required onblur="handleEmailBlur()">
				<div id="emailError" class="text-mt-2 er-sz" style="display: none;"></div>
			</div>
		</div>
	</div>
	<div class="col-12" id="otpSection" style="display: none;">
		 <div class="input-group-meta position-relative mb-25">
			<label for="otp" class="mb-10">Enter OTP<em style="color: #ff0000;">*</em></label>
			<input type="text" placeholder="Enter OTP" id="otp" name="otp" class="form-control text-color" maxlength="6" onblur="verifyOTP(this.value)">
			<div id="otpError" class="mt-2 er-sz" style="display: none;"></div>
			<div id="otpTimer" class="mt-2 er-sz"></div>
			<button type="button" id="resendOtpBtn" class="btn-four w-100 mt-2 widthbutton " style="display: none;" onclick="sendOTPAgain()">Resend OTP</button>
		</div>
	</div>
	<div class="col-12">
		<div class="input-group-meta position-relative mb-25">
			<label for="firstName">First Name<em style="color: #ff0000;">*</em></label>
			<input type="text" placeholder="John" id="firstName" name="firstName" class="text-color" required>
		</div>
	</div>
	<div class="col-12">
		<div class="input-group-meta position-relative mb-25">
			<label for="lastName">Last Name<em style="color: #ff0000;">*</em></label>
			<input type="text" placeholder="Smith" id="lastName" name="lastName" class="text-color" required>
		</div>
	</div>
	<div class="col-12">
		<div class="input-group-meta position-relative mb-20">
			<label for="password">New Password<em style="color: #ff0000;">*</em></label>
			<input type="password" placeholder="Enter Password" class="pass_log_id text-color" id="password" name="password" required>
			<span class="placeholder_icon"><span class="passVicon"><img src="images/icon/icon_13.svg" alt=""></span></span>
		</div>
	</div>
	<div class="col-12 mt-4">
		<div class="input-group-meta position-relative mb-20">
			<div class="g-recaptcha" data-sitekey="6LdGwaQqAAAAAFdnhAV6p4lS3B4wdRbSVWpcxxtC"></div>
				<span id="recaptcha-error" style="color: #B31942; font-size: 16px;"></span>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	<div class="col-12">
		<div class="agreement-checkbox d-flex justify-content-between align-items-center">
			<div>
				<input type="checkbox" id="signupcheckbox" name="signupcheckbox" required>
				<label for="signupcheckbox">By hitting the "Register" button, you agree to the <a href="/terms" target="_blank">Terms conditions</a> & <a href="/privacy" target="_blank">Privacy Policy</a></label>
				<span id="checkbox-error"></span>
			</div>
		</div>
	</div>
	<div class="col-12">
		<button class="btn-four w-100 tran3s d-block mt-20" type="submit" id="registerBtn" value="submit">Register</button>
	</div>
	</div>
</form>
</div>
                      
</div>
</div>
</div>
             
 </div>
</div>
 </div>
 
 
          
 
<!--Login Validation error message -->
<script>
$(document).ready(function() {
	<!--// Check if the URL contains the 'error' query parameter-->
	if (window.location.search.indexOf('error') !== -1) {
		<!--// Display the error -->
	$('#error-message').text('Invalid username or password. Please try again.').show();
	}
});

$(document).ready(function () {
      $('#ValidateForm1').on('submit', function (e) {
          var response = grecaptcha.getResponse();

          if (response.length === 0) {
              $('#recaptcha-error').text('Please confirm you are not a Robot');
              e.preventDefault();
          } else {
              $('#recaptcha-error').text('');  // Clear the error message
          }
      });
  });
</script>
	<script>
	
$(document).ready(function() {
       
 
<!--// Handle email blur event to send OTP-->
//$('#email').on('blur', handleEmailBlur);-
 
<!--// Verify OTP when input loses focus-->
<!--   // $('#otp').on('blur', verifyOTP);-->
 
<!--    // Handle signup form submission-->
    $('#ValidateForm1').on('submit', function(e) {
        // Check if OTP is validated
        if (false) {
            e.preventDefault(); // Prevent form submission
            $('#otpError').text('Please validate the OTP before proceeding').show();
        }
    });
});
	
	
<!--// Variable to store generated OTP  				-->
	var genOTP="";
	var otpTimer;
    var otpExpireTime = 90;
    
	
<!-- // Function to handle email focus event-->
function handleEmailBlur() {
	var email = $('#email').val();
	<!--// Check if email field is empty-->
	if (email === '') {
		$('#emailError').text('Please enter your email').hide();
		$('#otpSection').hide();
		return;
	}
  // Validate email format
	if (!validateEmail(email)) {
		$('#emailError').text('Please enter a valid email').hide();
		$('#otpSection').hide();
	 	return;
 	}
 	$('#otpSection').show();
	$('#emailError').hide(); 
	sendOTP(email);
}
<!--// Function to validate email format-->
function validateEmail(email) {
	 var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	 return re.test(email);
}<!--// Function to send OTP to the provided email-->

function sendOTP(email) {
	$.ajax({
		url: '/getOTP/'+email,
		method: 'GET',
		success: function(response) {
			if (response.success) {
				genOTP=response.OTP;
				$('#otp').val('');
				$('#emailError').text('OTP has been sent to your email').css('color','green').show();
				startOTPTimer();
				$('#resendOtpBtn').hide(); // Show resend OTP button
			} else {
				$('#emailError').text('This email already exists').css('color','#B31942').show();
				$('#otpSection').hide();
			}
		},
		error: function() {
			$('#emailError').text('An error occurred. Please try again').show();
			$('#otpSection').hide();
		}
	});
}	   
function startOTPTimer() {
  	var timerDisplay = $('#otpTimer');
  	var seconds = otpExpireTime;
	if (otpTimer) {
	 	clearInterval(otpTimer);
	}
	function updateTimer() {
		 var minutes = Math.floor(seconds / 60);
		 var remainingSeconds = seconds % 60;
		 if  (seconds > 0){
		 	timerDisplay.text('OTP expires in ' + minutes + 'm ' + remainingSeconds + 's').css('color', 'black');
		 }else {
			 clearInterval(otpTimer);
			 timerDisplay.text('OTP has expired. Please request a new one.').css('color', '#B31942');
			 $('#otp').prop('disabled', true);
			 $('#resendOtpBtn').show(); // Show resend OTP button when OTP expires
		 }
		 seconds--;
	 }
	 updateTimer();
	 otpTimer = setInterval(updateTimer, 1000);
}
function sendOTPAgain() {
	var email = $('#email').val();
	if (email) {
		sendOTP(email);  // Resend OTP to the email
        $('#otp').prop('disabled', false); // Enable OTP input field
        $('#otpTimer').text('');  // Clear previous timer text
        $('#resendOtpBtn').hide();  // Hide Resend OTP button after sending OTP again
	 }
}           

<!--// Function to verify OTP and register the user-->
function verifyOTP(x) {
       var otp = x;
	   var email = $('#email').val(); 
	   $.ajax({
	   		url: '/authenticationOTP/'+ otp + '?newUserEmail=' + encodeURIComponent(email),
	   		method: 'POST',
	   		success: function(response) {
 	   			if (response === "OTP validated successfully.") {
					$('#otpError').text('OTP Validated').removeClass('otp-invalid').addClass('otp-valid').show();
					$('#otpError').css('color', 'green').text('OTP Validated').show();
					$('#otpTimer').remove();
			        $('#registerBtn').prop('disabled', false);
		     		<!--//Stop the OTP timer if the OTP is validated-->
				 	clearInterval(otpTimer);
					$('#resendOtpBtn').hide();  // Hide Resend OTP button if OTP is validated	
	   			} else if (response === "Invalid OTP."){
					$('#otpError').text('Invalid OTP. Please try again.').show();
				   	$('#otpError').css('color', '#B31942');
			       	$('#otp').val('');
		           	$('#registerBtn').prop('disabled', true);
	   			}
	   		},
	   		error: function() {
 	   		}
	   	});
}
 
  <!--// Function to register the user-->
   function registerUser(email, firstName, lastName, password) {
       $.ajax({
           url: '/register/save',
           method: 'POST',
           data: {
               email: email,
               firstName: firstName,
               lastName: lastName,
               password: password
           },
           success: function(registerResponse) {
               if (registerResponse.success) {
                   alert('Registration successful!');
                   $('#loginModal').modal('hide');
               } else {
                   alert('Registration failed. Please try again.');
               }
           },
           error: function() {
               alert('An error occurred during registration. Please try again.').css('color','#B31942');
           }
       });
   }
                <!--// Function to check if OTP is valid-->
function isOTPValid() {
    var otp = $('#otp').val();
    return otp === genOTP;
}

<!--//login & signup code-->
 
$(document).ready(function(){	
	
    function showLogin() {
        $('#signUpBtn').removeClass('active');
        $('#loginBtn').addClass('active');
        
        $('#fc2').removeClass('show active');
        $('#fc1').addClass('show active');
    }
 
    function showSignup() {
	
        $('#loginBtn').removeClass('active');
        $('#signUpBtn').addClass('active');
        
        $('#fc1').removeClass('show active');
        $('#fc2').addClass('show active');
    }
	$('#loginpopup').click(function() {
	        showLogin();
	    });
 
	    $('#signuppopup').click(function() {
	        showSignup();
	    });
});
</script>
					<!--<script>
					function validateForm() {
					    const checkbox = document.getElementById('signupcheckbox');
					    if (!checkbox.checked) {
					        alert('You must agree to the Terms and Privacy Policy before registering.');
					        return false; // Prevent form submission
					    }
					    return true; // Allow form submission
					}
					</script>-->
<script>
	function validateForm() {
		const checkbox = document.getElementById('signupcheckbox');
		const errorSpan = document.getElementById('checkbox-error');
										    
		if (!checkbox.checked) {
			errorSpan.textContent = 'You must agree to the Terms and Privacy Policy before registering';
			errorSpan.style.display = 'inline'; // Show the error message
			return false; // Prevent form submission
		} else {
			errorSpan.style.display = 'none'; // Hide the error message if no error
			return true; // Allow form submission
		}
	}
</script>


<script>

  function validateEmail(email) {
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    if (email) return emailReg.test(email);
    return false;
  }

  function sendLeadToFP(){
      var emailInput = document.querySelector('input[type="email"],input[name="email"]');
      var submitButton = document.querySelector("button[type='submit'],input[type='submit']");
      
      //use the mousedown or touchstart event to prevent overwriting the default click event.
      ["mousedown", "touchstart"].forEach(function (event) {
        submitButton.addEventListener(event, function () {
          if (validateEmail(emailInput.value)) {
            fpr("referral", {
              email: emailInput.value,
            });
          }
        });
      });
  }

  if (window.attachEvent) {
      window.attachEvent("onload", sendLeadToFP);
  } else {
      window.addEventListener("load", sendLeadToFP, false);
  }
</script>

