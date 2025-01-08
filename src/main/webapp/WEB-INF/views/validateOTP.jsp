<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%@ include file="/WEB-INF/views/css.jsp" %>
      <%@ include file="/WEB-INF/views/header-login.jsp" %>
      <%@ include file="/WEB-INF/views/log-reg.jsp" %>
      <%@ include file="/WEB-INF/views/right-click.jsp" %>
      <title>Forgot Password</title>
      <style>
         .step {
         display: none;
         }
         .step.active {
         display: block;
         }
         .center-text {
         text-align: center;
         }
         .center-form {
         max-width: 400px; /* Set a max width for the form */
         margin: 0 auto; /* Center the form horizontally */
         }
         .center-button {
         display: block;
         margin: 20px auto;
         width: 100%; /* Make the button full width within the form */
         }
         .message {
         color: rgba(0, 0, 0, 0.7); /* Style the message text color */
         margin-top: 10px; /* Space above the message */
         text-align: center; /* Center-align the message */
         }
         #otp-not-valid-msg
         {
         color:#b31942;
         }
      </style>
      <style>
         .val2::-webkit-outer-spin-button,
         .val2::-webkit-inner-spin-button
         {
         -webkit-appearance: none;
         margin: 0;
         }
         .val2[type=number]
         {
         -moz-appearance: textfield;
         }
         #otp-not-valid-msg{
         margin-top: -6%;
         }
      </style>
   </head>
   <body>
      <div class="main-page-wrapper">
         <!-- Include Header -->
         <br>
         <!-- Main Content -->
         <div class="mid-content ud-main">
            <div class="container input-group-meta position-relative mb-25">
               <h3 class="center-text">Reset Password</h3>
               <p class="center-text">Enter your OTP which has been sent to your email.</p>
               <form id="forgot-password-form" action="/validateOTPsubmit" method="POST" class="center-form">
                  <div class="input-group-meta form-group mb-30">
                     <label for="otp">OTP<em style="color: #ff0000;">*</em></label>
                     <input type="number" style="color: black !important;" id="otp" name="otp" value="${otpData.otp} " class="form-control val2" required aria-required="true" maxlength="6" pattern="\d{6}">
                     <div class="help-block with-errors"></div>
                     <div id="message" class="message"></div>
                  </div>
                  <p style="font-weight: normal;font-size: 20px;" id ="otp-not-valid-msg">${message}</p>
                  <button id="resend-otp-btn" class="btn-four tran3s center-button" type="button">Resend OTP</button>
                  <button id="continue-btn" class="btn-four tran3s center-button" type="submit" value="submit">Continue</button>
                  <p id="timer" class="center-text"></p>
               </form>
            </div>
         </div>
         <!-- Include Footer -->
         <%@ include file="/WEB-INF/views/footer.jsp" %>
      </div>
	  
	  
	  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <!-- JavaScript Files -->
      <script src="/vendor/jquery.min.js"></script>
      <script src="js/jquery.validate.min.js"></script>
      <script src="js/additional-methods.min.js"></script>
      <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
      <script src="js/theme.js"></script>
      <script>
         $(document).ready(function() {
             let timerDuration = 90; // Timer duration in seconds
             let timerInterval;
         
             function startTimer() {
                 $("#continue-btn").show();
                 $("#resend-otp-btn").hide(); // Hide resend OTP button initially
         
                 clearInterval(timerInterval); // Clear any existing intervals
         		//var now = new Date().getTime();
                 var endTime = sessionStorage.getItem('otpEndTime');
         		sessionStorage.setItem('otpEndTime', endTime);
         
                 		// Check if endTime exists and if it's expired
         		       if (!endTime || new Date().getTime() > endTime) {
         		           var now = new Date().getTime();
         		           var otpDuration = timerDuration * 1000; // Convert seconds to milliseconds
         		           endTime = now + otpDuration;
         		           sessionStorage.setItem('otpEndTime', endTime);
         		       }
                 function updateTimer() {
                     var now = new Date().getTime();
                     var remainingTime = endTime - now;
         
                     if (remainingTime > 0) {
                         var seconds = Math.floor(remainingTime / 1000); // Convert milliseconds to seconds
                         $("#timer").text('OTP expires in ' + seconds + 's').css('color', 'black');
         				
                     } else {
                         clearInterval(timerInterval);
                         $("#timer").text('OTP expired. Please request a new one.').css('color', '#B31942');
         				// OTP has expired, disable continue button and show resend button
                         $("#continue-btn").hide();
						 $('#otp-not-valid-msg').hide();
                         $("#resend-otp-btn").show(); // Show resend OTP button when timer expires
         				$("#resend-otp-btn").attr("disabled", false); // Ensure the button is enabled
                     }
                 }
         
                 updateTimer(); // Initial call to update the timer immediately
                 timerInterval = setInterval(updateTimer, 1000);
             }
         
             // Start the timer on page load
             startTimer();
         
             // Handle Resend OTP button click
             $("#resend-otp-btn").on("click", function() {
         		// The resend button is only enabled after expiration
         		$(this).attr("disabled", true);
                     $.ajax({
                         url: '/sendOTP',
                         type: 'POST',
                         data: { email: '${userEmail}' }, // Ensure ${userEmail} is correctly replaced
                         success: function(response) {
                             $("#message").text('OTP has been resent to your email.');
         					// Reset the timer by updating the endTime in sessionStorage
         					var now = new Date().getTime();
         					var newEndTime = now + (timerDuration * 1000); // 90 seconds from now
         					sessionStorage.setItem('otpEndTime', newEndTime);
         
         					// Restart the timer with the new endTime
                             startTimer();
         					// Hide the resend button and show the continue button
				                $("#resend-otp-btn").hide(); // Hide resend button after resending OTP
				                $("#continue-btn").attr("disabled", false); // Enable continue button after resending OTP
								setTimeout(function() {	
									$("#message").hide();
								}, 5000);
				            },
                        
                         error: function(xhr, status, error) {
                             $("#message").text('An error occurred while resending OTP. Please try again.');
         					$("#resend-otp-btn").attr("disabled", false); // Re-enable the resend button on failure
                         }
                     });
                 
             });
         
             // Handle form validation
         
         	// Handle form validation
         	$("#forgot-password-form").validate({
         	    rules: {
         	        otp: {
         	            required: true,        // Field is required
         	            pattern:/^\d+$/,         // Only digits allowed (no letters, special characters)
         	            minlength: 6,          // Minimum length of 6 characters
         	            maxlength: 6           // Maximum length of 6 characters
         	        },
         	    },
         	    messages: {
         	        otp: {
         	            required: "Please enter the OTP",
         	            pattern: "Please enter only numbers",
         	            minlength: "Please enter exactly 6 digits",
         	            maxlength: "Please enter exactly 6 digits"
         	        },
         	    },
                 submitHandler: function(form) {
                     form.submit(); // Submit the form if validation passes
                 },
                 invalidHandler: function(event, validator) {
                     $("#message").text("OTP validation failed. Please try again.");
                 }
             });
         	
         	 $("#otp").on("input", function () {
         	        let value = $(this).val();
         	        // Remove any non-numeric characters
         	        $(this).val(value.replace(/[^0-9]/g, ''));
         	    });
         
         
         
         });
         
      </script>
   </body>
</html>