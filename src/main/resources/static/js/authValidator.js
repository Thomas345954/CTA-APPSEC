// jQuery validations for login and signup form --> strat
$(document).ready(function() {
	// Define a custom method for validating email with specific suffixes and no special characters after @
	$.validator.addMethod("validEmailSuffix", function(value, element) {
		// Regular expression to match a valid email format with specific suffixes
		// Ensures only letters, numbers, and dots are allowed after @
		var emailPattern = /^[a-zA-Z0-9_\.%\+\-]+@[a-zA-Z\-]+\.[a-zA-Z]{2,}$/;
		var suffixPattern = /\.(com|org|net|edu|gov|in)$/i;

		return this.optional(element) || (emailPattern.test(value) && suffixPattern.test(value));
	}, "Please enter a valid email address with a proper suffix (.com, .org, .net, .edu, .gov, .in) and no special characters after '@'.");

	// Initialize the form validation
	$("#ValidateForm").validate({
		rules: {
			username: {
				required: true,
				email: true,
				validEmailSuffix: true,
				minlength: 2,
				maxlength: 254
			},
			password: {
				required: true,
				pattern: /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%&*])[a-zA-Z\d!@#$%&*]+$/,
				minlength: 8,
				maxlength: 15
			}
		},
		messages: {
			username: {
				required: "Please enter an email address",
				email: "Please enter a valid email address",
				minlength: "Your email must consist of at least two characters",
				maxlength: "Your email must be below 254 characters"
			},
			password: {
				required: "Please enter a password",
				pattern: "Ensure the password contains at least one number, one upper case, and one special character",
				minlength: "Your password must consist of at least eight characters",
				maxlength: "Your password must be below 15 characters"
			}
		}
	});
	$("#ValidateForm1").validate({
		rules: {
			firstName: {
				required: true,
				minlength: 2,
				maxlength: 100,
				pattern: /^[A-Za-z.\s'-]+$/
			},
			lastName: {
				required: true,
				minlength: 2,
				maxlength: 100,
				pattern: /^[A-Za-z.\s'-]+$/
			},
			email: {
				required: true,
				email: true,
				validEmailSuffix: true,
				minlength: 2,
				maxlength: 254
			},
			password: {
				required: true,
				pattern: /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%&*])[a-zA-Z\d!@#$%&*]+$/,
				minlength: 8,
				maxlength: 15
			},
			signupconfirmpassword: {
				required: true,
				pattern: /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%&*])[a-zA-Z\d!@#$%&*]+$/,
				minlength: 8,
				maxlength: 15,
				equalTo: "#signuppassword"
			},
			signupcheckbox: {
				required: true,
			},

		},
		messages: {
			firstName: {
				required: "Please enter a valid name (2-100 characters)",
				minlength: "Your username must consist of at least two characters",
				maxlength: "Your username must be 100 characters",
				pattern: "Only alphabets are allowed"
			},
			lastName: {
				required: "Please enter a valid last name",
				minlength: "Your last name must consist of at least two characters",
				maxlength: "Your last name must be below 100 characters",
				pattern: "Only alphabets are allowed"
			},
			email: {
				required: "Please enter an email",
				email: "Please enter a valid email address",
				minlength: "Your email must consist of at least two characters",
				maxlength: "Your email must be below 254 characters"
			},
			password: {
				required: "Please enter a valid password",
				pattern: "Ensure the password contains at least one number, one upper case, and one special character",
				minlength: "Your password must consist of at least eight characters",
				maxlength: "Your password must be below 15 characters"
			},
			signupconfirmpassword: {
				required: "Please confirm your password",
				pattern: "Ensure the password contains at least one number, one upper case, and one special character",
				minlength: "Your password must consist of at least eight characters",
				maxlength: "Your password must be below 15 characters",
				equalTo: "Please enter the same password as above"
			},
			signupcheckbox: "Please accept the terms to continue",
		}
	});
});

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for login and signup form --> end


//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for forgot form --> start

$().ready(function() {
	$("#forgot-password-form").validate({
		rules: {
			forgotemail: {
				required: true,
				email: true,
			},
			npassword: {
				required: true,
				minlength: 8
			},
			cpassword: {
				required: true,
				minlength: 8,
				equalTo: "#npassword"
			},
			consignupcheckbox: {
				required: true,
			},
		},
		messages: {
			forgotemail: {
				required: "Please enter an email address",
				email: "Please enter a valid email address"
			},
			npassword: {
				required: "Please enter a password",
				minlength: "Your password must consist of at least eight characters"
			},
			cpassword: {
				required: "Please confirm your password",
				minlength: "Your password must consist of at least eight characters",
				equalTo: "Passwords do not match"
			},
			consignupcheckbox: "This field is required"
		}
	});
});


$(window).on('load', function() {
	if (window.location.href.indexOf("login") !== -1) {
		$('#loginModal').modal('show'); // Show the modal when the page is fully loaded and the URL contains "login"
	}
});

$('form input').attr('autocomplete', 'new-password');


//Ended by Ananth
