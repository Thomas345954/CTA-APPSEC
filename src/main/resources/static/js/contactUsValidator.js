// jQuery validations for contact-us form --> strat

$().ready(function() {
	$("#contactusjq").validate({
		rules: {
			name: {
				required: true,
				minlength: 1,
				maxlength: 100,
				pattern: /^[A-Za-z.\s'-]+$/
			},
			email_id: {
				pattern: /^[a-zA-Z0-9_\.%\+\-]+@[a-zA-Z\-]+\.[a-zA-Z]{2,}$/,
				minlength: 2,
				maxlength: 254
			},
			comments: {
				required: true,
				minlength: 10,
				maxlength: 500
			}

		},

		// in 'messages' user have to specify message as per rules
		messages: {
			name: {
				required: "Please enter your first name",
				minlength: "Your first name must be at least one character long",
				maxlength: "Your first name must be less than 100 characters long",
				pattern: "Only alphabets are allowed"
			},
			email_id: {
				minlength: "Email must be at least two characters long",
				maxlength: "Email must be no more than 254 characters long",
				pattern: "Please enter a valid email address. After '@', only letters and dots are allowed, with no consecutive dots"
			},
			comments: {
				required: "Please enter a message",
				minlength: "Your message must be at least 10 characters long",
				maxlength: "Your message must be at most 500 characters long"
			}

		}
	});
});
// jQuery validations for contact us form --> end


$('form input').attr('autocomplete', 'new-password');


//Ended by Ananth