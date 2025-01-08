$().ready(function() {
    $("#editprofilejq").validate({
        rules: {
            name: {
                required: true,
                minlength: 2,
                maxlength: 100,
                pattern: /^[a-zA-Z\s.]*$/
            },
            last_name: {
                required: true,
                minlength: 2,
                maxlength: 100,
                pattern: /^[a-zA-Z\s.]*$/
            },
            email: {
                required: true,
                email: true
            },
            id_code: {
                pattern: /^[a-zA-Z0-9]+$/
            },
            number: {
                digits: true
            }
        },

        // in 'messages' user has to specify message as per rules
        messages: {
            name: {
                required: "Please enter your first name",
                minlength: "Your username must consist of at least 2 characters",
                maxlength: "Your username must be 100 characters",
                pattern: "Only Alphabets are allowed"
            },
            last_name: {
                required: "Please enter your last name",
                minlength: "Your lastname must consist of at least 2 characters",
                maxlength: "Your lastname must be 100 characters",
                pattern: "Only Alphabets are allowed"
            },
            email: {
                required: " Please enter a email",
                email: "Please enter a valid email address"
            },
            id_code: {
                pattern: "Only Alphanumeric values are allowed"
            },
            number: {
                digits: "Please enter only digits"
            }
        }
    });
});