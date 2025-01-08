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
		#email-error-msg
		{
			color: #B31942;
		}
		.blackinput{
			color: black !important;
		}
    </style>
	    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="main-page-wrapper">
 
<br>
    <!-- Main Content -->
    <div class="mid-content ud-main">
        <div class="container input-group-meta position-relative mb-25">
            <h3 class="center-text">Reset Password</h3>
            <p class="center-text">We've all been there.</p>
            <p class="center-text">Enter your email and we'll take care of it.</p>
            <form  class="center-form">
				<div class="input-group-meta form-group mb-30">
				   <label for="forgotemail"  class="mb-10">Email Address*</label>
				   <input type="email" id="femail" name="femail"  class="form-control blackinput" required aria-required="true">
				   <button id="sendOTP" class="btn btn-primary mt-2">Send OTP</button>
				   <div class="help-block with-errors"></div>
				</div>
				<div class="input-group-meta form-group mb-30" id="otpForm" style="display: none;" >
				   <input type="text" id="fotp" class="form-control" placeholder="Enter OTP" class="form-control blackinput" required aria-required="true">
				   <button id="verifyOTP" class="btn btn-primary mt-2">Verify OTP</button>
                   <button id="resendOTP" class="btn btn-link mt-2">Resend OTP</button>
				</div>
				
				<div class="input-group-meta form-group mb-30" id="newPasswordForm" style="display: none;">
				 	<input type="password" id="newPassword" class="form-control mb-2" placeholder="New Password" class="form-control blackinput" required aria-required="true">
					<input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" class="form-control blackinput" required aria-required="true">
					<button id="savePassword" class="btn btn-primary mt-2">Save Password</button>
				</div>
            </form>
        </div>
    </div>

 </div>
 
    <!-- Include Footer -->
    <%@ include file="/WEB-INF/views/footer.jsp" %>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
  	  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			  	<script src="vendor/jquery.min.js"></script>
				<script src="js/jquery.validate.min.js"></script>
				<script src="js/additional-methods.min.js"></script>
	  	      <!--<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
	  	      <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>-->
	  	      <!-- Bootstrap JS -->
	  	      <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	  	      <!-- WOW js -->
	  	      <script src="vendor/wow/wow.min.js"></script>
	  	      <!-- Slick Slider -->
	  	      <script src="vendor/slick/slick.min.js"></script>
	  	      <!-- Fancybox -->
	  	      <script src="vendor/fancybox/dist/jquery.fancybox.min.js"></script>
	  	      <!-- Lazy -->
	  	      <script src="vendor/jquery.lazy.min.js"></script>
	  	      <!-- js Counter -->
	  	      <script src="vendor/jquery.counterup.min.js"></script>
	  	      <script src="vendor/jquery.waypoints.min.js"></script>
	  	      <!-- validator js -->
	  	      <script src="vendor/validator.js"></script>
	  	      <!-- Theme js -->
	  	      <script src="js/theme.js"></script>
	  	      <script src="js/customjquery.js"></script>
	  	      
<script>
        $(document).ready(function() {
            let email = '';
 
            
            
            // Send OTP
            $('#sendOTP').click(function() {
                email = $('#femail').val();
                if (email) {
                	$.get('/sendemailotp/' + email, function(response) {
                		 if (response.success) {
                             $('#emailForm').hide();
                             $('#otpForm').show();
                         } else {
                             alert('Failed to send OTP. Please try again.');
                         }
                	}).fail(function() {
                		 alert('An error occurred. Please try again.');
                	});
                } else {
                    alert('Please enter your email.');
                }
            });

            // Resend OTP
            $('#resendOTP').click(function() {
                // You can reuse the sendOTP logic here
                $('#sendOTP').click();
            });

            // Verify OTP
            $('#verifyOTP').click(function() {
                let otp = $('#fotp').val();
                if (otp) {
                    $.ajax({
                        url: '/verifyemailotp/'+email+'/'+otp,  
                        method: 'GET',
                        success: function(response) {
                            if (response.success) {
                                $('#otpForm').hide();
                                $('#newPasswordForm').show();
                            } else if(!response.success){
                            	alert(response.message);
                            } else{
                                alert('Invalid OTP. Please try again.');
                            }
                        },
                        error: function() {
                            alert('An error occurred. Please try again.');
                        }
                    });
                } else {
                    alert('Please enter the OTP.');
                }
            });

            // Save new password
            $('#savePassword').click(function(e) {
                e.preventDefault(); // Prevent default button action
                let newPassword = $('#newPassword').val();
                let confirmPassword = $('#confirmPassword').val();

                if (newPassword && confirmPassword) {
                    if (newPassword === confirmPassword) {
                        let otp = $('#fotp').val();
                        fetch('/savepassword', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({ email: email, password: newPassword, otp: otp }),
                        })
                        .then(response => response.json())
                        .then(data => {
                             if (data.success) {
                                alert('Password reset successfully!');
                                // Redirect to login page
                                setTimeout(function() {
                                    window.location.href = '/login';  
                                }, 1500); 
                            } else {
                                alert('Failed to reset password. Please try again.');
                            }
                        })
                        .catch((error) => {
                            console.error('Error:', error);
                            alert('An error occurred. Please try again.');
                        });
                    } else {
                        alert('Passwords do not match.');
                    }
                } else {
                    alert('Please enter and confirm your new password.');
                }
            });
            
            
        });
    </script>  
</body>
</html>