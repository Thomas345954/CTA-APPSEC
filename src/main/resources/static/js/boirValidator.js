// Custom jQuery validations for all the forms CTA Harbor
// Created on   : 26/07/2024.
// Developed by : (yashwanth.s@microgridtechsol.com) / (sandhya.k@microgridtechsol.com)


//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for login and signup form --> strat
var filingInfoId;

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for login and signup form --> end

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validationf for blog details page --> Start

$().ready(function() {
	$("#blogdetailjq").validate({
		rules: {
			bdname: {
				required: true,
				minlength: 1,
				maxlength: 100,
				pattern: /^[A-Za-z.\s'-]+$/
			},
			bdemail: {
				required: true,
				email: true,
			},
			bdmessage: {
				minlength: 10,
				maxlength: 500
			}
		},

		// in 'messages' user have to specify message as per rules
		messages: {
			bdname: {
				required: "Please enter your first name",
				minlength: "Your first name must be at least one character long",
				maxlength: "Your first name must be less than 100 characters long",
				pattern: "Only alphabets are allowed"
			},
			bdemail: {
				required: " Please enter an email",
				minlength: " Please enter a valid email",
			},
			bdmessage: {
				minlength: "Your message must be at least 10 characters long",
				maxlength: "Your message must be at most 500 characters long"
			}

		}
	});
});

//----------------------------------------------------------------------------------------------------------------------
// jQuery validationf for blog details page --> End

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Filing Information step form rules --> strat


$(document).ready(function() {
	$("#FilingInfo").validate({
		rules: {
			filingType: {
				required: true
			},
			legalName: {
				required: true,
				minlength: 1,
				maxlength: 150,
				pattern: /^[a-zA-Z0-9\s'-.]+$/
			},
			taxIdType: {
				required: true,
			},
			countryOrJurisdiction: {
				required: true,
			}
		},

		// In 'messages', specify messages as per rules
		messages: {
			filingType: {
				required: "Please select a valid type of filing from the available options"
			},
			legalName: {
				required: "Legal name is a required field",
				minlength: "Please enter your legal name",
				maxlength: "Your legal name must be 150 characters or less",
				pattern: "Only alphabets, spaces, apostrophes, numbers, and hyphens are allowed"
			},
			taxIdType: {
				required: "Tax ID type is a required field",
			},
			countryOrJurisdiction: {
				required: "Please select the country or jurisdiction."
			}
		},

		errorPlacement: function(error, element) {
			if (element.is(":radio")) {
				error.appendTo(element.closest('.form-rows').find('.row'));
			} else {
				error.insertAfter(element);
			}
		}
	});
});


//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Filing Information step form rules --> end


//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Reporting Company step form rules --> start

$("#ReportingCom").validate({
	ignore: function(index, element) {
        const name = $(element).attr("name");
        const validator = $(element).closest('form').data('validator');
        return !$(element).is(":visible") && (!validator.settings.rules[name]);
    },
	rules: {
		requestToReceiveFinCenId: {
			required: false,
		},
		foreignPooledInvestmentVehicle: {
			required: false,
		},
		reportingCompanyLegalName: {
			required: true,
			minlength: 1,
			maxlength: 150
		},
		taxIdentificationType: {
			required: true,
		},
		countryOrJurisdictionRep: {
			required: true,
		},
		countryOrJurisdictionFormation: {
			required: true,
		},
//		stateFormation: {
//			required: true,
//		},
//		tribalJurisdictionFormation: {
//			required: true,
//		},
//		otherTribeFormation: {
//			required: true,
//			maxlength: 150
//		},
//		stateFirstRegistration: {
//			required: true,
//		},
//		tribalJurisdictionFirstRegistration: {
//			required: true,
//		},
//		otherTribeFirstRegistration: {
//			required: true,
//		},
		dateOfIncorporation: {
			required: false,
		},
		"reportingAddress.address": {
			required: true,
			pattern: /^[a-zA-Z0-9\s-,.]*$/,
			minlength: 1,
			maxlength: 100
		},
		"reportingAddress.city": {
			required: true,
			pattern: /^[a-zA-Z0-9\s]*$/,
			minlength: 1,
			maxlength: 50
		},
		"reportingAddress.country": {
			required: true,
		},
		"reportingAddress.state": {
			required: true,
		},
		"reportingAddress.postalCode": {
			required: true,
			pattern: /^(?!12345)(?!.*(\d)\1{4})(?!.*123456789)\d{5}(?:\d{4})?$/
		}

	},

	// in 'messages' user have to specify message as per rules

	messages: {
		reportingCompanyLegalName: {
			required: "Company legal name is required",
			minlength: "Your company name must consist of at least one character",
			maxlength: "Company legal name must be at most 150 characters"

		},
		alternateName: {
			required: "Please enter a valid alternate name",
			minlength: "Your alternate name must consist of at least one character",
			maxlength: "Alternate name must be at most 150 characters"
		},
		taxIdentificationType: {
			required: "Tax Identification type is required",
		},
		countryOrJurisdictionRep: {
			required: "Please select the country/jurisdiction",
		},
		countryOrJurisdictionFormation: {
			required: "Country/Jurisdiction of formation is required",
		},
//		stateFormation: {
//
//			required: "Select a valid state",
//		},
//		tribalJurisdictionFormation: {
//			required: "Tribal jurisdiction of formation is required",
//		},
//		otherTribeFormation: {
//			required: "Other tribe is a required field",
//			maxlength: "150 characters maximum"
//		},
//		stateFirstRegistration: {
//			required: "State of first registration is required",
//		},
//		tribalJurisdictionFirstRegistration: {
//			required: "Tribal jurisdiction of first registration is required",
//		},
//		otherTribeFirstRegistration: {
//			required: "Other tribe of first registration is required",
//			maxlength: "150 characters maximum"
//		},
		dateOfIncorporation: {
			required: "Date of Incorporation is required and must be a valid date",
		},
		"reportingAddress.address": {
			required: "Address (number, street, and apt. or suite no.) is required",
			pattern: "Please enter only letters, numbers, hyphen, comma and spaces",
			minlength: "Your address must consist of at least one character",
			maxlength: "100 characters maximum"
		},
		"reportingAddress.city": {
			required: "City is required",
			pattern: "Please enter only letters, numbers, and spaces",
			minlength: "Your city must consist of at least one character",
			maxlength: "50 characters maximum"
		},
		"reportingAddress.country": {
			required: "U.S. or U.S. Territory is required",
		},
		"reportingAddress.state": {
			required: "State is required",
		},
		"reportingAddress.postalCode": {
			required: "Zip Code is required",
			pattern: "Zip Code must be either five or nine numeric characters, and cannot be a consecutive string of the same number, or 123456789"
		}
	}
});

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Reporting Company step form rules --> end

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Company Applicant step form rules --> start

$("#CompanyAppinfo").validate({
	ignore: function(index, element) {
	        const name = $(element).attr("name");
	        const validator = $(element).closest('form').data('validator');
	        return !$(element).is(":visible") && (!validator.settings.rules[name]);
	    },
	rules: {

		existingRepoCompany: {
			required: false
		},
		finCenId: {
			required: false
		},
		comdob: {
			required: true
		},
		comaddtype: {
			required: true,
		},
		comadd: {
			required: true,
			pattern: /^[a-zA-Z0-9\s-,.]*$/,
			minlength: 1,
			maxlength: 100
		},
		comcity: {
			required: true,
			pattern: /^[a-zA-Z0-9\s]+$/,
			minlength: 1,
			maxlength: 50
		},
		comzipcode: {
			required: true,
			minlength: 5,
			maxlength: 10,
			pattern: /^[a-zA-Z0-9\s\-]{3,10}$/
		},
		comcountjuri1: {
			required: true
		},
		comstate1: {
			required: true
		},
	},

	// in 'messages' user have to specify message as per rules
	messages: {
		existingRepoCompany: {
			required: "Please select one of the options"
		},
		finCenId: {
			required: "Must be equal to 12 numeric characters "
		},
		comdob: {
			required: "Date of birth is required"

		},
		comaddtype: {
			required: "Please select the address type",
		},
		comadd: {
			required: "Address (number, street, and apt. or suite no.) is required",
			pattern: "Please enter only letters, numbers, hyphen, comma and spaces",
			minlength: "Your address must consist of at least one character",
			maxlength: "100 characters maximum"
		},
		comcity: {
			required: "City is required",
			pattern: "Only alphanumeric characters are allowed",
			minlength: "Your city must consist of at least one character",
			maxlength: "50 characters maximum"
		},
		comzipcode: {
			required: "ZIP code is required",
			minlength: "Your ZIP code must consist of at least 5-10 characters",
			maxlength: "Your ZIP code must be at most 10 characters",
			pattern: "Must be alphanumeric only"
		},
		comcountjuri1: {
			required: "Please select the country/jurisdiction"
		},
		comstate1: {
			required: "Please select the state"
		},
	},
	errorPlacement: function(error, element) {
		if (element.is(":radio")) {
			error.appendTo(element.closest('.form-fields').find('.row'));
		} else {
			error.insertAfter(element);
		}
	},
});

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Company Applicant step form rules --> end

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Beneficial step form rules --> start

$("#BeneficialForm").validate({
	ignore: function(index, element) {
        const name = $(element).attr("name");
        const validator = $(element).closest('form').data('validator');
        return !$(element).is(":visible") && (!validator.settings.rules[name]);
    },
	rules: {
		benidt: {
			required: true,
		},
		benidi: {
			required: true,
			accept: "application/pdf,image/jpeg,image/png",
			maxlength: "250"
		},
		benidn: {
			required: true,
			minlength: 1,
			maxlength: 25,
			pattern: /^[a-zA-Z0-9]+$/
		},
		Countryjur: {
			required: true,
		},
		benstate: {
			required: function(element) {
				return $("#Countryjur").val() === "United States of America" && $("#benlocaltribal").val() === "";
			}
		},
		benlocaltribal: {
			required: function(element) {
				return $("#Countryjur").val() === "United States of America" && $("#benstate").val() === "";
			}
		},
		benotherlocal: {
			required: function(element) {
				return $("#benlocaltribal").val() === "other";
			},
			maxlength: 150,
			pattern: /^[a-zA-Z]+$/
		},
		benfincen: {
			minlength: 1,
			maxlength: 20,
			pattern: /^[a-zA-Z0-9]+$/
		},
		bensuffix: {
			minlength: 1,
			maxlength: 50,
			pattern: /^[a-zA-Z\s]+$/
		},
		benfirstname: {
			required: true,
			minlength: 1,
			maxlength: 50,
			pattern: /^[A-Za-z.\s]+$/
		},
		benmiddlename: {
			minlength: 1,
			maxlength: 50,
			pattern: /^[A-Za-z.\s]+$/
		},
		benlastname: {
			required: true,
			minlength: 1,
			maxlength: 150,
			pattern: /^[A-Za-z.\s]+$/
		},
		bendob: {
			required: true,
		},
		benaddresstype: {
			required: true,
		},
		benaddressnumber: {
			required: true,
			minlength: 1,
			maxlength: 100,
			pattern: /^[a-zA-Z0-9\s,.-]+$/
		},
		bencity: {
			required: true,
			minlength: 1,
			maxlength: 50,
			pattern: /^[A-Za-z.\s]+$/
		},
		Countryjur2: {
			required: true,
		},
		benstate2: {
			required: true,
		},
		benzipcode: {
			required: true,
			minlength: 5,
			maxlength: 10,
			pattern: /^[a-zA-Z0-9\s\-]{3,10}$/

		}

	},

	// in 'messages' user have to specify message as per rules
	messages: {
		benidt: {
			required: "Must be a valid document type",
		},
		benidi: {
			required: "Please upload a file",
			accept: "Only PDF, JPEG, and PNG formats are allowed",
			maxlength: "Your Identifying document file name must not exceed 250 characters"
		},
		benidn: {
			required: "Please enter a value",
			pattern: "Only alphanumeric characters are allowed",
			maxlength: "Your Identifying document number must not exceed 25 characters"
		},
		Countryjur: {
			required: "Country is required"
		},
		benstate: {
			required: "State is required"
		},
		benlocaltribal: {
			required: "Local/Tribal is required"
		},
		benotherlocal: {
			required: "Please provide a description for other local/tribal",
			maxlength: "150 characters maximum",
			pattern: "Only alphabets are allowed"
		},
		typefilling: {
			required: "Please select an option"
		},
		benfincen: {
			minlength: "You must enter at least one character",
			maxlength: "you must not enter more than 20 characters",
			pattern: "Only alphanumeric characters are allowed"
		},
		bensuffix: {
			minlength: "You must enter at least one character",
			maxlength: "You must not enter more than 50 characters",
			pattern: "Only alphabets are allowed"
		},
		benfirstname: {
			required: "Please enter your first name",
			minlength: "Your first name must be at least one character long",
			maxlength: "Your first name must be less than 50 characters long",
			pattern: "Only alphabets are allowed"
		},
		benmiddlename: {
			minlength: "Your middle name must be at least one character long",
			maxlength: "Your middle name must be less than 50 characters long",
			pattern: "Only alphabets are allowed"
		},
		benlastname: {
			required: "Please enter your last name",
			minlength: "Your last name must be at least one character long",
			maxlength: "Your last name must be less than 150 characters long",
			pattern: "Only alphabets are allowed"
		},
		bendob: {
			required: "Must be a valid date",
		},
		benaddresstype: {
			required: "Please select an option",
		},
		benaddressnumber: {
			required: "Please enter your address",
			minlength: "You must enter minimum one character",
			maxlength: "You must not enter more than 100 characters",
			pattern: "Only alphanumerics are allowed"
		},
		bencity: {
			required: "Please enter your city",
			minlength: "You must enter at least one character",
			maxlength: "You must not enter more than 50 characters",
			pattern: "Only alphabets are allowed"
		},
		Countryjur2: {
			required: "Country is required"
		},
		benstate2: {
			required: "State is required"
		},
		benzipcode: {
			required: "ZIP Code is required",
			minlength: "You must enter minimum five character",
			maxlength: "You must not enter more than 10 characters",
			pattern: "Only alphanumerics are allowed"
		}

	},
	errorPlacement: function(error, element) {
		if (element.is(":radio")) {
			error.appendTo(element.closest('.form-rows').find('.row'));
		} else {
			error.insertAfter(element);
		}
	},
});

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Beneficial step form rules --> end

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Submit step form rules --> start

$("#SubmitForm").validate({
	rules: {
		email: {
			required: true,
			email: true,
		},
		subconemail: {
			required: true,
			email: true,
			equalTo: "#subemail"
		},
		firstName: {
			required: true,
			minlength: 1,
			maxlength: 50,
			pattern: /^[A-Za-z.\s]+$/
		},
		lastName: {
			required: true,
			minlength: 1,
			maxlength: 50,
			pattern: /^[A-Za-z.\s]+$/
		},
		subcheckbox1: "required",
		subcheckbox2: "required"
	},

	// in 'messages' user have to specify message as per rules
	messages: {
		email: {
			required: " Please enter an email",
			minlength: " Please enter a valid email",
		},
		subconemail: {
			required: " Please enter an email",
			minlength: " Please enter a valid email",
			equalTo: " Please enter the same email"
		},
		firstName: {
			required: "Please enter your first name",
			minlength: "Your first name must be at least one character long",
			maxlength: "Your first name must be less than 50 characters long",
			pattern: "Only alphabets are allowed"
		},
		lastName: {
			required: "Please enter your last name",
			minlength: "Your last name must be at least one character long",
			maxlength: "Your last name must be less than 50 characters long",
			pattern: "Only Alphabets are allowed"
		},
		subcheckbox1: "This is required",
		subcheckbox2: "This field is required"
	},
	errorPlacement: function(error, element) {
		if (element.is(":checkbox")) {
			error.appendTo(element.closest('.form-rows').find('.check-field'));
		} else {
			error.insertAfter(element);
		}
	}
});

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Submit step form rules --> end


//-----------------------------------------------------------------------------------------------------------------------
//Stepform logic given by Ananth and some modifications done by sandhya & Yashwanth start

function openStep(currentStep) {
	$("#step1").removeClass("active").addClass("inactive");
	$("#step2").removeClass("active").addClass("inactive");
	$("#step3").removeClass("active").addClass("inactive");
	$("#step4").removeClass("active").addClass("inactive");
	$("#step5").removeClass("active").addClass("inactive");

	if (currentStep === '2') {
		$("#step2").removeClass("inactive").addClass("active");
	} else if (currentStep === '3') {
		$("#step3").removeClass("inactive").addClass("active");
	} else if (currentStep === '4') {
		$("#step4").removeClass("inactive").addClass("active");
	} else if (currentStep === '5') {
		$("#step5").removeClass("inactive").addClass("active");
	} else {
		$("#step1").removeClass("inactive").addClass("active");
	}
}

function updateStep1FormFields(filingInfo) {
	for (var key in filingInfo) {
		if (filingInfo.hasOwnProperty(key)) {
			var input = $('[name="' + key + '"]');
			if (input.attr('type') === 'radio') {
				$('input[name="' + key + '"][value="' + filingInfo[key] + '"]').prop('checked', true);
			} else {
				input.val(filingInfo[key]);
			}
		}
	}
}

function updateStep2FormFields(reportingCompany) {
	for (var key in reportingCompany) {
		if (reportingCompany.hasOwnProperty(key)) {
			var input = $('[name="' + key + '"]');
			if (input.attr('type') === 'radio') {
				$('input[name="' + key + '"][value="' + reportingCompany[key] + '"]').prop('checked', true);
			} else {
				input.val(reportingCompany[key]);
			}
		}
	}
	// Newly added alternate name start
	$(document).ready(function() {
		// Function to load alternate names
		function loadAlternateNames() {
			$('#alternate-names-container').empty();
			if (reportingCompany.alternateName) {
				let alternateNameIndex = 1;
				reportingCompany.alternateName.forEach(function(name) {
					let labelSuffix = alternateNameIndex === 1 ? '' : `.${alternateNameIndex - 1}`;
					let altNameField = `
			                    <div class="form-rows" id="alternate-name-${alternateNameIndex}">
			                        <label class="main-label" for="alternateName-${alternateNameIndex}">5${labelSuffix} Alternate name</label>
			                        <div class="form-fields d-flex">
			                            <div class="normal-field col-sm-8">
			                                <input type="text" id="alternateName-${alternateNameIndex}" name="alternateName[${alternateNameIndex}].name" 
			                                placeholder="Enter Alternate name" class="alternate-name form-field form-control" value="${name.name}" />
			                            </div>
			                            <div class="col-sm-4">
			                                <button class="remove-alternate-name btn btn-primary bg-btn" data-index="${alternateNameIndex}">Remove</button>
			                            </div>
			                        </div>
			                    </div>`;
					$('#alternate-names-container').append(altNameField);
					alternateNameIndex++;
				});

				// Rebind event handler for the remove button
				$('.remove-alternate-name').off('click').on('click', function() {
					let index = $(this).data('index');
					$(`#alternate-name-${index}`).remove();
					// Optionally, update the reportingCompany.alternateName array if needed
				});
			}
		}
	});
}

function updateStep3FormFields(companyApplicant) {
	for (var key in companyApplicant) {
		if (companyApplicant.hasOwnProperty(key)) {
			var input = $('[name="' + key + '"]');
			if (input.attr('type') === 'radio') {
				$('input[name="' + key + '"][value="' + companyApplicant[key] + '"]').prop('checked', true);
			} else {
				input.val(companyApplicant[key]);
			}
		}
	}
}

function updateStep4FormFields(beneficialOwner) {
	for (var key in beneficialOwner) {
		if (beneficialOwner.hasOwnProperty(key)) {
			var input = $('[name="' + key + '"]');
			if (input.attr('type') === 'radio') {
				$('input[name="' + key + '"][value="' + beneficialOwner[key] + '"]').prop('checked', true);
			} else {
				input.val(beneficialOwner[key]);
			}
		}
	}
}

function updateStep5FormFields(submitterDetails) {
	for (var key in submitterDetails) {
		if (submitterDetails.hasOwnProperty(key)) {
			var input = $('[name="' + key + '"]');
			if (input.attr('type') === 'radio') {
				$('input[name="' + key + '"][value="' + submitterDetails[key] + '"]').prop('checked', true);
			} else {
				input.val(submitterDetails[key]);
			}
		}
	}
}

function callApi(stepToActivatePostSuccess) {

	var disabledFields = $("#FilingInfo").find(':disabled');
	disabledFields.each(function() {
		$(this).data('wasDisabled', true).prop('disabled', false);
	});

	$.ajax({
		url: '/filingInfo',
		type: 'POST',
		data: $('#FilingInfo').serialize(),
		success: function(response) {
			if (response.success) {
				// Update the form fields with response data
				updateStep1FormFields(response.filingInfo);

				filingInfoId = response.filingInfo.filingInfoId;
				$("#filingInfoId").val(filingInfoId);
				$("#beneficialOwner[0].filingInfoId").val(filingInfoId);
				$("#step1").removeClass("active");
				$(stepToActivatePostSuccess).addClass("active");
				//hideLoader();
			} else {
				//hideLoader();
				// Display an error message
				alert('Form submission failed: ' + response.message);

			}
		},
		error: function(xhr, status, error) {
			// Hide the loader
			//hideLoader();
			// Display an error message
			alert('Form submission failed: ' + error);
		}
	});

	disabledFields.each(function() {
		// Restore the 'disabled' attribute
		if ($(this).data('wasDisabled')) {
			$(this).prop('disabled', true).removeData('wasDisabled');
		}
	});
}


function callstep3api() {
	var disabledFields = $("#CompanyAppinfo").find(':disabled');
	disabledFields.each(function() {
		$(this).data('wasDisabled', true).prop('disabled', false);
	});

	filingInfoId = $("#filingInfoId").val();
	$.ajax({
		url: '/companyApplicant',
		type: 'POST',
		data: $('#CompanyAppinfo').serialize() + '&filingInfoId=' + filingInfoId,
		success: function(response) {

			if (response.success) {
				// Update the form fields with response data
				//updateStep2FormFields(response.reportingCompany);

				$("#step3").removeClass("active");
				$("#step4").addClass("active");
				var reportingCom = $("#CompanyAppinfo");
				if (reportingCom.length > 0) {
					var firstField = reportingCom.find(":radio").first();
					if (firstField.length > 0) {
						// Focus on the first input field
						// firstField.focus();

						// Optionally scroll to the first field (if needed)
						$('html, body').animate({
							scrollTop: firstField.offset().top + 400 // Adjust the offset as needed
						}, 500);
					} else {
						console.error("No radio buttons found inside #CompanyAppinfo.");
					}
				} else {
					console.error("#CompanyAppinfo element not found.");
				}
				//hideLoader();
			} else {
				//hideLoader();
				alert('Form submission failed: ' + response.message);
			}
		},
		error: function(xhr, status, error) {
			// Hide the loader
			//hideLoader();
			alert('Form submission failed: ' + error);
		}
	});
	disabledFields.each(function() {
		// Restore the 'disabled' attribute
		if ($(this).data('wasDisabled')) {
			$(this).prop('disabled', true).removeData('wasDisabled');
		}
	});
}

function loadSubmitterDetailsPreview(submitterDetails) {
	try {
		return `
<table class="box-bg-sec res-table-sec">
    <tr>
     <th colspan="2" class="rt-heading">Submitter Information</th>
    </tr>
	<tr>
	    <td>First name</td>
	    <td>${submitterDetails.firstName}</td>
	</tr>
	<tr>
	    <td>Last name</td>
	    <td>${submitterDetails.lastName}</td>
	</tr>
	<tr>
	    <td>E-mail address</td>
	    <td>${submitterDetails.email}</td>
	</tr>
</table>
`;

	} catch (e) {
		return "";
	}
}
function loadFilingInfoPreview(filingInfo) {
	if (filingInfo.filingType === 'initial') {
		return `
			<table class="box-bg-sec res-table-sec">
			<tr>
			<th colspan="2" class="rt-heading">Filing Information</th>
			</tr>
			<tr>
			<td>Type of filing</td>
			<td>${filingInfo.filingType ? (filingInfo.filingType === 'initial' ? 'Initial report' : filingInfo.filingType) : ''}</td>
			</tr>
			</table>
			`;
	} else {
		return `
		<table class="box-bg-sec res-table-sec">
			<tr>
			<th colspan="2" class="rt-heading">Filing Information</th>
			</tr>
			<tr>
			<td>Type of filing</td>
			<td>${filingInfo.filingType ? (filingInfo.filingType === 'correct' ? 'Correct prior report' : (filingInfo.filingType === 'update' ? 'Update prior report' : (filingInfo.filingType === 'newly' ? 'Newly exempt entity' : ''))) : ''}</td>
			</tr>
			<tr>
			<td>Legal Name</td>
			<td>${filingInfo.legalName ? filingInfo.legalName : ''}</td>
			</tr>
			<tr>
			<td>Tax Identification Type</td>
			<td>${filingInfo.taxIdType ? filingInfo.taxIdType : ''}</td>
			</tr>
			<tr>
			<td>Tax Identification Number</td>
			<td>${filingInfo.taxIdNum ? filingInfo.taxIdNum : ''}</td>
			</tr>
			<tr>
			<td>Country/Jurisdiction (if foreign tax ID only)</td>
			<td>${filingInfo.countryOrJurisdiction ? filingInfo.countryOrJurisdiction : ''}</td>
			</tr>
		</table>
	
	`;
	}
}
function loadReportingCompany(reportingCompany) {
	try {
		let htmlContent = '';

		if (reportingCompany.alternateName && reportingCompany.alternateName.length > 0) {
			reportingCompany.alternateName.forEach((alternateName) => {
				htmlContent += `	
			<table class="box-bg-sec res-table-sec">
				<tr><th colspan="2" class="rt-heading">Reporting Company Information</th></tr>
				<tr><th class="rt-sub-heading" colspan="2">Legal Name &amp; DBAs</th></tr>
				<tr>
					<td>Reporting Company legal name</td>
					<td>${reportingCompany.reportingCompanyLegalName ? reportingCompany.reportingCompanyLegalName : ''}</td>
				</tr>
				<tr>
					<td>Alternate name (e.g. trade name, DBA)</td>
					<td>${alternateName ? alternateName.name : ''}</td>
				</tr>
				<tr class="border-row"><td colspan="2"></td></tr>
				<tr><th class="rt-sub-heading" colspan="2">Tax Identification</th></tr>
				<tr>
					<td>Tax ID type</td>
					<td>${reportingCompany.taxIdentificationType ? reportingCompany.taxIdentificationType : ''}</td>
				</tr>
				<tr>
					<td>Tax Number</td>
					<td>${reportingCompany.taxIdentificationNumber ? reportingCompany.taxIdentificationNumber : ''}</td>
				</tr>
				<tr>
					<td>Country/Jurisdiction (if foreign tax ID only)</td>
					<td>
						${reportingCompany.countryOrJurisdictionRep ? reportingCompany.countryOrJurisdictionRep : ''}
					</td>
				</tr>
				<tr class="border-row"><td colspan="2"></td></tr>
				<tr><th class="rt-sub-heading" colspan="2">Jurisdiction of Formation or First Registration</th></tr>
				<tr>
				<td>Country/Jurisdiction of formation</td>
				<td>${reportingCompany.countryOrJurisdictionFormation ? reportingCompany.countryOrJurisdictionFormation : ''}</td>
				</tr>	
				<tr>
				<td>State of Formation</td>
				<td>${reportingCompany.stateFormation ? reportingCompany.stateFormation : ''}</td>
				</tr>
				<tr>
				<td>Tribal Jurisdiction Formation</td>
				<td>${reportingCompany.tribalJurisdictionFormation ? reportingCompany.tribalJurisdictionFormation : ''}</td>
				</tr>
				<tr class="border-row"><td colspan="2"></td></tr>
				<tr><th class="rt-sub-heading" colspan="2">Current US Business Address</th></tr>
				<tr>
				<td>Address (number, street, and apt. or suite no.)</td>
				<td>${reportingCompany.reportingAddress.address ? reportingCompany.reportingAddress.address : ''}</td>
				</tr>
				<tr>
				<td>City</td>
				<td>${reportingCompany.reportingAddress.city ? reportingCompany.reportingAddress.city : ''}</td>
				</tr>
				<tr>
				<td>U.S. or U.S. Territory</td>
				<td>${reportingCompany.reportingAddress.country ? reportingCompany.reportingAddress.country : ''}</td>
				</tr>
				<tr>
				<td>State</td>
				<td>${reportingCompany.reportingAddress.state ? reportingCompany.reportingAddress.state : ''}</td>
				</tr>
				<tr>
				<td>ZIP Code</td>
				<td>${reportingCompany.reportingAddress.postalCode ? reportingCompany.reportingAddress.postalCode : ''}</td>
				</tr>
				<tr class="border-row"><td colspan="2"></td></tr>
				<tr><th class="rt-sub-heading" colspan="2">Placeholder Title...</th></tr>
				<tr>
				<td>Request to receive FinCEN Identifier (FinCEN ID)</td>
				<td>${reportingCompany.requestToReceiveFinCenId !== null && reportingCompany.requestToReceiveFinCenId !== undefined ? (reportingCompany.requestToReceiveFinCenId === true ? 'Yes' : 'No') : ''}</td>
				</tr>
				<tr>
				<td>Foreign pooled investment vehicle</td>
				<td>${reportingCompany.foreignPooledInvestmentVehicle !== null && reportingCompany.foreignPooledInvestmentVehicle !== undefined ? (reportingCompany.foreignPooledInvestmentVehicle === true ? 'Yes' : 'No') : (reportingCompany.foreignPooledInvestmentVehicle2 !== null && reportingCompany.foreignPooledInvestmentVehicle2 !== undefined ? (reportingCompany.foreignPooledInvestmentVehicle2 === true ? 'Yes' : 'No') : '')}</td>
				</tr>
				<tr>
				<td>Date of Incorporation</td>
				<td>${reportingCompany.dateOfIncorporation ? reportingCompany.dateOfIncorporation : ''}</td>
				</tr>
				<tr>
				<td>Name of the other Tribe</td>
				<td>${reportingCompany.otherTribeFormation ? reportingCompany.otherTribeFormation : ''}</td>
				</tr>
				<tr>
				<td>State of first registration</td>
				<td>${reportingCompany.stateFirstRegistration ? reportingCompany.stateFirstRegistration : ''}</td>
				</tr>
				<tr>
				<td>Tribal jurisdiction of first registration</td>
				<td>${reportingCompany.tribalJurisdictionFirstRegistration ? reportingCompany.tribalJurisdictionFirstRegistration : ''}</td>
				</tr>
				<tr>
				<td>Name of the other Tribe First Registration</td>
				<td>${reportingCompany.otherTribeFirstRegistration ? reportingCompany.otherTribeFirstRegistration : ''}</td>
				</tr>
				</table>
`;
			});
		} else {
			// Handle case where alternateName is empty or undefined
			htmlContent += `
		<table class="box-bg-sec res-table-sec">
<tr><th colspan="2" class="rt-heading">Reporting Company Information</th></tr>
<tr><th class="rt-sub-heading" colspan="2">Legal Name &amp; DBAs</th></tr>
<tr>
 <td>Reporting Company legal name</td>
<td>${reportingCompany.reportingCompanyLegalName ? reportingCompany.reportingCompanyLegalName : ''}</td>
</tr>
<tr>
 <td>Alternate name (e.g. trade name, DBA)</td>
 <td></td>
</tr>
<tr class="border-row"><td colspan="2"></td></tr>
<tr><th class="rt-sub-heading" colspan="2">Tax Identification</th></tr>
<tr>
 <td>Tax ID type</td>
 <td>${reportingCompany.taxIdentificationType ? reportingCompany.taxIdentificationType : ''}</td>
</tr>
<tr>
 <td>Tax number</td>
 <td>${reportingCompany.taxIdentificationNumber ? reportingCompany.taxIdentificationNumber : ''}</td>
</tr>
<tr>
 <td>Country/Jurisdiction (if foreign tax ID only)</td>
 <td>${reportingCompany.countryOrJurisdictionRep ? reportingCompany.countryOrJurisdictionRep : ''}</td>
</tr>
<tr class="border-row"><td colspan="2"></td></tr>
<tr><th class="rt-sub-heading" colspan="2">Jurisdiction of Formation or First Registration</th></tr>
<tr>
 <td>Country/Jurisdiction of formation</td>
 <td>${reportingCompany.countryOrJurisdictionFormation ? reportingCompany.countryOrJurisdictionFormation : ''}</td>
</tr>
<tr>
 <td>State of Formation</td>
 <td>${reportingCompany.stateFormation ? reportingCompany.stateFormation : ''}</td>
</tr>
<tr>
 <td>Tribal Jurisdiction Formation</td>
 <td>${reportingCompany.tribalJurisdictionFormation ? reportingCompany.tribalJurisdictionFormation : ''}</td>
</tr>
<tr class="border-row"><td colspan="2"></td></tr>
<tr><th class="rt-sub-heading" colspan="2">Current US Business Address</th></tr>
<tr>
 <td>Address (number, street, and apt. or suite no.)</td>
 <td>${reportingCompany.reportingAddress.address ? reportingCompany.reportingAddress.address : ''}</td>
</tr>
<tr>
 <td>City</td>
 <td>${reportingCompany.reportingAddress.city ? reportingCompany.reportingAddress.city : ''}</td>
</tr>
<tr>
 <td>U.S. or U.S. Territory</td>
 <td>${reportingCompany.reportingAddress.country ? reportingCompany.reportingAddress.country : ''}</td>
</tr>
<tr>
 <td>State</td>
 <td>${reportingCompany.reportingAddress.state ? reportingCompany.reportingAddress.state : ''}</td>
</tr>
<tr>
 <td>ZIP Code</td>
 <td>${reportingCompany.reportingAddress.postalCode ? reportingCompany.reportingAddress.postalCode : ''}</td>
</tr>
<tr class="border-row"><td colspan="2"></td></tr>
<tr><th class="rt-sub-heading" colspan="2"></th></tr>
<tr>
 <td>Request to receive FinCEN Identifier (FinCEN ID)</td>
 <td>${reportingCompany.requestToReceiveFinCenId !== null && reportingCompany.requestToReceiveFinCenId !== undefined ? (reportingCompany.requestToReceiveFinCenId === true ? 'Yes' : 'No') : ''}</td>
</tr>
<tr>
<td>Foreign pooled investment vehicle</td>
<td>${reportingCompany.foreignPooledInvestmentVehicle !== null && reportingCompany.foreignPooledInvestmentVehicle !== undefined ? (reportingCompany.foreignPooledInvestmentVehicle === true ? 'Yes' : 'No') : (reportingCompany.foreignPooledInvestmentVehicle2 !== null && reportingCompany.foreignPooledInvestmentVehicle2 !== undefined ? (reportingCompany.foreignPooledInvestmentVehicle2 === true ? 'Yes' : 'No') : '')}</td>
</tr>
<tr>
 <td>Date of Incorporation</td>
 <td>${reportingCompany.dateOfIncorporation ? reportingCompany.dateOfIncorporation : ''}</td>
</tr>
<tr>
 <td> Name of the other Tribe</td>
 <td>${reportingCompany.otherTribeFormation ? reportingCompany.otherTribeFormation : ''}</td>
</tr>
<tr>
 <td>State of first registration</td>
 <td>${reportingCompany.stateFirstRegistration ? reportingCompany.stateFirstRegistration : ''}</td>
</tr>
<tr>
 <td>Tribal jurisdiction of first registration</td>
 <td>${reportingCompany.tribalJurisdictionFirstRegistration ? reportingCompany.tribalJurisdictionFirstRegistration : ''}</td>
</tr>
<tr>
 <td> Name of the other Tribe First Registration</td>
 <td>${reportingCompany.otherTribeFirstRegistration ? reportingCompany.otherTribeFirstRegistration : ''}</td>
</tr>
</table>
		`;
		}
		return htmlContent;
	} catch (e) {
		return "";
	}
}

function loadCompanyApplicant(companyApplicant) {
	try {
		let htmlContent = '';
		if (companyApplicant.companyApplicantInfo && companyApplicant.companyApplicantInfo.length > 0) {
			companyApplicant.companyApplicantInfo.forEach((applicant) => {
				htmlContent += `
                <table class="box-bg-sec res-table-sec">
					<tr><th colspan="2" class="rt-heading">Company Applicant Details</th>
					<tr><th class="rt-sub-heading" colspan="2">FinCEN ID</th></tr>	
					<tr>
					<td>Existing reporting company (check if existing reporting company as of January 1, 2024)</td>
					<td>${companyApplicant.existingRepoCompany !== null && companyApplicant.existingRepoCompany !== undefined ? (companyApplicant.existingRepoCompany === true ? 'Yes' : 'No') : ''}</td>
					</tr>
					<tr>
					<td>FinCEN ID</td>
					<td>${applicant.finCenId ? applicant.finCenId : ''}</td>
					</tr>
					<tr class="border-row"><td colspan="2"></td></tr>
					<tr><th class="rt-sub-heading" colspan="2">Form of identification and issuing jurisdiction</th></tr>
					<tr>
					<td>Identifying document type</td>
					<td>${applicant.identificationDocuments && applicant.identificationDocuments.documentType ? applicant.identificationDocuments.documentType : ''}</td>
					</tr>
					<tr>
					<td>Identifying document name</td>
					<td><span class="file-name-display">${applicant.identificationDocuments && applicant.identificationDocuments.documentName ? applicant.identificationDocuments.documentName : ''}</span></td>
					</tr>
					<tr>
					<td>Identifying document number</td>
					<td>${applicant.identificationDocuments && applicant.identificationDocuments.documentNumber ? applicant.identificationDocuments.documentNumber : ''}</td>
					</tr>
					<tr>
					<td>Country/Jurisdiction</td>
					<td>${applicant.identificationDocuments && applicant.identificationDocuments.issuerCountry ? applicant.identificationDocuments.issuerCountry : ''}</td>
					</tr>
					<tr>
					<td>State</td>
					<td>${applicant.identificationDocuments && applicant.identificationDocuments.issuerState ? applicant.identificationDocuments.issuerState : ''}</td>
					</tr>
					<tr>
					<td>Local/Tribal</td>
					<td>${applicant.identificationDocuments && applicant.identificationDocuments.issuerLocalOrTribal ? applicant.identificationDocuments.issuerLocalOrTribal : ''}</td>
					</tr>
					<tr>
					<td>Other local/Tribal description</td>
					<td>${applicant.identificationDocuments && applicant.identificationDocuments.otherLocalDesc ? applicant.identificationDocuments.otherLocalDesc : ''}</td>
					</tr>
					<tr class="border-row"><td colspan="2"></td></tr>
					<tr><th class="rt-sub-heading" colspan="2">Legal Name &amp; Date of Birth</th></tr>
					<tr>
					<td>Individual's last name</td>
					<td>${applicant.individualsLastName ? applicant.individualsLastName : ''}</td>
					</tr>
					<tr>
					<td>First name</td>
					<td>${applicant.firstName ? applicant.firstName : ''}</td>
					</tr>
					<tr>
					<td>Middle name</td>
					<td>${applicant.middleName ? applicant.middleName : ''}</td>
					</tr>
					<tr>
					<td>Suffix</td>
					<td>${applicant.suffix ? applicant.suffix : ''}</td>
					</tr>
					<tr>
					<td>Date of birth</td>
					<td>${applicant.dateOfBirth ? applicant.dateOfBirth : ''}</td>
					</tr>
					<tr class="border-row"><td colspan="2"></td></tr>
					<tr><th class="rt-sub-heading" colspan="2">Legal Name &amp; Date of Birth</th></tr>
					<tr>
					<td>Address type</td>
					<td>${applicant.address && applicant.address.addressType ? applicant.address.addressType : ''}</td>
					</tr>
					<tr>
					<td>Address (number, street, and apt. or suite no.)</td>
					<td>${applicant.address && applicant.address.address ? applicant.address.address : ''}</td>
					</tr>
					<tr>
					<td>City</td>
					<td>${applicant.address && applicant.address.city ? applicant.address.city : ''}</td>
					</tr>
					<tr>
					<td>Country</td>
					<td>${applicant.address && applicant.address.country ? applicant.address.country : ''}</td>
					</tr>
					<tr>
					<td>State</td>
					<td>${applicant.address && applicant.address.state ? applicant.address.state : ''}</td>
					</tr>
					<tr>
					<td>Zip code</td>
					<td>${applicant.address && applicant.address.postalCode ? applicant.address.postalCode : ''}</td>
					</tr>
					</table>
				`;
			});
		} else {
			htmlContent += `
			           <table class="box-bg-sec res-table-sec">
						<tr>
						 <th colspan="2" class="rt-heading">Company Applicant(s) Information</th>
						</tr>
						<tr>
						 <td>Existing reporting company (as of Jan 1, 2024)</td>
						 <td>${companyApplicant.existingRepoCompany !== null && companyApplicant.existingRepoCompany !== undefined ? (companyApplicant.existingRepoCompany === true ? 'Yes' : 'No') : ''}</td>
						</tr>
						</table>`;
		}

		return htmlContent;

	} catch (error) {
		return "";
	}
}

function loadBeneficialOwner(beneficialOwners) {
	let htmlContent = '';
 
	beneficialOwners.forEach((beneficialOwner) => {
		try {
			htmlContent += `
				<table class="box-bg-sec res-table-sec">
					<tr><th colspan="2" class="rt-heading">Beneficial Owner Information</th></tr>
					<tr><th class="rt-sub-heading" colspan="2">FinCEN ID</th></tr>
					<tr>
					<td>Parent/Guardian information instead of minor child</td>
					<td>${beneficialOwner.isMinorChild !== null && beneficialOwner.isMinorChild !== undefined ? (beneficialOwner.isMinorChild === true ? 'Yes' : 'No') : ''}</td>
					</tr>
					<tr>
					<td>FinCEN ID</td>
					<td>${beneficialOwner.finCenId ? beneficialOwner.finCenId : ''}</td>
					</tr>
					<tr>
					<td>Exempt entity</td>
					<td>${beneficialOwner.exemptEntity !== null && beneficialOwner.exemptEntity !== undefined ? (beneficialOwner.exemptEntity === true ? 'Yes' : 'No') : ''}</td>
					</tr>
					<tr class="border-row"><td colspan="2"></td></tr>
					<tr><th class="rt-sub-heading" colspan="2">Form of identification and issuing jurisdiction</th></tr>
					<tr>
					<td>Identifying document type</td>
					<td>${beneficialOwner.identificationDocuments.documentType ? beneficialOwner.identificationDocuments.documentType : ''}</td>
					</tr>
					<tr>
					<td>Identifying document name</td>
					<td><span class="file-name-display">${beneficialOwner.identificationDocuments.documentName ? beneficialOwner.identificationDocuments.documentName : ''}</span></td>
					</tr>
					<tr>
					<td>Identifying document number</td>
					<td>${beneficialOwner.identificationDocuments.documentNumber ? beneficialOwner.identificationDocuments.documentNumber : ''}</td>
					</tr>
					<tr>
					<td>Country/Jurisdiction</td>
					<td>${beneficialOwner.identificationDocuments.issuerCountry ? beneficialOwner.identificationDocuments.issuerCountry : ''}</td>
					</tr>
					<tr>
					<td>State</td>
					<td>${beneficialOwner.identificationDocuments.issuerState ? beneficialOwner.identificationDocuments.issuerState : ''}</td>
					</tr>
					<tr>
					<td>Local/tribal</td>
					<td>${beneficialOwner.identificationDocuments.issuerLocalOrTribal ? beneficialOwner.identificationDocuments.issuerLocalOrTribal : ''}</td>
					</tr>
					<tr>
					<td>Other local/Tribal description</td>
					<td>${beneficialOwner.identificationDocuments.otherLocalDesc ? beneficialOwner.identificationDocuments.otherLocalDesc : ''}</td>
					</tr>
					<tr class="border-row"><td colspan="2"></td></tr>
					<tr><th class="rt-sub-heading" colspan="2">Legal Name &amp; Date of Birth</th></tr>
					<tr>
					<td>Individual's last name</td>
					<td>${beneficialOwner.legalName ? beneficialOwner.legalName : (beneficialOwner.flegalName ? beneficialOwner.flegalName : '')}</td>
					</tr>
					<tr>
					<td>First name</td>
					<td>${beneficialOwner.firstName ? beneficialOwner.firstName : (beneficialOwner.ffirstName ? beneficialOwner.ffirstName : '')}</td>
					</tr>
					<tr>
					<td>Middle name</td>
					<td>${beneficialOwner.middleName ? beneficialOwner.middleName : ''}</td>
					</tr>
					<tr>
					<td>Suffix</td>
					<td>${beneficialOwner.suffix ? beneficialOwner.suffix : ''}</td>
					</tr>
					<tr>
					<td>Date of birth</td>
					<td>${beneficialOwner.dateOfBirth ? beneficialOwner.dateOfBirth : ''}</td>
					</tr>
					<tr class="border-row"><td colspan="2"></td></tr>
					<tr><th class="rt-sub-heading" colspan="2">Current Address</th></tr>
					<tr>
					<td>Address type</td>
					<td>${beneficialOwner.address.addressType ? beneficialOwner.address.addressType : ''}</td>
					</tr>
					<tr>
					<td>Address (number, street, and apt. or suite no.)</td>
					<td>${beneficialOwner.address.address ? beneficialOwner.address.address : ''}</td>
					</tr>
					<tr>
					<td>City</td>
					<td>${beneficialOwner.address.city ? beneficialOwner.address.city : ''}</td>
					</tr>
					<tr>
					<td>Country/Jurisdiction</td>
					<td>${beneficialOwner.address.country ? beneficialOwner.address.country : ''}</td>
					</tr>
					<tr>
					<td>State</td>
					<td>${beneficialOwner.address.state ? beneficialOwner.address.state : ''}</td>
					</tr>
					<tr>
					<td>ZIP/Foreign postal code</td>
					<td>${beneficialOwner.address.postalCode ? beneficialOwner.address.postalCode : ''}</td>
					</tr>
				</table>
        `;
		} catch (e) {    }
	});

	return htmlContent;
}



$(document).ready(function() {
	let exemptSelected = false;
	var currentStep = $('#currentStep').val();
 	openStep(currentStep);
	$("#next1").click(function() {
		//showLoader();
		if ($("#FilingInfo").valid() && !exemptSelected) {
			$(this).addClass("loading").prop("disabled", true);
			setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
			callApi("#step2");

		} else if ($("#FilingInfo").valid() && exemptSelected) {
			$(this).addClass("loading").prop("disabled", true);
			setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
			callApi("#step5");
		} else {
			//hideLoader();
			// If the form is invalid, find the first invalid field and focus on it
			var firstInvalidField = $("#FilingInfo").find(":input").filter(function() {
				return $(this).hasClass("error");
			}).first();

			// Focus on the first invalid field if it exists
			if (firstInvalidField.length > 0) {
				firstInvalidField.focus();
			}
		}
		return false;
	});


	// Popup show logic
	$('#exemptRadio').on('change', function() {
		if ($(this).is(':checked')) {
			$('#exemptModal').modal('show');
		}
	});

	// Popup yes
	$('#exemptyes').on('click', function() {
		event.preventDefault();
		$('#exemptModal').modal('hide');
		$('.downcontent').show();
		exemptSelected = true;
	});

	//popup no
	$('#exemptno').on('click', function() {
		$('#exemptModal').modal('hide');
		$('#exemptRadio').prop('checked', false);
	});

	$("#Initial").click(function() {
		exemptSelected = false;
		/*$('#req-fincen-field-def').hide();*/
		/*$('#req-fincen-field').show();*/
		/*$('#request3yes').prop('checked', true);*/
		$('#request3yes').prop('checked', true).prop('disabled', true);
		$('#request3no').prop('checked', false).prop('disabled', true);
		//		$('#edit-button').hide();
	});

	$("#Update, #Correct").click(function() {
		exemptSelected = false;
		/*$('#req-fincen-field-def').show();
		$('#req-fincen-field').hide();*/
		/*$('#request3yes').prop('checked', false);*/
	});

	$("#prev1").click(function() {
		if ($("#FilingInfo").valid()) {
			$("#step2").removeClass("active");
			$("#step1").addClass("active");
			$("#Initial").focus();
		}
		event.preventDefault();
		loadAlternateNames();
		return false;
	});

	$("#next2").click(function() {
		//showLoader();
		$('.alternate-name').each(function() {
			$(this).rules("add", {
				required: false,
				minlength: 1,
				maxlength: 150,
				messages: {
					required: "Please enter a valid alternate name",
					minlength: "Your alternate name must consist of at least one character",
					maxlength: "Alternate name must be at most 150 characters long"
				}
			});
		});

		if ($("#ReportingCom").valid()) {
			$(this).addClass("loading").prop("disabled", true);
			setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
			var disabledFields = $("#ReportingCom").find(':disabled');
			disabledFields.each(function() {
				$(this).data('wasDisabled', true).prop('disabled', false);
			});
			var dateofincorporation=$('#dateOfIncorporation').val();
			  var enteredYear = new Date(dateofincorporation).getFullYear(); 
			  if (enteredYear < 2024) {
				document.getElementById("existyes").checked = true;
				foriegnArray.forEach(function(selector) {
	               $(selector).prop('disabled', true);
				   $('.radio-que-sec-para').show();
	           });
			  }else{
				if (foreignVehicleConfirmed) {
		           foriegnArray.forEach(function(selector) {
		               $(selector).prop('disabled', true);
					   $('.radio-que-sec-para').show();
		           });
		        }else {
					document.getElementById("existno").checked = true;
		              idArray.forEach(function(selector) {
		                  $(selector).prop('disabled', false);
		              });
		              $('.radio-que-sec-para').hide();
		          }
			}
			filingInfoId = $("#filingInfoId").val();
			document.getElementById("formRepoErrorText").style.display = 'none';
			$.ajax({
				url: '/reportingCompany',
				type: 'POST',
				data: $('#ReportingCom').serialize() + '&filingInfoId=' + filingInfoId,
				success: function(response) {
					if (response.success) {
						// Update the form fields with response data
						updateStep2FormFields(response.reportingCompany);
						$('#stateFormation').find('[data-disabled="true"]').attr('disabled', true);
						$("#step2").removeClass("active");
						$("#step3").addClass("active");
						var reportingCom = $("#ReportingCom");
						if (reportingCom.length > 0) {
							var firstField = reportingCom.find(":radio").first();
							if (firstField.length > 0) {

								// Optionally scroll to the first field (if needed)
								$('html, body').animate({

									scrollTop: firstField.offset().top + 400 // Adjust the offset as needed
								}, 500);
							} else {
								console.error("No radio buttons found inside #ReportingCom.");
							}
						} else {
							console.error("#ReportingCom element not found.");
						}

						//hideLoader();
					} else {
						//hideLoader();
						// Display an error message
						alert('Form submission failed: ' + response.message);
					}
				},
				error: function(xhr, status, error) {
					// Hide the loader
					//hideLoader();
					// Display an error message
					alert('Form submission failed: ' + error);
				}

			});


			disabledFields.each(function() {
				// Restore the 'disabled' attribute
				if ($(this).data('wasDisabled')) {
					$(this).prop('disabled', true).removeData('wasDisabled');
				}
			});

		} else {
			//hideLoader();
			// If the form is invalid, find the first invalid field and focus on it
			document.getElementById("formRepoErrorText").style.display = 'block';
			var firstInvalidField = $("#ReportingCom").find(":input").filter(function() {
				return $(this).hasClass("error");
			}).first();

			// Focus on the first invalid field if it exists
			if (firstInvalidField.length > 0) {
				firstInvalidField.focus();
			}
		}
		return false;
	});


	$("#prev2").click(function() {
		if ($("#ReportingCom").valid()) {
			$("#step3").removeClass("active");
			$("#step2").addClass("active");
			$("#request3yes").focus();
		}
		return false;
	});
	$("#next3").click(function() {
		ResetComAppFieldsValidations();
		//showLoader();
		// Add custom method for max file size validation
		/*
		   $.validator.addMethod("fileSize", function (value, element, param) {
			   // Check if a file is selected
			   if (element.files.length > 0) {
				   // Get the size of the file in bytes (element.files[0].size) and compare it with the limit (param)
				   return element.files[0].size <= param;
			   }
			   return true; // No file selected, so validation passes
		   }, "File size must not exceed 4MB.");*/
		/*
			
		
		//added fincen iD in stepform code
		$('.com-idi	').each(function() {
			
			$(this).rules("add", {
				required: true,
				accept: "application/pdf,image/jpeg,image/png",
				maxlength: 250,
				messages: {
					required: "Identifying document image is required",
					accept: "Images and PDF only",
					maxlength: "250 characters entry maximum"
				}
			});
		});
		*/
		$('.comfincin-id').each(function() {
			var index = $(this).data('index'); // Correct syntax for accessing data attributes
			let fincenValue = $(this).val().trim();
	        if (fincenValue.length === 0) {
				var comFileInput = $('[name="companyApplicantInfo['+index+'].identificationDocuments.document"]');
				var comFileNameDisplay=$('.comFileNameDisplay'+index);
				if (comFileNameDisplay.is(':visible')) {
					comFileInput.rules("remove", "required");
				} else {
					comFileInput.rules("add", {
						required: true,
						accept: "application/pdf,image/jpeg,image/png",
						maxlength: 250,
						messages: {
							required: "Identifying document image is required",
							accept: "Images and PDF only",
							maxlength: "250 characters entry maximum"
						}
					});
				}
				$('[name="companyApplicantInfo['+index+'].identificationDocuments.documentType"]').rules("add", {
					required: true,
					messages: {
						required: "Must be a valid document type",
					}
				});
				$('[name="companyApplicantInfo['+index+'].identificationDocuments.documentNumber"]').rules("add", {
					required: true,
					pattern: /^[a-zA-Z0-9]+$/,
					minlength: 1,
					maxlength: 25,
					messages: {
						required: "Identifying document number is required",
						pattern: "Only alphanumeric characters are allowed",
						minlength: "Your identifying document number must consist of at least one character",
						maxlength: "25 numeric/alphanumeric characters maximum"
					}
				});
				$('[name="companyApplicantInfo['+index+'].identificationDocuments.issuerCountry"]').rules("add", {
					required: true,
					messages: {
						required: "Please select the country/jurisdiction"
					}
				});
				$('[name="companyApplicantInfo['+index+'].identificationDocuments.issuerState"]').rules("add", {
					required: function(element) {
						return $('[name="companyApplicantInfo[' + index + '].identificationDocuments.issuerCountry"]').val() === "US" &&$('[name="companyApplicantInfo[' + index + '].identificationDocuments.issuerLocalOrTribal"]').val() === "";
					},
					messages: {
						required: "Please select the state"
					}
				});
				$('[name="companyApplicantInfo['+index+'].identificationDocuments.issuerLocalOrTribal"]').rules("add", {
					required: function(element) {
						return $('[name="companyApplicantInfo[' + index + '].identificationDocuments.issuerCountry"]').val() === "US" &&$('[name="companyApplicantInfo[' + index + '].identificationDocuments.issuerState"]').val() === "";
					},
					messages: {
						required: "Please select the local/tribal jurisdiction"
					}
				});
				$('[name="companyApplicantInfo['+index+'].identificationDocuments.otherLocalDesc"]').rules("add", {
					required: function(element) {
						return $('[name="companyApplicantInfo[' + index + '].identificationDocuments.issuerLocalOrTribal"]').val() === "Other";
					},
					pattern: /^[a-zA-Z0-9\s]+$/,
					minlength: 0,
					maxlength: 150,
					messages: {
						required: "Please enter the description",
						pattern: "Only alphanumeric characters are allowed",
						minlength: "Your description must consist of at least one character",
						maxlength: "150 characters maximum"
					}
				});
				$('[name="companyApplicantInfo['+index+'].suffix"]').rules("add", {
					minlength: 1,
					maxlength: 50,
					pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
					messages: {
						minlength: "You must enter minimum one character",
						maxlength: "50 characters maximum",
						pattern: "Only alphabets are allowed"
					}
				});
				$('[name="companyApplicantInfo['+index+'].firstName"]').rules("add", {
					required: true,
					pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
					minlength: 1,
					maxlength: 50,
					messages: {
						required: "First name is required",
						pattern: "Only alphanumeric characters are allowed",
						minlength: "Your first name must consist of at least one character",
						maxlength: "50 characters maximum"
					}
				});
				$('[name="companyApplicantInfo['+index+'].middleName"]').rules("add", {
					minlength: 1,
					maxlength: 50,
					pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
					messages: {
						minlength: "Your middle name must be at least one character long",
						maxlength: "50 characters maximum",
						pattern: "Only alphabets are allowed"
					}
				});
				$('[name="companyApplicantInfo['+index+'].individualsLastName"]').rules("add", {
					required: true,
					pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
					maxlength: 150,
					messages: {
						required: "Last name is required",
						pattern: "Last name is invalid. It contains one or more special characters that are not supported",
						maxlength: "Last name must be at most 150 characters"
					}
				});
				$.validator.addMethod("minAge", function(value, element, min) {
				    // Parse the birth date
				    let birthDate = new Date(value);
				    let today = new Date();
				    
				    // Calculate age
				    let age = today.getFullYear() - birthDate.getFullYear();
				    let monthDiff = today.getMonth() - birthDate.getMonth();
				    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
				        age--;
				    }
				    
				    // Return true if age is 18 or older, false otherwise
				    return age >= min;
				}, "You must be at least 18 years old");

				$('[name="companyApplicantInfo['+index+'].dateOfBirth"]').rules("add", {
					required: true,
			        minAge: 18, // Validate that the age is at least 18
			        messages: {
			            required: "Date of birth is required",
			            minAge: "You must be at least 18 years old" // Message for under-18 validation
			        }
				});
				$('[name="companyApplicantInfo['+index+'].address.addressType"]').rules("add", {
					required: true,
					messages: {
						required: "Please select the address type",
					}
				});
				$('[name="companyApplicantInfo['+index+'].address.address"]').rules("add", {
					required: true,
					pattern: /^[a-zA-Z0-9\s-,.]+$/,
					minlength: 1,
					maxlength: 100,
					messages: {
						required: "Address (number, street, and apt. or suite no.) is required",
						pattern: "Please enter only letters, numbers, hyphen, comma and spaces",
						minlength: "Your address must consist of at least one character",
						maxlength: "100 characters maximum"
					}
				});
				$('[name="companyApplicantInfo['+index+'].address.city"]').rules("add", {
					required: true,
					pattern: /^[a-zA-Z0-9\s]+$/,
					minlength: 1,
					maxlength: 50,
					messages: {
						required: "City is required",
						pattern: "Only alphanumeric characters are allowed",
						minlength: "Your city must consist of at least one character",
						maxlength: "50 characters maximum"
					}
				});
				$('[name="companyApplicantInfo['+index+'].address.country"]').rules("add", {
					required: true,
					messages: {
						required: "Please select the country/jurisdiction"
					}
				});
				$('[name="companyApplicantInfo['+index+'].address.state"]').rules("add", {
					required: true,
					messages: {
						required: "Please select the state"
					}
				});
				$('[name="companyApplicantInfo['+index+'].address.postalCode"]').rules("add", {
					required: true,
					pattern: /^(?!12345)(?!.*(\d)\1{4})(?!.*123456789)\d{5}(?:\d{4})?$/,
					messages: {
						required: "ZIP/Foreign postal code is required",
						pattern: "Zip Code must be either 5 or 9 numeric characters, cannot be a consecutive string of the same number or 123456789."
					}
				});
			}
		});
		if ($("#CompanyAppinfo").valid()) {
			$(this).addClass("loading").prop("disabled", true);
			document.getElementById("formComErrorText").style.display = 'none';
			setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
			callstep3api(); // Proceed with the API call
 		} else {
			// Find and focus on the first invalid field dynamically
			document.getElementById("formComErrorText").style.display = 'block';
			var firstInvalidField = $("#CompanyAppinfo").find(":input").filter(function() {
				return !$(this).valid(); // Dynamically check if the field is invalid
			}).first();
			if (firstInvalidField.length > 0) {
				firstInvalidField.focus(); // Focus on the first invalid field
			}
		}
		return false;
	});
	//Ended
	$("#prev3").click(function() {
		if ($("#CompanyAppinfo").valid()) {
			$("#step4").removeClass("active");
			$("#step3").addClass("active");
			$("#existyes").focus();
		}
		return false;
	});

	$("#next4").click(function() {
		ResetBenAppFieldsValidations();
		
		//showLoader();
		// added benfincen ID in stepform 
		$('.ben-exemptYes').each(function(){
			var index = $(this).data('index'); // Correct syntax for accessing data attributes
 			let exemptValue = $(this).val();
			if(exemptValue==='true' && $(this).is(':checked')){
				$('[name="beneficialOwner['+index+'].legalName"]').rules("add", {
						required: true,
						pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
						maxlength: 150,
						messages: {
							required: "Last name is required",
							pattern: "Last name is invalid. It contains one or more special characters that are not supported",
							maxlength: "Last name must be at most 150 characters"
						}
					});
			}else{
				//$('.ben-fincenid').each(function(){
					let fincenValue = $('[name="beneficialOwner['+index+'].finCenId"]').val().trim();
			        if (fincenValue.length === 0) {
						$('[name="beneficialOwner['+index+'].identificationDocuments.documentType"]').rules("add", {
							required: true,
							messages: {
								required: "Must be a valid document type",
							}
						});
						
						$('[name="beneficialOwner['+index+'].benficialEmail"]').rules("add", {
							email: true,
							maxlength: 500,
							messages: {
								minlength: "Please enter a valid email",
								maxlength: "The maximum length for an email address is 500 characters",
							}
						});
						/*	
							// Code to validation of Choose File
							$.validator.addMethod("filesize", function(value, element, param) {
								if (element.files.length > 0) {
									return this.optional(element) || (element.files[0].size <= param);
								}
								return true;
							}, "File size must not exceed 4 MB.");
							*/
						/*
								
						//ended*/
						$('[name="beneficialOwner['+index+'].identificationDocuments.documentNumber"]').rules("add", {
							required: true,
							minlength: 1,
							maxlength: 25,
							pattern: /^[a-zA-Z0-9]+$/,
							messages: {
								required: "Please enter a value",
								pattern: "Only alphanumeric characters are allowed",
								maxlength: "Your Identifying document number must be 25 characters"
							}
						});
						var benFileInput = $('[name="beneficialOwner[' + index + '].identificationDocuments.document"]');
						var benFileNameDisplay=$('.benFileNameDisplay'+index);
//							if (benFileInput.is(':visible')) {
								if (benFileNameDisplay.is(':visible')) {
						            benFileInput.rules("remove", "required");
						        } else {
							    benFileInput.rules("add", {
							        required: true,
							        accept: "application/pdf,image/jpeg,image/png",
							        maxlength: 250,
							        messages: {
							            required: "Identifying document image is required",
							            accept: "Images and PDF only",
							            maxlength: "250 characters maximum"
							        }
							    });
							}
//							} else {
//							    benFileInput.rules("remove", "required");
//							}
						$('[name="beneficialOwner['+index+'].identificationDocuments.issuerCountry"]').rules("add", {
							required: true,
							messages: {
								required: "Country is required"
							}
						});
						$('[name="beneficialOwner['+index+'].identificationDocuments.issuerState"]').rules("add", {
							required: function(element) {
								return $(".ben-counjuri").val() === "US" && $(".ben-localtrib").val() === "";
							},
							messages: {
								required: "State is required"
							}
						});
						$('[name="beneficialOwner['+index+'].identificationDocuments.issuerLocalOrTribal"]').rules("add", {
							required: function(element) {
								return $(".ben-counjuri").val() === "US" && $(".ben-state").val() === "";
							},
							messages: {
								required: "Local/Tribal  is required"
							}
						});
						$('[name="beneficialOwner['+index+'].identificationDocuments.otherLocalDesc"]').rules("add", {
							required: function(element) {
								return $(".ben-localtrib").val() === "Other";
							},
							pattern: /^[a-zA-Z0-9\s]+$/,
							minlength: 0,
							maxlength: 150,
							messages: {
								required: "Please provide a description for other local/tribal",
								minlength: "Your description must consist of at least one character",
								maxlength: "150 characters maximum",
								pattern: "Only alphabets are allowed"
							}
						});
						$('[name="beneficialOwner['+index+'].suffix"]').rules("add", {
							minlength: 1,
							maxlength: 50,
							pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
							messages: {
								minlength: "You must enter at least one character",
								maxlength: "50 characters maximum",
								pattern: "Only alphabets are allowed"
							}
						});
						$('[name="beneficialOwner['+index+'].firstName"]').rules("add", {
							required: true,
							minlength: 1,
							maxlength: 50,
							pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
							messages: {
								required: "First name is required",
								minlength: "Your first name must be at least one character long",
								maxlength: "50 characters maximum",
								pattern: "Only alphabets are allowed"
							}
						});
						$('[name="beneficialOwner['+index+'].middleName"]').rules("add", {
							minlength: 1,
							maxlength: 50,
							pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
							messages: {
								minlength: "Your middle name must be at least one character long",
								maxlength: "50 characters maximum",
								pattern: "Only alphabets are allowed"
							}
						});
						$('[name="beneficialOwner['+index+'].legalName"]').rules("add", {
							required: true,
							pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
							maxlength: 150,
							messages: {
								required: "Last name is required",
								pattern: "Last name is invalid. It contains one or more special characters that are not supported",
								maxlength: "Last name must be at most 150 characters"
							}
						});
						// Custom method to validate minimum age (18 years)
							$.validator.addMethod("minAge", function(value, element, min) {
							    // Parse the birth date
							    let birthDate = new Date(value);
							    let today = new Date();
							    
							    // Calculate age
							    let age = today.getFullYear() - birthDate.getFullYear();
							    let monthDiff = today.getMonth() - birthDate.getMonth();
							    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
							        age--;
							    }
							    
							    // Return true if age is 18 or older, false otherwise
							    return age >= min;
							}, "You must be at least 18 years old");
						$('[name="beneficialOwner['+index+'].dateOfBirth"]').rules("add", {
					        required: true,
					        minAge: 18, // Validate that the age is at least 18
					        messages: {
					            required: "Date of birth is required",
					            minAge: "You must be at least 18 years old" // Message for under-18 validation
					        }
						});
						$('[name="beneficialOwner['+index+'].address.addressType"]').rules("add", {
							required: true,
							messages: {
								required: "Please select an option",
							}
						});
						$('[name="beneficialOwner['+index+'].address.address"]').rules("add", {
							required: true,
							minlength: 1,
							maxlength: 100,
							pattern: /^[a-zA-Z0-9\s,.-]+$/,
							messages: {
								required: "Address (number, street, and apt. or suite no.) is required",
								minlength: "You must enter minimum one character",
								maxlength: "100 characters entry maximum",
								pattern: "Only Alphanumerics are allowed"
							}
						});
						$('[name="beneficialOwner['+index+'].address.city"]').rules("add", {
							required: true,
							minlength: 1,
							maxlength: 50,
							pattern: /^[A-Za-z.\s]+$/,
							messages: {
								required: "City is required",
								minlength: "You must enter at least one character",
								maxlength: "50 characters entry maximum",
								pattern: "Only alphabets are allowed"
							}
						});
						$('[name="beneficialOwner['+index+'].address.country"]').rules("add", {
							required: true,
							messages: {
								required: "Country is required"
							}
						});
						$('[name="beneficialOwner['+index+'].address.state"]').rules("add", {
							required: true,
							messages: {
								required: "State is required"
							}
						});
						$('[name="beneficialOwner['+index+'].address.postalCode"]').rules("add", {
							required: true,
							pattern: /^(?!12345)(?!.*(\d)\1{4})(?!.*123456789)\d{5}(?:\d{4})?$/,
							messages: {
								required: "ZIP/Foreign postal code is required",
								pattern: "Zip Code must be either 5 or 9 numeric characters, cannot be a consecutive string of the same number or 123456789."
							}
						});
					}else{
						$('[name="beneficialOwner['+index+'].legalName"]').rules("remove", "required");
						$('[name="beneficialOwner['+index+'].flegalName"]').rules("add", {
							required: true,
							pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
							maxlength: 150,
							messages: {
								required: "Last name is required",
								pattern: "Last name is invalid. It contains one or more special characters that are not supported",
								maxlength: "Last name must be at most 150 characters"
							}
						});
						$('[name="beneficialOwner['+index+'].ffirstName"]').rules("add", {
							required: true,
							pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
							maxlength: 150,
							messages: {
								required: "First name is required",
								pattern: "First name is invalid. It contains one or more special characters that are not supported",
								maxlength: "First name must be at most 150 characters"
							}
						});
					}
				//});
			}
		});
		$('.file-name-display').on('DOMSubtreeModified', function() {
		    $('.ben-exemptYes').each(function() {
		        var index = $(this).data('index');
		        var benFileInput = $('[name="beneficialOwner[' + index + '].identificationDocuments.document"]');
				var benFileNameDisplay=$('.benFileNameDisplay'+index);
		        if (benFileNameDisplay.is(':visible')) {
		            benFileInput.rules("remove", "required");
		        } else {
		            benFileInput.rules("add", {
		                required: true,
		                accept: "application/pdf,image/jpeg,image/png",
		                maxlength: 250,
		                messages: {
		                    required: "Identifying document image is required",
		                    accept: "Images and PDF only",
		                    maxlength: "250 characters maximum"
		                }
		            });
		        }
		    });
		});
		if ($("#BeneficialForm").valid()) {
			$(this).addClass("loading").prop("disabled", true);
			setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
			var disabledFields = $("#BeneficialForm").find(':disabled');
			disabledFields.each(function() {
				$(this).data('wasDisabled', true).prop('disabled', false);
			});
			document.getElementById("formBenErrorText").style.display = 'none';
			filingInfoId = $("#filingInfoId").val();
			$.ajax({
				url: '/beneficialOwner',
				type: 'POST',
				data: $('#BeneficialForm').serialize() + '&filingInfoId=' + filingInfoId,
				success: function(response) {

					if (response.success) {
						// Update the form fields with response data
						//updateStep2FormFields(response.reportingCompany);
						if (!$('.checkBeneficialEmail').is(':checked')) {
						    $("#step4").removeClass("active");
						    $("#step5").addClass("active");
						}else{
							$('#BeneEmailSuccessModel').modal('show');
						}
						var reportingCom = $("#BeneficialForm");
						if (reportingCom.length > 0) {
							var firstField = reportingCom.find("#addBeneficial").first();
							if (firstField.length > 0) {
								// Focus on the first input field
								// firstField.focus();

								// Optionally scroll to the first field (if needed)
								$('html, body').animate({
									scrollTop: firstField.offset().top + 400 // Adjust the offset as needed
								}, 500);
							} else {
								console.error("No radio buttons found inside #BeneficialForm.");
							}
						} else {
							console.error("#BeneficialForm element not found.");
						}
						//hideLoader();
					} else {
						//hideLoader();
						// Display an error message
						alert('Form submission failed: ' + response.message);
					}
				},
				error: function(xhr, status, error) {
					// Hide the loader
					//hideLoader();
					// Display an error message
					alert('Form submission failed: ' + error);
				}
			});
			disabledFields.each(function() {
				// Restore the 'disabled' attribute
				if ($(this).data('wasDisabled')) {
					$(this).prop('disabled', true).removeData('wasDisabled');
				}
			});
		} else {
			// Dynamically find the first invalid field in #BeneficialForm
			document.getElementById("formBenErrorText").style.display = 'block';
			var firstInvalidField = $("#BeneficialForm").find(":input").filter(function() {
				return !$(this).valid(); // Check if the field is invalid
			}).first();

			// Focus on the first invalid field if it exists
			if (firstInvalidField.length > 0) {
				firstInvalidField.focus(); // Set focus on the invalid field
			}
		}

		//first field enabled for top
		return false;
	});

	$("#prev4").click(function() {
		if ($("#BeneficialForm").valid()) {
			$("#step5").removeClass("active");

			// Check the condition before activating step 1
			if ($("#FilingInfo").valid() && exemptSelected) {
				$("#step1").addClass("active");
				$("#Initial").focus();
			} else {
				$("#step4").addClass("active");
				$("#parentyes").focus();
			}
		}
		return false;
	});

	$("#next5").click(function() {
 
		$('.sub-email').each(function() {
			$(this).rules("add", {
				required: true,
				email: true,
				maxlength: 500,
				messages: {
					required: " Please enter an email",
					minlength: "Please enter a valid email",
					maxlength: "The maximum length for an email address is 500 characters",
				}
			});
		});
		$('.sub-confimemail').each(function() {
			$(this).rules("add", {
				required: true,
				email: true,
				maxlength: 500,
				equalTo: "#subemail",
				messages: {
					required: " Please enter an email",
					minlength: "Please enter a valid email",
					maxlength: "The maximum length for an email address is 500 characters",
					equalTo: "Please enter the same email"
				}
			});
		});
		$('.subfname').each(function() {
			$(this).rules("add", {
				required: true,
				minlength: 1,
				maxlength: 50,
				pattern: /^[A-Za-z.\s]+$/,
				messages: {
					required: "Please enter your first name",
					minlength: "Your first name must be at least one character long",
					maxlength: "Your first name must be less than 50 characters long",
					pattern: "Only alphabets are allowed"
				}
			});
		});
		$('.sublname').each(function() {
			$(this).rules("add", {
				required: true,
				minlength: 1,
				maxlength: 50,
				pattern: /^[A-Za-z.\s]+$/,
				messages: {
					required: "Please enter your last name",
					minlength: "Your last name must be at least one character long",
					maxlength: "Your last name must be less than 50 characters long",
					pattern: "Only alphabets are allowed"
				}
			});
		});
		var disabledFields = $("#SubmitForm").find(':disabled');
		disabledFields.each(function() {
			$(this).data('wasDisabled', true).prop('disabled', false);
		});
 		if ($("#SubmitForm").valid()) {
			$(this).addClass("loading").prop("disabled", true);
			setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
			//showLoader();
			filingInfoId = $("#filingInfoId").val();
			$.ajax({
				url: '/submitterDetails',
				type: 'POST',
				data: $('#SubmitForm').serialize() + '&filingInfoId=' + filingInfoId,
				success: function(response) {
					if (response.success) {
						$('#previewContainer').empty();

						// Load Filing Info
						document.getElementById('previewContainer').innerHTML =
							loadSubmitterDetailsPreview(response.submitterDetails) +
							loadFilingInfoPreview(response.filingInfo) +
							loadReportingCompany(response.reportingCompany) +
							loadCompanyApplicant(response.companyApplicant) +
							loadBeneficialOwner(response.beneficialOwner);

						$("#step5").removeClass("active");
						$("#step6").addClass("active");
						var reportingCom = $("#SubmitForm");
						if (reportingCom.length > 0) {
							var firstField = reportingCom.find(":input").first();
							if (firstField.length > 0) {
								// Focus on the first input field
								//firstField.focus();

								// Optionally scroll to the first field (if needed)
								$('html, body').animate({
									scrollTop: firstField.offset().top + 400 // Adjust the offset as needed
								}, 500);
							} else {
								console.error("No radio buttons found inside #SubmitForm.");
							}
						} else {
							console.error("#SubmitForm element not found.");
						}
						//hideLoader();
					} else {
						//hideLoader();
						alert('Form submission failed: ' + response.message);
					}
				},
				error: function(xhr, status, error) {
					// Hide the loader
					//hideLoader();
					// Display an error message
					alert('Form submission failed: ' + error);
				}
			});

			disabledFields.each(function() {
				// Restore the 'disabled' attribute
				if ($(this).data('wasDisabled')) {
					$(this).prop('disabled', true).removeData('wasDisabled');
				}
			});
			// Logic for handling invalid form input should be outside of the AJAX call
			if (!$("#SubmitForm").valid()) {
				// If the form is invalid, find the first invalid field and focus on it
				var firstInvalidField = $("#BeneficialForm").find(":input").filter(function() {
					return $(this).hasClass("error");
				}).first();

				// Focus on the first invalid field if it exists
				if (firstInvalidField.length > 0) {
					firstInvalidField.focus();
				}
			}
			//first field enabled for top
			return false;
		}
	});

	$("#prev5").click(function() {
		if ($("#SubmitForm").valid()) {
			$("#step6").removeClass("active");
			$("#step5").addClass("active");
			$("#subemail").focus();
		}
		return false;
	});

	$("#next6").click(function() {
 		//   $("#step6").removeClass("active");
		//   $("#step7").addClass("active");
	});

	$("#prev6").click(function() {
		$("#step7").removeClass("active");
		$("#step6").addClass("active");
	});


	$("#ReviewStepForm").click(function() {
 
		var disabledFields = $("#SubmitForm").find(':disabled');
		disabledFields.each(function() {
			$(this).data('wasDisabled', true).prop('disabled', false);
		});
		//showLoader();
		$(this).addClass("loading").prop("disabled", true);
		setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
		filingInfoId = $("#filingInfoId").val();
		$.ajax({
			url: '/submitterDetails',
			type: 'POST',
			data: $('#SubmitForm').serialize() + '&filingInfoId=' + filingInfoId,
			success: function(response) {
				//hideLoader();
				if (response.success) {
					// Redirect to the hyperlink with the filingInfoId
					window.location.href = '/stepformpreview/' + filingInfoId;
				} else {
					alert('Form submission failed: ' + response.message);
				}
			},
			error: function(xhr, status, error) {
				//hideLoader();
				alert('Form submission failed: ' + error);
			}
		});
		disabledFields.each(function() {
			// Restore the 'disabled' attribute
			if ($(this).data('wasDisabled')) {
				$(this).prop('disabled', true).removeData('wasDisabled');
			}
		});
		return false;
	});
	$("#multiStepForm").submit(function(e) {
		e.preventDefault();
		alert("Form submitted!");
		// Here you can add your form submission logic
	});
});

function showLoader() {
	$("#loader, #next1, #prev1, #next2").addClass("activate");
}

function hideLoader() {
	$("#loader, #next1, #prev1, #next2").removeClass("activate");
}
//-----------------------------------------------------------------------------------------------------------------------
//Stepform logic given by Ananth and some modifications done by sandhya & Yashwanth Ended

$(document).ready(function() {
	// Get the current date
	var today = new Date();
	var day = ("0" + today.getDate()).slice(-2);
	var month = ("0" + (today.getMonth() + 1)).slice(-2);
	var year = today.getFullYear();
	var currentDate = year + "-" + month + "-" + day;

	// Set the value of the date input field to the current date
	$('#datePrepared, #dateOfIncorporation').val(currentDate);

	$('#datePrepared, #dateOfIncorporation').attr('max', currentDate);

	// Ensure the input is disabled
	//  $('#filingdp').prop('disabled', true);
});

$("#saveBenficial").click(function() {
	ResetBenAppFieldsValidations();
	$('.ben-exemptYes').each(function(){
		let exemptValue = $(this).val();
		if(exemptValue==='true' && $(this).is(':checked')){		
			$('.ben-lname').rules("add", {
				required: true,
				pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
				maxlength: 150,
				messages: {
					required: "Last name is required",
					pattern: "Last name is invalid. It contains one or more special characters that are not supported",
					maxlength: "Last name must be at most 150 characters"
				}
			});
		}else{
			let fincenValue = $('.ben-fincenid').val().trim();
	        if (fincenValue.length === 0) {
		
				$('.ben-idt').each(function() {
					$(this).rules("add", {
						required: true,
						messages: {
							required: "Must be a valid document type",
						}
					});
				});
				$('ben-email').each(function() {
					$(this).rules("add", {
						required: true,
						email: true,
						maxlength: 500,
						messages: {
							required: " Please enter an email",
							minlength: "Please enter a valid email",
							maxlength: "The maximum length for an email address is 500 characters",
						}
					});
				});
				$('.ben-idn').each(function() {
					$(this).rules("add", {
						required: true,
						minlength: 1,
						maxlength: 25,
						pattern: /^[a-zA-Z0-9]+$/,
						messages: {
							required: "Please enter a value",
							pattern: "Only alphanumeric characters are allowed",
							maxlength: "Your Identifying document number must be 25 characters"
						}
					});
				});
				$('.ben-file-input').each(function() {
					$(this).rules("add", {
						required: true,
						accept: "application/pdf,image/jpeg,image/png",
						maxlength: 250,
						messages: {
							required: "Identifying document image is required",
							accept: "Images and PDF only",
							maxlength: "250 characters maximum"
						}
					});
				});
				$('.ben-counjuri').each(function() {
					$(this).rules("add", {
						required: true,
						messages: {
							required: "Country is required"
						}
					});
				});
				$('.ben-state').each(function() {
					$(this).rules("add", {
						required: function(element) {
							return $(".ben-counjuri").val() === "US" && $(".ben-localtrib").val() === "";
						},
						messages: {
							required: "State is required"
						}
					});
				});
				$('.ben-localtrib').each(function() {
					$(this).rules("add", {
						required: function(element) {
							return $(".ben-counjuri").val() === "US" && $(".ben-state").val() === "";
						},
						messages: {
							required: "Local/Tribal  is required"
						}
					});
				});
				$('.ben-otherlt').each(function() {
					$(this).rules("add", {
						required: function(element) {
							return $(".ben-localtrib").val() === "Other";
						},
						pattern: /^[a-zA-Z0-9\s]+$/,
						minlength: 0,
						maxlength: 150,
						messages: {
							required: "Please provide a description for other local/tribal",
							minlength: "Your description must consist of at least one character",
							maxlength: "150 characters maximum",
							pattern: "Only alphabets are allowed"
						}
					});
				});
				$('.ben-suffix').each(function() {
					$(this).rules("add", {
						minlength: 1,
						maxlength: 50,
						pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
						messages: {
							minlength: "You must enter at least one character",
							maxlength: "50 characters maximum",
							pattern: "Only alphabets are allowed"
						}
					});
				});
				$('.ben-fn').each(function() {
					$(this).rules("add", {
						required: true,
						minlength: 1,
						maxlength: 50,
						pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
						messages: {
							required: "First name is required",
							minlength: "Your first name must be at least one character long",
							maxlength: "50 characters maximum",
							pattern: "Only alphabets are allowed"
						}
					});
				});
				$('.ben-midname	').each(function() {
					$(this).rules("add", {
						minlength: 1,
						maxlength: 50,
						pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
						messages: {
							minlength: "Your middle name must be at least one character long",
							maxlength: "50 characters maximum",
							pattern: "Only alphabets are allowed"
						}
					});
				});
				$('.ben-lname').each(function() {
					$(this).rules("add", {
						required: true,
						pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
						maxlength: 150,
						messages: {
							required: "Last name is required",
							pattern: "Last name is invalid. It contains one or more special characters that are not supported",
							maxlength: "Last name must be at most 150 characters"
						}
					});
				});
				$('.ben-dob').each(function() {
					$(this).rules("add", {
						required: true,
				       	messages: {
				            	required: "Date of birth is required",
				        }
					});
				});
				$('.ben-addtype').each(function() {
					$(this).rules("add", {
						required: true,
						messages: {
							required: "Please select an option",
						}
					});
				});
				$('.ben-address').each(function() {
					$(this).rules("add", {
						required: true,
						minlength: 1,
						maxlength: 100,
						pattern: /^[a-zA-Z0-9\s,.-]+$/,
						messages: {
							required: "Address (number, street, and apt. or suite no.) is required",
							minlength: "You must enter minimum one character",
							maxlength: "100 characters entry maximum",
							pattern: "Only Alphanumerics are allowed"
						}
					});
				});
				$('.ben-city').each(function() {
					$(this).rules("add", {
						required: true,
						minlength: 1,
						maxlength: 50,
						pattern: /^[A-Za-z.\s]+$/,
						messages: {
							required: "City is required",
							minlength: "You must enter at least one character",
							maxlength: "50 characters entry maximum",
							pattern: "Only alphabets are allowed"
						}
					});
				});
				$('.ben-countryjuri').each(function() {
					$(this).rules("add", {
						required: true,
						messages: {
							required: "Country is required"
						}
					});
				});
				$('.benstate').each(function() {
					$(this).rules("add", {
						required: true,
						messages: {
							required: "State is required"
						}
					});
				});
				$('.ben-zipcode').each(function() {
					$(this).rules("add", {
						required: true,
						pattern: /^(?!12345)(?!.*(\d)\1{4})(?!.*123456789)\d{5}(?:\d{4})?$/,
						messages: {
							required: "ZIP/Foreign postal code is required",
							pattern: "Zip Code must be either 5 or 9 numeric characters, cannot be a consecutive string of the same number or 123456789."
						}
					});
				});
			}else{
				$('.ben-lname').each(function() {
					$(this).rules("remove", "required");
				});
				$('.ben-fincen-lname').each(function() {
					$(this).rules("add", {
						required: true,
						pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
						maxlength: 150,
						messages: {
							required: "Last name is required",
							pattern: "Last name is invalid. It contains one or more special characters that are not supported",
							maxlength: "Last name must be at most 150 characters"
						}
					});
				});
				$('.ben-fincen-fn')	.each(function() {
					$(this).rules("add", {
						required: true,
						pattern: /^[a-zA-Z0-9 !@$%^&_\-+'/?~,.\s]+$/,
						maxlength: 150,
						messages: {
							required: "First name is required",
							pattern: "First name is invalid. It contains one or more special characters that are not supported",
							maxlength: "First name must be at most 150 characters"
						}
					});
				});
			}
		}
	});
	if ($("#BeneficialForm").valid()) {
		
	const urlParams = new URLSearchParams(window.location.search);
	const trackingid = urlParams.get('trackingid');
	$(".verificationSuccess").modal('hide');
	$(".beneFormSubmissionSuccess").modal('hide');
	$(this).addClass("loading").prop("disabled", true);
	setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
	var disabledFields = $("#BeneficialForm").find(':disabled');
	disabledFields.each(function() {
		$(this).data('wasDisabled', true).prop('disabled', false);
	});
	document.getElementById("formBenEmailErrorText").style.display = 'none';
	filingInfoId = $("#filingInfoId").val();
	$.ajax({
		url: '/beneficialOwnerSaveTracking',
		type: 'POST',
		data: $('#BeneficialForm').serialize() + '&filingInfoId=' + filingInfoId+'&trackingid='+trackingid,
		success: function(response) {

			if (response.success) {
//				alert('Your response recorded successfully');
			$(".beneFormSubmissionSuccess").modal('show');
				//hideLoader();
			} else {
				//hideLoader();
				// Display an error message
				alert('Form submission failed: ' + response.message);
			}
		},
		error: function(xhr, status, error) {
			// Hide the loader
			//hideLoader();
			// Display an error message
			alert('Form submission failed: ' + error);
		}
	});
	disabledFields.each(function() {
		// Restore the 'disabled' attribute
		if ($(this).data('wasDisabled')) {
			$(this).prop('disabled', true).removeData('wasDisabled');
		}
	});

}else {
		// Dynamically find the first invalid field in #BeneficialForm
		document.getElementById("formBenEmailErrorText").style.display = 'block';
}
});
function setFieldValue(selector) {
	$(selector).prop('disabled', true);
}
function resetFieldValue(selector) {
	$(selector).prop('disabled', false);
}
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}
$(document).on('blur', '.ben-email', function() {
    var index = $(this).data('index');
    var $checkBox = $('#checkBenEmail' + index);
    
    $checkBox.prop('disabled', true);
    
    const emailValue = $(this).val().trim();
    
	if (emailValue .length !== 0 && !isValidEmail(emailValue)||emailValue==="") {
		$('#checkBenEmail'+index).prop('disabled', true);
    } else {
		$('#checkBenEmail'+index).prop('disabled', false);
    }
});
$(document).on('change', ".checkBeneficialEmail", function() {
	const index = $(this).data('index');
 		var docnumId = 'beneficialOwner[' + index + '].identificationDocuments.documentNumber';
		var fnameId = 'beneficialOwner[' + index + '].firstName';
		var countryId = 'beneficialOwner[' + index + '].identificationDocuments.issuerCountry';
		var lastnameId = 'beneficialOwner[' + index + '].legalName';
		var dobId = 'beneficialOwner[' + index + '].dateOfBirth';
		var addressId = 'beneficialOwner[' + index + '].address.address';
		var addressCountryId = 'beneficialOwner[' + index + '].address.country';
//		var issuerCountryId = 'beneficialOwner[' + index + '].identificationDocuments.issuerCountry';
		var stateId = 'beneficialOwner[' + index + '].address.state';
		var issuerStateId = 'beneficialOwner[' + index + '].identificationDocuments.issuerState';
		var middleNameId = 'beneficialOwner[' + index + '].middleName';
		var issuerLocalOrTribalId = 'beneficialOwner[' + index + '].identificationDocuments.issuerLocalOrTribal';
		var otherLocalDescId = 'beneficialOwner[' + index + '].identificationDocuments.otherLocalDesc';
		var suffixId = 'beneficialOwner[' + index + '].suffix';
		var postalCodeId = 'beneficialOwner[' + index + '].address.postalCode';
		var cityId = 'beneficialOwner[' + index + '].address.city';
		var isMinorId='beneficialOwner[' + index + '].isMinorChild';//radio
		var finCenIdId='beneficialOwner[' + index + '].finCenId';
		var exemptEntityId='beneficialOwner[' + index + '].exemptEntity';//radio
		var documentTypeId='beneficialOwner[' + index + '].identificationDocuments.documentType';//select
		var documentId='beneficialOwner[' + index + '].identificationDocuments.document';//upload
		var addressTypeId='beneficialOwner[' + index + '].address.addressType';//radio
		var checkBenEmailId = 'checkBenEmail' + index; // Construct the ID dynamically
		var checkboxElement = $('#' + checkBenEmailId);
		if (checkboxElement.is(':checked') && checkboxElement.val() === 'beneficialEmailChecked') {
			document.getElementById('beneficialDraft').style.display = 'block';
		    document.getElementById('beneficialProceed').style.display = 'none';
			setFieldValue('input[name="' + docnumId + '"]');
			setFieldValue('input[name="' + fnameId + '"]');
			setFieldValue('select[name*="' + countryId + '"]');
			setFieldValue('input[name="' + lastnameId + '"]');
			setFieldValue('input[name="' + dobId + '"]');
			setFieldValue('input[name="' + addressId + '"]');
			setFieldValue('select[name*="' + addressCountryId + '"]');
//			setFieldValue('select[name*="' + issuerCountryId + '"]');
			setFieldValue('select[name*="' + stateId + '"]');
			setFieldValue('select[name*="' + issuerStateId + '"]');
			setFieldValue('input[name="' + middleNameId + '"]');
			setFieldValue('select[name*="' + issuerLocalOrTribalId + '"]');
			setFieldValue('input[name="' + otherLocalDescId + '"]');
			setFieldValue('input[name="' + suffixId + '"]');
			setFieldValue('input[name="' + cityId + '"]');
			setFieldValue('input[name="' + postalCodeId + '"]');
			setFieldValue('select[name*="' + documentTypeId + '"]');
			setFieldValue('input[name="' + isMinorId + '"]');
			setFieldValue('input[name="' + exemptEntityId + '"]');
			setFieldValue('input[name="' + documentId + '"]');
			setFieldValue('input[name="' + addressTypeId + '"]');
			setFieldValue('input[name="' + finCenIdId + '"]');
		}
		else{
			document.getElementById('beneficialDraft').style.display = 'none';
		    document.getElementById('beneficialProceed').style.display = 'block';
			resetFieldValue('input[name="' + docnumId + '"]');
			resetFieldValue('input[name="' + fnameId + '"]');
//			resetFieldValue('select[name*="' + countryId + '"]');
			resetFieldValue('input[name="' + lastnameId + '"]');
			resetFieldValue('input[name="' + dobId + '"]');
			resetFieldValue('input[name="' + addressId + '"]');
			resetFieldValue('select[name*="' + addressCountryId + '"]');
//			resetFieldValue('select[name*="' + issuerCountryId + '"]');
			resetFieldValue('select[name*="' + stateId + '"]');
//			resetFieldValue('select[name*="' + issuerStateId + '"]');
			resetFieldValue('input[name="' + middleNameId + '"]');
			resetFieldValue('input[name="' + suffixId + '"]');
			resetFieldValue('input[name="' + cityId + '"]');
			resetFieldValue('input[name="' + postalCodeId + '"]');
			resetFieldValue('select[name*="' + documentTypeId + '"]');
			resetFieldValue('input[name="' + isMinorId + '"]');
			resetFieldValue('input[name="' + exemptEntityId + '"]');
			resetFieldValue('input[name="' + documentId + '"]');
			resetFieldValue('input[name="' + addressTypeId + '"]');
			resetFieldValue('input[name="' + finCenIdId + '"]');
		}
});
$(document).on('click', ".boiremail-button", function() {
//$(".boiremail-button").click(function() {
	$(this).addClass("loading").prop("disabled", true);
	setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 3000);
	var disabledFields = $("#BeneficialForm").find(':disabled');
	disabledFields.each(function() {
		$(this).data('wasDisabled', true).prop('disabled', false);
	});
	filingInfoId = $("#filingInfoId").val();
	
	$.ajax({
		url: '/beneficialOwnerSendMail',
		type: 'POST',
		data: $('#BeneficialForm').serialize() + '&filingInfoId=' + filingInfoId,
		success: function(response) {

			if (response.success) {
//				alert('Your response recorded successfully');
				//hideLoader();
				
			} else {
				//hideLoader();
				// Display an error message
				alert('Form submission failed: ' + response.message);
			}
		},
		error: function(xhr, status, error) {
			// Hide the loader
			//hideLoader();
			// Display an error message
			alert('Form submission failed: ' + error);
		}
	});
	disabledFields.each(function() {
		// Restore the 'disabled' attribute
		if ($(this).data('wasDisabled')) {
			$(this).prop('disabled', true).removeData('wasDisabled');
		}
	});


});
//-----------------------------------------------------------------------------------------------------------------------
//Stepform1 datepicker code Started Ended

//-----------------------------------------------------------------------------------------------------------------------
//Country/Jurisdiction select code For 4th form started

$(document).ready(function() {

	// Mapping of country abbreviations to full names
	const specialCountries = {
		"AS": "American Samoa",
		"GU": "Guam",
		"MH": "Marshall Islands",
		"FM": "Micronesia, Federated States",
		"MP": "Northern Mariana Islands",
		"PW": "Palau",
		"PR": "Puerto Rico",
		"VI": "U.S. Virgin Islands"
	};

	const initialStateOptions = $("[name^='beneficialOwner'][name$='.issuerState']").html();

	$(document).on("change", "[name^='beneficialOwner'][name$='.issuerCountry']", function() {
		const nameAttr = $(this).attr('name');
		const index = nameAttr.match(/\[([\d]+)\]/)[1];

		const selectedCountry = $(this).val();
		const stateSelector = `[name='beneficialOwner[${index}].identificationDocuments.issuerState']`;
		const localTribalSelector = `[name='beneficialOwner[${index}].identificationDocuments.issuerLocalOrTribal']`;
		const otherLocalDescSelector = `[name='beneficialOwner[${index}].identificationDocuments.otherLocalDesc']`;

		if (selectedCountry === "US") {
			$(stateSelector).html(initialStateOptions).prop("disabled", false).val("");
			//$(localTribalSelector).prop("disabled", false).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		} else if (specialCountries.hasOwnProperty(selectedCountry)) {
			$(stateSelector).html(`<option value="${selectedCountry}">${specialCountries[selectedCountry]}</option>`).prop("disabled", true).val(selectedCountry);
			$(localTribalSelector).prop("disabled", true).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		} else {
			$(stateSelector).html(initialStateOptions).prop("disabled", true).val("");
			$(localTribalSelector).prop("disabled", true).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		}
	});

	$(document).on("change", "[name^='beneficialOwner'][name$='.issuerState']", function() {
		const nameAttr = $(this).attr('name');
		const index = nameAttr.match(/\[([\d]+)\]/)[1];

		const localTribalSelector = `[name='beneficialOwner[${index}].identificationDocuments.issuerLocalOrTribal']`;
		const otherLocalDescSelector = `[name='beneficialOwner[${index}].identificationDocuments.otherLocalDesc']`;

		if ($(this).val() !== "") {
			$(localTribalSelector).prop("disabled", true).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		} else {
			$(localTribalSelector).prop("disabled", false);
		}
	});

	$(document).on("change", "[name^='beneficialOwner'][name$='.issuerLocalOrTribal']", function() {
		const nameAttr = $(this).attr('name');
		const index = nameAttr.match(/\[([\d]+)\]/)[1];

		const stateSelector = `[name='beneficialOwner[${index}].identificationDocuments.issuerState']`;
		const otherLocalDescSelector = `[name='beneficialOwner[${index}].identificationDocuments.otherLocalDesc']`;

		if ($(this).val() !== "") {
			$(stateSelector).prop("disabled", true).val("");
			if ($(this).val() === "Other") {
				$(otherLocalDescSelector).prop("disabled", false);
			} else {
				$(otherLocalDescSelector).prop("disabled", true).val("");
			}
		} else {
			$(stateSelector).prop("disabled", false);
			$(otherLocalDescSelector).prop("disabled", true).val("");
		}
	});

});

//-----------------------------------------------------------------------------------------------------------------------
//Country/Jurisdiction select code For 4th form started Ended

//-----------------------------------------------------------------------------------------------------------------------
//Country/Jurisdiction select code For 3rd form started Started

$(document).ready(function() {

	// Script for major functionality
	const specialCountries = {
		"AS": "American Samoa",
		"GU": "Guam",
		"MH": "Marshall Islands",
		"FM": "Micronesia, Federated States",
		"MP": "Northern Mariana Islands",
		"PW": "Palau",
		"PR": "Puerto Rico",
		"VI": "U.S. Virgin Islands"
	};

	const initialStateOptions = $("[name^='companyApplicantInfo'][name$='.issuerState']").html();

	$(document).on("change", "[name^='companyApplicantInfo'][name$='.issuerCountry']", function() {
		const nameAttr = $(this).attr('name');
		const index = nameAttr.match(/\[([\d]+)\]/)[1];

		const selectedCountry = $(this).val();
		const stateSelector = `[name='companyApplicantInfo[${index}].identificationDocuments.issuerState']`;
		const localTribalSelector = `[name='companyApplicantInfo[${index}].identificationDocuments.issuerLocalOrTribal']`;
		const otherLocalDescSelector = `[name='companyApplicantInfo[${index}].identificationDocuments.otherLocalDesc']`;

		if (selectedCountry === "US") {
			$(stateSelector).html(initialStateOptions).prop("disabled", false).val("");
			//$(localTribalSelector).prop("disabled", false).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		} else if (specialCountries.hasOwnProperty(selectedCountry)) {
			$(stateSelector).html(`<option value="${selectedCountry}">${specialCountries[selectedCountry]}</option>`).prop("disabled", true).val(selectedCountry);
			$(localTribalSelector).prop("disabled", true).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		} else {
			$(stateSelector).html(initialStateOptions).prop("disabled", true).val("");
			$(localTribalSelector).prop("disabled", true).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		}
	});

	$(document).on("change", "[name^='companyApplicantInfo'][name$='.issuerState']", function() {
		const nameAttr = $(this).attr('name');
		const index = nameAttr.match(/\[([\d]+)\]/)[1];

		const localTribalSelector = `[name='companyApplicantInfo[${index}].identificationDocuments.issuerLocalOrTribal']`;
		const otherLocalDescSelector = `[name='companyApplicantInfo[${index}].identificationDocuments.otherLocalDesc']`;

		if ($(this).val() !== "") {
			$(localTribalSelector).prop("disabled", true).val("");
			$(otherLocalDescSelector).prop("disabled", true).val("");
		} else {
			$(localTribalSelector).prop("disabled", false);
		}
	});

	$(document).on("change", "[name^='companyApplicantInfo'][name$='.issuerLocalOrTribal']", function() {
		const nameAttr = $(this).attr('name');
		const index = nameAttr.match(/\[([\d]+)\]/)[1];

		const stateSelector = `[name='companyApplicantInfo[${index}].identificationDocuments.issuerState']`;
		const otherLocalDescSelector = `[name='companyApplicantInfo[${index}].identificationDocuments.otherLocalDesc']`;

		if ($(this).val() !== "") {
			$(stateSelector).prop("disabled", true).val("");
			if ($(this).val() === "Other") {
				$(otherLocalDescSelector).prop("disabled", false);
			} else {
				$(otherLocalDescSelector).prop("disabled", true).val("");
			}
		} else {
			$(stateSelector).prop("disabled", false);
			$(otherLocalDescSelector).prop("disabled", true).val("");
		}
	});

});

//-----------------------------------------------------------------------------------------------------------------------
//Country/Jurisdiction select code For 3rd form started Ended

//-----------------------------------------------------------------------------------------------------------------------
// form1 radio buttons code Start

$(document).ready(function() {
	$('input[name="filingType"]').on('change', function() {
		var downContent = $('.downcontent');
		if ($(this).val() === "correct" || $(this).val() === "update") {
			downContent.show();
		} else {
			downContent.hide();
		}
	});

	$('#taxIdNum').prop('disabled', true);
	$('#countryOrJurisdiction').prop('disabled', true);

	$('#taxIdType').on('change', function() {
		var taxIdNum = $('#taxIdNum');
		var countryOrJurisdiction = $('#countryOrJurisdiction');
		var selectedValue = $(this).val();

		// Reset the fields to disabled
		taxIdNum.prop('disabled', true).val('');
		countryOrJurisdiction.prop('disabled', true).val('');

		// Enable fields based on the selected value
		if (selectedValue === "9") {
			taxIdNum.prop('disabled', false);
			countryOrJurisdiction.prop('disabled', false);
		} else if (selectedValue === "2" || selectedValue === "1") {
			taxIdNum.prop('disabled', false);
		}
	});

	//-----------------------------------------------------------------------------------------------------------------------
	// form1 radio buttons code end


	//reporting company fields

	$('#taxIdentificationNumber').prop('disabled', true);
	$('#countryOrJurisdictionRep').prop('disabled', true);

	$('#taxIdentificationType').on('change', function() {
		var taxIdentificationNumber = $('#taxIdentificationNumber');
		var countryOrJurisdictionRep = $('#countryOrJurisdictionRep');
		var selectedValue = $(this).val();

		// Reset the fields to disabled
		taxIdentificationNumber.prop('disabled', true).val('');
		countryOrJurisdictionRep.prop('disabled', true).val('');

		// Enable fields based on the selected value
		if (selectedValue === "9") {
			taxIdentificationNumber.prop('disabled', false);
			countryOrJurisdictionRep.prop('disabled', false);
		} else if (selectedValue === "2" || selectedValue === "1") {
			taxIdentificationNumber.prop('disabled', false);
		}
	});
});

//-----------------------------------------------------------------------------------------------------------------------
// form1 radio buttons code end

//-----------------------------------------------------------------------------------------------------------------------
// Alternate name code for second form start

$(document).ready(function() {
	// Initialize alternateNameIndex based on the number of existing fields
	let alternateNameIndex = $('#alternate-names-container').children().length + 1;

	function addAlternateNameField(index) {
		const labelSuffix = index === 1 ? '' : `.${index - 1}`;
		const newField = `
	    <div class="form-rows" id="alternate-name-${index}">
	    <label class="main-label" for="repaltername-${index}">5${labelSuffix}. Alternate name (e.g. trade name, DBA)</label>
	    <div class="form-fields d-flex">
	    <div class="normal-field col-sm-8">
	    <input type="text" id="alternateName[${index}].name" name="alternateName[${index}].name" placeholder="Enter Alternate name" class="alternate-name form-field form-control" />
	    </div>
	    <div class="col-sm-4">
	    <button class="remove-alternate-name btn btn-primary bg-btn" data-index="${index}">Remove</button>
	    </div>
	    </div>
	    </div>`;
		$('#alternate-names-container').append(newField);
		toggleRemoveButtons();
	}

	function toggleRemoveButtons() {
		const totalFields = $('#alternate-names-container').children().length;
		$('.remove-alternate-name').toggleClass('d-none', totalFields === 1);
	}

	function updateFieldLabels() {
		$('#alternate-names-container .form-rows').each(function(index) {
			const newIndex = index + 1;
			const labelSuffix = newIndex === 1 ? '' : `.${newIndex - 1}`;
			$(this).attr('id', `alternate-name-${newIndex}`);
			$(this).find('label').attr('for', `repaltername-${newIndex}`).text(`5${labelSuffix}. Alternate name (e.g. trade name, DBA)`);
			$(this).find('input').attr('id', `alternateName[${newIndex}].name`).attr('name', `alternateName[${newIndex}].name`);
			$(this).find('.remove-alternate-name').data('index', newIndex);
		});
		alternateNameIndex = $('#alternate-names-container').children().length + 1;
	}

	$('#add-alternate-name').click(function(e) {
		e.preventDefault();
		addAlternateNameField(alternateNameIndex++);
	});

	$('#alternate-names-container').on('click', '.remove-alternate-name', function(e) {
		e.preventDefault();
		if ($('#alternate-names-container').children().length > 1) {
			$(`#alternate-name-${$(this).data('index')}`).remove();
			updateFieldLabels();
			toggleRemoveButtons();
		} else {
			// Reset the label to 6. when only the default field remains
			$(this).closest('.form-rows').find('label').text('5. Alternate name (e.g. trade name, DBA)');
		}
	});

	//-----------------------------------------------------------------------------------------------------------------------
	// Alternate name code for second form start

	let applicantCounter = 1;

	$('#addcom').on('click', function(event) {
		// Prevent the default form submission behavior
		event.preventDefault();
		$(`#collapse${applicantCounter}`).removeClass('show').collapse('hide');

		applicantCounter++;
		// Collapse previous applicant
		$('#collapse0').removeClass('show');

		// Create new applicant section
		const newApplicant = `
		        <div class="accordion-item">
 <h2 class="accordion-header">
 <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${applicantCounter}" aria-expanded="true" aria-controls="collapse${applicantCounter}">
Company Applicant
 </button>
</h2>
<div class="sf-btn-bar no-margin"><button type="button" class="remove-applicant bg-btn no-margin" data-applicant="${applicantCounter}">Remove Applicant</button></div>
<div id="collapse${applicantCounter}" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
<div class="accordion-body">
<!-- New Applicant Form Content -->
<!-- Company applicant Start -->
<div class="accordion def-acc-sec">
 <!-- Company applicant FinCEN ID Start -->
  <div class="accordion-item box-bg-sec">
   <div class="accordion-header row">
       <div class="dah-left col-md-8"><h2>Company applicant FinCEN ID</h2></div>
       <div class="dah-right col-md-4">
        <span><a class="hover-modal-btn" href="#boirNeedHelp7"><img src="/images/help-icon.svg"></a></span>
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCAconditionOne${applicantCounter}" aria-expanded="true" aria-controls="collapseCAconditionOne${applicantCounter}"></button>
       </div>
    </div>
    <div id="collapseCAconditionOne${applicantCounter}" class="accordion-collapse collapse show">
        <div class="accordion-body">
         <div class="ab-top-para"><p>If the company applicant has a FinCEN ID, please enter it below to skip the remaining fields.</p>
         <div class="col-sm-6 mt-15" title="">
            <div class="form-fields">
               <input type="text" data-index="${applicantCounter}" id="companyApplicantInfo[${applicantCounter}].finCenId" name="companyApplicantInfo[${applicantCounter}].finCenId" onblur="disableFields1(this,${applicantCounter})" value="" placeholder="Enter FinCEN ID" class="comfincin-id form-field" />
            </div>
         </div> 
        </div>
      </div>
    </div>
  </div>
 <!-- Company applicant FinCEN ID End -->

  <!-- Rest Of the Company Appicant Fields on Condition Based Start -->
  <div id="existrepotcom${applicantCounter}">
   <div class="accordion def-acc-sec">

   	<!-- Form of identification and issuing jurisdiction Start -->
   	<div class="accordion-item box-bg-sec">
   	 <div class="accordion-header row">
         <div class="dah-left col-md-8"><h2>Form of identification and issuing jurisdiction</h2></div>
         <div class="dah-right col-md-4">
          <span><a class="hover-modal-btn" href="#boirNeedHelp8"><img src="/images/help-icon.svg"></a></span>
          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCAconditionTwo${applicantCounter}" aria-expanded="true" aria-controls="collapseCAconditionTwo${applicantCounter}"></button>
         </div>
        </div>
        <div id="collapseCAconditionTwo${applicantCounter}" class="accordion-collapse collapse show">
          <div class="accordion-body">
           <div class="ab-top-para"><p>Please provide the company applicant's identification details and the jurisdiction that issued it. For a faster experience, you can use DocAI to quickly fill out your details by uploading your ID document.</p></div>

           <div class="row two-fields">
           	
           	<div class="col-sm-6 mt-15">
				<label class="main-label" for="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentType">Identifying document type</label>
				<div class="form-fields">
				  <select class="com-idt form-field" id="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentType" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentType">
				   <option value="">Select an ID type</option>
				   <option value="37">State issued driver's license</option>
				   <option value="38">State/local/tribe-issued ID</option>
				   <option value="39">U.S. passport</option>
				   <option value="40">Foreign passport</option>
				  </select>
				</div>
			</div>
			<div class="col-sm-6 mt-15" title="">
				
				<div class="fileinput">
					<label class="main-label" for="companyApplicantInfo[${applicantCounter}].identificationDocuments.document">Identifying document image <em>*</em></label>
					<input type="file" class="com-idi com-file-input fileInput"  id="companyApplicantInfo[${applicantCounter}].identificationDocuments.document" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.document"/>
					<input type="hidden"  id="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentPath" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentPath"/>
					<input type="hidden"  id="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentName" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentName"/>
					<span id="file-name-display" class="comFileNameDisplay${applicantCounter}" style="display:none;"></span>
					<button class="blue-btn btn btn-four" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;" type="button" id="edit-button">Edit</button>
															  
				</div>
				<div id="progressWrapper" style="display:none;">										
					<progress id="progressBar" value="0" max="100"></progress>
					<span id="progressText">0%</span>
				</div>
				<div class="auto-data-extract-modal modal fade" id="auto-data-extract-popup[${applicantCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
					<div class="modal-dialog modal-fullscreen modal-dialog-centered">
					<div class="container">
					<div class="user-data-form step-form-modal modal-content">
					<button type="button" class="btn-close" data-bs-dismiss="modal" id="auto-data-extract-manual" aria-label="Close"></button>
					<div class="modal-cont">
					<div class="boddy">
					<h3 class="text-left">Automated Data Extraction</h3>
					<p class="text-left">Would you like the system to automatically extract the necessary fields from the Identifying Document you uploaded using Doc AI?</p>
					<p class="text-left">This will help populate the relevant fields quickly and accurately. </p>
					<a href="#" class="btn-four" id="auto-data-extract-proceed">Proceed with Doc AI </a>
					<a href="#" class="btn-four"  data-bs-dismiss="modal" id="auto-data-extract-manual">I’ll Input Manually</a><br>
					</div>
					</div>
					</div>
					</div>
					</div>
				</div>
				<div class="extract-info-modal modal fade" id="extract-info-popup[${applicantCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
					<div class="modal-dialog modal-fullscreen modal-dialog-centered">
					<div class="container">
					<div class="user-data-form step-form-modal modal-content" style="max-width:; padding: -10px;">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					<div class="modal-cont">
					<div class="boddy">
					<h3 style="text-align: left;">Extracting Information...</h3>
					<p style="text-align: left;font-size: 15px;">We’re automatically extracting the necessary details from your uploaded document. This won’t take long!</p>
					<p style="  text-align: left;font-size:11px;">Please do not refresh the page during this process. </p>
					<img class="spinner1" src="images/loading.png">
					</div>
					<div class="modal-btns step-mod-btns" style="margin-top:-20px">
					</div>
					</div>
					</div>
					</div>
					</div>
				</div>
				<div class="foreignvehicle-modal modal fade" id="extract-info-complete[${applicantCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
					<div class="modal-dialog modal-fullscreen modal-dialog-centered">
					<div class="container">
					<div class="user-data-form step-form-modal modal-content w-600">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					<div class="modal-cont">
					<div class="boddy">
					<h3 class="modal-head">Auto-population Complete</h3>
					<p class="text-left">
					<b>Your document has been submitted successfully.</b>
					</p>
					<p class="text-left">The fields in this form have been auto-populated using the document you uploaded. Please review the information and make any necessary changes before proceeding </p>
					<a href="#" data-bs-dismiss="modal" class="btn-four mt-20">GOT IT</a>
					<br>
					</div>
					<div class="modal-btns step-mod-btns" style="margin-top:-20px">
					</div>
					</div>
					</div>
					</div>
					</div>
				</div>
				<div class="filelengthmodal modal fade" id="fileSizeTooLargeModal[${applicantCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
					<div class="modal-dialog modal-fullscreen modal-dialog-centered">
					<div class="container">
					<div class="user-data-form step-form-modal modal-content">
					<div class="modal-cont">
					<h2>Oops! File Too Large</h2>
					<p>It looks like your file is too big. Please upload a file that's 4MB or less.</p>
					<div class="modal-btns step-mod-btns">
					<button type="button" class="blue-btn" data-bs-dismiss="modal" id="fileSizeTooSmallOk">Okay</button>
					</div>
					</div>
					</div>
					</div>
					</div>
				</div>
					
			</div>
			<div class="col-sm-6 mt-15" title="">
				<label class="main-label" for="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentNumber">Identifying document number <em>*</em></label>
				<div class="form-fields">
					<input type="text" id="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentNumber" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.documentNumber" value="" placeholder="Enter Identification number" class="com-idn form-field" />
				</div>
			</div>
			<div class="col-sm-6 mt-15" title="">
			    <label class="main-label" for="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerCountry">Country/Jurisdiction <em>*</em></label>
			    <div class="form-fields">
			        <select class="com-counjuri form-field" id="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerCountry" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerCountry">
			            <option value="">Select a Country/Jurisdiction</option>
						<option value="US">United States of America</option>
			            <option value="AS">American Samoa</option>
			            <option value="GU">Guam</option>
			            <option value="MH">Marshall Islands</option>
			            <option value="FM">Micronesia, Federated States</option>
			            <option value="MP">Northern Mariana Islands</option>
			            <option value="PW">Palau</option>
			            <option value="PR">Puerto Rico</option>
			            <option value="VI">U.S. Virgin Islands</option>
						<option value="AF">Afghanistan</option>
						 <option value="AX">Åland Islands</option>
						 <option value="AL">Albania</option>
						 <option value="DZ">Algeria</option>
						 <option value="AD">Andorra</option>
						 <option value="AO">Angola</option>
						 <option value="AI">Anguilla</option>
						 <option value="AQ">Antarctica</option>
						 <option value="AG">Antigua And Barbuda</option>
						 <option value="AR">Argentina</option>
						 <option value="AM">Armenia</option>
						 <option value="AW">Aruba</option>
						 <option value="AU">Australia</option>
						 <option value="AT">Austria</option>
						 <option value="AZ">Azerbaijan</option>
						 <option value="BS">Bahamas</option>
						 <option value="BH">Bahrain</option>
						 <option value="BD">Bangladesh</option>
						 <option value="BB">Barbados</option>
						 <option value="BY">Belarus</option>
						 <option value="BE">Belgium</option>
						 <option value="BZ">Belize</option>
						 <option value="BJ">Benin</option>
						 <option value="BM">Bermuda</option>
						 <option value="BT">Bhutan</option>
						 <option value="BO">Bolivia, Plurinational State Of</option>
						 <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
						 <option value="BA">Bosnia And Herzegovina</option>
						 <option value="BW">Botswana</option>
						 <option value="BV">Bouvet Island</option>
						 <option value="BR">Brazil</option>
						 <option value="IO">British Indian Ocean Territory</option>
						 <option value="BN">Brunei Darussalam</option>
						 <option value="BG">Bulgaria</option>
						 <option value="BF">Burkina Faso</option>
						 <option value="BI">Burundi</option>
						 <option value="KH">Cambodia</option>
						 <option value="CM">Cameroon</option>
						 <option value="CA">Canada</option>
						 <option value="CV">Cape Verde</option>
						 <option value="KY">Cayman Islands</option>
						 <option value="CF">Central African Republic</option>
						 <option value="TD">Chad</option>
						 <option value="CL">Chile</option>
						 <option value="CN">China</option>
						 <option value="CX">Christmas Island</option>
						 <option value="CC">Cocos (Keeling) Islands</option>
						 <option value="CO">Colombia</option>
						 <option value="KM">Comoros</option>
						 <option value="CG">Congo</option>
						 <option value="CD">Congo, The Democratic Republic Of The</option>
						 <option value="CK">Cook Islands</option>
						 <option value="CR">Costa Rica</option>
						 <option value="CI">Côte D'ivoire</option>
						 <option value="HR">Croatia</option>
						 <option value="CU">Cuba</option>
						 <option value="CW">Curaçao</option>
						 <option value="CY">Cyprus</option>
						 <option value="CZ">Czech Republic</option>
						 <option value="DK">Denmark</option>
						 <option value="DJ">Djibouti</option>
						 <option value="DM">Dominica</option>
						 <option value="DO">Dominican Republic</option>
						 <option value="EC">Ecuador</option>
						 <option value="EG">Egypt</option>
						 <option value="SV">El Salvador</option>
						 <option value="GQ">Equatorial Guinea</option>
						 <option value="ER">Eritrea</option>
						 <option value="EE">Estonia</option>
						 <option value="ET">Ethiopia</option>
						 <option value="FK">Falkland Islands (Malvinas)</option>
						 <option value="FO">Faroe Islands</option>
						 <option value="FJ">Fiji</option>
						 <option value="FI">Finland</option>
						 <option value="FR">France</option>
						 <option value="GF">French Guiana</option>
						 <option value="PF">French Polynesia</option>
						 <option value="TF">French Southern Territories</option>
						 <option value="GA">Gabon</option>
						 <option value="GM">Gambia</option>
						 <option value="GE">Georgia</option>
						 <option value="DE">Germany</option>
						 <option value="GH">Ghana</option>
						 <option value="GI">Gibraltar</option>
						 <option value="GR">Greece</option>
						 <option value="GL">Greenland</option>
						 <option value="GD">Grenada</option>
						 <option value="GP">Guadeloupe</option>
						 <option value="GT">Guatemala</option>
						 <option value="GG">Guernsey</option>
						 <option value="GN">Guinea</option>
						 <option value="GW">Guinea-bissau</option>
						 <option value="GY">Guyana</option>
						 <option value="HT">Haiti</option>
						 <option value="HM">Heard Island And Mcdonald Islands</option>
						 <option value="VA">Holy See (Vatican City State)</option>
						 <option value="HN">Honduras</option>
						 <option value="HK">Hong Kong</option>
						 <option value="HU">Hungary</option>
						 <option value="IS">Iceland</option>
						 <option value="IN">India</option>
						 <option value="ID">Indonesia</option>
						 <option value="IR">Iran, Islamic Republic Of</option>
						 <option value="IQ">Iraq</option>
						 <option value="IE">Ireland</option>
						 <option value="IM">Isle Of Man</option>
						 <option value="IL">Israel</option>
						 <option value="IT">Italy</option>
						 <option value="JM">Jamaica</option>
						 <option value="JP">Japan</option>
						 <option value="JE">Jersey</option>
						 <option value="JO">Jordan</option>
						 <option value="KZ">Kazakhstan</option>
						 <option value="KE">Kenya</option>
						 <option value="KI">Kiribati</option>
						 <option value="KP">Korea, Democratic People's Republic Of</option>
						 <option value="KR">Korea, Republic Of</option>
						 <option value="KW">Kuwait</option>
						 <option value="KG">Kyrgyzstan</option>
						 <option value="LA">Lao People's Democratic Republic</option>
						 <option value="LV">Latvia</option>
						 <option value="LB">Lebanon</option>
						 <option value="LS">Lesotho</option>
						 <option value="LR">Liberia</option>
						 <option value="LY">Libya</option>
						 <option value="LI">Liechtenstein</option>
						 <option value="LT">Lithuania</option>
						 <option value="LU">Luxembourg</option>
						 <option value="MO">Macao</option>
						 <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
						 <option value="MG">Madagascar</option>
						 <option value="MW">Malawi</option>
						 <option value="MY">Malaysia</option>
						 <option value="MV">Maldives</option>
						 <option value="ML">Mali</option>
						 <option value="MT">Malta</option>
						 <option value="MQ">Martinique</option>
						 <option value="MR">Mauritania</option>
						 <option value="MU">Mauritius</option>
						 <option value="YT">Mayotte</option>
						 <option value="MX">Mexico</option>
						 <option value="MD">Moldova, Republic Of</option>
						 <option value="MC">Monaco</option>
						 <option value="MN">Mongolia</option>
						 <option value="ME">Montenegro</option>
						 <option value="MS">Montserrat</option>
						 <option value="MA">Morocco</option>
						 <option value="MZ">Mozambique</option>
						 <option value="MM">Myanmar</option>
						 <option value="NA">Namibia</option>
						 <option value="NR">Nauru</option>
						 <option value="NP">Nepal</option>
						 <option value="NL">Netherlands</option>
						 <option value="NC">New Caledonia</option>
						 <option value="NZ">New Zealand</option>
						 <option value="NI">Nicaragua</option>
						 <option value="NE">Niger</option>
						 <option value="NG">Nigeria</option>
						 <option value="NU">Niue</option>
						 <option value="NF">Norfolk Island</option>
						 <option value="NO">Norway</option>
						 <option value="OM">Oman</option>
						 <option value="PK">Pakistan</option>
						 <option value="PS">Palestinian Territory, Occupied</option>
						 <option value="PA">Panama</option>
						 <option value="PG">Papua New Guinea</option>
						 <option value="PY">Paraguay</option>
						 <option value="PE">Peru</option>
						 <option value="PH">Philippines</option>
						 <option value="PN">Pitcairn</option>
						 <option value="PL">Poland</option>
						 <option value="PT">Portugal</option>
						 <option value="QA">Qatar</option>
						 <option value="RE">Réunion</option>
						 <option value="RO">Romania</option>
						 <option value="RU">Russian Federation</option>
						 <option value="RW">Rwanda</option>
						 <option value="BL">Saint Barthélemy</option>
						 <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
						 <option value="KN">Saint Kitts And Nevis</option>
						 <option value="LC">Saint Lucia</option>
						 <option value="MF">Saint Martin (french Part)</option>
						 <option value="PM">Saint Pierre And Miquelon</option>
						 <option value="VC">Saint Vincent And The Grenadines</option>
						 <option value="WS">Samoa</option>
						 <option value="SM">San Marino</option>
						 <option value="ST">Sao Tome And Principe</option>
						 <option value="SA">Saudi Arabia</option>
						 <option value="SN">Senegal</option>
						 <option value="RS">Serbia</option>
						 <option value="SC">Seychelles</option>
						 <option value="SL">Sierra Leone</option>
						 <option value="SG">Singapore</option>
						 <option value="SX">Sint Maarten (dutch Part)</option>
						 <option value="SK">Slovakia</option>
						 <option value="SI">Slovenia</option>
						 <option value="SB">Solomon Islands</option>
						 <option value="SO">Somalia</option>
						 <option value="ZA">South Africa</option>
						 <option value="GS">South Georgia And The South Sandwich Islands</option>
						 <option value="SS">South Sudan</option>
						 <option value="ES">Spain</option>
						 <option value="LK">Sri Lanka</option>
						 <option value="SD">Sudan</option>
						 <option value="SR">Suriname</option>
						 <option value="SJ">Svalbard And Jan Mayen</option>
						 <option value="SZ">Swaziland</option>
						 <option value="SE">Sweden</option>
						 <option value="CH">Switzerland</option>
						 <option value="SY">Syrian Arab Republic</option>
						 <option value="TW">Taiwan</option>
						 <option value="TJ">Tajikistan</option>
						 <option value="TZ">Tanzania, United Republic Of</option>
						 <option value="TH">Thailand</option>
						 <option value="TL">Timor-leste</option>
						 <option value="TG">Togo</option>
						 <option value="TK">Tokelau</option>
						 <option value="TO">Tonga</option>
						 <option value="TT">Trinidad And Tobago</option>
						 <option value="TN">Tunisia</option>
						 <option value="TR">Turkey</option>
						 <option value="TM">Turkmenistan</option>
						 <option value="TC">Turks And Caicos Islands</option>
						 <option value="TV">Tuvalu</option>
						 <option value="UG">Uganda</option>
						 <option value="UA">Ukraine</option>
						 <option value="AE">United Arab Emirates</option>
						 <option value="GB">United Kingdom</option>
						 <option value="UY">Uruguay</option>
						 <option value="UZ">Uzbekistan</option>
						 <option value="VU">Vanuatu</option>
						 <option value="VE">Venezuela, Bolivarian Republic Of</option>
						 <option value="VN">Viet Nam</option>
						 <option value="VG">Virgin Islands, British</option>
						 <option value="WF">Wallis And Futuna</option>
						 <option value="EH">Western Sahara</option>
						 <option value="YE">Yemen</option>
						 <option value="ZM">Zambia</option>
						 <option value="ZW">Zimbabwe</option>
			        </select>
			    </div>
			</div>
			<div class="col-sm-6 mt-15" title="">
			    <label class="main-label" for="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerState">State </label>
			    <div class="form-fields">
			        <select class="com-state form-field" id="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerState" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerState">
			            <option value="">Select a state</option>
						<option value="AL">Alabama</option>
						 <option value="AK">Alaska</option>
						 <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
						 <option value="AA">Armed Forces Americas (except Canada)</option>
						 <option value="AP">Armed Forces Pacific</option>
						 <option value="AZ">Arizona</option>
						 <option value="AR">Arkansas</option>
						 <option value="CA">California</option>
						 <option value="CO">Colorado</option>
						 <option value="CT">Connecticut</option>
						 <option value="DE">Delaware</option>
						 <option value="DC">District of Columbia</option>
						 <option value="FL">Florida</option>
						 <option value="GA">Georgia</option>
						 <option value="HI">Hawaii</option>
						 <option value="ID">Idaho</option>
						 <option value="IL">Illinois</option>
						 <option value="IN">Indiana</option>
						 <option value="IA">Iowa</option>
						 <option value="KS">Kansas</option>
						 <option value="KY">Kentucky</option>
						 <option value="LA">Louisiana</option>
						 <option value="ME">Maine</option>
						 <option value="MD">Maryland</option>
						 <option value="MA">Massachusetts</option>
						 <option value="MI">Michigan</option>
						 <option value="MN">Minnesota</option>
						 <option value="MS">Mississippi</option>
						 <option value="MO">Missouri</option>
						 <option value="MT">Montana</option>
						 <option value="NE">Nebraska</option>
						 <option value="NV">Nevada</option>
						 <option value="NH">New Hampshire</option>
						 <option value="NJ">New Jersey</option>
						 <option value="NM">New Mexico</option>
						 <option value="NY">New York</option>
						 <option value="NC">North Carolina</option>
						 <option value="ND">North Dakota</option>
						 <option value="OH">Ohio</option>
						 <option value="OK">Oklahoma</option>
						 <option value="OR">Oregon</option>
						 <option value="PA">Pennsylvania</option>
						 <option value="RI">Rhode Island</option>
						 <option value="SC">South Carolina</option>
						 <option value="SD">South Dakota</option>
						 <option value="TN">Tennessee</option>
						 <option value="TX">Texas</option>
						 <option value="UT">Utah</option>
						 <option value="VT">Vermont</option>
						 <option value="VA">Virginia</option>
						 <option value="WA">Washington</option>
						 <option value="WV">West Virginia</option>
						 <option value="WI">Wisconsin</option>
						 <option value="WY">Wyoming</option>
			        </select>
			    </div>
			</div>
			<div class="col-sm-6 mt-15" title="">
		        <label class="main-label" for="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerLocalOrTribal">Local/Tribal </label>
		        <div class="form-fields">
		            <select class="com-localtrib form-field" id="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerLocalOrTribal" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.issuerLocalOrTribal" disabled>
		                <option value="">Select Local/Tribal</option>
						<option value="Absentee-Shawnee">Absentee-Shawnee Tribe of Indians of Oklahoma</option>
						 <option value="Agdaagux">Agdaagux Tribe of King Cove</option>
						 <option value="Agua Caliente">Agua Caliente Band of Cahuilla Indians of the Agua Caliente Indian Reservation, California</option>
						 <option value="Ak Chin">Ak-Chin Indian Community</option>
						 <option value="Akiachak">Akiachak Native Community</option>
						 <option value="Akiak">Akiak Native Community</option>
						 <option value="Alabama-Coushatta">Alabama-Coushatta Tribe of Texas</option>
						 <option value="Alabama-Quassarte Tribal Town">Alabama-Quassarte Tribal Town</option>
						 <option value="Alatna">Alatna Village</option>
						 <option value="Algaaciq">Algaaciq Native Village (St. Mary's)</option>
						 <option value="Allakaket">Allakaket Village</option>
						 <option value="Alturas">Alturas Indian Rancheria, California</option>
						 <option value="Alutiiq Tribe of Old Harbor">Alutiiq Tribe of Old Harbor</option>
						 <option value="Angoon">Angoon Community Association</option>
						 <option value="Anvik">Anvik Village</option>
						 <option value="Apache">Apache Tribe of Oklahoma</option>
						 <option value="Arctic Village">Arctic Village (See Native Village of Venetie Tribal Government)</option>
						 <option value="Asa'carsarmiut">Asa'carsarmiut Tribe</option>
						 <option value="Assiniboine and Sioux">Assiniboine &amp; Sioux Tribes of the Fort Peck Indian Reservation, Montana</option>
						 <option value="Augustine">Augustine Band of Cahuilla Indians, California</option>
						 <option value="Bad River Band">Bad River Band of the Lake Superior Tribe of Chippewa Indians of the Bad River Reservation, Wisconsin</option>
						 <option value="Bay Mills">Bay Mills Indian Community, Michigan</option>
						 <option value="Bear River">Bear River Band of the Rohnerville Rancheria, California</option>
						 <option value="Beaver">Beaver Village</option>
						 <option value="Berry Creek">Berry Creek Rancheria of Maidu Indians of California</option>
						 <option value="Big Lagoon">Big Lagoon Rancheria, California</option>
						 <option value="Big Pine Reservation">Big Pine Paiute Tribe of the Owens Valley</option>
						 <option value="Big Sandy">Big Sandy Rancheria of Western Mono Indians of California</option>
						 <option value="Big Valley Rancheria">Big Valley Band of Pomo Indians of the Big Valley Rancheria, California</option>
						 <option value="Birch Creek">Birch Creek Tribe</option>
						 <option value="Bishop Paiute">Bishop Paiute Tribe</option>
						 <option value="Blackfeet">Blackfeet Tribe of the Blackfeet Indian Reservation of Montana</option>
						 <option value="Blue Lake">Blue Lake Rancheria, California</option>
						 <option value="Bridgeport Indian Colony">Bridgeport Indian Colony</option>
						 <option value="Buena Vista Rancheria">Buena Vista Rancheria of Me-Wuk Indians of California</option>
						 <option value="Burns Paiute">Burns Paiute Tribe</option>
						 <option value="Cabazon">Cabazon Band of Mission Indians, California</option>
						 <option value="Cachil DeHe">Cachil DeHe Band of Wintun Indians of the Colusa Indian Community of the Colusa Rancheria, California</option>
						 <option value="Caddo">Caddo Nation of Oklahoma</option>
						 <option value="Cahto">Cahto Tribe of the Laytonville Rancheria</option>
						 <option value="Cahuilla">Cahuilla Band of Indians</option>
						 <option value="California Valley">California Valley Miwok Tribe, California</option>
						 <option value="Campo">Campo Band of Diegueno Mission Indians of the Campo Indian Reservation, California</option>
						 <option value="Capitan Grande">Capitan Grande Band of Diegueno Mission Indians of California (Barona Group of Capitan Grande Band of Mission Indians of the Barona Reservation, California)</option>
						 <option value="Capitan Grande Band">Capitan Grande Band of Diegueno Mission Indians of California</option>
						 <option value="Viejas">Capitan Grande Band of Diegueno Mission Indians of California: Viejas (Baron Long) Group of Capitan Grande Band of Mission Indians of the Viejas Reservation, California</option>
						 <option value="Catawba">Catawba Indian Nation (aka Catawba Indian Tribe of South Carolina)</option>
						 <option value="Cayuga Nation of New York">Cayuga Nation</option>
						 <option value="Cedarville">Cedarville Rancheria, California</option>
						 <option value="Tlingit &amp; Haida">Central Council of the Tlingit &amp; Haida Indian Tribes</option>
						 <option value="Chalkyitsik">Chalkyitsik Village</option>
						 <option value="Cheesh-Na">Cheesh-Na Tribe</option>
						 <option value="Chemehuevi">Chemehuevi Indian Tribe of the Chemehuevi Reservation, California</option>
						 <option value="Cher-Ae Heights">Cher-Ae Heights Indian Community of the Trinidad Rancheria, California</option>
						 <option value="Cherokee Nation">Cherokee Nation</option>
						 <option value="Chevak">Chevak Native Village</option>
						 <option value="Cheyenne River">Cheyenne and Arapaho Tribes, Oklahoma</option>
						 <option value="Cheyenne River Sioux Tribe">Cheyenne River Sioux Tribe of the Cheyenne River Reservation, South Dakota</option>
						 <option value="Chickahominy Indians-Eastern Division">Chickahominy Indian Tribe - Eastern Division</option>
						 <option value="Chickahominy Indian Tribe, Inc.">Chickahominy Indian Tribe</option>
						 <option value="Chickaloon">Chickaloon Native Village</option>
						 <option value="Chicken Ranch">Chicken Ranch Rancheria of Me-Wuk Indians of California</option>
						 <option value="Chignik Bay">Chignik Bay Tribal Council</option>
						 <option value="Chignik Lake">Chignik Lake Village</option>
						 <option value="Chilkat">Chilkat Indian Village (Klukwan)</option>
						 <option value="Chilkoot">Chilkoot Indian Association (Haines)</option>
						 <option value="Chinik">Chinik Eskimo Community (Golovin)</option>
						 <option value="Chippewa-Cree">Chippewa Cree Indians of the Rocky Boy's Reservation, Montana</option>
						 <option value="Chitimacha">Chitimacha Tribe of Louisiana</option>
						 <option value="Chuloonawick">Chuloonawick Native Village</option>
						 <option value="Circle">Circle Native Community</option>
						 <option value="Citizen Potawatomi">Citizen Potawatomi Nation, Oklahoma</option>
						 <option value="Cloverdale">Cloverdale Rancheria of Pomo Indians of California</option>
						 <option value="Cocopah">Cocopah Tribe of Arizona</option>
						 <option value="Coeur D'Alene">Coeur D'Alene Tribe</option>
						 <option value="Cold Springs">Cold Springs Rancheria of Mono Indians of California</option>
						 <option value="Colorado River">Colorado River Indian Tribes of the Colorado River Indian Reservation, Arizona and California</option>
						 <option value="Comanche">Comanche Nation, Oklahoma</option>
						 <option value="Confederated Salish">Confederated Salish and Kootenai Tribes of the Flathead Reservation</option>
						 <option value="Confederated Yakama">Confederated Tribes and Bands of the Yakama Nation</option>
						 <option value="Siletz Tribe">Confederated Tribes of Siletz Indians of Oregon</option>
						 <option value="Chehalis">Confederated Tribes of the Chehalis Reservation</option>
						 <option value="Confederated Colville">Confederated Tribes of the Colville Reservation</option>
						 <option value="Confederated Coos">Confederated Tribes of the Coos, Lower Umpqua and Siuslaw Indians</option>
						 <option value="Confederated Goshute">Confederated Tribes of the Goshute Reservation, Nevada and Utah</option>
						 <option value="Grand Ronde Tribes">Confederated Tribes of the Grand Ronde Community of Oregon</option>
						 <option value="Umatilla Tribe">Confederated Tribes of the Umatilla Indian Reservation</option>
						 <option value="Warms Springs Tribe">Confederated Tribes of the Warm Springs Reservation of Oregon</option>
						 <option value="Coquille">Coquille Indian Tribe</option>
						 <option value="Coushatta">Coushatta Tribe of Louisiana</option>
						 <option value="Cow Creek">Cow Creek Band of Umpqua Tribe of Indians</option>
						 <option value="Cowlitz">Cowlitz Indian Tribe</option>
						 <option value="Coyote Valley">Coyote Valley Band of Pomo Indians of California</option>
						 <option value="Craig">Craig Tribal Association</option>
						 <option value="Crow Creek">Crow Creek Sioux Tribe of the Crow Creek Reservation, South Dakota</option>
						 <option value="Crow">Crow Tribe of Montana</option>
						 <option value="Curyung">Curyung Tribal Council</option>
						 <option value="Delaware Nation">Delaware Nation, Oklahoma</option>
						 <option value="Delaware Tribe of Indians">Delaware Tribe of Indians</option>
						 <option value="Douglas">Douglas Indian Association</option>
						 <option value="Dry Creek">Dry Creek Rancheria Band of Pomo Indians, California</option>
						 <option value="Duckwater">Duckwater Shoshone Tribe of the Duckwater Reservation, Nevada</option>
						 <option value="Eastern Cherokee">Eastern Band of Cherokee Indians</option>
						 <option value="Eastern Shawnee Tribe of Oklahoma">Eastern Shawnee Tribe of Oklahoma</option>
						 <option value="Eastern Shoshone">Eastern Shoshone Tribe of the Wind River Reservation, Wyoming</option>
						 <option value="Egegik">Egegik Village</option>
						 <option value="Eklutna">Eklutna Native Village</option>
						 <option value="Elem">Elem Indian Colony of Pomo Indians of the Sulphur Bank Rancheria, California</option>
						 <option value="Elk Valley">Elk Valley Rancheria, California</option>
						 <option value="Ely Shoshone">Ely Shoshone Tribe of Nevada</option>
						 <option value="Emmonak">Emmonak Village</option>
						 <option value="Enterprise">Enterprise Rancheria of Maidu Indians of California</option>
						 <option value="Evansville">Evansville Village (aka Bettles Field)</option>
						 <option value="Ewiiaapaayp">Ewiiaapaayp Band of Kumeyaay Indians, California</option>
						 <option value="Federated Indians of Graton">Federated Indians of Graton Rancheria, California</option>
						 <option value="Flandreau">Flandreau Santee Sioux Tribe of South Dakota</option>
						 <option value="Forest County">Forest County Potawatomi Community, Wisconsin</option>
						 <option value="Assiniboine and Gros Ventre Tribes">Fort Belknap Indian Community of the Fort Belknap Reservation of Montana</option>
						 <option value="Fort Bidwell">Fort Bidwell Indian Community of the Fort Bidwell Reservation of California</option>
						 <option value="Fort Independence">Fort Independence Indian Community of Paiute Indians of the Fort Independence Reservation, California</option>
						 <option value="Fort McDermitt">Fort McDermitt Paiute and Shoshone Tribes of the Fort McDermitt Indian Reservation, Nevada and Oregon</option>
						 <option value="Fort McDowell">Fort McDowell Yavapai Nation, Arizona</option>
						 <option value="Fort Mojave">Fort Mojave Indian Tribe of Arizona, California &amp; Nevada</option>
						 <option value="Fort Sill">Fort Sill Apache Tribe of Oklahoma</option>
						 <option value="Galena">Galena Village (aka Louden Village)</option>
						 <option value="Gila River">Gila River Indian Community of the Gila River Indian Reservation, Arizona</option>
						 <option value="Grand Traverse">Grand Traverse Band of Ottawa and Chippewa Indians, Michigan</option>
						 <option value="Greenville">Greenville Rancheria</option>
						 <option value="Grindstone">Grindstone Indian Rancheria of Wintun-Wailaki Indians of California</option>
						 <option value="Guidiville">Guidiville Rancheria of California</option>
						 <option value="Gulkana">Gulkana Village Council</option>
						 <option value="Habematolel">Habematolel Pomo of Upper Lake, California</option>
						 <option value="Hannahville">Hannahville Indian Community, Michigan</option>
						 <option value="Havasupai">Havasupai Tribe of the Havasupai Reservation, Arizona</option>
						 <option value="Healy Lake">Healy Lake Village</option>
						 <option value="Ho-Chunk">Ho-Chunk Nation of Wisconsin</option>
						 <option value="Hoh">Hoh Indian Tribe</option>
						 <option value="Holy Cross">Holy Cross Tribe</option>
						 <option value="Hoonah">Hoonah Indian Association</option>
						 <option value="Hoopa">Hoopa Valley Tribe, California</option>
						 <option value="Hopi">Hopi Tribe of Arizona</option>
						 <option value="Hopland">Hopland Band of Pomo Indians, California</option>
						 <option value="Houlton">Houlton Band of Maliseet Indians</option>
						 <option value="Hualapai">Hualapai Indian Tribe of the Hualapai Indian Reservation, Arizona</option>
						 <option value="Hughes">Hughes Village</option>
						 <option value="Huslia">Huslia Village</option>
						 <option value="Hydaburg">Hydaburg Cooperative Association</option>
						 <option value="Igiugig">Igiugig Village</option>
						 <option value="Iipay">Iipay Nation of Santa Ysabel, California</option>
						 <option value="Inaja">Inaja Band of Diegueno Mission Indians of the Inaja and Cosmit Reservation, California</option>
						 <option value="Inupiat Community of the Arctic Slope">Inupiat Community of the Arctic Slope</option>
						 <option value="Ione">Ione Band of Miwok Indians of California</option>
						 <option value="Iowa of Kansas">Iowa Tribe of Kansas and Nebraska</option>
						 <option value="Iowa of Oklahoma">Iowa Tribe of Oklahoma</option>
						 <option value="Iqugmiut">Iqugmiut Traditional Council</option>
						 <option value="Ivanof Bay Tribe">Ivanof Bay Tribe</option>
						 <option value="Jackson">Jackson Band of Miwuk Indians</option>
						 <option value="Jamestown">Jamestown S'Klallam Tribe</option>
						 <option value="Jamul">Jamul Indian Village of California</option>
						 <option value="Jena">Jena Band of Choctaw Indians</option>
						 <option value="Jicarilla">Jicarilla Apache Nation, New Mexico</option>
						 <option value="Kaguyuk">Kaguyak Village</option>
						 <option value="Kaibab">Kaibab Band of Paiute Indians of the Kaibab Indian Reservation, Arizona</option>
						 <option value="Kaktovik">Kaktovik Village (aka Barter Island)</option>
						 <option value="Kalispel">Kalispel Indian Community of the Kalispel Reservation</option>
						 <option value="Karuk">Karuk Tribe</option>
						 <option value="Kashia">Kashia Band of Pomo Indians of the Stewarts Point Rancheria, California</option>
						 <option value="Kasigluk">Kasigluk Traditional Elders Council</option>
						 <option value="Kaw">Kaw Nation, Oklahoma</option>
						 <option value="Kenaitze">Kenaitze Indian Tribe</option>
						 <option value="Ketchikan">Ketchikan Indian Community</option>
						 <option value="Keweenaw">Keweenaw Bay Indian Community, Michigan</option>
						 <option value="Kialegee Tribal Town">Kialegee Tribal Town</option>
						 <option value="Kickapoo of Texas">Kickapoo Traditional Tribe of Texas</option>
						 <option value="Kickapoo Tribe in Kansas">Kickapoo Tribe of Indians of the Kickapoo Reservation in Kansas</option>
						 <option value="Kickapoo of Oklahoma">Kickapoo Tribe of Oklahoma</option>
						 <option value="King Island">King Island Native Community</option>
						 <option value="King Salmon">King Salmon Tribe</option>
						 <option value="Kiowa Tribe">Kiowa  Indian Tribe of Oklahoma</option>
						 <option value="Klamath">Klamath Tribes</option>
						 <option value="Klawock">Klawock Cooperative Association</option>
						 <option value="Cortina">Kletsel Dehe Band of Wintun Indians</option>
						 <option value="Knik">Knik Tribe</option>
						 <option value="Koi">Koi Nation of Northern California</option>
						 <option value="Kokhanok">Kokhanok Village</option>
						 <option value="Kootenai">Kootenai Tribe of Idaho</option>
						 <option value="Koyukuk">Koyukuk Native Village</option>
						 <option value="La Jolla">La Jolla Band of Luiseno Indians, California</option>
						 <option value="La Posta">La Posta Band of Diegueno Mission Indians of the La Posta Indian Reservation, California</option>
						 <option value="Lac Courte Oreilles">Lac Courte Oreilles Band of Lake Superior Chippewa Indians of Wisconsin</option>
						 <option value="Lac du Flambeau">Lac du Flambeau Band of Lake Superior Chippewa Indians of the Lac du Flambeau Reservation of Wisconsin</option>
						 <option value="Lac Vieux">Lac Vieux Desert Band of Lake Superior Chippewa Indians of Michigan</option>
						 <option value="Las Vegas">Las Vegas Tribe of Paiute Indians of the Las Vegas Indian Colony, Nevada</option>
						 <option value="Levelock">Levelock Village</option>
						 <option value="Lime">Lime Village</option>
						 <option value="Little River">Little River Band of Ottawa Indians, Michigan</option>
						 <option value="Little Shell Tribe">Little Shell Tribe of Chippewa Indians of Montana</option>
						 <option value="Little Traverse">Little Traverse Bay Bands of Odawa Indians, Michigan</option>
						 <option value="Lone Pine">Lone Pine Paiute-Shoshone Tribe</option>
						 <option value="Los Coyotes">Los Coyotes Band of Cahuilla and Cupeno Indians, California</option>
						 <option value="Lovelock">Lovelock Paiute Tribe of the Lovelock Indian Colony, Nevada</option>
						 <option value="Lower Brule">Lower Brule Sioux Tribe of the Lower Brule Reservation, South Dakota</option>
						 <option value="Lower Elwha">Lower Elwha Tribal Community</option>
						 <option value="Lower Sioux">Lower Sioux Indian Community in the State of Minnesota</option>
						 <option value="Lummi">Lummi Tribe of the Lummi Reservation</option>
						 <option value="Lytton">Lytton Rancheria of California</option>
						 <option value="Makah">Makah Indian Tribe of the Makah Indian Reservation</option>
						 <option value="Manchester">Manchester Band of Pomo Indians of the Manchester Rancheria, California</option>
						 <option value="Manley Hot Springs">Manley Hot Springs Village</option>
						 <option value="Manokotak">Manokotak Village</option>
						 <option value="Manzanita">Manzanita Band of Diegueno Mission Indians of the Manzanita Reservation, California</option>
						 <option value="Mashantucket Pequot">Mashantucket Pequot Indian Tribe</option>
						 <option value="Mashpee">Mashpee Wampanoag Tribe</option>
						 <option value="Match-e-be-nash-she-wish Band">Match-e-be-nash-she-wish Band of Pottawatomi Indians of Michigan</option>
						 <option value="Mcgrath">McGrath Native Village</option>
						 <option value="Mechoopda">Mechoopda Indian Tribe of Chico Rancheria, California</option>
						 <option value="Menominee">Menominee Indian Tribe of Wisconsin</option>
						 <option value="Mentasta">Mentasta Traditional Council</option>
						 <option value="Mesa Grande">Mesa Grande Band of Diegueno Mission Indians of the Mesa Grande Reservation, California</option>
						 <option value="Mescalero Apache">Mescalero Apache Tribe of the Mescalero Reservation, New Mexico</option>
						 <option value="Metlakatla">Metlakatla Indian Community, Annette Island Reserve</option>
						 <option value="Miami Tribe of Oklahoma">Miami Tribe of Oklahoma</option>
						 <option value="Miccosukee">Miccosukee Tribe of Indians</option>
						 <option value="Middletown">Middletown Rancheria of Pomo Indians of California</option>
						 <option value="Mi'kmaq Nation">Mi'kmaq Nation</option>
						 <option value="Bois Forte">Minnesota Chippewa Tribe - Bois Forte Band (Nett Lake)</option>
						 <option value="Fond du Lac">Minnesota Chippewa Tribe - Fond du Lac Band</option>
						 <option value="Grand Portage">Minnesota Chippewa Tribe - Grand Portage Band</option>
						 <option value="Leech Lake">Minnesota Chippewa Tribe - Leech Lake Band</option>
						 <option value="Mille Lacs">Minnesota Chippewa Tribe - Mille Lacs Band</option>
						 <option value="White Earth">Minnesota Chippewa Tribe - White Earth Band</option>
						 <option value="Minnesota Chippewa">Minnesota Chippewa Tribe, Minnesota</option>
						 <option value="Mississippi Choctaw">Mississippi Band of Choctaw Indians</option>
						 <option value="Moapa">Moapa Band of Paiute Indians of the Moapa River Indian Reservation, Nevada</option>
						 <option value="Modoc Nation">Modoc Nation</option>
						 <option value="Mohegan">Mohegan Tribe of Indians of Connecticut</option>
						 <option value="Monacan Indian Nation">Monacan Indian Nation</option>
						 <option value="Mooretown">Mooretown Rancheria of Maidu Indians of California</option>
						 <option value="Morongo">Morongo Band of Mission Indians, California</option>
						 <option value="Muckleshoot">Muckleshoot Indian Tribe</option>
						 <option value="Naknek">Naknek Native Village</option>
						 <option value="Nansemond Indian Tribe">Nansemond Indian Nation</option>
						 <option value="Narragansett">Narragansett Indian Tribe</option>
						 <option value="Afognak">Native Village of Afognak</option>
						 <option value="Akhiok">Native Village of Akhiok</option>
						 <option value="Akutan">Native Village of Akutan</option>
						 <option value="Aleknagik">Native Village of Aleknagik</option>
						 <option value="Ambler">Native Village of Ambler</option>
						 <option value="Atka">Native Village of Atka</option>
						 <option value="Native Village of Atqasuk">Native Village of Atqasuk</option>
						 <option value="Barrow">Native Village of Barrow Inupiat Traditional Government</option>
						 <option value="Belkofski">Native Village of Belkofski</option>
						 <option value="Brevig Mission">Native Village of Brevig Mission</option>
						 <option value="Buckland">Native Village of Buckland</option>
						 <option value="Cantwell">Native Village of Cantwell</option>
						 <option value="Chenega">Native Village of Chenega (aka Chanega)</option>
						 <option value="Chignik Lagoon">Native Village of Chignik Lagoon</option>
						 <option value="Chitina">Native Village of Chitina</option>
						 <option value="Chuathbaluk">Native Village of Chuathbaluk (Russian Mission, Kuskokwim)</option>
						 <option value="Council">Native Village of Council</option>
						 <option value="Deering">Native Village of Deering</option>
						 <option value="Diomede">Native Village of Diomede (aka Inalik)</option>
						 <option value="Eagle">Native Village of Eagle</option>
						 <option value="Eek">Native Village of Eek</option>
						 <option value="Ekuk">Native Village of Ekuk</option>
						 <option value="Ekwok">Native Village of Ekwok</option>
						 <option value="Elim IRA">Native Village of Elim</option>
						 <option value="Eyak">Native Village of Eyak (Cordova)</option>
						 <option value="False Pass">Native Village of False Pass</option>
						 <option value="Fort Yukon">Native Village of Fort Yukon</option>
						 <option value="Gakona">Native Village of Gakona</option>
						 <option value="Gambell">Native Village of Gambell</option>
						 <option value="Georgetown">Native Village of Georgetown</option>
						 <option value="Goodnews Bay">Native Village of Goodnews Bay</option>
						 <option value="Hamilton">Native Village of Hamilton</option>
						 <option value="Hooper Bay">Native Village of Hooper Bay</option>
						 <option value="Kanatak">Native Village of Kanatak</option>
						 <option value="Karluk">Native Village of Karluk</option>
						 <option value="Kiana">Native Village of Kiana</option>
						 <option value="Kipnuk">Native Village of Kipnuk</option>
						 <option value="Kivalina">Native Village of Kivalina</option>
						 <option value="Kluti Kaah">Native Village of Kluti Kaah (aka Copper Center)</option>
						 <option value="Kobuk">Native Village of Kobuk</option>
						 <option value="Kongiganak">Native Village of Kongiganak</option>
						 <option value="Kotzebue">Native Village of Kotzebue</option>
						 <option value="Koyuk">Native Village of Koyuk</option>
						 <option value="Kwigillingok">Native Village of Kwigillingok</option>
						 <option value="Kwinhagak">Native Village of Kwinhagak (aka Quinhagak)</option>
						 <option value="Larsen Bay">Native Village of Larsen Bay</option>
						 <option value="Marshall">Native Village of Marshall (aka Fortuna Ledge)</option>
						 <option value="Mary's Igloo">Native Village of Mary's Igloo</option>
						 <option value="Mekoryuk">Native Village of Mekoryuk</option>
						 <option value="Minto">Native Village of Minto</option>
						 <option value="Nanwalek">Native Village of Nanwalek (aka English Bay)</option>
						 <option value="Napaimute">Native Village of Napaimute</option>
						 <option value="Napakiak">Native Village of Napakiak</option>
						 <option value="Napaskiak">Native Village of Napaskiak</option>
						 <option value="Nelson Lagoon">Native Village of Nelson Lagoon</option>
						 <option value="Nightmute">Native Village of Nightmute</option>
						 <option value="Nikolski">Native Village of Nikolski</option>
						 <option value="Noatak">Native Village of Noatak</option>
						 <option value="Nuiqsut">Native Village of Nuiqsut (aka Nooiksut)</option>
						 <option value="Nunam Iqua">Native Village of Nunam Iqua</option>
						 <option value="Nunapitchuk">Native Village of Nunapitchuk</option>
						 <option value="Ouzinkie">Native Village of Ouzinkie</option>
						 <option value="Paimiut">Native Village of Paimiut</option>
						 <option value="Perryville">Native Village of Perryville</option>
						 <option value="Pilot Point">Native Village of Pilot Point</option>
						 <option value="Point Hope IRA">Native Village of Point Hope</option>
						 <option value="Point Lay IRA">Native Village of Point Lay</option>
						 <option value="Port Graham">Native Village of Port Graham</option>
						 <option value="Port Heiden">Native Village of Port Heiden</option>
						 <option value="Port Lions">Native Village of Port Lions</option>
						 <option value="Ruby">Native Village of Ruby</option>
						 <option value="St. Michael IRA">Native Village of Saint Michael</option>
						 <option value="Savoonga">Native Village of Savoonga</option>
						 <option value="Scammon Bay">Native Village of Scammon Bay</option>
						 <option value="Selawik">Native Village of Selawik</option>
						 <option value="Shaktoolik">Native Village of Shaktoolik</option>
						 <option value="Shishmaref IRA">Native Village of Shishmaref</option>
						 <option value="Shungnak">Native Village of Shungnak</option>
						 <option value="Stevens Village">Native Village of Stevens</option>
						 <option value="Tanacross">Native Village of Tanacross</option>
						 <option value="Tanana">Native Village of Tanana</option>
						 <option value="Tatitlek">Native Village of Tatitlek</option>
						 <option value="Tazlina">Native Village of Tazlina</option>
						 <option value="Teller">Native Village of Teller</option>
						 <option value="Tetlin">Native Village of Tetlin</option>
						 <option value="Tuntutuliak">Native Village of Tuntutuliak</option>
						 <option value="Tununak">Native Village of Tununak</option>
						 <option value="Tyonek">Native Village of Tyonek</option>
						 <option value="Unalakleet">Native Village of Unalakleet</option>
						 <option value="Unga">Native Village of Unga</option>
						 <option value="Venetie IRA">Native Village of Venetie Tribal Government (Arctic Village and Village of Venetie)</option>
						 <option value="Wales">Native Village of Wales</option>
						 <option value="White Mountain AK">Native Village of White Mountain</option>
						 <option value="Navajo">Navajo Nation, Arizona, New Mexico &amp; Utah</option>
						 <option value="Nenana">Nenana Native Association</option>
						 <option value="New Koliganek">New Koliganek Village Council</option>
						 <option value="New Stuyahok">New Stuyahok Village</option>
						 <option value="Newhalen">Newhalen Village</option>
						 <option value="Newtok">Newtok Village</option>
						 <option value="Nez Perce">Nez Perce Tribe</option>
						 <option value="Nikolai">Nikolai Village</option>
						 <option value="Ninilchik">Ninilchik Village</option>
						 <option value="Nisqually">Nisqually Indian Tribe</option>
						 <option value="Nome">Nome Eskimo Community</option>
						 <option value="Nondalton">Nondalton Village</option>
						 <option value="Nooksack">Nooksack Indian Tribe</option>
						 <option value="Noorvik">Noorvik Native Community</option>
						 <option value="Northern Arapaho">Northern Arapaho Tribe of the Wind River Reservation, Wyoming</option>
						 <option value="Northern Cheyenne">Northern Cheyenne Tribe of the Northern Cheyenne Indian Reservation, Montana</option>
						 <option value="North Fork">Northfork Rancheria of Mono Indians of California</option>
						 <option value="Northway">Northway Village</option>
						 <option value="Northwestern Shoshone">Northwestern Band of the Shoshone Nation</option>
						 <option value="Nottawaseppi Potawatomi">Nottawaseppi Huron Band of the Potawatomi, Michigan</option>
						 <option value="Nulato">Nulato Village</option>
						 <option value="Nunakauyarmiut">Nunakauyarmiut Tribe</option>
						 <option value="Oglala Sioux">Oglala Sioux Tribe</option>
						 <option value="Ohkay Owingeh">Ohkay Owingeh, New Mexico</option>
						 <option value="Omaha">Omaha Tribe of Nebraska</option>
						 <option value="Oneida">Oneida Indian Nation</option>
						 <option value="Oneida Nation (Wisconsin)">Oneida Nation</option>
						 <option value="Onondaga">Onondaga Nation</option>
						 <option value="Grayling">Organized Village of Grayling (aka Holikachuk)</option>
						 <option value="Kake">Organized Village of Kake</option>
						 <option value="Kasaan">Organized Village of Kasaan</option>
						 <option value="Kwethluk">Organized Village of Kwethluk</option>
						 <option value="Saxman">Organized Village of Saxman</option>
						 <option value="Orutsararmiut">Orutsararmiut Traditional Native Council</option>
						 <option value="Oscarville">Oscarville Traditional Village</option>
						 <option value="Otoe-Missouria">Otoe-Missouria Tribe of Indians, Oklahoma</option>
						 <option value="Ottawa Tribe of Oklahoma">Ottawa Tribe of Oklahoma</option>
						 <option value="Paiute of Utah">Paiute Indian Tribe of Utah (Cedar Band of Paiutes, Kanosh Band of Paiutes, Koosharem Band of Paiutes, Indian Peaks Band of Paiutes, and Shivwits Band of Paiutes)</option>
						 <option value="Paiute-Shoshone">Paiute-Shoshone Tribe of the Fallon Reservation and Colony, Nevada</option>
						 <option value="Pala">Pala Band of Mission Indians</option>
						 <option value="Pamunkey Indian Tribe">Pamunkey Indian Tribe</option>
						 <option value="Pascua Yaqui">Pascua Yaqui Tribe of Arizona</option>
						 <option value="Paskenta">Paskenta Band of Nomlaki Indians of California</option>
						 <option value="Passamaquoddy Indian Township">Passamaquoddy Tribe - Indian Township</option>
						 <option value="Passamaquoddy Pleasant Point">Passamaquoddy Tribe - Pleasant Point</option>
						 <option value="Passamaquoddy Tribe">Passamaquoddy Tribe</option>
						 <option value="Pauloff Harbor">Pauloff Harbor Village</option>
						 <option value="Pauma">Pauma Band of Luiseno Mission Indians of the Pauma &amp; Yuima Reservation, California</option>
						 <option value="Pawnee">Pawnee Nation of Oklahoma</option>
						 <option value="Pechanga Band of Indians">Pechanga Band of Indians</option>
						 <option value="Pedro Bay">Pedro Bay Village</option>
						 <option value="Penobscot">Penobscot Nation</option>
						 <option value="Peoria Tribe of Indians of Oklahoma">Peoria Tribe of Indians of Oklahoma</option>
						 <option value="Petersburg">Petersburg Indian Association</option>
						 <option value="Picayune">Picayune Rancheria of Chukchansi Indians of California</option>
						 <option value="Pilot Station">Pilot Station Traditional Village</option>
						 <option value="Pinoleville">Pinoleville Pomo Nation, California</option>
						 <option value="Pit River">Pit River Tribe, California</option>
						 <option value="Pitka's Point">Pitka's Point Traditional Council</option>
						 <option value="Platinum">Platinum Traditional Village</option>
						 <option value="Poarch">Poarch Band of Creek Indians</option>
						 <option value="Pokagon">Pokagon Band of Potawatomi Indians, Michigan and Indiana</option>
						 <option value="Ponca of Oklahoma">Ponca Tribe of Indians of Oklahoma</option>
						 <option value="Ponca of Nebraska">Ponca Tribe of Nebraska</option>
						 <option value="Port Gamble">Port Gamble S'Klallam Tribe</option>
						 <option value="Portage Creek">Portage Creek Village (aka Ohgsenakale)</option>
						 <option value="Potter Valley">Potter Valley Tribe, California</option>
						 <option value="Prairie Band">Prairie Band Potawatomi Nation</option>
						 <option value="Prairie Island">Prairie Island Indian Community in the State of Minnesota</option>
						 <option value="Pribilof Islands Aleut Communities">Pribilof Islands Aleut Communities</option>
						 <option value="Pueblo of Acoma">Pueblo of Acoma, New Mexico</option>
						 <option value="Pueblo of Cochiti">Pueblo of Cochiti, New Mexico</option>
						 <option value="Pueblo of Isleta">Pueblo of Isleta, New Mexico</option>
						 <option value="Pueblo of Jemez">Pueblo of Jemez, New Mexico</option>
						 <option value="Pueblo of Laguna">Pueblo of Laguna, New Mexico</option>
						 <option value="Pueblo of Nambe">Pueblo of Nambe, New Mexico</option>
						 <option value="Pueblo of Picuris">Pueblo of Picuris, New Mexico</option>
						 <option value="Pueblo of Pojoaque">Pueblo of Pojoaque, New Mexico</option>
						 <option value="Pueblo of San Felipe">Pueblo of San Felipe, New Mexico</option>
						 <option value="Pueblo of San Ildefonso">Pueblo of San Ildefonso, New Mexico</option>
						 <option value="Pueblo of Sandia">Pueblo of Sandia, New Mexico</option>
						 <option value="Pueblo of Santa Ana">Pueblo of Santa Ana, New Mexico</option>
						 <option value="Pueblo of Santa Clara">Pueblo of Santa Clara, New Mexico</option>
						 <option value="Pueblo of Taos">Pueblo of Taos, New Mexico</option>
						 <option value="Pueblo of Tesuque">Pueblo of Tesuque, New Mexico</option>
						 <option value="Pueblo of Zia">Pueblo of Zia, New Mexico</option>
						 <option value="Puyallup">Puyallup Tribe of the Puyallup Reservation</option>
						 <option value="Pyramid Lake">Pyramid Lake Paiute Tribe of the Pyramid Lake Reservation, Nevada</option>
						 <option value="Qagan Tayagungin">Qagan Tayagungin Tribe of Sand Point</option>
						 <option value="Qawalangin">Qawalangin Tribe of Unalaska</option>
						 <option value="Quapaw Nation">Quapaw Nation</option>
						 <option value="Quartz Valley">Quartz Valley Indian Community of the Quartz Valley Reservation of California</option>
						 <option value="Quechan">Quechan Tribe of the Fort Yuma Indian Reservation, California &amp; Arizona</option>
						 <option value="Quileute">Quileute Tribe of the Quileute Reservation</option>
						 <option value="Quinault">Quinault Indian Nation</option>
						 <option value="Ramah Navajo Chapter">Ramah Navajo Chapter of the Navajo Nation</option>
						 <option value="Ramona">Ramona Band of Cahuilla, California</option>
						 <option value="Rampart">Rampart Village</option>
						 <option value="Rappahannock Tribe, Inc.">Rappahannock Tribe, Inc.</option>
						 <option value="Red Cliff">Red Cliff Band of Lake Superior Chippewa Indians of Wisconsin</option>
						 <option value="Red Lake">Red Lake Band of Chippewa Indians, Minnesota</option>
						 <option value="Redding">Redding Rancheria, California</option>
						 <option value="Redwood Valley">Redwood Valley or Little River Band of Pomo Indians of the Redwood Valley Rancheria California</option>
						 <option value="Reno-Sparks">Reno-Sparks Indian Colony, Nevada</option>
						 <option value="Resighini">Resighini Rancheria, California</option>
						 <option value="Rincon">Rincon Band of Luiseno Mission Indians of the Rincon Reservation, California</option>
						 <option value="Robinson">Robinson Rancheria</option>
						 <option value="Rosebud">Rosebud Sioux Tribe of the Rosebud Indian Reservation, South Dakota</option>
						 <option value="Round Valley">Round Valley Indian Tribes, Round Valley Reservation, California</option>
						 <option value="Sac &amp; Fox Nation of Missouri in Kansas and Nebraska">Sac &amp; Fox Nation of Missouri in Kansas and Nebraska</option>
						 <option value="Sac &amp; Fox Nation, Oklahoma">Sac &amp; Fox Nation, Oklahoma</option>
						 <option value="Sac &amp; Fox of Mississippi">Sac &amp; Fox Tribe of the Mississippi in Iowa</option>
						 <option value="Saginaw Chippewa">Saginaw Chippewa Indian Tribe of Michigan</option>
						 <option value="St. George">Saint George Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
						 <option value="Saint Paul">Saint Paul Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
						 <option value="Saint Regis">Saint Regis Mohawk Tribe</option>
						 <option value="Salamatof">Salamatof Tribe</option>
						 <option value="Salt River">Salt River Pima-Maricopa Indian Community of the Salt River Reservation, Arizona</option>
						 <option value="Samish">Samish Indian Nation</option>
						 <option value="San Carlos">San Carlos Apache Tribe of the San Carlos Reservation, Arizona</option>
						 <option value="San Juan">San Juan Southern Paiute Tribe of Arizona</option>
						 <option value="San Pasqual">San Pasqual Band of Diegueno Mission Indians of California</option>
						 <option value="Santa Rosa of Cahuilla">Santa Rosa Band of Cahuilla Indians, California</option>
						 <option value="Santa Rosa">Santa Rosa Indian Community of the Santa Rosa Rancheria, California</option>
						 <option value="Santa Ynez">Santa Ynez Band of Chumash Mission Indians of the Santa Ynez Reservation, California</option>
						 <option value="Santee Sioux">Santee Sioux Nation, Nebraska</option>
						 <option value="Santo Domingo">Santo Domingo Pueblo</option>
						 <option value="Sauk-Suiattle">Sauk-Suiattle Indian Tribe</option>
						 <option value="Sault Ste. Marie">Sault Ste. Marie Tribe of Chippewa Indians, Michigan</option>
						 <option value="Scotts Valley">Scotts Valley Band of Pomo Indians of California</option>
						 <option value="Seldovia">Seldovia Village Tribe</option>
						 <option value="Seminole">Seminole Tribe of Florida</option>
						 <option value="Seneca">Seneca Nation of Indians</option>
						 <option value="Seneca-Cayuga Nation">Seneca-Cayuga Nation</option>
						 <option value="Shageluk">Shageluk Native Village</option>
						 <option value="Shakopee">Shakopee Mdewakanton Sioux Community of Minnesota</option>
						 <option value="Shawnee Tribe">Shawnee Tribe</option>
						 <option value="Sherwood Valley">Sherwood Valley Rancheria of Pomo Indians of California</option>
						 <option value="Shingle Springs">Shingle Springs Band of Miwok Indians, Shingle Springs Rancheria (Verona Tract), California</option>
						 <option value="Shinnecock">Shinnecock Indian Nation</option>
						 <option value="Shoalwater">Shoalwater Bay Indian Tribe of the Shoalwater Bay Indian Reservation</option>
						 <option value="Shoshone-Bannock">Shoshone-Bannock Tribes of the Fort Hall Reservation</option>
						 <option value="Shoshone-Paiute">Shoshone-Paiute Tribes of the Duck Valley Reservation, Nevada</option>
						 <option value="Sisseton-Wahpeton">Sisseton-Wahpeton Oyate of the Lake Traverse Reservation, South Dakota</option>
						 <option value="Sitka">Sitka Tribe of Alaska</option>
						 <option value="Skagway">Skagway Village</option>
						 <option value="Skokomish">Skokomish Indian Tribe</option>
						 <option value="Skull Valley">Skull Valley Band of Goshute Indians of Utah</option>
						 <option value="Snoqualmie">Snoqualmie Indian Tribe</option>
						 <option value="Soboba">Soboba Band of Luiseno Indians, California</option>
						 <option value="Sokaogon">Sokaogon Chippewa  Community, Wisconsin</option>
						 <option value="South Naknek">South Naknek Village</option>
						 <option value="Southern Ute">Southern Ute Indian Tribe of the Southern Ute Reservation, Colorado</option>
						 <option value="Spirit Lake">Spirit Lake Tribe, North Dakota</option>
						 <option value="Spokane">Spokane Tribe of the Spokane Reservation</option>
						 <option value="Squaxin">Squaxin Island Tribe of the Squaxin Island Reservation</option>
						 <option value="St. Croix">St. Croix Chippewa Indians of Wisconsin</option>
						 <option value="Standing Rock">Standing Rock Sioux Tribe of North &amp; South Dakota</option>
						 <option value="Stebbins">Stebbins Community Association</option>
						 <option value="Stillaguamish">Stillaguamish Tribe of Indians of Washington</option>
						 <option value="Stockbridge">Stockbridge Munsee Community, Wisconsin</option>
						 <option value="Summit Lake">Summit Lake Paiute Tribe of Nevada</option>
						 <option value="Sun'aq">Sun'aq Tribe of Kodiak</option>
						 <option value="Suquamish">Suquamish Indian Tribe of the Port Madison Reservation</option>
						 <option value="Susanville">Susanville Indian Rancheria, California</option>
						 <option value="Swinomish">Swinomish Indian Tribal Community</option>
						 <option value="Sycuan">Sycuan Band of the Kumeyaay Nation</option>
						 <option value="Table Mountain">Table Mountain Rancheria</option>
						 <option value="Takotna">Takotna Village</option>
						 <option value="Tangirnaq">Tangirnaq Native Village</option>
						 <option value="Tejon">Tejon Indian Tribe</option>
						 <option value="Telida">Telida Village</option>
						 <option value="Te-Moak">Te-Moak Tribe of Western Shoshone Indians of Nevada (Four constituent bands: Battle Mountain Band; Elko Band; South Fork Band and Wells Band)</option>
						 <option value="Chickasaw Nation">The Chickasaw Nation</option>
						 <option value="The Choctaw Nation of Oklahoma">The Choctaw Nation of Oklahoma</option>
						 <option value="The Muscogee (Creek) Nation">The Muscogee (Creek) Nation</option>
						 <option value="The Osage Nation">The Osage Nation</option>
						 <option value="The Seminole Nation  of Oklahoma">The Seminole Nation of Oklahoma</option>
						 <option value="Thlopthlocco Tribal Town">Thlopthlocco Tribal Town</option>
						 <option value="Three Affiliated">Three Affiliated Tribes of the Fort Berthold Reservation, North Dakota</option>
						 <option value="Timbi-sha Shoshone">Timbisha Shoshone Tribe</option>
						 <option value="Tohono O'odham">Tohono O'odham Nation of Arizona</option>
						 <option value="Tolowa Dee-ni'">Tolowa Dee-ni' Nation</option>
						 <option value="Tonawanda">Tonawanda Band of Seneca</option>
						 <option value="Tonkawa">Tonkawa Tribe of Indians of Oklahoma</option>
						 <option value="Tonto Apache">Tonto Apache Tribe of Arizona</option>
						 <option value="Torres Martinez">Torres Martinez Desert Cahuilla Indians, California</option>
						 <option value="Togiak">Traditional Village of Togiak</option>
						 <option value="Tulalip">Tulalip Tribes of Washington</option>
						 <option value="Tule River">Tule River Indian Tribe of the Tule River Reservation, California</option>
						 <option value="Tuluksak">Tuluksak Native Community</option>
						 <option value="Tunica-Biloxi">Tunica-Biloxi Indian Tribe</option>
						 <option value="Tuolumne">Tuolumne Band of Me-Wuk Indians of the Tuolumne Rancheria of California</option>
						 <option value="Turtle Mountain">Turtle Mountain Band of Chippewa Indians of North Dakota</option>
						 <option value="Tuscarora">Tuscarora Nation</option>
						 <option value="Twenty-Nine Palms">Twenty-Nine Palms Band of Mission Indians of California</option>
						 <option value="Twin Hills">Twin Hills Village</option>
						 <option value="Ugashik">Ugashik Village</option>
						 <option value="Umkumiut">Umkumiut Native Village</option>
						 <option value="United Auburn">United Auburn Indian Community of the Auburn Rancheria of California</option>
						 <option value="United Keetoowah Band of Cherokee Indians in Oklahoma">United Keetoowah Band of Cherokee Indians in Oklahoma</option>
						 <option value="Upper Mattaponi Tribe">Upper Mattaponi Tribe</option>
						 <option value="Upper Sioux">Upper Sioux Community, Minnesota</option>
						 <option value="Upper Skagit">Upper Skagit Indian Tribe</option>
						 <option value="Ute">Ute Indian Tribe of the Uintah &amp; Ouray Reservation, Utah</option>
						 <option value="Ute Mountain Ute">Ute Mountain Ute Tribe</option>
						 <option value="Benton">Utu Utu Gwaitu Paiute Tribe of the Benton Paiute Reservation, California</option>
						 <option value="Alakanuk">Village of Alakanuk</option>
						 <option value="Anaktuvuk Pass">Village of Anaktuvuk Pass</option>
						 <option value="Aniak">Village of Aniak</option>
						 <option value="Atmautluak">Village of Atmautluak</option>
						 <option value="Bill Moore's Slough">Village of Bill Moore's Slough</option>
						 <option value="Chefornak">Village of Chefornak</option>
						 <option value="Clark's Point">Village of Clarks Point</option>
						 <option value="Crooked Creek">Village of Crooked Creek</option>
						 <option value="Dot Lake">Village of Dot Lake</option>
						 <option value="Iliamna">Village of Iliamna</option>
						 <option value="Kalskag">Village of Kalskag</option>
						 <option value="Kaltag">Village of Kaltag</option>
						 <option value="Kotlik">Village of Kotlik</option>
						 <option value="Lower Kalskag">Village of Lower Kalskag</option>
						 <option value="Ohogamiut">Village of Ohogamiut</option>
						 <option value="Red Devil">Village of Red Devil</option>
						 <option value="Sleetmute">Village of Sleetmute</option>
						 <option value="Solomon">Village of Solomon</option>
						 <option value="Stony River">Village of Stony River</option>
						 <option value="Venetie">Village of Venetie (See Native Village of Venetie Tribal Government)</option>
						 <option value="Wainwright">Village of Wainwright</option>
						 <option value="Walker River">Walker River Paiute Tribe of the Walker River Reservation, Nevada</option>
						 <option value="Wampanoag">Wampanoag Tribe of Gay Head (Aquinnah)</option>
						 <option value="Washoe">Washoe Tribe of Nevada &amp; California (Carson Colony, Dresslerville Colony, Woodfords Community, Stewart Community, &amp; Washoe Ranches)</option>
						 <option value="White Mountain">White Mountain Apache Tribe of the Fort Apache Reservation, Arizona</option>
						 <option value="Wichita">Wichita and Affiliated Tribes (Wichita, Keechi, Waco &amp; Tawakonie), Oklahoma</option>
						 <option value="Wilton">Wilton Rancheria, California</option>
						 <option value="Winnebago">Winnebago Tribe of Nebraska</option>
						 <option value="Winnemucca">Winnemucca Indian Colony of Nevada</option>
						 <option value="Wiyot">Wiyot Tribe, California</option>
						 <option value="Wrangell">Wrangell Cooperative Association</option>
						 <option value="Wyandotte Nation">Wyandotte Nation</option>
						 <option value="Yakutat">Yakutat Tlingit Tribe</option>
						 <option value="Yankton">Yankton Sioux Tribe of South Dakota</option>
						 <option value="Yavapai-Apache">Yavapai-Apache Nation of the Camp Verde Indian Reservation, Arizona</option>
						 <option value="Yavapai-Prescott">Yavapai-Prescott Indian Tribe</option>
						 <option value="Yerington">Yerington Paiute Tribe of the Yerington Colony and Campbell Ranch, Nevada</option>
						 <option value="Yocha Dehe">Yocha Dehe Wintun Nation, California</option>
						 <option value="Yomba Shoshone">Yomba Shoshone Tribe of the Yomba Reservation, Nevada</option>
						 <option value="Ysleta Del Sur">Ysleta del Sur Pueblo</option>
						 <option value="Yuhaaviatam of San Manuel Nation">Yuhaaviatam of San Manuel Nation</option>
						 <option value="Andreafski">Yupiit of Andreafski</option>
						 <option value="Yurok">Yurok Tribe of the Yurok Reservation, California</option>
						 <option value="Pueblo of Zuni">Zuni Tribe of the Zuni Reservation, New Mexico</option>
						 <option value="Other">Other</option>
		            </select>
		        </div>
		    </div>
		    <div class="col-sm-6 mt-15" title="">
		        <label class="main-label" for="companyApplicantInfo[${applicantCounter}].identificationDocuments.otherLocalDesc">Other local/Tribal description </label>
		        <div class="form-fields">
		            <input type="text" id="companyApplicantInfo[${applicantCounter}].identificationDocuments.otherLocalDesc" name="companyApplicantInfo[${applicantCounter}].identificationDocuments.otherLocalDesc" value="" placeholder="Enter local/Tribal description" class="com-otherlt form-field" disabled/>
		        </div>
		    </div>

           </div>

          </div>
        </div> 
   	</div>
   	<!-- Form of identification and issuing jurisdiction End -->

   	<!-- Legal Name & Date of Birth Start -->

   	<div class="accordion-item box-bg-sec">
   	 <div class="accordion-header row">
      <div class="dah-left col-md-8"><h2>Legal Name &amp; Date of Birth</h2></div>
      <div class="dah-right col-md-4">
       <span><a class="hover-modal-btn" href="#boirNeedHelp9"><img src="/images/help-icon.svg"></a></span>
       <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCAconditionThree${applicantCounter}" aria-expanded="true" aria-controls="collapseCAconditionThree${applicantCounter}"></button>
      </div>
     </div>
     <div id="collapseCAconditionThree${applicantCounter}" class="accordion-collapse collapse show">
       <div class="accordion-body">
          <div class="ab-top-para">
           <p>Enter your legal name and birthdate exactly as they appear on your identification documents.</p>
          </div>
          <div class="row">
           	<div class="col-sm-8 mt-15" title="">
			    <label class="main-label" for="companyApplicantInfo[${applicantCounter}].individualsLastName">Individual's last name or entity's legal name <em>*</em></label>
			    <div class="form-fields">
			        <input type="text" id="companyApplicantInfo[${applicantCounter}].individualsLastName" name="companyApplicantInfo[${applicantCounter}].individualsLastName" value="" placeholder="Enter last name" class="com-lname form-field" />
			    </div>
			</div>
          </div>
          <div class="row two-fields">
	        <div class="col-sm-4 mt-15" title="">
	            <label class="main-label" for="companyApplicantInfo[${applicantCounter}].firstName">First name <em>*</em></label>
	            <div class="form-fields">
	                <input type="text" id="companyApplicantInfo[${applicantCounter}].firstName" name="companyApplicantInfo[${applicantCounter}].firstName" value="" placeholder="Enter First name" class="com-fn form-field" />
	            </div>
	        </div>
	        <div class="col-sm-4 mt-15" title="">
	            <label class="main-label" for="companyApplicantInfo[${applicantCounter}].middleName">Middle name </label>
	            <div class="form-fields">
	                <input type="text" id="companyApplicantInfo[${applicantCounter}].middleName" name="companyApplicantInfo[${applicantCounter}].middleName" value="" placeholder="Enter Middle name" class="com-midname form-field" />
	            </div>
	        </div>
			<div class="col-sm-4 mt-15" title="">
	            <label class="main-label" for="companyApplicantInfo[${applicantCounter}].suffix">Suffix </label>
	            <div class="form-fields">
	                <input type="text" id="companyApplicantInfo[${applicantCounter}].suffix" name="companyApplicantInfo[${applicantCounter}].suffix" value="" placeholder="Suffix" class="com-suffix form-field" />
	            </div>
	        </div>
	      </div>
	      <div class="row">
	      	<div class="col-sm-6 mt-15" title="">
			    <label class="main-label" for="companyApplicantInfo[${applicantCounter}].dateOfBirth">Date of birth <em>*</em> </label>
			    <div class="form-fields">
			        <div class="date-field">
			            <input type="date" id="companyApplicantInfo[${applicantCounter}].dateOfBirth" name="companyApplicantInfo[${applicantCounter}].dateOfBirth" value="" placeholder="06/20/2024" class="com-dob form-field" />
			        </div>
			    </div>
			</div>
	      </div>


    	</div>
     </div>	
   	</div>

   	<!-- Legal Name & Date of Birth End -->

   	<!-- Current Address Start -->
   	<div class="accordion-item box-bg-sec">
   	 <div class="accordion-header row">
      <div class="dah-left col-md-8"><h2>Current Address</h2></div>
      <div class="dah-right col-md-4">
       <span><a class="hover-modal-btn" href="#boirNeedHelp10"><img src="/images/help-icon.svg"></a></span>
       <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCAconditionFour${applicantCounter}" aria-expanded="true" aria-controls="collapseCAconditionFour${applicantCounter}"></button>
      </div>
     </div>
     <div id="collapseCAconditionFour${applicantCounter}" class="accordion-collapse collapse show">
      <div class="accordion-body">
      	<div class="ab-top-para">
         <p>Please enter your current address—home or work.</p>
        </div>
        <div class="row">
         <div class="col-lg-6 col-md-10 mt-15" title="">
		    <label class="main-label" for="companyApplicantInfo[${applicantCounter}].address.addressType">Address type <em>*</em></label>
		    <div class="form-fields">
		        <div class="row">
		            <label class="col-sm-6">
		                <input type="radio" id="Residential${applicantCounter}" name="companyApplicantInfo[${applicantCounter}].address.addressType" value="Residential" class="com-addtype"/> Residential</label>
		            <label class="col-sm-6">
		                <input type="radio" id="Business${applicantCounter}" name="companyApplicantInfo[${applicantCounter}].address.addressType" value="Business" class="com-addtype" /> Business</label>
		        </div>
		    </div>
		 </div>
        </div>
        <div class="row two-fields">
		    <div class="col-sm-7 mt-15" title="">
		        <label class="main-label" for="companyApplicantInfo[${applicantCounter}].address.address">Address (number, street, and apt. or suite no.) <em>*</em></label>
		        <div class="form-fields">
		            <input type="text" id="companyApplicantInfo[${applicantCounter}].address.address" name="companyApplicantInfo[${applicantCounter}].address.address" value="" placeholder="Enter Address" class="com-address form-field" />
		        </div>
		    </div>
		    <div class="col-sm-5 mt-15" title="">
		        <label class="main-label" for="companyApplicantInfo[${applicantCounter}].address.city">City <em>*</em></label>
		        <div class="form-fields">
		            <input type="text" id="companyApplicantInfo[${applicantCounter}].address.city" name="companyApplicantInfo[${applicantCounter}].address.city" value="" placeholder="Enter City name" class="com-city form-field" />
		        </div>
		    </div>
		    <div class="col-sm-4 mt-15" title="">
		        <label class="main-label" for="companyApplicantInfo[${applicantCounter}].address.country">Country/Jurisdiction <em>*</em></label>
		        <div class="com-countryjuri form-fields">
		            <select class="com-countryjuri form-field" id="companyApplicantInfo[${applicantCounter}].address.country" name="companyApplicantInfo[${applicantCounter}].address.country">
		                <option value="">Select a Country/Jurisdiction</option>
						<option value="US">United States of America</option>
						 <option value="AS">American Samoa</option>
						 <option value="GU">Guam</option>
						 <option value="MH">Marshall Islands</option>
						 <option value="FM">Micronesia, Federated States</option>
						 <option value="MP">Northern Mariana Islands</option>
						 <option value="PW">Palau</option>
						 <option value="PR">Puerto Rico</option>
						 <option value="VI">U.S. Virgin Islands</option>
						 <option value="AF">Afghanistan</option>
						 <option value="AX">Åland Islands</option>
						 <option value="AL">Albania</option>
						 <option value="DZ">Algeria</option>
						 <option value="AD">Andorra</option>
						 <option value="AO">Angola</option>
						 <option value="AI">Anguilla</option>
						 <option value="AQ">Antarctica</option>
						 <option value="AG">Antigua And Barbuda</option>
						 <option value="AR">Argentina</option>
						 <option value="AM">Armenia</option>
						 <option value="AW">Aruba</option>
						 <option value="AU">Australia</option>
						 <option value="AT">Austria</option>
						 <option value="AZ">Azerbaijan</option>
						 <option value="BS">Bahamas</option>
						 <option value="BH">Bahrain</option>
						 <option value="BD">Bangladesh</option>
						 <option value="BB">Barbados</option>
						 <option value="BY">Belarus</option>
						 <option value="BE">Belgium</option>
						 <option value="BZ">Belize</option>
						 <option value="BJ">Benin</option>
						 <option value="BM">Bermuda</option>
						 <option value="BT">Bhutan</option>
						 <option value="BO">Bolivia, Plurinational State Of</option>
						 <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
						 <option value="BA">Bosnia And Herzegovina</option>
						 <option value="BW">Botswana</option>
						 <option value="BV">Bouvet Island</option>
						 <option value="BR">Brazil</option>
						 <option value="IO">British Indian Ocean Territory</option>
						 <option value="BN">Brunei Darussalam</option>
						 <option value="BG">Bulgaria</option>
						 <option value="BF">Burkina Faso</option>
						 <option value="BI">Burundi</option>
						 <option value="KH">Cambodia</option>
						 <option value="CM">Cameroon</option>
						 <option value="CA">Canada</option>
						 <option value="CV">Cape Verde</option>
						 <option value="KY">Cayman Islands</option>
						 <option value="CF">Central African Republic</option>
						 <option value="TD">Chad</option>
						 <option value="CL">Chile</option>
						 <option value="CN">China</option>
						 <option value="CX">Christmas Island</option>
						 <option value="CC">Cocos (Keeling) Islands</option>
						 <option value="CO">Colombia</option>
						 <option value="KM">Comoros</option>
						 <option value="CG">Congo</option>
						 <option value="CD">Congo, The Democratic Republic Of The</option>
						 <option value="CK">Cook Islands</option>
						 <option value="CR">Costa Rica</option>
						 <option value="CI">Côte D'ivoire</option>
						 <option value="HR">Croatia</option>
						 <option value="CU">Cuba</option>
						 <option value="CW">Curaçao</option>
						 <option value="CY">Cyprus</option>
						 <option value="CZ">Czech Republic</option>
						 <option value="DK">Denmark</option>
						 <option value="DJ">Djibouti</option>
						 <option value="DM">Dominica</option>
						 <option value="DO">Dominican Republic</option>
						 <option value="EC">Ecuador</option>
						 <option value="EG">Egypt</option>
						 <option value="SV">El Salvador</option>
						 <option value="GQ">Equatorial Guinea</option>
						 <option value="ER">Eritrea</option>
						 <option value="EE">Estonia</option>
						 <option value="ET">Ethiopia</option>
						 <option value="FK">Falkland Islands (Malvinas)</option>
						 <option value="FO">Faroe Islands</option>
						 <option value="FJ">Fiji</option>
						 <option value="FI">Finland</option>
						 <option value="FR">France</option>
						 <option value="GF">French Guiana</option>
						 <option value="PF">French Polynesia</option>
						 <option value="TF">French Southern Territories</option>
						 <option value="GA">Gabon</option>
						 <option value="GM">Gambia</option>
						 <option value="GE">Georgia</option>
						 <option value="DE">Germany</option>
						 <option value="GH">Ghana</option>
						 <option value="GI">Gibraltar</option>
						 <option value="GR">Greece</option>
						 <option value="GL">Greenland</option>
						 <option value="GD">Grenada</option>
						 <option value="GP">Guadeloupe</option>
						 <option value="GT">Guatemala</option>
						 <option value="GG">Guernsey</option>
						 <option value="GN">Guinea</option>
						 <option value="GW">Guinea-bissau</option>
						 <option value="GY">Guyana</option>
						 <option value="HT">Haiti</option>
						 <option value="HM">Heard Island And Mcdonald Islands</option>
						 <option value="VA">Holy See (Vatican City State)</option>
						 <option value="HN">Honduras</option>
						 <option value="HK">Hong Kong</option>
						 <option value="HU">Hungary</option>
						 <option value="IS">Iceland</option>
						 <option value="IN">India</option>
						 <option value="ID">Indonesia</option>
						 <option value="IR">Iran, Islamic Republic Of</option>
						 <option value="IQ">Iraq</option>
						 <option value="IE">Ireland</option>
						 <option value="IM">Isle Of Man</option>
						 <option value="IL">Israel</option>
						 <option value="IT">Italy</option>
						 <option value="JM">Jamaica</option>
						 <option value="JP">Japan</option>
						 <option value="JE">Jersey</option>
						 <option value="JO">Jordan</option>
						 <option value="KZ">Kazakhstan</option>
						 <option value="KE">Kenya</option>
						 <option value="KI">Kiribati</option>
						 <option value="KP">Korea, Democratic People's Republic Of</option>
						 <option value="KR">Korea, Republic Of</option>
						 <option value="KW">Kuwait</option>
						 <option value="KG">Kyrgyzstan</option>
						 <option value="LA">Lao People's Democratic Republic</option>
						 <option value="LV">Latvia</option>
						 <option value="LB">Lebanon</option>
						 <option value="LS">Lesotho</option>
						 <option value="LR">Liberia</option>
						 <option value="LY">Libya</option>
						 <option value="LI">Liechtenstein</option>
						 <option value="LT">Lithuania</option>
						 <option value="LU">Luxembourg</option>
						 <option value="MO">Macao</option>
						 <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
						 <option value="MG">Madagascar</option>
						 <option value="MW">Malawi</option>
						 <option value="MY">Malaysia</option>
						 <option value="MV">Maldives</option>
						 <option value="ML">Mali</option>
						 <option value="MT">Malta</option>
						 <option value="MQ">Martinique</option>
						 <option value="MR">Mauritania</option>
						 <option value="MU">Mauritius</option>
						 <option value="YT">Mayotte</option>
						 <option value="MX">Mexico</option>
						 <option value="MD">Moldova, Republic Of</option>
						 <option value="MC">Monaco</option>
						 <option value="MN">Mongolia</option>
						 <option value="ME">Montenegro</option>
						 <option value="MS">Montserrat</option>
						 <option value="MA">Morocco</option>
						 <option value="MZ">Mozambique</option>
						 <option value="MM">Myanmar</option>
						 <option value="NA">Namibia</option>
						 <option value="NR">Nauru</option>
						 <option value="NP">Nepal</option>
						 <option value="NL">Netherlands</option>
						 <option value="NC">New Caledonia</option>
						 <option value="NZ">New Zealand</option>
						 <option value="NI">Nicaragua</option>
						 <option value="NE">Niger</option>
						 <option value="NG">Nigeria</option>
						 <option value="NU">Niue</option>
						 <option value="NF">Norfolk Island</option>
						 <option value="NO">Norway</option>
						 <option value="OM">Oman</option>
						 <option value="PK">Pakistan</option>
						 <option value="PS">Palestinian Territory, Occupied</option>
						 <option value="PA">Panama</option>
						 <option value="PG">Papua New Guinea</option>
						 <option value="PY">Paraguay</option>
						 <option value="PE">Peru</option>
						 <option value="PH">Philippines</option>
						 <option value="PN">Pitcairn</option>
						 <option value="PL">Poland</option>
						 <option value="PT">Portugal</option>
						 <option value="QA">Qatar</option>
						 <option value="RE">Réunion</option>
						 <option value="RO">Romania</option>
						 <option value="RU">Russian Federation</option>
						 <option value="RW">Rwanda</option>
						 <option value="BL">Saint Barthélemy</option>
						 <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
						 <option value="KN">Saint Kitts And Nevis</option>
						 <option value="LC">Saint Lucia</option>
						 <option value="MF">Saint Martin (french Part)</option>
						 <option value="PM">Saint Pierre And Miquelon</option>
						 <option value="VC">Saint Vincent And The Grenadines</option>
						 <option value="WS">Samoa</option>
						 <option value="SM">San Marino</option>
						 <option value="ST">Sao Tome And Principe</option>
						 <option value="SA">Saudi Arabia</option>
						 <option value="SN">Senegal</option>
						 <option value="RS">Serbia</option>
						 <option value="SC">Seychelles</option>
						 <option value="SL">Sierra Leone</option>
						 <option value="SG">Singapore</option>
						 <option value="SX">Sint Maarten (dutch Part)</option>
						 <option value="SK">Slovakia</option>
						 <option value="SI">Slovenia</option>
						 <option value="SB">Solomon Islands</option>
						 <option value="SO">Somalia</option>
						 <option value="ZA">South Africa</option>
						 <option value="GS">South Georgia And The South Sandwich Islands</option>
						 <option value="SS">South Sudan</option>
						 <option value="ES">Spain</option>
						 <option value="LK">Sri Lanka</option>
						 <option value="SD">Sudan</option>
						 <option value="SR">Suriname</option>
						 <option value="SJ">Svalbard And Jan Mayen</option>
						 <option value="SZ">Swaziland</option>
						 <option value="SE">Sweden</option>
						 <option value="CH">Switzerland</option>
						 <option value="SY">Syrian Arab Republic</option>
						 <option value="TW">Taiwan</option>
						 <option value="TJ">Tajikistan</option>
						 <option value="TZ">Tanzania, United Republic Of</option>
						 <option value="TH">Thailand</option>
						 <option value="TL">Timor-leste</option>
						 <option value="TG">Togo</option>
						 <option value="TK">Tokelau</option>
						 <option value="TO">Tonga</option>
						 <option value="TT">Trinidad And Tobago</option>
						 <option value="TN">Tunisia</option>
						 <option value="TR">Turkey</option>
						 <option value="TM">Turkmenistan</option>
						 <option value="TC">Turks And Caicos Islands</option>
						 <option value="TV">Tuvalu</option>
						 <option value="UG">Uganda</option>
						 <option value="UA">Ukraine</option>
						 <option value="AE">United Arab Emirates</option>
						 <option value="GB">United Kingdom</option>
						 <option value="UY">Uruguay</option>
						 <option value="UZ">Uzbekistan</option>
						 <option value="VU">Vanuatu</option>
						 <option value="VE">Venezuela, Bolivarian Republic Of</option>
						 <option value="VN">Viet Nam</option>
						 <option value="VG">Virgin Islands, British</option>
						 <option value="WF">Wallis And Futuna</option>
						 <option value="EH">Western Sahara</option>
						 <option value="YE">Yemen</option>
						 <option value="ZM">Zambia</option>
						 <option value="ZW">Zimbabwe</option>
		            </select>
		        </div>
		    </div>
		    <div class="col-sm-4 mt-15" title="">
		        <label class="main-label" for="companyApplicantInfo[${applicantCounter}].address.state">State <em>*</em></label>
		        <div class="company-state form-fields">
		            <select class="company-state form-field" id="companyApplicantInfo[${applicantCounter}].address.state" name="companyApplicantInfo[${applicantCounter}].address.state">
		                <option value="">Select a state</option>
						<option value="AL">Alabama</option>
						 <option value="AK">Alaska</option>
						 <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
						 <option value="AA">Armed Forces Americas (except Canada)</option>
						 <option value="AP">Armed Forces Pacific</option>
						 <option value="AZ">Arizona</option>
						 <option value="AR">Arkansas</option>
						 <option value="CA">California</option>
						 <option value="CO">Colorado</option>
						 <option value="CT">Connecticut</option>
						 <option value="DE">Delaware</option>
						 <option value="DC">District of Columbia</option>
						 <option value="FL">Florida</option>
						 <option value="GA">Georgia</option>
						 <option value="HI">Hawaii</option>
						 <option value="ID">Idaho</option>
						 <option value="IL">Illinois</option>
						 <option value="IN">Indiana</option>
						 <option value="IA">Iowa</option>
						 <option value="KS">Kansas</option>
						 <option value="KY">Kentucky</option>
						 <option value="LA">Louisiana</option>
						 <option value="ME">Maine</option>
						 <option value="MD">Maryland</option>
						 <option value="MA">Massachusetts</option>
						 <option value="MI">Michigan</option>
						 <option value="MN">Minnesota</option>
						 <option value="MS">Mississippi</option>
						 <option value="MO">Missouri</option>
						 <option value="MT">Montana</option>
						 <option value="NE">Nebraska</option>
						 <option value="NV">Nevada</option>
						 <option value="NH">New Hampshire</option>
						 <option value="NJ">New Jersey</option>
						 <option value="NM">New Mexico</option>
						 <option value="NY">New York</option>
						 <option value="NC">North Carolina</option>
						 <option value="ND">North Dakota</option>
						 <option value="OH">Ohio</option>
						 <option value="OK">Oklahoma</option>
						 <option value="OR">Oregon</option>
						 <option value="PA">Pennsylvania</option>
						 <option value="RI">Rhode Island</option>
						 <option value="SC">South Carolina</option>
						 <option value="SD">South Dakota</option>
						 <option value="TN">Tennessee</option>
						 <option value="TX">Texas</option>
						 <option value="UT">Utah</option>
						 <option value="VT">Vermont</option>
						 <option value="VA">Virginia</option>
						 <option value="WA">Washington</option>
						 <option value="WV">West Virginia</option>
						 <option value="WI">Wisconsin</option>
						 <option value="WY">Wyoming</option>
		            </select>
		        </div>
		    </div>
		    <div class="col-sm-4 mt-15" title="">
		        <label class="main-label" for="companyApplicantInfo[${applicantCounter}].address.postalCode">Zip Code <em>*</em></label>
		        <div class="form-fields">
		            <input type="text" id="companyApplicantInfo[${applicantCounter}].address.postalCode" name="companyApplicantInfo[${applicantCounter}].address.postalCode" value="" placeholder="Enter Zip Code" class="com-zipcode form-field" />
		        </div>
		    </div>
</div>



      </div>	
     </div>
   	</div>
   	<!-- Current Address End -->


   </div>
  </div>
  <!-- Rest Of the Company Appicant Fields on Condition Based End -->
		    `;

		// Append the new applicant section to the accordion
		$('#accordionExample').append(newApplicant);
		//enable the autocomplete off to the fields
		$('form input').attr('autocomplete', 'new-password');
		// Add remove functionality
		$('.remove-applicant').last().on('click', function() {
			const applicantNumber = $(this).data('applicant');
			$(`#collapse${applicantNumber}`).parent().remove();
		});

	});

	//-----------------------------------------------------------------------------------------------------

	let beneficialCounter = 1;

	$('#addBeneficial').on('click', function(event) {

		filingInfoId = $("#filingInfoId").val();
		// Prevent the default behavior
		event.preventDefault();

		$(`#collapseBeneficial${beneficialCounter}`).removeClass('show').collapse('hide');
		beneficialCounter++;

		$('#collapseBeneficial0').removeClass('show');

		// Create a new beneficial owner section
		const newBeneficial = `
	<div class="accordion-item">
	<h2 class="accordion-header">
	 <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBeneficial${beneficialCounter}" aria-expanded="true" aria-controls="collapseBeneficial${beneficialCounter}">Beneficial Owner</button>
	</h2>
	<div class="text-right">
		<button type="button" class="remove-beneficial bg-btn" data-beneficial="${beneficialCounter}">Remove Beneficial Owner</button>
	</div>	
	<div id="collapseBeneficial${beneficialCounter}" data-index="${beneficialCounter}" class="accordion-collapse getIndex collapse show" data-bs-parent="#accordionExample1">
	   <div class="accordion-body">

	   	<div class="accordion def-acc-sec">
	   	 <!-- Send Form to Beneficial Owner Start -->
		 <div>
		    	   <div id="benOwnerEmailField${beneficialCounter}" class="form-rows pt-15" title="" >
		 		 <p>Would you like to invite this beneficial owner to complete their information? Send them a link instead.</p>
		 		 	<div class="accordion-item box-bg-sec">
		 		 	 <div class="sf-form-body no-padding">
		                  
		                  <label class="main-label" for="beneficialOwner[${beneficialCounter}].benficialEmail">Send Form to Beneficial Owner</label>
		                  <div class="form-fields">
		                     <div class="normal-field col-sm-6">
		                        <input  id="beneficialOwner[${beneficialCounter}].benficialEmail" data-index="${beneficialCounter}" name="beneficialOwner[${beneficialCounter}].benficialEmail" type="email" placeholder="Enter Beneficial Owner's Email" class="form-field ben-email" autocomplete="new-password">
		 					<input id="beneficialOwner[${beneficialCounter}].benficialEmailSentDate" name="beneficialOwner[${beneficialCounter}].benficialEmailSentDate" type="hidden" />
		 					<input id="beneficialOwner[${beneficialCounter}].beneficialTrackId" name="beneficialOwner[${beneficialCounter}].beneficialTrackId" type="hidden" />
		 					<input id="beneficialOwner[${beneficialCounter}].beneficialStatus" name="beneficialOwner[${beneficialCounter}].beneficialStatus" type="hidden" />								  <div class="check-field mt-15 mb-10">									
		 						<label class="check-ben-lab">
		 						 <input class="checkBeneficialEmail" type="checkbox" data-index="${beneficialCounter}" id="checkBenEmail${beneficialCounter}" value="beneficialEmailChecked" name="checkBenEmail${beneficialCounter}" style="margin-right:10px;" disabled>By checking on this below all fields will be disabled
		 						</label>
		 					  </div>
		 					</div>
		                  </div>
		              </div>
		                  </div>
		               </div>
		 		<input type="hidden" name="beneficialOwner[${beneficialCounter}].filingInfoId" value="${filingInfoId}"/>	
		    	  </div>	


	   	  <div id="parentfinceid${beneficialCounter}">

	   	  <!-- Provide Parent/Guardian Start -->
	   	   <div class="accordion-item box-bg-sec">
	   	   	 <div class="accordion-header row">
               <div class="dah-left col-md-8"><h2>Beneficial Owner is a Minor – Provide Parent/Guardian Information Instead</h2></div>
               <div class="dah-right col-md-4">
                <span><a class="hover-modal-btn" href="#boirNeedHelp11"><img src="/images/help-icon.svg"></a></span>
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoAddOnOne${beneficialCounter}" aria-expanded="true" aria-controls="collapseBoAddOnOne${beneficialCounter}"></button>
               </div>
              </div>
              <div id="collapseBoAddOnOne${beneficialCounter}" class="accordion-collapse collapse show">
              	<div class="accordion-body">
              	 <div class="ab-top-para">
                    <p>Select this option if the beneficial owner is a minor and you will be entering parent or guardian details instead.</p>
                 </div>
                 <div class="sf-form-body">
                 <div class="form-rows" title="">
				   <div class="form-fields">
					  <div class="row">
						 <label class="col-sm-3">
						 <input type="radio" id="yes" name="beneficialOwner[${beneficialCounter}].isMinorChild" value="true" /> Yes
						 </label>
						 <label class="col-sm-3">
						 <input type="radio" id="no" name="beneficialOwner[${beneficialCounter}].isMinorChild" value="false" checked /> No
						 </label>
					  </div>
				   </div>
				  </div>
				  </div>

              	</div>
              </div>
	   	   </div>

	   	   <!-- Provide Parent/Guardian End -->

	   	   <!-- Beneficial Owner FinCEN ID Start -->

	   	   <div class="accordion-item box-bg-sec">
	   	   	<div class="accordion-header row">
               <div class="dah-left col-md-8"><h2>Beneficial Owner FinCEN ID</h2></div>
               <div class="dah-right col-md-4">
                <span><a class="hover-modal-btn" href="#boirNeedHelp12"><img src="/images/help-icon.svg"></a></span>
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoAddOnTwo${beneficialCounter}" aria-expanded="true" aria-controls="collapseBoAddOnTwo${beneficialCounter}"></button>
               </div>
             </div>
             <div id="collapseBoAddOnTwo${beneficialCounter}" class="accordion-collapse collapse show">
                <div class="accordion-body">
                  <div class="ab-top-para">
                    <p>If the beneficial owner has a FinCEN ID, please enter it below to skip the remaining fields.</p>
                 </div>
                 <div class="sf-form-body">
					<div class="form-rows no-margin" title="">
					   <label class="main-label" for="beneficialOwner[${beneficialCounter}].finCenId">FinCEN ID</label>
					   <div class="form-fields">
						  <div class="normal-field col-sm-6">
							 <input id="beneficialOwner[${beneficialCounter}].finCenId" name="beneficialOwner[${beneficialCounter}].finCenId" onblur="disableFields(this,${beneficialCounter})" type="text" placeholder="Enter FinCEN ID" class="ben-fincenid form-field" />
						  </div>
					   </div>
					</div>
				 
				 <div id="benficialnamefieldp2${beneficialCounter}" style="display: none;"> 
				  	<div class="row">
				   		<div class="col-sm-6 mt-15" title="">
				    		<label class="main-label whsp" for="beneficialOwner[${beneficialCounter}].flegalName">Last name <em>*</em></label>
				    		<div class="form-fields">
				    			<input id="beneficialOwner[${beneficialCounter}].flegalName" name="beneficialOwner[${beneficialCounter}].flegalName" type="text" placeholder="Enter Last Name" class="ben-fincen-lname form-field" />
				    		</div>
				   		</div>
				   		<div class="col-sm-6 mt-15" title="">
				    		<label class="main-label" for="beneficialOwner[${beneficialCounter}].ffirstName">First name <em>*</em></label>
				     		<div class="form-fields">
				      			<input id="beneficialOwner[${beneficialCounter}].ffirstName" name="beneficialOwner[${beneficialCounter}].ffirstName" type="text" placeholder="Enter First Name" class="ben-fincen-fn form-field" />
				    		</div>
				   		</div>
				   		<div class="col-sm-12 mt-15">
				    		<p>Based on your FinCEN ID, all fields have been disabled. You are not required to fill them out here. However, please ensure to enter your First Name and Last Name for certificate generation.</p>
				   		</div>
				  	</div>
				 </div>
				 </div>

                </div>
         	 </div>

	   	   </div>

	   	   <!-- Beneficial Owner FinCEN ID End -->

	   	  </div>
	   	 <!-- Send Form to Beneficial Owner End -->	
	   	</div>

			  <div id="benificialfinid${beneficialCounter}">
			  	<div class="accordion def-acc-sec">
			  	 <!-- Exempt entity Start -->
			  	  <div class="accordion-item box-bg-sec">
			  	  	<div class="accordion-header row">
				     <div class="dah-left col-md-8"><h2>Exempt entity</h2></div>
				     <div class="dah-right col-md-4">
				      <span><a class="hover-modal-btn" href="#boirNeedHelp13"><img src="/images/help-icon.svg"></a></span>
				      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoAddOnThree${beneficialCounter}" aria-expanded="true" aria-controls="collapseBoAddOnThree${beneficialCounter}"></button>
				     </div>
				    </div>
				    <div id="collapseBoAddOnThree${beneficialCounter}" class="accordion-collapse collapse show">
				     <div class="accordion-body">
				      <div class="ab-top-para">
					  <p>Exempt entity: Check this box if the beneficial owner holds its ownership interest in the reporting company exclusively through one or more exempt entities, and the name of that exempt entity or entities are being reported in lieu of the beneficial owner’s information.</p>
			          </div>
			          <div class="sf-form-body">
			           <div class="form-rows" title="">
					    <label class="main-label">Exempt entity</label>
					     <div class="form-fields">
						  <div class="row">
							 <label class="col-sm-3">
							 <input type="radio" id="beneficialOwner[${beneficialCounter}].exemptEntity" name="beneficialOwner[${beneficialCounter}].exemptEntity" value="true" onchange="exemptEntityFunction(this,'${beneficialCounter}')" data-index="${beneficialCounter}" class="ben-exemptentity ben-exemptYes"/> Yes</label>
							 <label class="col-sm-3">
							 <input type="radio" id="beneficialOwner[${beneficialCounter}].exemptEntity" name="beneficialOwner[${beneficialCounter}].exemptEntity" value="false" onchange="exemptEntityFunction(this,'${beneficialCounter}')" class="ben-exemptentity" checked/> No</label>
						  </div>
					   	 </div>
					    </div>
			          </div>

				     </div>	
				    </div>

			  	  </div>
			  	 <!-- Exempt entity End -->	

			  	 <!-- Form of identification and issuing jurisdiction Start -->
   				<div class="benexemptidi${beneficialCounter}" id="benexemptidi${beneficialCounter}">
   				 <div class="accordion-item box-bg-sec">
   				  <div class="accordion-header row">
				    <div class="dah-left col-md-8"><h2>Form of identification and issuing jurisdiction</h2></div>
				    <div class="dah-right col-md-4">
				      <span><a class="hover-modal-btn" href="#boirNeedHelp14"><img src="/images/help-icon.svg"></a></span>
				     <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoAddOnFour${beneficialCounter}" aria-expanded="true" aria-controls="collapseBoAddOnFour${beneficialCounter}"></button>
				    </div>
				  </div>
				  <div id="collapseBoAddOnFour${beneficialCounter}" class="accordion-collapse collapse show">
				  	<div class="accordion-body">
				  	 <div class="ab-top-para">
			          <p>Please provide the company applicant's identification details and the jurisdiction that issued it. For a faster experience, you can use DocAI to quickly fill out your details by uploading your ID document.</p>
			         </div>
			         <div class="sf-form-body">
			         <div class="row two-fields">	
			          <div class="col-sm-6 mt-15" title="">
							 <label for="beneficialOwner[${beneficialCounter}].identificationDocuments.documentType" class="main-label">Identifying document type <em>*</em></label>
							 <div class="form-fields">
								<select class="ben-idt form-field" id="beneficialOwner[${beneficialCounter}].identificationDocuments.documentType" name="beneficialOwner[${beneficialCounter}].identificationDocuments.documentType">
									<option value="">Select an ID type</option>
                                    <option value="37">State issued driver's license</option>
                                    <option value="38">State/local/tribe-issued ID</option>
                                    <option value="39">U.S. passport</option>
                                    <option value="40">Foreign passport</option>
								</select>
							 </div>
						  </div>
						  <div class="col-sm-6 mt-15" title="">
						     <div class="fileinput">
						        <label class="main-label" for="beneficialOwner[${beneficialCounter}].identificationDocuments.document">Identifying document image <em>*</em></label>
						        <input type="file" class="ben-idi ben-file-input fileInput"  id="beneficialOwner[${beneficialCounter}].identificationDocuments.document" name="beneficialOwner[${beneficialCounter}].identificationDocuments.document"/>
						        <input type="hidden"  id="beneficialOwner[${beneficialCounter}].identificationDocuments.documentPath" name="beneficialOwner[${beneficialCounter}].identificationDocuments.documentPath"/>
						        <input type="hidden"  id="beneficialOwner[${beneficialCounter}].identificationDocuments.documentName" name="beneficialOwner[${beneficialCounter}].identificationDocuments.documentName"/>
								<span id="file-name-display" class="benFileNameDisplay${beneficialCounter}" style="display:none;"></span>
								<button class="blue-btn btn btn-four" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;" type="button" id="edit-button">Edit</button>															 
							</div>
						     <div id="progressWrapperBen" style="display:none;">
						        <progress id="progressBarBen" value="0" max="100"></progress>
						        <span id="progressTextBen">0%</span>
						     </div>
							 <div class="auto-data-extract-modal modal fade" id="auto-data-extract-popup2[${beneficialCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
 						   	     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
 						   	         <div class="container">
 						   	             <div class="user-data-form step-form-modal modal-content">
 						   	                 <button type="button" class="btn-close" data-bs-dismiss="modal" id="auto-data-extract-manual" aria-label="Close"></button>
 						   	                 <div class="modal-cont">
 						   	                     <div class="boddy">
 						   	                         <h3 style="text-align: left;">Automated Data Extraction</h3>
 						   	                         <p style="text-align: left;font-size: 15px;">Would you like the system to automatically extract the necessary fields from the Identifying Document you uploaded using Doc AI?</p>
 						   	                         <p style="  text-align: left;">This will help populate the relevant fields quickly and accurately. </p>
 						   	                         <a href="#" class="btn-four" id="auto-data-extract-proceed">Proceed with Doc AI </a>
 						   	                         <a href="#" class="btn-four"  data-bs-dismiss="modal" id="auto-data-extract-manual">I’ll Input Manually</a><br>
 						   	                     </div>
 						   	                 </div>
 						   	             </div>
 						   	         </div>
 						   	     </div>
 						   	 </div>
 							 <div class="extract-info-modal modal fade" id="extract-info-popup2[${beneficialCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
 					 		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
 					 		         <div class="container">
 					 		             <div class="user-data-form step-form-modal modal-content" style="max-width:; padding: -10px;">
										 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
 					 		                 <div class="modal-cont">
 					 		                     <div class="boddy">
 					 		                         <h3 style="text-align: left;">Extracting Information...</h3>
 					 		                         <p style="text-align: left;font-size: 15px;">We’re automatically extracting the necessary details from your uploaded document. This won’t take long!</p>
 					 		                         <p style="  text-align: left;font-size:11px;">Please do not refresh the page during this process. </p>
 					 		                         <img class="spinner1" src="images/loading.png">
 					 		                     </div>
 					 		                     <div class="modal-btns step-mod-btns" style="margin-top:-20px">
 					 		                     </div>
 					 		                 </div>
 					 		             </div>
 					 		         </div>
 					 		     </div>
 					 		 </div>
 							 <div class="foreignvehicle-modal modal fade" id="extract-info-complete2[${beneficialCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
 					 		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
 					 		         <div class="container">
 					 		             <div class="user-data-form step-form-modal modal-content w-600">
 					 		                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
 					 		                 <div class="modal-cont">
 					 		                     <div class="boddy">
 					 		                         <h3 class="modal-head">Auto-population Complete</h3>
 					 		                         <p class="text-left">
 					 		                             <b>Your document has been submitted successfully.</b>
 					 		                         </p>
 					 		                         <p class="text-left">The fields in this form have been auto-populated using the document you uploaded. Please review the information and make any necessary changes before proceeding </p>
 					 		                         <a href="#" data-bs-dismiss="modal" class="btn-four mt-20">GOT IT</a>
 					 		                         
 					 		                     </div>
 					 		                     <div class="modal-btns step-mod-btns" style="margin-top:-20px">
 					 		                     </div>
 					 		                 </div>
 					 		             </div>
 					 		         </div>
 					 		     </div>
 					 		 </div>
						     <div class="filelengthmodal modal fade" id="fileSizeTooLargeModal2[${beneficialCounter}]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
						        <div class="modal-dialog modal-fullscreen modal-dialog-centered">
						           <div class="container">
						              <div class="user-data-form step-form-modal modal-content">
						                 <div class="modal-cont">
						                    <h2>Oops! File Too Large</h2>
						                    <p>It looks like your file is too big. Please upload a file that's 4MB or less.</p>
						                    <div class="modal-btns step-mod-btns">
						                       <button type="button" class="blue-btn" data-bs-dismiss="modal" id="fileSizeTooSmallOk">Okay</button>
						                    </div>
						                 </div>
						              </div>
						           </div>
						        </div>
						     </div>
						  </div>
						  
							 <div class="col-sm-6 mt-15" title="">
								<label class="main-label" for="beneficialOwner[${beneficialCounter}].identificationDocuments.documentNumber">Identifying document number <em>*</em></label>
								<div class="form-fields">
								   <input type="text" name="beneficialOwner[${beneficialCounter}].identificationDocuments.documentNumber" id="beneficialOwner[${beneficialCounter}].identificationDocuments.documentNumber" placeholder="Enter Tax Identification number" class="ben-idn form-field" />
								</div>
							 </div>
							 <div class="col-sm-6 mt-15" title="">
								<label class="main-label" for="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerCountry">Country/Jurisdiction <em>*</em></label>
								<div class="form-fields">
								   <select class="ben-counjuri form-field" id="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerCountry" name="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerCountry">
									  <option value="">Select Country</option>
									  <option value="US">United States of America</option>
									  <option value="AS">American Samoa</option>
									  <option value="GU">Guam</option>
									  <option value="MH">Marshall Islands</option>
									  <option value="FM">Micronesia, Federated States</option>
									  <option value="MP">Northern Mariana Islands</option>
									  <option value="PW">Palau</option>
									  <option value="PR">Puerto Rico</option>
									  <option value="VI">U.S. Virgin Islands</option>
									  <option value="AF">Afghanistan</option>
									  <option value="AX">Åland Islands</option>
									  <option value="AL">Albania</option>
									  <option value="DZ">Algeria</option>
									  <option value="AD">Andorra</option>
									  <option value="AO">Angola</option>
									  <option value="AI">Anguilla</option>
									  <option value="AQ">Antarctica</option>
									  <option value="AG">Antigua And Barbuda</option>
									  <option value="AR">Argentina</option>
									  <option value="AM">Armenia</option>
									  <option value="AW">Aruba</option>
									  <option value="AU">Australia</option>
									  <option value="AT">Austria</option>
									  <option value="AZ">Azerbaijan</option>
									  <option value="BS">Bahamas</option>
									  <option value="BH">Bahrain</option>
									  <option value="BD">Bangladesh</option>
									  <option value="BB">Barbados</option>
									  <option value="BY">Belarus</option>
									  <option value="BE">Belgium</option>
									  <option value="BZ">Belize</option>
									  <option value="BJ">Benin</option>
									  <option value="BM">Bermuda</option>
									  <option value="BT">Bhutan</option>
									  <option value="BO">Bolivia, Plurinational State Of</option>
									  <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
									  <option value="BA">Bosnia And Herzegovina</option>
									  <option value="BW">Botswana</option>
									  <option value="BV">Bouvet Island</option>
									  <option value="BR">Brazil</option>
									  <option value="IO">British Indian Ocean Territory</option>
									  <option value="BN">Brunei Darussalam</option>
									  <option value="BG">Bulgaria</option>
									  <option value="BF">Burkina Faso</option>
									  <option value="BI">Burundi</option>
									  <option value="KH">Cambodia</option>
									  <option value="CM">Cameroon</option>
									  <option value="CA">Canada</option>
									  <option value="CV">Cape Verde</option>
									  <option value="KY">Cayman Islands</option>
									  <option value="CF">Central African Republic</option>
									  <option value="TD">Chad</option>
									  <option value="CL">Chile</option>
									  <option value="CN">China</option>
									  <option value="CX">Christmas Island</option>
									  <option value="CC">Cocos (Keeling) Islands</option>
									  <option value="CO">Colombia</option>
									  <option value="KM">Comoros</option>
									  <option value="CG">Congo</option>
									  <option value="CD">Congo, The Democratic Republic Of The</option>
									  <option value="CK">Cook Islands</option>
									  <option value="CR">Costa Rica</option>
									  <option value="CI">Côte D'ivoire</option>
									  <option value="HR">Croatia</option>
									  <option value="CU">Cuba</option>
									  <option value="CW">Curaçao</option>
									  <option value="CY">Cyprus</option>
									  <option value="CZ">Czech Republic</option>
									  <option value="DK">Denmark</option>
									  <option value="DJ">Djibouti</option>
									  <option value="DM">Dominica</option>
									  <option value="DO">Dominican Republic</option>
									  <option value="EC">Ecuador</option>
									  <option value="EG">Egypt</option>
									  <option value="SV">El Salvador</option>
									  <option value="GQ">Equatorial Guinea</option>
									  <option value="ER">Eritrea</option>
									  <option value="EE">Estonia</option>
									  <option value="ET">Ethiopia</option>
									  <option value="FK">Falkland Islands (Malvinas)</option>
									  <option value="FO">Faroe Islands</option>
									  <option value="FJ">Fiji</option>
									  <option value="FI">Finland</option>
									  <option value="FR">France</option>
									  <option value="GF">French Guiana</option>
									  <option value="PF">French Polynesia</option>
									  <option value="TF">French Southern Territories</option>
									  <option value="GA">Gabon</option>
									  <option value="GM">Gambia</option>
									  <option value="GE">Georgia</option>
									  <option value="DE">Germany</option>
									  <option value="GH">Ghana</option>
									  <option value="GI">Gibraltar</option>
									  <option value="GR">Greece</option>
									  <option value="GL">Greenland</option>
									  <option value="GD">Grenada</option>
									  <option value="GP">Guadeloupe</option>
									  <option value="GT">Guatemala</option>
									  <option value="GG">Guernsey</option>
									  <option value="GN">Guinea</option>
									  <option value="GW">Guinea-bissau</option>
									  <option value="GY">Guyana</option>
									  <option value="HT">Haiti</option>
									  <option value="HM">Heard Island And Mcdonald Islands</option>
									  <option value="VA">Holy See (Vatican City State)</option>
									  <option value="HN">Honduras</option>
									  <option value="HK">Hong Kong</option>
									  <option value="HU">Hungary</option>
									  <option value="IS">Iceland</option>
									  <option value="IN">India</option>
									  <option value="ID">Indonesia</option>
									  <option value="IR">Iran, Islamic Republic Of</option>
									  <option value="IQ">Iraq</option>
									  <option value="IE">Ireland</option>
									  <option value="IM">Isle Of Man</option>
									  <option value="IL">Israel</option>
									  <option value="IT">Italy</option>
									  <option value="JM">Jamaica</option>
									  <option value="JP">Japan</option>
									  <option value="JE">Jersey</option>
									  <option value="JO">Jordan</option>
									  <option value="KZ">Kazakhstan</option>
									  <option value="KE">Kenya</option>
									  <option value="KI">Kiribati</option>
									  <option value="KP">Korea, Democratic People's Republic Of</option>
									  <option value="KR">Korea, Republic Of</option>
									  <option value="KW">Kuwait</option>
									  <option value="KG">Kyrgyzstan</option>
									  <option value="LA">Lao People's Democratic Republic</option>
									  <option value="LV">Latvia</option>
									  <option value="LB">Lebanon</option>
									  <option value="LS">Lesotho</option>
									  <option value="LR">Liberia</option>
									  <option value="LY">Libya</option>
									  <option value="LI">Liechtenstein</option>
									  <option value="LT">Lithuania</option>
									  <option value="LU">Luxembourg</option>
									  <option value="MO">Macao</option>
									  <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
									  <option value="MG">Madagascar</option>
									  <option value="MW">Malawi</option>
									  <option value="MY">Malaysia</option>
									  <option value="MV">Maldives</option>
									  <option value="ML">Mali</option>
									  <option value="MT">Malta</option>
									  <option value="MQ">Martinique</option>
									  <option value="MR">Mauritania</option>
									  <option value="MU">Mauritius</option>
									  <option value="YT">Mayotte</option>
									  <option value="MX">Mexico</option>
									  <option value="MD">Moldova, Republic Of</option>
									  <option value="MC">Monaco</option>
									  <option value="MN">Mongolia</option>
									  <option value="ME">Montenegro</option>
									  <option value="MS">Montserrat</option>
									  <option value="MA">Morocco</option>
									  <option value="MZ">Mozambique</option>
									  <option value="MM">Myanmar</option>
									  <option value="NA">Namibia</option>
									  <option value="NR">Nauru</option>
									  <option value="NP">Nepal</option>
									  <option value="NL">Netherlands</option>
									  <option value="NC">New Caledonia</option>
									  <option value="NZ">New Zealand</option>
									  <option value="NI">Nicaragua</option>
									  <option value="NE">Niger</option>
									  <option value="NG">Nigeria</option>
									  <option value="NU">Niue</option>
									  <option value="NF">Norfolk Island</option>
									  <option value="NO">Norway</option>
									  <option value="OM">Oman</option>
									  <option value="PK">Pakistan</option>
									  <option value="PS">Palestinian Territory, Occupied</option>
									  <option value="PA">Panama</option>
									  <option value="PG">Papua New Guinea</option>
									  <option value="PY">Paraguay</option>
									  <option value="PE">Peru</option>
									  <option value="PH">Philippines</option>
									  <option value="PN">Pitcairn</option>
									  <option value="PL">Poland</option>
									  <option value="PT">Portugal</option>
									  <option value="QA">Qatar</option>
									  <option value="RE">Réunion</option>
									  <option value="RO">Romania</option>
									  <option value="RU">Russian Federation</option>
									  <option value="RW">Rwanda</option>
									  <option value="BL">Saint Barthélemy</option>
									  <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
									  <option value="KN">Saint Kitts And Nevis</option>
									  <option value="LC">Saint Lucia</option>
									  <option value="MF">Saint Martin (french Part)</option>
									  <option value="PM">Saint Pierre And Miquelon</option>
									  <option value="VC">Saint Vincent And The Grenadines</option>
									  <option value="WS">Samoa</option>
									  <option value="SM">San Marino</option>
									  <option value="ST">Sao Tome And Principe</option>
									  <option value="SA">Saudi Arabia</option>
									  <option value="SN">Senegal</option>
									  <option value="RS">Serbia</option>
									  <option value="SC">Seychelles</option>
									  <option value="SL">Sierra Leone</option>
									  <option value="SG">Singapore</option>
									  <option value="SX">Sint Maarten (dutch Part)</option>
									  <option value="SK">Slovakia</option>
									  <option value="SI">Slovenia</option>
									  <option value="SB">Solomon Islands</option>
									  <option value="SO">Somalia</option>
									  <option value="ZA">South Africa</option>
									  <option value="GS">South Georgia And The South Sandwich Islands</option>
									  <option value="SS">South Sudan</option>
									  <option value="ES">Spain</option>
									  <option value="LK">Sri Lanka</option>
									  <option value="SD">Sudan</option>
									  <option value="SR">Suriname</option>
									  <option value="SJ">Svalbard And Jan Mayen</option>
									  <option value="SZ">Swaziland</option>
									  <option value="SE">Sweden</option>
									  <option value="CH">Switzerland</option>
									  <option value="SY">Syrian Arab Republic</option>
									  <option value="TW">Taiwan</option>
									  <option value="TJ">Tajikistan</option>
									  <option value="TZ">Tanzania, United Republic Of</option>
									  <option value="TH">Thailand</option>
									  <option value="TL">Timor-leste</option>
									  <option value="TG">Togo</option>
									  <option value="TK">Tokelau</option>
									  <option value="TO">Tonga</option>
									  <option value="TT">Trinidad And Tobago</option>
									  <option value="TN">Tunisia</option>
									  <option value="TR">Turkey</option>
									  <option value="TM">Turkmenistan</option>
									  <option value="TC">Turks And Caicos Islands</option>
									  <option value="TV">Tuvalu</option>
									  <option value="UG">Uganda</option>
									  <option value="UA">Ukraine</option>
									  <option value="AE">United Arab Emirates</option>
									  <option value="GB">United Kingdom</option>
									  <option value="UY">Uruguay</option>
									  <option value="UZ">Uzbekistan</option>
									  <option value="VU">Vanuatu</option>
									  <option value="VE">Venezuela, Bolivarian Republic Of</option>
									  <option value="VN">Viet Nam</option>
									  <option value="VG">Virgin Islands, British</option>
									  <option value="WF">Wallis And Futuna</option>
									  <option value="EH">Western Sahara</option>
									  <option value="YE">Yemen</option>
									  <option value="ZM">Zambia</option>
									  <option value="ZW">Zimbabwe</option>
								   </select>
								</div>
							 </div>
							 <div class="col-sm-6 mt-15" title="">
								   <label class="main-label" for="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerState">State <em>*</em></label>
								   <div class="form-fields">
									  <select class="ben-state form-field" id="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerState" name="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerState">
										 <option value="">Select a State </option>
										 <option value="AL">Alabama</option>
										 <option value="AK">Alaska</option>
										 <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
										 <option value="AA">Armed Forces Americas (except Canada)</option>
										 <option value="AP">Armed Forces Pacific</option>
										 <option value="AZ">Arizona</option>
										 <option value="AR">Arkansas</option>
										 <option value="CA">California</option>
										 <option value="CO">Colorado</option>
										 <option value="CT">Connecticut</option>
										 <option value="DE">Delaware</option>
										 <option value="DC">District of Columbia</option>
										 <option value="FL">Florida</option>
										 <option value="GA">Georgia</option>
										 <option value="HI">Hawaii</option>
										 <option value="ID">Idaho</option>
										 <option value="IL">Illinois</option>
										 <option value="IN">Indiana</option>
										 <option value="IA">Iowa</option>
										 <option value="KS">Kansas</option>
										 <option value="KY">Kentucky</option>
										 <option value="LA">Louisiana</option>
										 <option value="ME">Maine</option>
										 <option value="MD">Maryland</option>
										 <option value="MA">Massachusetts</option>
										 <option value="MI">Michigan</option>
										 <option value="MN">Minnesota</option>
										 <option value="MS">Mississippi</option>
										 <option value="MO">Missouri</option>
										 <option value="MT">Montana</option>
										 <option value="NE">Nebraska</option>
										 <option value="NV">Nevada</option>
										 <option value="NH">New Hampshire</option>
										 <option value="NJ">New Jersey</option>
										 <option value="NM">New Mexico</option>
										 <option value="NY">New York</option>
										 <option value="NC">North Carolina</option>
										 <option value="ND">North Dakota</option>
										 <option value="OH">Ohio</option>
										 <option value="OK">Oklahoma</option>
										 <option value="OR">Oregon</option>
										 <option value="PA">Pennsylvania</option>
										 <option value="RI">Rhode Island</option>
										 <option value="SC">South Carolina</option>
										 <option value="SD">South Dakota</option>
										 <option value="TN">Tennessee</option>
										 <option value="TX">Texas</option>
										 <option value="UT">Utah</option>
										 <option value="VT">Vermont</option>
										 <option value="VA">Virginia</option>
										 <option value="WA">Washington</option>
										 <option value="WV">West Virginia</option>
										 <option value="WI">Wisconsin</option>
										 <option value="WY">Wyoming</option>
									  </select>
								   </div>
								</div>
								<div class="col-sm-6 mt-15" title="">
								   <label class="main-label" for="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerLocalOrTribal">Local/Tribal <em>*</em></label>
								   <div class="form-fields">
									  <select disabled class="ben-localtrib form-field" id="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerLocalOrTribal" name="beneficialOwner[${beneficialCounter}].identificationDocuments.issuerLocalOrTribal">
										 <option value="">Select Local/Tribal</option>
										 <option value="Absentee-Shawnee">Absentee-Shawnee Tribe of Indians of Oklahoma</option>
										 <option value="Agdaagux">Agdaagux Tribe of King Cove</option>
										 <option value="Agua Caliente">Agua Caliente Band of Cahuilla Indians of the Agua Caliente Indian Reservation, California</option>
										 <option value="Ak Chin">Ak-Chin Indian Community</option>
										 <option value="Akiachak">Akiachak Native Community</option>
										 <option value="Akiak">Akiak Native Community</option>
										 <option value="Alabama-Coushatta">Alabama-Coushatta Tribe of Texas</option>
										 <option value="Alabama-Quassarte Tribal Town">Alabama-Quassarte Tribal Town</option>
										 <option value="Alatna">Alatna Village</option>
										 <option value="Algaaciq">Algaaciq Native Village (St. Mary's)</option>
										 <option value="Allakaket">Allakaket Village</option>
										 <option value="Alturas">Alturas Indian Rancheria, California</option>
										 <option value="Alutiiq Tribe of Old Harbor">Alutiiq Tribe of Old Harbor</option>
										 <option value="Angoon">Angoon Community Association</option>
										 <option value="Anvik">Anvik Village</option>
										 <option value="Apache">Apache Tribe of Oklahoma</option>
										 <option value="Arctic Village">Arctic Village (See Native Village of Venetie Tribal Government)</option>
										 <option value="Asa'carsarmiut">Asa'carsarmiut Tribe</option>
										 <option value="Assiniboine and Sioux">Assiniboine &amp; Sioux Tribes of the Fort Peck Indian Reservation, Montana</option>
										 <option value="Augustine">Augustine Band of Cahuilla Indians, California</option>
										 <option value="Bad River Band">Bad River Band of the Lake Superior Tribe of Chippewa Indians of the Bad River Reservation, Wisconsin</option>
										 <option value="Bay Mills">Bay Mills Indian Community, Michigan</option>
										 <option value="Bear River">Bear River Band of the Rohnerville Rancheria, California</option>
										 <option value="Beaver">Beaver Village</option>
										 <option value="Berry Creek">Berry Creek Rancheria of Maidu Indians of California</option>
										 <option value="Big Lagoon">Big Lagoon Rancheria, California</option>
										 <option value="Big Pine Reservation">Big Pine Paiute Tribe of the Owens Valley</option>
										 <option value="Big Sandy">Big Sandy Rancheria of Western Mono Indians of California</option>
										 <option value="Big Valley Rancheria">Big Valley Band of Pomo Indians of the Big Valley Rancheria, California</option>
										 <option value="Birch Creek">Birch Creek Tribe</option>
										 <option value="Bishop Paiute">Bishop Paiute Tribe</option>
										 <option value="Blackfeet">Blackfeet Tribe of the Blackfeet Indian Reservation of Montana</option>
										 <option value="Blue Lake">Blue Lake Rancheria, California</option>
										 <option value="Bridgeport Indian Colony">Bridgeport Indian Colony</option>
										 <option value="Buena Vista Rancheria">Buena Vista Rancheria of Me-Wuk Indians of California</option>
										 <option value="Burns Paiute">Burns Paiute Tribe</option>
										 <option value="Cabazon">Cabazon Band of Mission Indians, California</option>
										 <option value="Cachil DeHe">Cachil DeHe Band of Wintun Indians of the Colusa Indian Community of the Colusa Rancheria, California</option>
										 <option value="Caddo">Caddo Nation of Oklahoma</option>
										 <option value="Cahto">Cahto Tribe of the Laytonville Rancheria</option>
										 <option value="Cahuilla">Cahuilla Band of Indians</option>
										 <option value="California Valley">California Valley Miwok Tribe, California</option>
										 <option value="Campo">Campo Band of Diegueno Mission Indians of the Campo Indian Reservation, California</option>
										 <option value="Capitan Grande">Capitan Grande Band of Diegueno Mission Indians of California (Barona Group of Capitan Grande Band of Mission Indians of the Barona Reservation, California)</option>
										 <option value="Capitan Grande Band">Capitan Grande Band of Diegueno Mission Indians of California</option>
										 <option value="Viejas">Capitan Grande Band of Diegueno Mission Indians of California: Viejas (Baron Long) Group of Capitan Grande Band of Mission Indians of the Viejas Reservation, California</option>
										 <option value="Catawba">Catawba Indian Nation (aka Catawba Indian Tribe of South Carolina)</option>
										 <option value="Cayuga Nation of New York">Cayuga Nation</option>
										 <option value="Cedarville">Cedarville Rancheria, California</option>
										 <option value="Tlingit &amp; Haida">Central Council of the Tlingit &amp; Haida Indian Tribes</option>
										 <option value="Chalkyitsik">Chalkyitsik Village</option>
										 <option value="Cheesh-Na">Cheesh-Na Tribe</option>
										 <option value="Chemehuevi">Chemehuevi Indian Tribe of the Chemehuevi Reservation, California</option>
										 <option value="Cher-Ae Heights">Cher-Ae Heights Indian Community of the Trinidad Rancheria, California</option>
										 <option value="Cherokee Nation">Cherokee Nation</option>
										 <option value="Chevak">Chevak Native Village</option>
										 <option value="Cheyenne River">Cheyenne and Arapaho Tribes, Oklahoma</option>
										 <option value="Cheyenne River Sioux Tribe">Cheyenne River Sioux Tribe of the Cheyenne River Reservation, South Dakota</option>
										 <option value="Chickahominy Indians-Eastern Division">Chickahominy Indian Tribe - Eastern Division</option>
										 <option value="Chickahominy Indian Tribe, Inc.">Chickahominy Indian Tribe</option>
										 <option value="Chickaloon">Chickaloon Native Village</option>
										 <option value="Chicken Ranch">Chicken Ranch Rancheria of Me-Wuk Indians of California</option>
										 <option value="Chignik Bay">Chignik Bay Tribal Council</option>
										 <option value="Chignik Lake">Chignik Lake Village</option>
										 <option value="Chilkat">Chilkat Indian Village (Klukwan)</option>
										 <option value="Chilkoot">Chilkoot Indian Association (Haines)</option>
										 <option value="Chinik">Chinik Eskimo Community (Golovin)</option>
										 <option value="Chippewa-Cree">Chippewa Cree Indians of the Rocky Boy's Reservation, Montana</option>
										 <option value="Chitimacha">Chitimacha Tribe of Louisiana</option>
										 <option value="Chuloonawick">Chuloonawick Native Village</option>
										 <option value="Circle">Circle Native Community</option>
										 <option value="Citizen Potawatomi">Citizen Potawatomi Nation, Oklahoma</option>
										 <option value="Cloverdale">Cloverdale Rancheria of Pomo Indians of California</option>
										 <option value="Cocopah">Cocopah Tribe of Arizona</option>
										 <option value="Coeur D'Alene">Coeur D'Alene Tribe</option>
										 <option value="Cold Springs">Cold Springs Rancheria of Mono Indians of California</option>
										 <option value="Colorado River">Colorado River Indian Tribes of the Colorado River Indian Reservation, Arizona and California</option>
										 <option value="Comanche">Comanche Nation, Oklahoma</option>
										 <option value="Confederated Salish">Confederated Salish and Kootenai Tribes of the Flathead Reservation</option>
										 <option value="Confederated Yakama">Confederated Tribes and Bands of the Yakama Nation</option>
										 <option value="Siletz Tribe">Confederated Tribes of Siletz Indians of Oregon</option>
										 <option value="Chehalis">Confederated Tribes of the Chehalis Reservation</option>
										 <option value="Confederated Colville">Confederated Tribes of the Colville Reservation</option>
										 <option value="Confederated Coos">Confederated Tribes of the Coos, Lower Umpqua and Siuslaw Indians</option>
										 <option value="Confederated Goshute">Confederated Tribes of the Goshute Reservation, Nevada and Utah</option>
										 <option value="Grand Ronde Tribes">Confederated Tribes of the Grand Ronde Community of Oregon</option>
										 <option value="Umatilla Tribe">Confederated Tribes of the Umatilla Indian Reservation</option>
										 <option value="Warms Springs Tribe">Confederated Tribes of the Warm Springs Reservation of Oregon</option>
										 <option value="Coquille">Coquille Indian Tribe</option>
										 <option value="Coushatta">Coushatta Tribe of Louisiana</option>
										 <option value="Cow Creek">Cow Creek Band of Umpqua Tribe of Indians</option>
										 <option value="Cowlitz">Cowlitz Indian Tribe</option>
										 <option value="Coyote Valley">Coyote Valley Band of Pomo Indians of California</option>
										 <option value="Craig">Craig Tribal Association</option>
										 <option value="Crow Creek">Crow Creek Sioux Tribe of the Crow Creek Reservation, South Dakota</option>
										 <option value="Crow">Crow Tribe of Montana</option>
										 <option value="Curyung">Curyung Tribal Council</option>
										 <option value="Delaware Nation">Delaware Nation, Oklahoma</option>
										 <option value="Delaware Tribe of Indians">Delaware Tribe of Indians</option>
										 <option value="Douglas">Douglas Indian Association</option>
										 <option value="Dry Creek">Dry Creek Rancheria Band of Pomo Indians, California</option>
										 <option value="Duckwater">Duckwater Shoshone Tribe of the Duckwater Reservation, Nevada</option>
										 <option value="Eastern Cherokee">Eastern Band of Cherokee Indians</option>
										 <option value="Eastern Shawnee Tribe of Oklahoma">Eastern Shawnee Tribe of Oklahoma</option>
										 <option value="Eastern Shoshone">Eastern Shoshone Tribe of the Wind River Reservation, Wyoming</option>
										 <option value="Egegik">Egegik Village</option>
										 <option value="Eklutna">Eklutna Native Village</option>
										 <option value="Elem">Elem Indian Colony of Pomo Indians of the Sulphur Bank Rancheria, California</option>
										 <option value="Elk Valley">Elk Valley Rancheria, California</option>
										 <option value="Ely Shoshone">Ely Shoshone Tribe of Nevada</option>
										 <option value="Emmonak">Emmonak Village</option>
										 <option value="Enterprise">Enterprise Rancheria of Maidu Indians of California</option>
										 <option value="Evansville">Evansville Village (aka Bettles Field)</option>
										 <option value="Ewiiaapaayp">Ewiiaapaayp Band of Kumeyaay Indians, California</option>
										 <option value="Federated Indians of Graton">Federated Indians of Graton Rancheria, California</option>
										 <option value="Flandreau">Flandreau Santee Sioux Tribe of South Dakota</option>
										 <option value="Forest County">Forest County Potawatomi Community, Wisconsin</option>
										 <option value="Assiniboine and Gros Ventre Tribes">Fort Belknap Indian Community of the Fort Belknap Reservation of Montana</option>
										 <option value="Fort Bidwell">Fort Bidwell Indian Community of the Fort Bidwell Reservation of California</option>
										 <option value="Fort Independence">Fort Independence Indian Community of Paiute Indians of the Fort Independence Reservation, California</option>
										 <option value="Fort McDermitt">Fort McDermitt Paiute and Shoshone Tribes of the Fort McDermitt Indian Reservation, Nevada and Oregon</option>
										 <option value="Fort McDowell">Fort McDowell Yavapai Nation, Arizona</option>
										 <option value="Fort Mojave">Fort Mojave Indian Tribe of Arizona, California &amp; Nevada</option>
										 <option value="Fort Sill">Fort Sill Apache Tribe of Oklahoma</option>
										 <option value="Galena">Galena Village (aka Louden Village)</option>
										 <option value="Gila River">Gila River Indian Community of the Gila River Indian Reservation, Arizona</option>
										 <option value="Grand Traverse">Grand Traverse Band of Ottawa and Chippewa Indians, Michigan</option>
										 <option value="Greenville">Greenville Rancheria</option>
										 <option value="Grindstone">Grindstone Indian Rancheria of Wintun-Wailaki Indians of California</option>
										 <option value="Guidiville">Guidiville Rancheria of California</option>
										 <option value="Gulkana">Gulkana Village Council</option>
										 <option value="Habematolel">Habematolel Pomo of Upper Lake, California</option>
										 <option value="Hannahville">Hannahville Indian Community, Michigan</option>
										 <option value="Havasupai">Havasupai Tribe of the Havasupai Reservation, Arizona</option>
										 <option value="Healy Lake">Healy Lake Village</option>
										 <option value="Ho-Chunk">Ho-Chunk Nation of Wisconsin</option>
										 <option value="Hoh">Hoh Indian Tribe</option>
										 <option value="Holy Cross">Holy Cross Tribe</option>
										 <option value="Hoonah">Hoonah Indian Association</option>
										 <option value="Hoopa">Hoopa Valley Tribe, California</option>
										 <option value="Hopi">Hopi Tribe of Arizona</option>
										 <option value="Hopland">Hopland Band of Pomo Indians, California</option>
										 <option value="Houlton">Houlton Band of Maliseet Indians</option>
										 <option value="Hualapai">Hualapai Indian Tribe of the Hualapai Indian Reservation, Arizona</option>
										 <option value="Hughes">Hughes Village</option>
										 <option value="Huslia">Huslia Village</option>
										 <option value="Hydaburg">Hydaburg Cooperative Association</option>
										 <option value="Igiugig">Igiugig Village</option>
										 <option value="Iipay">Iipay Nation of Santa Ysabel, California</option>
										 <option value="Inaja">Inaja Band of Diegueno Mission Indians of the Inaja and Cosmit Reservation, California</option>
										 <option value="Inupiat Community of the Arctic Slope">Inupiat Community of the Arctic Slope</option>
										 <option value="Ione">Ione Band of Miwok Indians of California</option>
										 <option value="Iowa of Kansas">Iowa Tribe of Kansas and Nebraska</option>
										 <option value="Iowa of Oklahoma">Iowa Tribe of Oklahoma</option>
										 <option value="Iqugmiut">Iqugmiut Traditional Council</option>
										 <option value="Ivanof Bay Tribe">Ivanof Bay Tribe</option>
										 <option value="Jackson">Jackson Band of Miwuk Indians</option>
										 <option value="Jamestown">Jamestown S'Klallam Tribe</option>
										 <option value="Jamul">Jamul Indian Village of California</option>
										 <option value="Jena">Jena Band of Choctaw Indians</option>
										 <option value="Jicarilla">Jicarilla Apache Nation, New Mexico</option>
										 <option value="Kaguyuk">Kaguyak Village</option>
										 <option value="Kaibab">Kaibab Band of Paiute Indians of the Kaibab Indian Reservation, Arizona</option>
										 <option value="Kaktovik">Kaktovik Village (aka Barter Island)</option>
										 <option value="Kalispel">Kalispel Indian Community of the Kalispel Reservation</option>
										 <option value="Karuk">Karuk Tribe</option>
										 <option value="Kashia">Kashia Band of Pomo Indians of the Stewarts Point Rancheria, California</option>
										 <option value="Kasigluk">Kasigluk Traditional Elders Council</option>
										 <option value="Kaw">Kaw Nation, Oklahoma</option>
										 <option value="Kenaitze">Kenaitze Indian Tribe</option>
										 <option value="Ketchikan">Ketchikan Indian Community</option>
										 <option value="Keweenaw">Keweenaw Bay Indian Community, Michigan</option>
										 <option value="Kialegee Tribal Town">Kialegee Tribal Town</option>
										 <option value="Kickapoo of Texas">Kickapoo Traditional Tribe of Texas</option>
										 <option value="Kickapoo Tribe in Kansas">Kickapoo Tribe of Indians of the Kickapoo Reservation in Kansas</option>
										 <option value="Kickapoo of Oklahoma">Kickapoo Tribe of Oklahoma</option>
										 <option value="King Island">King Island Native Community</option>
										 <option value="King Salmon">King Salmon Tribe</option>
										 <option value="Kiowa Tribe">Kiowa  Indian Tribe of Oklahoma</option>
										 <option value="Klamath">Klamath Tribes</option>
										 <option value="Klawock">Klawock Cooperative Association</option>
										 <option value="Cortina">Kletsel Dehe Band of Wintun Indians</option>
										 <option value="Knik">Knik Tribe</option>
										 <option value="Koi">Koi Nation of Northern California</option>
										 <option value="Kokhanok">Kokhanok Village</option>
										 <option value="Kootenai">Kootenai Tribe of Idaho</option>
										 <option value="Koyukuk">Koyukuk Native Village</option>
										 <option value="La Jolla">La Jolla Band of Luiseno Indians, California</option>
										 <option value="La Posta">La Posta Band of Diegueno Mission Indians of the La Posta Indian Reservation, California</option>
										 <option value="Lac Courte Oreilles">Lac Courte Oreilles Band of Lake Superior Chippewa Indians of Wisconsin</option>
										 <option value="Lac du Flambeau">Lac du Flambeau Band of Lake Superior Chippewa Indians of the Lac du Flambeau Reservation of Wisconsin</option>
										 <option value="Lac Vieux">Lac Vieux Desert Band of Lake Superior Chippewa Indians of Michigan</option>
										 <option value="Las Vegas">Las Vegas Tribe of Paiute Indians of the Las Vegas Indian Colony, Nevada</option>
										 <option value="Levelock">Levelock Village</option>
										 <option value="Lime">Lime Village</option>
										 <option value="Little River">Little River Band of Ottawa Indians, Michigan</option>
										 <option value="Little Shell Tribe">Little Shell Tribe of Chippewa Indians of Montana</option>
										 <option value="Little Traverse">Little Traverse Bay Bands of Odawa Indians, Michigan</option>
										 <option value="Lone Pine">Lone Pine Paiute-Shoshone Tribe</option>
										 <option value="Los Coyotes">Los Coyotes Band of Cahuilla and Cupeno Indians, California</option>
										 <option value="Lovelock">Lovelock Paiute Tribe of the Lovelock Indian Colony, Nevada</option>
										 <option value="Lower Brule">Lower Brule Sioux Tribe of the Lower Brule Reservation, South Dakota</option>
										 <option value="Lower Elwha">Lower Elwha Tribal Community</option>
										 <option value="Lower Sioux">Lower Sioux Indian Community in the State of Minnesota</option>
										 <option value="Lummi">Lummi Tribe of the Lummi Reservation</option>
										 <option value="Lytton">Lytton Rancheria of California</option>
										 <option value="Makah">Makah Indian Tribe of the Makah Indian Reservation</option>
										 <option value="Manchester">Manchester Band of Pomo Indians of the Manchester Rancheria, California</option>
										 <option value="Manley Hot Springs">Manley Hot Springs Village</option>
										 <option value="Manokotak">Manokotak Village</option>
										 <option value="Manzanita">Manzanita Band of Diegueno Mission Indians of the Manzanita Reservation, California</option>
										 <option value="Mashantucket Pequot">Mashantucket Pequot Indian Tribe</option>
										 <option value="Mashpee">Mashpee Wampanoag Tribe</option>
										 <option value="Match-e-be-nash-she-wish Band">Match-e-be-nash-she-wish Band of Pottawatomi Indians of Michigan</option>
										 <option value="Mcgrath">McGrath Native Village</option>
										 <option value="Mechoopda">Mechoopda Indian Tribe of Chico Rancheria, California</option>
										 <option value="Menominee">Menominee Indian Tribe of Wisconsin</option>
										 <option value="Mentasta">Mentasta Traditional Council</option>
										 <option value="Mesa Grande">Mesa Grande Band of Diegueno Mission Indians of the Mesa Grande Reservation, California</option>
										 <option value="Mescalero Apache">Mescalero Apache Tribe of the Mescalero Reservation, New Mexico</option>
										 <option value="Metlakatla">Metlakatla Indian Community, Annette Island Reserve</option>
										 <option value="Miami Tribe of Oklahoma">Miami Tribe of Oklahoma</option>
										 <option value="Miccosukee">Miccosukee Tribe of Indians</option>
										 <option value="Middletown">Middletown Rancheria of Pomo Indians of California</option>
										 <option value="Mi'kmaq Nation">Mi'kmaq Nation</option>
										 <option value="Bois Forte">Minnesota Chippewa Tribe - Bois Forte Band (Nett Lake)</option>
										 <option value="Fond du Lac">Minnesota Chippewa Tribe - Fond du Lac Band</option>
										 <option value="Grand Portage">Minnesota Chippewa Tribe - Grand Portage Band</option>
										 <option value="Leech Lake">Minnesota Chippewa Tribe - Leech Lake Band</option>
										 <option value="Mille Lacs">Minnesota Chippewa Tribe - Mille Lacs Band</option>
										 <option value="White Earth">Minnesota Chippewa Tribe - White Earth Band</option>
										 <option value="Minnesota Chippewa">Minnesota Chippewa Tribe, Minnesota</option>
										 <option value="Mississippi Choctaw">Mississippi Band of Choctaw Indians</option>
										 <option value="Moapa">Moapa Band of Paiute Indians of the Moapa River Indian Reservation, Nevada</option>
										 <option value="Modoc Nation">Modoc Nation</option>
										 <option value="Mohegan">Mohegan Tribe of Indians of Connecticut</option>
										 <option value="Monacan Indian Nation">Monacan Indian Nation</option>
										 <option value="Mooretown">Mooretown Rancheria of Maidu Indians of California</option>
										 <option value="Morongo">Morongo Band of Mission Indians, California</option>
										 <option value="Muckleshoot">Muckleshoot Indian Tribe</option>
										 <option value="Naknek">Naknek Native Village</option>
										 <option value="Nansemond Indian Tribe">Nansemond Indian Nation</option>
										 <option value="Narragansett">Narragansett Indian Tribe</option>
										 <option value="Afognak">Native Village of Afognak</option>
										 <option value="Akhiok">Native Village of Akhiok</option>
										 <option value="Akutan">Native Village of Akutan</option>
										 <option value="Aleknagik">Native Village of Aleknagik</option>
										 <option value="Ambler">Native Village of Ambler</option>
										 <option value="Atka">Native Village of Atka</option>
										 <option value="Native Village of Atqasuk">Native Village of Atqasuk</option>
										 <option value="Barrow">Native Village of Barrow Inupiat Traditional Government</option>
										 <option value="Belkofski">Native Village of Belkofski</option>
										 <option value="Brevig Mission">Native Village of Brevig Mission</option>
										 <option value="Buckland">Native Village of Buckland</option>
										 <option value="Cantwell">Native Village of Cantwell</option>
										 <option value="Chenega">Native Village of Chenega (aka Chanega)</option>
										 <option value="Chignik Lagoon">Native Village of Chignik Lagoon</option>
										 <option value="Chitina">Native Village of Chitina</option>
										 <option value="Chuathbaluk">Native Village of Chuathbaluk (Russian Mission, Kuskokwim)</option>
										 <option value="Council">Native Village of Council</option>
										 <option value="Deering">Native Village of Deering</option>
										 <option value="Diomede">Native Village of Diomede (aka Inalik)</option>
										 <option value="Eagle">Native Village of Eagle</option>
										 <option value="Eek">Native Village of Eek</option>
										 <option value="Ekuk">Native Village of Ekuk</option>
										 <option value="Ekwok">Native Village of Ekwok</option>
										 <option value="Elim IRA">Native Village of Elim</option>
										 <option value="Eyak">Native Village of Eyak (Cordova)</option>
										 <option value="False Pass">Native Village of False Pass</option>
										 <option value="Fort Yukon">Native Village of Fort Yukon</option>
										 <option value="Gakona">Native Village of Gakona</option>
										 <option value="Gambell">Native Village of Gambell</option>
										 <option value="Georgetown">Native Village of Georgetown</option>
										 <option value="Goodnews Bay">Native Village of Goodnews Bay</option>
										 <option value="Hamilton">Native Village of Hamilton</option>
										 <option value="Hooper Bay">Native Village of Hooper Bay</option>
										 <option value="Kanatak">Native Village of Kanatak</option>
										 <option value="Karluk">Native Village of Karluk</option>
										 <option value="Kiana">Native Village of Kiana</option>
										 <option value="Kipnuk">Native Village of Kipnuk</option>
										 <option value="Kivalina">Native Village of Kivalina</option>
										 <option value="Kluti Kaah">Native Village of Kluti Kaah (aka Copper Center)</option>
										 <option value="Kobuk">Native Village of Kobuk</option>
										 <option value="Kongiganak">Native Village of Kongiganak</option>
										 <option value="Kotzebue">Native Village of Kotzebue</option>
										 <option value="Koyuk">Native Village of Koyuk</option>
										 <option value="Kwigillingok">Native Village of Kwigillingok</option>
										 <option value="Kwinhagak">Native Village of Kwinhagak (aka Quinhagak)</option>
										 <option value="Larsen Bay">Native Village of Larsen Bay</option>
										 <option value="Marshall">Native Village of Marshall (aka Fortuna Ledge)</option>
										 <option value="Mary's Igloo">Native Village of Mary's Igloo</option>
										 <option value="Mekoryuk">Native Village of Mekoryuk</option>
										 <option value="Minto">Native Village of Minto</option>
										 <option value="Nanwalek">Native Village of Nanwalek (aka English Bay)</option>
										 <option value="Napaimute">Native Village of Napaimute</option>
										 <option value="Napakiak">Native Village of Napakiak</option>
										 <option value="Napaskiak">Native Village of Napaskiak</option>
										 <option value="Nelson Lagoon">Native Village of Nelson Lagoon</option>
										 <option value="Nightmute">Native Village of Nightmute</option>
										 <option value="Nikolski">Native Village of Nikolski</option>
										 <option value="Noatak">Native Village of Noatak</option>
										 <option value="Nuiqsut">Native Village of Nuiqsut (aka Nooiksut)</option>
										 <option value="Nunam Iqua">Native Village of Nunam Iqua</option>
										 <option value="Nunapitchuk">Native Village of Nunapitchuk</option>
										 <option value="Ouzinkie">Native Village of Ouzinkie</option>
										 <option value="Paimiut">Native Village of Paimiut</option>
										 <option value="Perryville">Native Village of Perryville</option>
										 <option value="Pilot Point">Native Village of Pilot Point</option>
										 <option value="Point Hope IRA">Native Village of Point Hope</option>
										 <option value="Point Lay IRA">Native Village of Point Lay</option>
										 <option value="Port Graham">Native Village of Port Graham</option>
										 <option value="Port Heiden">Native Village of Port Heiden</option>
										 <option value="Port Lions">Native Village of Port Lions</option>
										 <option value="Ruby">Native Village of Ruby</option>
										 <option value="St. Michael IRA">Native Village of Saint Michael</option>
										 <option value="Savoonga">Native Village of Savoonga</option>
										 <option value="Scammon Bay">Native Village of Scammon Bay</option>
										 <option value="Selawik">Native Village of Selawik</option>
										 <option value="Shaktoolik">Native Village of Shaktoolik</option>
										 <option value="Shishmaref IRA">Native Village of Shishmaref</option>
										 <option value="Shungnak">Native Village of Shungnak</option>
										 <option value="Stevens Village">Native Village of Stevens</option>
										 <option value="Tanacross">Native Village of Tanacross</option>
										 <option value="Tanana">Native Village of Tanana</option>
										 <option value="Tatitlek">Native Village of Tatitlek</option>
										 <option value="Tazlina">Native Village of Tazlina</option>
										 <option value="Teller">Native Village of Teller</option>
										 <option value="Tetlin">Native Village of Tetlin</option>
										 <option value="Tuntutuliak">Native Village of Tuntutuliak</option>
										 <option value="Tununak">Native Village of Tununak</option>
										 <option value="Tyonek">Native Village of Tyonek</option>
										 <option value="Unalakleet">Native Village of Unalakleet</option>
										 <option value="Unga">Native Village of Unga</option>
										 <option value="Venetie IRA">Native Village of Venetie Tribal Government (Arctic Village and Village of Venetie)</option>
										 <option value="Wales">Native Village of Wales</option>
										 <option value="White Mountain AK">Native Village of White Mountain</option>
										 <option value="Navajo">Navajo Nation, Arizona, New Mexico &amp; Utah</option>
										 <option value="Nenana">Nenana Native Association</option>
										 <option value="New Koliganek">New Koliganek Village Council</option>
										 <option value="New Stuyahok">New Stuyahok Village</option>
										 <option value="Newhalen">Newhalen Village</option>
										 <option value="Newtok">Newtok Village</option>
										 <option value="Nez Perce">Nez Perce Tribe</option>
										 <option value="Nikolai">Nikolai Village</option>
										 <option value="Ninilchik">Ninilchik Village</option>
										 <option value="Nisqually">Nisqually Indian Tribe</option>
										 <option value="Nome">Nome Eskimo Community</option>
										 <option value="Nondalton">Nondalton Village</option>
										 <option value="Nooksack">Nooksack Indian Tribe</option>
										 <option value="Noorvik">Noorvik Native Community</option>
										 <option value="Northern Arapaho">Northern Arapaho Tribe of the Wind River Reservation, Wyoming</option>
										 <option value="Northern Cheyenne">Northern Cheyenne Tribe of the Northern Cheyenne Indian Reservation, Montana</option>
										 <option value="North Fork">Northfork Rancheria of Mono Indians of California</option>
										 <option value="Northway">Northway Village</option>
										 <option value="Northwestern Shoshone">Northwestern Band of the Shoshone Nation</option>
										 <option value="Nottawaseppi Potawatomi">Nottawaseppi Huron Band of the Potawatomi, Michigan</option>
										 <option value="Nulato">Nulato Village</option>
										 <option value="Nunakauyarmiut">Nunakauyarmiut Tribe</option>
										 <option value="Oglala Sioux">Oglala Sioux Tribe</option>
										 <option value="Ohkay Owingeh">Ohkay Owingeh, New Mexico</option>
										 <option value="Omaha">Omaha Tribe of Nebraska</option>
										 <option value="Oneida">Oneida Indian Nation</option>
										 <option value="Oneida Nation (Wisconsin)">Oneida Nation</option>
										 <option value="Onondaga">Onondaga Nation</option>
										 <option value="Grayling">Organized Village of Grayling (aka Holikachuk)</option>
										 <option value="Kake">Organized Village of Kake</option>
										 <option value="Kasaan">Organized Village of Kasaan</option>
										 <option value="Kwethluk">Organized Village of Kwethluk</option>
										 <option value="Saxman">Organized Village of Saxman</option>
										 <option value="Orutsararmiut">Orutsararmiut Traditional Native Council</option>
										 <option value="Oscarville">Oscarville Traditional Village</option>
										 <option value="Otoe-Missouria">Otoe-Missouria Tribe of Indians, Oklahoma</option>
										 <option value="Ottawa Tribe of Oklahoma">Ottawa Tribe of Oklahoma</option>
										 <option value="Paiute of Utah">Paiute Indian Tribe of Utah (Cedar Band of Paiutes, Kanosh Band of Paiutes, Koosharem Band of Paiutes, Indian Peaks Band of Paiutes, and Shivwits Band of Paiutes)</option>
										 <option value="Paiute-Shoshone">Paiute-Shoshone Tribe of the Fallon Reservation and Colony, Nevada</option>
										 <option value="Pala">Pala Band of Mission Indians</option>
										 <option value="Pamunkey Indian Tribe">Pamunkey Indian Tribe</option>
										 <option value="Pascua Yaqui">Pascua Yaqui Tribe of Arizona</option>
										 <option value="Paskenta">Paskenta Band of Nomlaki Indians of California</option>
										 <option value="Passamaquoddy Indian Township">Passamaquoddy Tribe - Indian Township</option>
										 <option value="Passamaquoddy Pleasant Point">Passamaquoddy Tribe - Pleasant Point</option>
										 <option value="Passamaquoddy Tribe">Passamaquoddy Tribe</option>
										 <option value="Pauloff Harbor">Pauloff Harbor Village</option>
										 <option value="Pauma">Pauma Band of Luiseno Mission Indians of the Pauma &amp; Yuima Reservation, California</option>
										 <option value="Pawnee">Pawnee Nation of Oklahoma</option>
										 <option value="Pechanga Band of Indians">Pechanga Band of Indians</option>
										 <option value="Pedro Bay">Pedro Bay Village</option>
										 <option value="Penobscot">Penobscot Nation</option>
										 <option value="Peoria Tribe of Indians of Oklahoma">Peoria Tribe of Indians of Oklahoma</option>
										 <option value="Petersburg">Petersburg Indian Association</option>
										 <option value="Picayune">Picayune Rancheria of Chukchansi Indians of California</option>
										 <option value="Pilot Station">Pilot Station Traditional Village</option>
										 <option value="Pinoleville">Pinoleville Pomo Nation, California</option>
										 <option value="Pit River">Pit River Tribe, California</option>
										 <option value="Pitka's Point">Pitka's Point Traditional Council</option>
										 <option value="Platinum">Platinum Traditional Village</option>
										 <option value="Poarch">Poarch Band of Creek Indians</option>
										 <option value="Pokagon">Pokagon Band of Potawatomi Indians, Michigan and Indiana</option>
										 <option value="Ponca of Oklahoma">Ponca Tribe of Indians of Oklahoma</option>
										 <option value="Ponca of Nebraska">Ponca Tribe of Nebraska</option>
										 <option value="Port Gamble">Port Gamble S'Klallam Tribe</option>
										 <option value="Portage Creek">Portage Creek Village (aka Ohgsenakale)</option>
										 <option value="Potter Valley">Potter Valley Tribe, California</option>
										 <option value="Prairie Band">Prairie Band Potawatomi Nation</option>
										 <option value="Prairie Island">Prairie Island Indian Community in the State of Minnesota</option>
										 <option value="Pribilof Islands Aleut Communities">Pribilof Islands Aleut Communities</option>
										 <option value="Pueblo of Acoma">Pueblo of Acoma, New Mexico</option>
										 <option value="Pueblo of Cochiti">Pueblo of Cochiti, New Mexico</option>
										 <option value="Pueblo of Isleta">Pueblo of Isleta, New Mexico</option>
										 <option value="Pueblo of Jemez">Pueblo of Jemez, New Mexico</option>
										 <option value="Pueblo of Laguna">Pueblo of Laguna, New Mexico</option>
										 <option value="Pueblo of Nambe">Pueblo of Nambe, New Mexico</option>
										 <option value="Pueblo of Picuris">Pueblo of Picuris, New Mexico</option>
										 <option value="Pueblo of Pojoaque">Pueblo of Pojoaque, New Mexico</option>
										 <option value="Pueblo of San Felipe">Pueblo of San Felipe, New Mexico</option>
										 <option value="Pueblo of San Ildefonso">Pueblo of San Ildefonso, New Mexico</option>
										 <option value="Pueblo of Sandia">Pueblo of Sandia, New Mexico</option>
										 <option value="Pueblo of Santa Ana">Pueblo of Santa Ana, New Mexico</option>
										 <option value="Pueblo of Santa Clara">Pueblo of Santa Clara, New Mexico</option>
										 <option value="Pueblo of Taos">Pueblo of Taos, New Mexico</option>
										 <option value="Pueblo of Tesuque">Pueblo of Tesuque, New Mexico</option>
										 <option value="Pueblo of Zia">Pueblo of Zia, New Mexico</option>
										 <option value="Puyallup">Puyallup Tribe of the Puyallup Reservation</option>
										 <option value="Pyramid Lake">Pyramid Lake Paiute Tribe of the Pyramid Lake Reservation, Nevada</option>
										 <option value="Qagan Tayagungin">Qagan Tayagungin Tribe of Sand Point</option>
										 <option value="Qawalangin">Qawalangin Tribe of Unalaska</option>
										 <option value="Quapaw Nation">Quapaw Nation</option>
										 <option value="Quartz Valley">Quartz Valley Indian Community of the Quartz Valley Reservation of California</option>
										 <option value="Quechan">Quechan Tribe of the Fort Yuma Indian Reservation, California &amp; Arizona</option>
										 <option value="Quileute">Quileute Tribe of the Quileute Reservation</option>
										 <option value="Quinault">Quinault Indian Nation</option>
										 <option value="Ramah Navajo Chapter">Ramah Navajo Chapter of the Navajo Nation</option>
										 <option value="Ramona">Ramona Band of Cahuilla, California</option>
										 <option value="Rampart">Rampart Village</option>
										 <option value="Rappahannock Tribe, Inc.">Rappahannock Tribe, Inc.</option>
										 <option value="Red Cliff">Red Cliff Band of Lake Superior Chippewa Indians of Wisconsin</option>
										 <option value="Red Lake">Red Lake Band of Chippewa Indians, Minnesota</option>
										 <option value="Redding">Redding Rancheria, California</option>
										 <option value="Redwood Valley">Redwood Valley or Little River Band of Pomo Indians of the Redwood Valley Rancheria California</option>
										 <option value="Reno-Sparks">Reno-Sparks Indian Colony, Nevada</option>
										 <option value="Resighini">Resighini Rancheria, California</option>
										 <option value="Rincon">Rincon Band of Luiseno Mission Indians of the Rincon Reservation, California</option>
										 <option value="Robinson">Robinson Rancheria</option>
										 <option value="Rosebud">Rosebud Sioux Tribe of the Rosebud Indian Reservation, South Dakota</option>
										 <option value="Round Valley">Round Valley Indian Tribes, Round Valley Reservation, California</option>
										 <option value="Sac &amp; Fox Nation of Missouri in Kansas and Nebraska">Sac &amp; Fox Nation of Missouri in Kansas and Nebraska</option>
										 <option value="Sac &amp; Fox Nation, Oklahoma">Sac &amp; Fox Nation, Oklahoma</option>
										 <option value="Sac &amp; Fox of Mississippi">Sac &amp; Fox Tribe of the Mississippi in Iowa</option>
										 <option value="Saginaw Chippewa">Saginaw Chippewa Indian Tribe of Michigan</option>
										 <option value="St. George">Saint George Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
										 <option value="Saint Paul">Saint Paul Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
										 <option value="Saint Regis">Saint Regis Mohawk Tribe</option>
										 <option value="Salamatof">Salamatof Tribe</option>
										 <option value="Salt River">Salt River Pima-Maricopa Indian Community of the Salt River Reservation, Arizona</option>
										 <option value="Samish">Samish Indian Nation</option>
										 <option value="San Carlos">San Carlos Apache Tribe of the San Carlos Reservation, Arizona</option>
										 <option value="San Juan">San Juan Southern Paiute Tribe of Arizona</option>
										 <option value="San Pasqual">San Pasqual Band of Diegueno Mission Indians of California</option>
										 <option value="Santa Rosa of Cahuilla">Santa Rosa Band of Cahuilla Indians, California</option>
										 <option value="Santa Rosa">Santa Rosa Indian Community of the Santa Rosa Rancheria, California</option>
										 <option value="Santa Ynez">Santa Ynez Band of Chumash Mission Indians of the Santa Ynez Reservation, California</option>
										 <option value="Santee Sioux">Santee Sioux Nation, Nebraska</option>
										 <option value="Santo Domingo">Santo Domingo Pueblo</option>
										 <option value="Sauk-Suiattle">Sauk-Suiattle Indian Tribe</option>
										 <option value="Sault Ste. Marie">Sault Ste. Marie Tribe of Chippewa Indians, Michigan</option>
										 <option value="Scotts Valley">Scotts Valley Band of Pomo Indians of California</option>
										 <option value="Seldovia">Seldovia Village Tribe</option>
										 <option value="Seminole">Seminole Tribe of Florida</option>
										 <option value="Seneca">Seneca Nation of Indians</option>
										 <option value="Seneca-Cayuga Nation">Seneca-Cayuga Nation</option>
										 <option value="Shageluk">Shageluk Native Village</option>
										 <option value="Shakopee">Shakopee Mdewakanton Sioux Community of Minnesota</option>
										 <option value="Shawnee Tribe">Shawnee Tribe</option>
										 <option value="Sherwood Valley">Sherwood Valley Rancheria of Pomo Indians of California</option>
										 <option value="Shingle Springs">Shingle Springs Band of Miwok Indians, Shingle Springs Rancheria (Verona Tract), California</option>
										 <option value="Shinnecock">Shinnecock Indian Nation</option>
										 <option value="Shoalwater">Shoalwater Bay Indian Tribe of the Shoalwater Bay Indian Reservation</option>
										 <option value="Shoshone-Bannock">Shoshone-Bannock Tribes of the Fort Hall Reservation</option>
										 <option value="Shoshone-Paiute">Shoshone-Paiute Tribes of the Duck Valley Reservation, Nevada</option>
										 <option value="Sisseton-Wahpeton">Sisseton-Wahpeton Oyate of the Lake Traverse Reservation, South Dakota</option>
										 <option value="Sitka">Sitka Tribe of Alaska</option>
										 <option value="Skagway">Skagway Village</option>
										 <option value="Skokomish">Skokomish Indian Tribe</option>
										 <option value="Skull Valley">Skull Valley Band of Goshute Indians of Utah</option>
										 <option value="Snoqualmie">Snoqualmie Indian Tribe</option>
										 <option value="Soboba">Soboba Band of Luiseno Indians, California</option>
										 <option value="Sokaogon">Sokaogon Chippewa  Community, Wisconsin</option>
										 <option value="South Naknek">South Naknek Village</option>
										 <option value="Southern Ute">Southern Ute Indian Tribe of the Southern Ute Reservation, Colorado</option>
										 <option value="Spirit Lake">Spirit Lake Tribe, North Dakota</option>
										 <option value="Spokane">Spokane Tribe of the Spokane Reservation</option>
										 <option value="Squaxin">Squaxin Island Tribe of the Squaxin Island Reservation</option>
										 <option value="St. Croix">St. Croix Chippewa Indians of Wisconsin</option>
										 <option value="Standing Rock">Standing Rock Sioux Tribe of North &amp; South Dakota</option>
										 <option value="Stebbins">Stebbins Community Association</option>
										 <option value="Stillaguamish">Stillaguamish Tribe of Indians of Washington</option>
										 <option value="Stockbridge">Stockbridge Munsee Community, Wisconsin</option>
										 <option value="Summit Lake">Summit Lake Paiute Tribe of Nevada</option>
										 <option value="Sun'aq">Sun'aq Tribe of Kodiak</option>
										 <option value="Suquamish">Suquamish Indian Tribe of the Port Madison Reservation</option>
										 <option value="Susanville">Susanville Indian Rancheria, California</option>
										 <option value="Swinomish">Swinomish Indian Tribal Community</option>
										 <option value="Sycuan">Sycuan Band of the Kumeyaay Nation</option>
										 <option value="Table Mountain">Table Mountain Rancheria</option>
										 <option value="Takotna">Takotna Village</option>
										 <option value="Tangirnaq">Tangirnaq Native Village</option>
										 <option value="Tejon">Tejon Indian Tribe</option>
										 <option value="Telida">Telida Village</option>
										 <option value="Te-Moak">Te-Moak Tribe of Western Shoshone Indians of Nevada (Four constituent bands: Battle Mountain Band; Elko Band; South Fork Band and Wells Band)</option>
										 <option value="Chickasaw Nation">The Chickasaw Nation</option>
										 <option value="The Choctaw Nation of Oklahoma">The Choctaw Nation of Oklahoma</option>
										 <option value="The Muscogee (Creek) Nation">The Muscogee (Creek) Nation</option>
										 <option value="The Osage Nation">The Osage Nation</option>
										 <option value="The Seminole Nation  of Oklahoma">The Seminole Nation of Oklahoma</option>
										 <option value="Thlopthlocco Tribal Town">Thlopthlocco Tribal Town</option>
										 <option value="Three Affiliated">Three Affiliated Tribes of the Fort Berthold Reservation, North Dakota</option>
										 <option value="Timbi-sha Shoshone">Timbisha Shoshone Tribe</option>
										 <option value="Tohono O'odham">Tohono O'odham Nation of Arizona</option>
										 <option value="Tolowa Dee-ni'">Tolowa Dee-ni' Nation</option>
										 <option value="Tonawanda">Tonawanda Band of Seneca</option>
										 <option value="Tonkawa">Tonkawa Tribe of Indians of Oklahoma</option>
										 <option value="Tonto Apache">Tonto Apache Tribe of Arizona</option>
										 <option value="Torres Martinez">Torres Martinez Desert Cahuilla Indians, California</option>
										 <option value="Togiak">Traditional Village of Togiak</option>
										 <option value="Tulalip">Tulalip Tribes of Washington</option>
										 <option value="Tule River">Tule River Indian Tribe of the Tule River Reservation, California</option>
										 <option value="Tuluksak">Tuluksak Native Community</option>
										 <option value="Tunica-Biloxi">Tunica-Biloxi Indian Tribe</option>
										 <option value="Tuolumne">Tuolumne Band of Me-Wuk Indians of the Tuolumne Rancheria of California</option>
										 <option value="Turtle Mountain">Turtle Mountain Band of Chippewa Indians of North Dakota</option>
										 <option value="Tuscarora">Tuscarora Nation</option>
										 <option value="Twenty-Nine Palms">Twenty-Nine Palms Band of Mission Indians of California</option>
										 <option value="Twin Hills">Twin Hills Village</option>
										 <option value="Ugashik">Ugashik Village</option>
										 <option value="Umkumiut">Umkumiut Native Village</option>
										 <option value="United Auburn">United Auburn Indian Community of the Auburn Rancheria of California</option>
										 <option value="United Keetoowah Band of Cherokee Indians in Oklahoma">United Keetoowah Band of Cherokee Indians in Oklahoma</option>
										 <option value="Upper Mattaponi Tribe">Upper Mattaponi Tribe</option>
										 <option value="Upper Sioux">Upper Sioux Community, Minnesota</option>
										 <option value="Upper Skagit">Upper Skagit Indian Tribe</option>
										 <option value="Ute">Ute Indian Tribe of the Uintah &amp; Ouray Reservation, Utah</option>
										 <option value="Ute Mountain Ute">Ute Mountain Ute Tribe</option>
										 <option value="Benton">Utu Utu Gwaitu Paiute Tribe of the Benton Paiute Reservation, California</option>
										 <option value="Alakanuk">Village of Alakanuk</option>
										 <option value="Anaktuvuk Pass">Village of Anaktuvuk Pass</option>
										 <option value="Aniak">Village of Aniak</option>
										 <option value="Atmautluak">Village of Atmautluak</option>
										 <option value="Bill Moore's Slough">Village of Bill Moore's Slough</option>
										 <option value="Chefornak">Village of Chefornak</option>
										 <option value="Clark's Point">Village of Clarks Point</option>
										 <option value="Crooked Creek">Village of Crooked Creek</option>
										 <option value="Dot Lake">Village of Dot Lake</option>
										 <option value="Iliamna">Village of Iliamna</option>
										 <option value="Kalskag">Village of Kalskag</option>
										 <option value="Kaltag">Village of Kaltag</option>
										 <option value="Kotlik">Village of Kotlik</option>
										 <option value="Lower Kalskag">Village of Lower Kalskag</option>
										 <option value="Ohogamiut">Village of Ohogamiut</option>
										 <option value="Red Devil">Village of Red Devil</option>
										 <option value="Sleetmute">Village of Sleetmute</option>
										 <option value="Solomon">Village of Solomon</option>
										 <option value="Stony River">Village of Stony River</option>
										 <option value="Venetie">Village of Venetie (See Native Village of Venetie Tribal Government)</option>
										 <option value="Wainwright">Village of Wainwright</option>
										 <option value="Walker River">Walker River Paiute Tribe of the Walker River Reservation, Nevada</option>
										 <option value="Wampanoag">Wampanoag Tribe of Gay Head (Aquinnah)</option>
										 <option value="Washoe">Washoe Tribe of Nevada &amp; California (Carson Colony, Dresslerville Colony, Woodfords Community, Stewart Community, &amp; Washoe Ranches)</option>
										 <option value="White Mountain">White Mountain Apache Tribe of the Fort Apache Reservation, Arizona</option>
										 <option value="Wichita">Wichita and Affiliated Tribes (Wichita, Keechi, Waco &amp; Tawakonie), Oklahoma</option>
										 <option value="Wilton">Wilton Rancheria, California</option>
										 <option value="Winnebago">Winnebago Tribe of Nebraska</option>
										 <option value="Winnemucca">Winnemucca Indian Colony of Nevada</option>
										 <option value="Wiyot">Wiyot Tribe, California</option>
										 <option value="Wrangell">Wrangell Cooperative Association</option>
										 <option value="Wyandotte Nation">Wyandotte Nation</option>
										 <option value="Yakutat">Yakutat Tlingit Tribe</option>
										 <option value="Yankton">Yankton Sioux Tribe of South Dakota</option>
										 <option value="Yavapai-Apache">Yavapai-Apache Nation of the Camp Verde Indian Reservation, Arizona</option>
										 <option value="Yavapai-Prescott">Yavapai-Prescott Indian Tribe</option>
										 <option value="Yerington">Yerington Paiute Tribe of the Yerington Colony and Campbell Ranch, Nevada</option>
										 <option value="Yocha Dehe">Yocha Dehe Wintun Nation, California</option>
										 <option value="Yomba Shoshone">Yomba Shoshone Tribe of the Yomba Reservation, Nevada</option>
										 <option value="Ysleta Del Sur">Ysleta del Sur Pueblo</option>
										 <option value="Yuhaaviatam of San Manuel Nation">Yuhaaviatam of San Manuel Nation</option>
										 <option value="Andreafski">Yupiit of Andreafski</option>
										 <option value="Yurok">Yurok Tribe of the Yurok Reservation, California</option>
										 <option value="Pueblo of Zuni">Zuni Tribe of the Zuni Reservation, New Mexico</option>
										 <option value="Other">Other</option>
									  </select>
								   </div>
								</div>
								<div class="col-sm-6 mt-15" title="">
								<label class="main-label" for="beneficialOwner[${beneficialCounter}].identificationDocuments.otherLocalDesc">Other local/Tribal description <em>*</em></label>
								<div class="form-fields">
								   <input id="beneficialOwner[${beneficialCounter}].identificationDocuments.otherLocalDesc" name="beneficialOwner[${beneficialCounter}].identificationDocuments.otherLocalDesc" type="text" placeholder="Enter local/Tribal description" class="ben-otherlt form-field" disabled/>
								</div>
							 </div>
							</div> 
							 
							 
			         </div>
				  	</div>
				  </div>
   				 </div>	
   				</div>
   				<!-- Form of identification and issuing jurisdiction End -->

   				<!-- Legal Name &amp; Date of Birth Start -->
   				 <div class="accordion-item box-bg-sec">
   				  <div class="accordion-header row">
				     <div class="dah-left col-md-8"><h2>Legal Name & Date of Birth</h2></div>
				     <div class="dah-right col-md-4">
				      <span ><a class="hover-modal-btn" href="#boirNeedHelp15"><img src="/images/help-icon.svg"></a></span>
				      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoAddOnFive${beneficialCounter}" aria-expanded="true" aria-controls="collapseBoAddOnFive${beneficialCounter}"></button>
				     </div>
				   </div>
				   <div id="collapseBoAddOnFive${beneficialCounter}" class="accordion-collapse collapse show">
				   	<div class="accordion-body">
				   	 <div class="ab-top-para">
			          <p>Enter your legal name and birthdate exactly as they appear on your identification documents.</p>
			         </div>
			         <div class="sf-form-body">
			          <div class="col-sm-6 mt-15" title="">
						 <label class="main-label" for="beneficialOwner[${beneficialCounter}].legalName">Individual's last name or entity's legal name <em>*</em></label>
						 <div class="form-fields">
							<input id="beneficialOwner[${beneficialCounter}].legalName" name="beneficialOwner[${beneficialCounter}].legalName" type="text" placeholder="Enter Last Name" class="ben-lname form-field" />
						 </div>
					   </div>
					   <div class="benficialexempt${beneficialCounter}" id="benficialexempt${beneficialCounter}">
					   	<div class="row two-fields">
							<div class="col-sm-4 mt-15" title="">
							   <label class="main-label" for="beneficialOwner[${beneficialCounter}].firstName">First name <em>*</em></label>
							   <div class="form-fields">
								  <input id="beneficialOwner[${beneficialCounter}].firstName" name="beneficialOwner[${beneficialCounter}].firstName" type="text" placeholder="Enter First Name" class="ben-fn form-field" />
							   </div>
							</div>
							<div class="col-sm-4 mt-15" title="">
							   <label class="main-label" for="beneficialOwner[${beneficialCounter}].middleName">Middle name</label>
							   <div class="form-fields">
								  <input id="beneficialOwner[${beneficialCounter}].middleName" name="beneficialOwner[${beneficialCounter}].middleName" type="text" placeholder="Enter Middle name" class="ben-midname form-field" />
							   </div>
							</div>
							<div class="col-sm-4 mt-15" title="">
							   <label class="main-label" for="beneficialOwner[${beneficialCounter}].suffix">Suffix </label>
							   <div class="form-fields">
								  <input id="beneficialOwner[${beneficialCounter}].suffix" name="beneficialOwner[${beneficialCounter}].suffix" type="text" placeholder="Enter Suffix" class="ben-suffix form-field" />
							   </div>
							</div>
							<div class="col-sm-6" title="">
							 <label class="main-label" for="beneficialOwner[${beneficialCounter}].dateOfBirth">Date of birth <em>*</em></label>
							 <div class="form-fields">
							   <div class="date-field">
								  <input id="beneficialOwner[${beneficialCounter}].dateOfBirth" name="beneficialOwner[${beneficialCounter}].dateOfBirth" type="date" placeholder="06/20/2024" class="ben-dob form-field" />
							   </div>
							 </div>
						    </div>
						 </div>
					   </div>

			         </div>
				   	</div>
				   </div>
   				 </div>	

   				<!-- Legal Name &amp; Date of Birth End -->

   				<!-- Current Residential Address Start -->
   			<div class="benexemptidi${beneficialCounter}" id="benexemptidi${beneficialCounter}">	
   				<div class="accordion-item box-bg-sec">
   				 <div class="accordion-header row">
				   <div class="dah-left col-md-8"><h2>Current Residential Address</h2></div>
				   <div class="dah-right col-md-4">
				     <span><a class="hover-modal-btn" href="#boirNeedHelp16"><img src="/images/help-icon.svg"></a></span>
				     <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoAddOnSix${beneficialCounter}" aria-expanded="true" aria-controls="collapseBoAddOnSix${beneficialCounter}"></button>
				   </div>
				 </div>
				 <div id="collapseBoAddOnSix${beneficialCounter}" class="accordion-collapse collapse show">
				  <div class="accordion-body">
			        <div class="ab-top-para">
			          <p>Please enter your current residential address.<br/>FinCEN requires the beneficial owner’s primary residential address, not a PO box or business address. </p>
			       </div>
			       <div class="sf-form-body">
			       	<div class="form-rows">
					  <label class="main-label" for="beneficialOwner[${beneficialCounter}].address.addressType">Address type <em>*</em></label>
					  <div class="form-fields">
						 <div class="row">
							<label class="col-sm-3">
							<input id="beneficialOwner[${beneficialCounter}].address.addressType" name="beneficialOwner[${beneficialCounter}].address.addressType" type="radio" value="Business" class="ben-addtype"/> Business</label>
							<label class="col-sm-3">
							<input type="radio" name="beneficialOwner[${beneficialCounter}].address.addressType" value="Residential" class="ben-addtype"/> Residential</label>
						 </div>
					  </div>
				   </div>
			       	<div class="row two-fields">
						  <div class="col-sm-7 mt-15" title="">
							 <label class="main-label" for="beneficialOwner[${beneficialCounter}].address.address">Address (number, street, and apt. or suite no.) <em>*</em></label>
							 <div class="form-fields">
								<input id="beneficialOwner[${beneficialCounter}].address.address" name="beneficialOwner[${beneficialCounter}].address.address" type="text" placeholder="Enter Address" class="ben-address form-field" />
							 </div>
						  </div>
						  <div class="col-sm-5 mt-15" title="">
							 <label class="main-label" for="beneficialOwner[${beneficialCounter}].address.city">City <em>*</em></label>
							 <div class="form-fields">
								<input id="beneficialOwner[${beneficialCounter}].address.city" name="beneficialOwner[${beneficialCounter}].address.city" type="text" placeholder="Enter City" class="ben-city form-field" />
							 </div>
						  </div>
						  <div class="col-sm-4 mt-15" title="">
							 <label class="main-label" for="beneficialOwner[${beneficialCounter}].address.country">Country/Jurisdiction <em>*</em></label>
							 <div class="form-fields">
								<select class="ben-countryjuri form-field" id="beneficialOwner[${beneficialCounter}].address.country" name="beneficialOwner[${beneficialCounter}].address.country">
								   <option value="">Select Country</option>
								   <option value="US">United States of America</option>
								   <option value="AS">American Samoa</option>
								   <option value="GU">Guam</option>
								   <option value="MH">Marshall Islands</option>
								   <option value="FM">Micronesia, Federated States</option>
								   <option value="MP">Northern Mariana Islands</option>
								   <option value="PW">Palau</option>
								   <option value="PR">Puerto Rico</option>
								   <option value="VI">U.S. Virgin Islands</option>
								   <option value="AF">Afghanistan</option>
								   <option value="AX">Åland Islands</option>
								   <option value="AL">Albania</option>
								   <option value="DZ">Algeria</option>
								   <option value="AD">Andorra</option>
								   <option value="AO">Angola</option>
								   <option value="AI">Anguilla</option>
								   <option value="AQ">Antarctica</option>
								   <option value="AG">Antigua And Barbuda</option>
								   <option value="AR">Argentina</option>
								   <option value="AM">Armenia</option>
								   <option value="AW">Aruba</option>
								   <option value="AU">Australia</option>
								   <option value="AT">Austria</option>
								   <option value="AZ">Azerbaijan</option>
								   <option value="BS">Bahamas</option>
								   <option value="BH">Bahrain</option>
								   <option value="BD">Bangladesh</option>
								   <option value="BB">Barbados</option>
								   <option value="BY">Belarus</option>
								   <option value="BE">Belgium</option>
								   <option value="BZ">Belize</option>
								   <option value="BJ">Benin</option>
								   <option value="BM">Bermuda</option>
								   <option value="BT">Bhutan</option>
								   <option value="BO">Bolivia, Plurinational State Of</option>
								   <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
								   <option value="BA">Bosnia And Herzegovina</option>
								   <option value="BW">Botswana</option>
								   <option value="BV">Bouvet Island</option>
								   <option value="BR">Brazil</option>
								   <option value="IO">British Indian Ocean Territory</option>
								   <option value="BN">Brunei Darussalam</option>
								   <option value="BG">Bulgaria</option>
								   <option value="BF">Burkina Faso</option>
								   <option value="BI">Burundi</option>
								   <option value="KH">Cambodia</option>
								   <option value="CM">Cameroon</option>
								   <option value="CA">Canada</option>
								   <option value="CV">Cape Verde</option>
								   <option value="KY">Cayman Islands</option>
								   <option value="CF">Central African Republic</option>
								   <option value="TD">Chad</option>
								   <option value="CL">Chile</option>
								   <option value="CN">China</option>
								   <option value="CX">Christmas Island</option>
								   <option value="CC">Cocos (Keeling) Islands</option>
								   <option value="CO">Colombia</option>
								   <option value="KM">Comoros</option>
								   <option value="CG">Congo</option>
								   <option value="CD">Congo, The Democratic Republic Of The</option>
								   <option value="CK">Cook Islands</option>
								   <option value="CR">Costa Rica</option>
								   <option value="CI">Côte D'ivoire</option>
								   <option value="HR">Croatia</option>
								   <option value="CU">Cuba</option>
								   <option value="CW">Curaçao</option>
								   <option value="CY">Cyprus</option>
								   <option value="CZ">Czech Republic</option>
								   <option value="DK">Denmark</option>
								   <option value="DJ">Djibouti</option>
								   <option value="DM">Dominica</option>
								   <option value="DO">Dominican Republic</option>
								   <option value="EC">Ecuador</option>
								   <option value="EG">Egypt</option>
								   <option value="SV">El Salvador</option>
								   <option value="GQ">Equatorial Guinea</option>
								   <option value="ER">Eritrea</option>
								   <option value="EE">Estonia</option>
								   <option value="ET">Ethiopia</option>
								   <option value="FK">Falkland Islands (Malvinas)</option>
								   <option value="FO">Faroe Islands</option>
								   <option value="FJ">Fiji</option>
								   <option value="FI">Finland</option>
								   <option value="FR">France</option>
								   <option value="GF">French Guiana</option>
								   <option value="PF">French Polynesia</option>
								   <option value="TF">French Southern Territories</option>
								   <option value="GA">Gabon</option>
								   <option value="GM">Gambia</option>
								   <option value="GE">Georgia</option>
								   <option value="DE">Germany</option>
								   <option value="GH">Ghana</option>
								   <option value="GI">Gibraltar</option>
								   <option value="GR">Greece</option>
								   <option value="GL">Greenland</option>
								   <option value="GD">Grenada</option>
								   <option value="GP">Guadeloupe</option>
								   <option value="GT">Guatemala</option>
								   <option value="GG">Guernsey</option>
								   <option value="GN">Guinea</option>
								   <option value="GW">Guinea-bissau</option>
								   <option value="GY">Guyana</option>
								   <option value="HT">Haiti</option>
								   <option value="HM">Heard Island And Mcdonald Islands</option>
								   <option value="VA">Holy See (Vatican City State)</option>
								   <option value="HN">Honduras</option>
								   <option value="HK">Hong Kong</option>
								   <option value="HU">Hungary</option>
								   <option value="IS">Iceland</option>
								   <option value="IN">India</option>
								   <option value="ID">Indonesia</option>
								   <option value="IR">Iran, Islamic Republic Of</option>
								   <option value="IQ">Iraq</option>
								   <option value="IE">Ireland</option>
								   <option value="IM">Isle Of Man</option>
								   <option value="IL">Israel</option>
								   <option value="IT">Italy</option>
								   <option value="JM">Jamaica</option>
								   <option value="JP">Japan</option>
								   <option value="JE">Jersey</option>
								   <option value="JO">Jordan</option>
								   <option value="KZ">Kazakhstan</option>
								   <option value="KE">Kenya</option>
								   <option value="KI">Kiribati</option>
								   <option value="KP">Korea, Democratic People's Republic Of</option>
								   <option value="KR">Korea, Republic Of</option>
								   <option value="KW">Kuwait</option>
								   <option value="KG">Kyrgyzstan</option>
								   <option value="LA">Lao People's Democratic Republic</option>
								   <option value="LV">Latvia</option>
								   <option value="LB">Lebanon</option>
								   <option value="LS">Lesotho</option>
								   <option value="LR">Liberia</option>
								   <option value="LY">Libya</option>
								   <option value="LI">Liechtenstein</option>
								   <option value="LT">Lithuania</option>
								   <option value="LU">Luxembourg</option>
								   <option value="MO">Macao</option>
								   <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
								   <option value="MG">Madagascar</option>
								   <option value="MW">Malawi</option>
								   <option value="MY">Malaysia</option>
								   <option value="MV">Maldives</option>
								   <option value="ML">Mali</option>
								   <option value="MT">Malta</option>
								   <option value="MQ">Martinique</option>
								   <option value="MR">Mauritania</option>
								   <option value="MU">Mauritius</option>
								   <option value="YT">Mayotte</option>
								   <option value="MX">Mexico</option>
								   <option value="MD">Moldova, Republic Of</option>
								   <option value="MC">Monaco</option>
								   <option value="MN">Mongolia</option>
								   <option value="ME">Montenegro</option>
								   <option value="MS">Montserrat</option>
								   <option value="MA">Morocco</option>
								   <option value="MZ">Mozambique</option>
								   <option value="MM">Myanmar</option>
								   <option value="NA">Namibia</option>
								   <option value="NR">Nauru</option>
								   <option value="NP">Nepal</option>
								   <option value="NL">Netherlands</option>
								   <option value="NC">New Caledonia</option>
								   <option value="NZ">New Zealand</option>
								   <option value="NI">Nicaragua</option>
								   <option value="NE">Niger</option>
								   <option value="NG">Nigeria</option>
								   <option value="NU">Niue</option>
								   <option value="NF">Norfolk Island</option>
								   <option value="NO">Norway</option>
								   <option value="OM">Oman</option>
								   <option value="PK">Pakistan</option>
								   <option value="PS">Palestinian Territory, Occupied</option>
								   <option value="PA">Panama</option>
								   <option value="PG">Papua New Guinea</option>
								   <option value="PY">Paraguay</option>
								   <option value="PE">Peru</option>
								   <option value="PH">Philippines</option>
								   <option value="PN">Pitcairn</option>
								   <option value="PL">Poland</option>
								   <option value="PT">Portugal</option>
								   <option value="QA">Qatar</option>
								   <option value="RE">Réunion</option>
								   <option value="RO">Romania</option>
								   <option value="RU">Russian Federation</option>
								   <option value="RW">Rwanda</option>
								   <option value="BL">Saint Barthélemy</option>
								   <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
								   <option value="KN">Saint Kitts And Nevis</option>
								   <option value="LC">Saint Lucia</option>
								   <option value="MF">Saint Martin (french Part)</option>
								   <option value="PM">Saint Pierre And Miquelon</option>
								   <option value="VC">Saint Vincent And The Grenadines</option>
								   <option value="WS">Samoa</option>
								   <option value="SM">San Marino</option>
								   <option value="ST">Sao Tome And Principe</option>
								   <option value="SA">Saudi Arabia</option>
								   <option value="SN">Senegal</option>
								   <option value="RS">Serbia</option>
								   <option value="SC">Seychelles</option>
								   <option value="SL">Sierra Leone</option>
								   <option value="SG">Singapore</option>
								   <option value="SX">Sint Maarten (dutch Part)</option>
								   <option value="SK">Slovakia</option>
								   <option value="SI">Slovenia</option>
								   <option value="SB">Solomon Islands</option>
								   <option value="SO">Somalia</option>
								   <option value="ZA">South Africa</option>
								   <option value="GS">South Georgia And The South Sandwich Islands</option>
								   <option value="SS">South Sudan</option>
								   <option value="ES">Spain</option>
								   <option value="LK">Sri Lanka</option>
								   <option value="SD">Sudan</option>
								   <option value="SR">Suriname</option>
								   <option value="SJ">Svalbard And Jan Mayen</option>
								   <option value="SZ">Swaziland</option>
								   <option value="SE">Sweden</option>
								   <option value="CH">Switzerland</option>
								   <option value="SY">Syrian Arab Republic</option>
								   <option value="TW">Taiwan</option>
								   <option value="TJ">Tajikistan</option>
								   <option value="TZ">Tanzania, United Republic Of</option>
								   <option value="TH">Thailand</option>
								   <option value="TL">Timor-leste</option>
								   <option value="TG">Togo</option>
								   <option value="TK">Tokelau</option>
								   <option value="TO">Tonga</option>
								   <option value="TT">Trinidad And Tobago</option>
								   <option value="TN">Tunisia</option>
								   <option value="TR">Turkey</option>
								   <option value="TM">Turkmenistan</option>
								   <option value="TC">Turks And Caicos Islands</option>
								   <option value="TV">Tuvalu</option>
								   <option value="UG">Uganda</option>
								   <option value="UA">Ukraine</option>
								   <option value="AE">United Arab Emirates</option>
								   <option value="GB">United Kingdom</option>
								   <option value="UY">Uruguay</option>
								   <option value="UZ">Uzbekistan</option>
								   <option value="VU">Vanuatu</option>
								   <option value="VE">Venezuela, Bolivarian Republic Of</option>
								   <option value="VN">Viet Nam</option>
								   <option value="VG">Virgin Islands, British</option>
								   <option value="WF">Wallis And Futuna</option>
								   <option value="EH">Western Sahara</option>
								   <option value="YE">Yemen</option>
								   <option value="ZM">Zambia</option>
								   <option value="ZW">Zimbabwe</option>
								</select>
							 </div>
						  </div>
						  <div class="col-sm-4 mt-15" title="">
							 <label class="main-label" for="beneficialOwner[${beneficialCounter}].address.state"> State <em>*</em></label>
							 <div class="form-fields">
								<select class="benstate form-field" id="beneficialOwner[${beneficialCounter}].address.state" name="beneficialOwner[${beneficialCounter}].address.state">
								   <option value="">Select a State </option>
								   <option value="AL">Alabama</option>
								   <option value="AK">Alaska</option>
								   <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
								   <option value="AA">Armed Forces Americas (except Canada)</option>
								   <option value="AP">Armed Forces Pacific</option>
								   <option value="AZ">Arizona</option>
								   <option value="AR">Arkansas</option>
								   <option value="CA">California</option>
								   <option value="CO">Colorado</option>
								   <option value="CT">Connecticut</option>
								   <option value="DE">Delaware</option>
								   <option value="DC">District of Columbia</option>
								   <option value="FL">Florida</option>
								   <option value="GA">Georgia</option>
								   <option value="HI">Hawaii</option>
								   <option value="ID">Idaho</option>
								   <option value="IL">Illinois</option>
								   <option value="IN">Indiana</option>
								   <option value="IA">Iowa</option>
								   <option value="KS">Kansas</option>
								   <option value="KY">Kentucky</option>
								   <option value="LA">Louisiana</option>
								   <option value="ME">Maine</option>
								   <option value="MD">Maryland</option>
								   <option value="MA">Massachusetts</option>
								   <option value="MI">Michigan</option>
								   <option value="MN">Minnesota</option>
								   <option value="MS">Mississippi</option>
								   <option value="MO">Missouri</option>
								   <option value="MT">Montana</option>
								   <option value="NE">Nebraska</option>
								   <option value="NV">Nevada</option>
								   <option value="NH">New Hampshire</option>
								   <option value="NJ">New Jersey</option>
								   <option value="NM">New Mexico</option>
								   <option value="NY">New York</option>
								   <option value="NC">North Carolina</option>
								   <option value="ND">North Dakota</option>
								   <option value="OH">Ohio</option>
								   <option value="OK">Oklahoma</option>
								   <option value="OR">Oregon</option>
								   <option value="PA">Pennsylvania</option>
								   <option value="RI">Rhode Island</option>
								   <option value="SC">South Carolina</option>
								   <option value="SD">South Dakota</option>
								   <option value="TN">Tennessee</option>
								   <option value="TX">Texas</option>
								   <option value="UT">Utah</option>
								   <option value="VT">Vermont</option>
								   <option value="VA">Virginia</option>
								   <option value="WA">Washington</option>
								   <option value="WV">West Virginia</option>
								   <option value="WI">Wisconsin</option>
								   <option value="WY">Wyoming</option>
								</select>
							 </div>
						  </div>
						  <div class="col-sm-4 mt-15" title="">
							 <label class="main-label" for="beneficialOwner[${beneficialCounter}].address.postalCode">Zip Code <em>*</em></label>
							 <div class="form-fields">
								<input id="beneficialOwner[${beneficialCounter}].address.postalCode" name="beneficialOwner[${beneficialCounter}].address.postalCode" type="text" placeholder="Enter Zip Code" class="ben-zipcode form-field" />
							 </div>
						  </div>
						</div>
			       </div>
			      </div>	
				 </div>

   				</div>	
   			</div>	
   				<!-- Current Residential Address End -->

			  	</div> <!-- Main End  -->




					</div>
				 </div>
			  </div>
		   </div>
		</div>
	</div>
	 </div>`;

		//addDynamicElement();
		// Append the new beneficial owner section
		$('#accordionExample1').append(newBeneficial);
		$('form input').attr('autocomplete', 'new-password');
		// Add remove functionality
		$('.remove-beneficial').last().on('click', function() {
			const beneficialNumber = $(this).data('beneficial');
			$(`#collapseBeneficial${beneficialNumber}`).parent().remove();
		});
	});
});

function exemptEntityFunction(x, y) {
 
//	y = y;
	let flag = x.value;
 	try {
		// Use the dynamic index in the selector for 'exemptEntity' field
		if (flag === "true") {
 			$('#parentfinceid' + y).hide();
			$('.benexemptidi' + y).hide();
			$('.benficialexempt' + y).hide();
		} else if (flag === "false") {
 			$('#parentfinceid' + y).show();
			$('.benexemptidi' + y).show();
			$('.benficialexempt' + y).show();
		}
	} catch (e) {
 	}
}



function addDynamicElement() {
	// Add the element to the DOM

	// Attach the event handler right after adding the element
	$('#beneficialOwner\\[2\\]\\.exemptEntity').on('change', function() {
 
		if ($(this).is(':checked')) {
			$('#parentfinceid').hide();
			$('.benexemptidi').hide();
			$('#benficialexempt').hide();
		} else if ($('#exemptentityno').is(':checked')) {
			$('#parentfinceid').show();
			$('.benexemptidi').show();
			$('#benficialexempt').show();
		}

		// Perform your logic for the specific beneficialOwner
	});
}


//-----------------------------------------------------------------------------------------------------------------------
// Alternate name code for second form end

//-----------------------------------------------------------------------------------------------------------------------
// Auto pop-up enable in login form start
$(window).on('load', function() {
	if (window.location.href.indexOf("login") !== -1) {
		$('#loginModal').modal('show'); // Show the modal when the page is fully loaded and the URL contains "login"
	}
});

//fincen id hide code for 4th form
function disableFields(x, y) {
	// Extract the value from the 'x' input
	let fincenValue = x.value.trim();
	let isValidFincen = /^\d{4}-\d{4}-\d{4}$/.test(fincenValue); // Check for valid pattern

 	if (isValidFincen) {
 		$('#benificialfinid' + y).hide(); // Hide element if valid
		$('#benficialnamefieldp2' + y).show();
	} else {
		$('#benificialfinid' + y).show(); // Show element if invalid
		$('#benficialnamefieldp2' + y).hide();
	}
}

//fincen id hide code for 3rd form start

function disableFields1(x, y) {
	let fincenValue = x.value.trim();
	let isValidFincen = /^\d{4}-\d{4}-\d{4}$/.test(fincenValue);
 	if (isValidFincen) {
 		$('#existrepotcom' + y).hide();
	} else {
		$('#existrepotcom' + y).show();
	}
}

//fincen id hide code for 3rd form end

//-----------------------------------------------------------------------------------------------------------------------
// Auto pop-up enable in login form end
//Document logic added by Ananth

$(document).ready(function() {
	// Default behavior on page load
	resetFieldsForAll();

	// Trigger action when the document type changes for dynamic indices
	$(document).on('change', "[id*='identificationDocuments\\.documentType']", function() {
		var docType = $(this).val();
		var nameAttr = $(this).attr('id');
		var entity = getEntityFromName(nameAttr); // companyApplicantInfo or beneficialOwner
		var index = getIndexFromName(nameAttr);

		resetFields(entity, index);  // Reset fields for this entity and index

		switch (docType) {
			case '37': // State issued driver's license
				enableCountryOptions(entity, index, [
					'US', 'AS', 'GU', 'MH', 'FM', 'MP', 'PW', 'PR', 'VI'
				]);
				enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
				break;

			case '38': // State/local/tribe-issued ID
				enableCountryOptions(entity, index, [
					'US', 'AS', 'GU', 'MH', 'FM', 'MP', 'PW', 'PR', 'VI'
				]);
				enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
				enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
				break;

			case '39': // U.S. passport
				selectCountryOption(entity, index, 'US');
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
				break;

			case '40': // Foreign passport
				enableCountryOptions(entity, index, [
					'AF', 'AX', 'AL', 'DZ', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BQ', 'BA', 'BW', 'BV', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CG', 'CD', 'CK', 'CR', 'CI', 'HR', 'CU', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', 'ET', 'FK', 'FO', 'FJ', 'FI', 'FR', 'GF', 'PF', 'TF', 'GA', 'GM', 'GE', 'DE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GT', 'GG', 'GN', 'GW', 'GY', 'HT', 'HM', 'VA', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID', 'IR', 'IQ', 'IE', 'IM', 'IL', 'IT', 'JM', 'JP', 'JE', 'JO', 'KZ', 'KE', 'KI', 'KP', 'KR', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MO', 'MK', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MQ', 'MR', 'MU', 'YT', 'MX', 'MD', 'MC', 'MN', 'ME', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'NO', 'OM', 'PK', 'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'QA', 'RE', 'RO', 'RU', 'RW', 'BL', 'SH', 'KN', 'LC', 'MF', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'RS', 'SC', 'SL', 'SG', 'SX', 'SK', 'SI', 'SB', 'SO', 'ZA', 'GS', 'SS', 'ES', 'LK', 'SD', 'SR', 'SJ', 'SZ', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'UG', 'UA', 'AE', 'GB', 'UY', 'UZ', 'VU', 'VE', 'VN', 'VG', 'WF', 'EH', 'YE', 'ZM', 'ZW'
				]);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
				break;

			default: // Default behavior for "Select an option"
				enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerCountry`);
				enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
				disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
		}
	});

	// Handle the Country/Jurisdiction dropdown logic
	$(document).on('change', "[id*='identificationDocuments\\.issuerCountry']", function() {
		var country = $(this).val();
		var nameAttr = $(this).attr('id');
		var entity = getEntityFromName(nameAttr);
		var index = getIndexFromName(nameAttr);
		var docType = $(`#${entity}\\[${index}\\]\\.identificationDocuments\\.documentType`).val();

		// Handle states when specific countries are selected
		if (['AS', 'GU', 'MH', 'FM', 'MP', 'PW', 'PR', 'VI'].includes(country)) {
			selectStateOption(entity, index, country);
			disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
			disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
			disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
		} else if (country === 'US' && docType === '37') {
			enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
			disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
			disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
		} else if (country === 'US' && docType === '38') {
			enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
			enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
		}
	});

	// Handle the Local/Tribal dropdown logic
	$(document).on('change', "[id*='identificationDocuments\\.issuerLocalOrTribal']", function() {
		var nameAttr = $(this).attr('id');
		var entity = getEntityFromName(nameAttr);
		var index = getIndexFromName(nameAttr);
		var localTribal = $(this).val();

		if (localTribal === 'Other') {
			enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
		} else {
			disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
		}
	});

	// Reset fields to their default state
	function resetFields(entity, index) {
		$(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerCountry`).val('');
		$(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`).val('');
		$(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`).val('');
		$(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`).val('');

		enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerCountry`);
		disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
		disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerLocalOrTribal`);
		disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.otherLocalDesc`);
	}

	// Reset fields for all instances of both entities
	function resetFieldsForAll() {
		$("[id*='identificationDocuments']").each(function() {
			var nameAttr = $(this).attr('id');
			var entity = getEntityFromName(nameAttr);
			var index = getIndexFromName(nameAttr);
			resetFields(entity, index);
		});
	}

	// Extract entity type (companyApplicantInfo or beneficialOwner) from the element's ID
	function getEntityFromName(nameAttr) {
		if (nameAttr.includes('companyApplicantInfo')) {
			return 'companyApplicantInfo';
		} else if (nameAttr.includes('beneficialOwner')) {
			return 'beneficialOwner';
		}
	}

	//addcom
	//changed to dummy and move to boirDocAi.js

	$(document).on('dummy', "[id*='identificationDocuments\\.document']", function() {
		var nameAttr = $(this).attr('id');
		var index = getIndexFromName(nameAttr);
		var fileInput = $(this)[0];
		var entity = getEntityFromName(nameAttr); // e.g., companyApplicantInfo or beneficialOwner
		var file = fileInput.files[0];
		var id = $(this).id;
		var id1 = this.id;
		alert("nameattr >> " + nameAttr + "   id:: " + id + " >> id1 :: " + id1);


		if (file) {
			// Validate file size
			var maxSize = 4 * 1024 * 1024; // 4MB in bytes
			if (file.size > maxSize) {
 				var modalSelector = "";
				if (entity == "companyApplicantInfo") {
					modalSelector = `#fileSizeTooLargeModal${entity ? `\\[${index}\\]` : ''}`;
				} else {
					modalSelector = `#fileSizeTooLargeModal2${entity ? `\\[${index}\\]` : ''}`;
				}
				$(modalSelector).modal('show'); // Show the file size too large modal
				$(fileInput).val(''); // Clear the file input
				return; // Exit the function
			}
			// Prepare form data
			var formData = new FormData();
			formData.append('file', file);
			// Show the progress bar
			$('#progressWrapper, #progressWrapperBen').show();
			$('#progressBar, #progressBarBen').val(0);
			$('#progressText, #progressTextBen').text('0%');
			// Send the AJAX request to upload the file
			$.ajax({
				url: '/upload',
				type: 'POST',
				data: formData,
				contentType: false,
				processData: false,
				xhr: function() {
					var xhr = new XMLHttpRequest();
					xhr.upload.addEventListener('progress', function(e) {
						if (e.lengthComputable) {
							var percentComplete = Math.round((e.loaded / e.total) * 100);
							$('#progressBar, #progressBarBen').val(percentComplete);
							$('#progressText, #progressTextBen').text(percentComplete + '%');
						}
					}, false);
					return xhr;
				},
				success: function(response) {
					if (response && response.fileUrl) {
						// Extract the document name and path based on the file input name
						let lastIndex = nameAttr.lastIndexOf(".");
 						let fileNameField = nameAttr.substring(0, lastIndex + 1) + "documentName";
						let filePathField = nameAttr.substring(0, lastIndex + 1) + "documentPath";
						 
						let inputField1 = $(`[name="${fileNameField}"]`);
						let inputField2 = $(`[name="${filePathField}"]`);
						inputField1.val(response.fileName);
						inputField2.val(response.fileUrl);
 					} else {
						$(fileInput).val('');
						alert(response.errorMessage);
 					}
					// Hide the progress bar
					$('#progressWrapper, #progressWrapperBen').hide();
				},
				error: function(jqXHR, textStatus, errorThrown) {
 					$(fileInput).val('');
					// Hide the progress bar
					$('#progressWrapper, #progressWrapperBen').hide();
				}
			});
		}
	});

	// Extract index from the element's ID
	function getIndexFromName(nameAttr) {
		var match = nameAttr.match(/\[(\d+)\]/);
		return match ? match[1] : 0;  // Return 0 if no index found, though this should never happen
	}

	// Enable specific country options
	function enableCountryOptions(entity, index, allowedCountries) {
		$(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerCountry option`).each(function() {
			var value = $(this).val();
			if (allowedCountries.includes(value) || value === '') {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
		enableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerCountry`);
	}

	// Select a specific country option
	function selectCountryOption(entity, index, country) {
		$(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerCountry`).val(country);
		disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerCountry`);
	}

	// Select a specific state option
	function selectStateOption(entity, index, state) {
		$(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`).val(state);
		disableField(`#${entity}\\[${index}\\]\\.identificationDocuments\\.issuerState`);
	}

	// Enable a field
	function enableField(selector) {
		$(selector).prop('disabled', false);
	}

	// Disable a field
	function disableField(selector) {
		$(selector).prop('disabled', true);
	}
});

//added by Ananth for zipcode validation

$(document).ready(function() {
	// Function to update postal code field validation for a specific applicant
	function updatePostalCodeValidationForApplicant(index, type) {
 		var countryField = $(`select[name="${type}[${index}].address.country"]`);
		var postalCodeField = $(`input[name="${type}[${index}].address.postalCode"]`);
		// Clear previous validation rules for postal code field
		postalCodeField.rules('remove');

		// Define validation rules based on selected country
		var country = countryField.val();

		switch (country) {
			case 'US':
			case 'AS':
			case 'GU':
			case 'MH':
			case 'FM':
			case 'MP':
			case 'PW':
			case 'PR':
			case 'VI':
				postalCodeField.rules('add', {
					required: true,
					pattern: /^(?!12345)(?!.*(\d)\1{4})(?!.*123456789)\d{5}(?:\d{4})?$/,  // US ZIP code pattern
					messages: {
						required: "ZIP/Foreign postal code is required",
						pattern: "ZIP Code must be either five or nine numeric characters, cannot be a consecutive string of the same number or 123456789"
					}
				});
				break;
			case 'ES':
				postalCodeField.rules('add', {
					required: true,
					pattern: /^\d{5}$/,  // Spanish postal code pattern
					messages: {
						required: "ZIP/Foreign postal code is required",
						pattern: "Consecutive string of the same number or 123456789"
					}
				});
				break;
			default:
				postalCodeField.rules('add', {
					required: false,
					pattern: /^[A-Za-z0-9]{1,9}$/,  // Alphanumeric pattern
					messages: {
						pattern: "If a foreign country/jurisdiction is recorded, entry can be one to nine alphanumeric characters"
					}
				});
				break;
		}
	}

	// Bind change event for issuerCountry field
	//$(document).on('change', "[name^='companyApplicantInfo'][name$='.address.country']", function() {
	$(document).on('change', "select[name$='.address.country']", function() {
		const nameAttr = $(this).attr('name');
		const index = nameAttr.match(/\[([\d]+)\]/)[1]; // Extract the index
		const type = nameAttr.match(/^(companyApplicantInfo|beneficialOwner)/)[1];
		updatePostalCodeValidationForApplicant(index, type);  // Update validation only for the changed applicant
	});
});
$('form input').attr('autocomplete', 'new-password');

function ResetComAppFieldsValidations(){
	$('.com-idt').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-file-input').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-idn').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-counjuri').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-state').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-localtrib').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-otherlt').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-suffix').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-fn').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-midname').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-lname').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-dob').each(function() {
		$(this).rules("remove", "required minAge");
	});
	$('.com-addtype').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-address').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-city').each(function() {
		$(this).rules("remove", "required");
	});
	$('.com-countryjuri').each(function() {
		$(this).rules("remove", "required");
	});
	$('.company-state').each(function() {
		$(this).rules("remove", "required");
	});
    $('.com-zipcode').each(function() {
		$(this).rules("remove", "required");
	});
}
//Ended by Ananth
function ResetBenAppFieldsValidations(){
	$('.ben-idt').each(function() {
		$(this).rules("remove", "required");
	});
	$('ben-email').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-idn').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-file-input').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-counjuri').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-state').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-localtrib').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-otherlt').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-suffix').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-fn').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-midname	').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-lname').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-dob').each(function() {
		$(this).rules("remove", "required minAge");
	});
	$('.ben-addtype').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-address').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-city').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-countryjuri').each(function() {
		$(this).rules("remove", "required");
	});
	$('.benstate').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-zipcode').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-fincen-fn').each(function() {
		$(this).rules("remove", "required");
	});
	$('.ben-fincen-lname').each(function() {
		$(this).rules("remove", "required");
	});

}
//-----------------------------------------------------------------------------------------------