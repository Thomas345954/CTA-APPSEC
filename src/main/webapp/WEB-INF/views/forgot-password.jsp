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
            <form id="forgot-password-form" action="/sendOTP" method="POST" class="center-form">
				<div class="input-group-meta form-group mb-30">
				   <label for="forgotemail"  class="mb-10">Email Address<em style="color: #ff0000;">*</em></label>
				   <input type="email" id="email" name="email" value="${OtpData.email}" class="form-control blackinput" required aria-required="true">
				   <div class="help-block with-errors"></div>
				</div>
				<p id ="email-error-msg">${message}</p>
                <button class="btn-four tran3s center-button" type="submit" value="submit" >Continue</button>
            </form>
        </div>
    </div>

    <!-- Include Footer -->
    <%@ include file="/WEB-INF/views/footer.jsp" %>

	<%@ include file="/WEB-INF/views/js.jsp" %>
</div>
<script>
	$(document).ready(function() {
		$.validator.addMethod("validEmailSuffix", function(value, element) {
				// Regular expression to match a valid email format with specific suffixes
				// Ensures only letters, numbers, and dots are allowed after @
				var emailPattern = /^[a-zA-Z0-9_\.%\+\-]+@[a-zA-Z\-]+\.[a-zA-Z]{2,}$/;
				var suffixPattern = /\.(com|org|net|edu|gov|in)$/i;
				return this.optional(element) || (emailPattern.test(value) && suffixPattern.test(value));
			}, "Please enter a valid email address with a proper suffix (.com, .org, .net, .edu, .gov, .in) and no special characters after '@'.");

		    $("#forgot-password-form").validate({
		        rules: {
		            "email": {
						required: true,
						email: true,
						validEmailSuffix: true,
						minlength: 2,
						maxlength: 254
		            },
		        },
		        messages: {
		            "email": {
						required: "Please enter an email address",
						email: "Please enter a valid email address",
						minlength: "Your email must consist of at least two characters",
						maxlength: "Your email must be below 254 characters"
		            },
		        }
		    });
			// Clear OTP end time when the page is unloaded
			   $(window).on('beforeunload', function() {
			       sessionStorage.removeItem('otpEndTime');
			   });
			   setTimeout(function() {	
					$("#email-error-msg").hide();
				}, 10000);	
			});
	  </script>
</body>
</html>