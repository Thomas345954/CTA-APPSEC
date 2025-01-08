// Custom jQuery validations for all the forms CTA Harbor
// Created on   : 26/07/2024.
// Developed by : (yashwanth.s@microgridtechsol.com) / (sandhya.k@microgridtechsol.com)

//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Edit Profile rules --> start


//-----------------------------------------------------------------------------------------------------------------------
// jQuery validations for Edit Profile rules --> end

// New script added for step 10.a,b,c,d,e,f,g stepform 2 start
//-----------------------------------------------------------------------------------------------------------------------


$(document).ready(function() {
	function resetRequiredCountryValidations(){
		 $('select[name="stateFormation"]').rules("remove", "required"); 
		 $('select[name="tribalJurisdictionFormation"]').rules("remove", "required"); 
		 $('select[name="stateFirstRegistration"]').rules("remove", "required"); 
		 $('select[name="tribalJurisdictionFirstRegistration"]').rules("remove", "required"); 
	 }
    $('#countryOrJurisdictionFormation').change(function() {
        var countryOrJurisdictionFormation = $(this).val();
        resetForm();
		resetRequiredCountryValidations();
        if (countryOrJurisdictionFormation === 'US') {
            $('#stateFormationDiv').removeClass('hidden');
            $('#tribalJurisdictionFormationDiv').removeClass('hidden');
			$('select[name="stateFormation"]').rules("add", {
	            required: true,
				messages:{
					required: "State formation is required",
				}
	        });
			$('select[name="tribalJurisdictionFormation"]').rules("add", {
	            required: true,
				messages:{
					required: "Tribal jurisdiction of formation is required",
				}
	        });
        } else if (['AS', 'GU', 'MH', 'FM', 'MP', 'PW', 'PR', 'VI'].includes(countryOrJurisdictionFormation)) {
            $('#stateFormationDiv').removeClass('hidden');
//			$('select[name="stateFormation"]').rules("add", {
//	            required: true,
//				messages:{
//					required: "Select a valid state",
//				}
//	        });
            $('#stateFormation').html('<option value="' + countryOrJurisdictionFormation + '">' + $(this).find("option:selected").text() + '</option>').prop('disabled', true);
        } else if (['AF', 'AX', 'AL', 'DZ', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BQ', 'BA', 'BW', 'BV', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CG', 'CD', 'CK', 'CR', 'CI', 'HR', 'CU', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', 'ET', 'FK', 'FO', 'FJ', 'FI', 'FR', 'GF', 'PF', 'TF', 'GA', 'GM', 'GE', 'DE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GT', 'GG', 'GN', 'GW', 'GY', 'HT', 'HM', 'VA', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID', 'IR', 'IQ', 'IE', 'IM', 'IL', 'IT', 'JM', 'JP', 'JE', 'JO', 'KZ', 'KE', 'KI', 'KP', 'KR', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MO', 'MK', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MQ', 'MR', 'MU', 'YT', 'MX', 'MD', 'MC', 'MN', 'ME', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'NO', 'OM', 'PK', 'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'QA', 'RE', 'RO', 'RU', 'RW', 'BL', 'SH', 'KN', 'LC', 'MF', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'RS', 'SC', 'SL', 'SG', 'SX', 'SK', 'SI', 'SB', 'SO', 'ZA', 'GS', 'SS', 'ES', 'LK', 'SD', 'SR', 'SJ', 'SZ', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'UG', 'UA', 'AE', 'GB', 'UY', 'UZ', 'VU', 'VE', 'VN', 'VG', 'WF', 'EH', 'YE', 'ZM', 'ZW'].includes(countryOrJurisdictionFormation)) {
            $('#stateFirstRegistrationDiv').removeClass('hidden');
            $('#tribalJurisdictionFirstRegistrationDiv').removeClass('hidden');
			$('select[name="stateFirstRegistration"]').rules("add", {
	            required: true,
				messages:{
					required: "State of first registration is required",
				}
	        });
			$('select[name="tribalJurisdictionFirstRegistration"]').rules("add", {
	            required: true,
				messages:{
					required: "Tribal jurisdiction of first registration is required",
				}
	        });
        }
    });

    $('#stateFormation').change(function() {
        if ($(this).val()) {
            $('#tribalJurisdictionFormation').prop('disabled', true);
        } else {
            $('#tribalJurisdictionFormation').prop('disabled', false);
        }
    });

    $('#tribalJurisdictionFormation').change(function() {
		$('input[name="otherTribeFormation"]').rules("remove", "required"); 
        if ($(this).val() === 'Other') {
            $('#otherTribeFormationDiv').removeClass('hidden');
			$('input[name="otherTribeFormation"]').rules("add", {
	            required: true,
				messages:{
					required: "Other tribe is a required field",
					maxlength: "150 characters maximum"
				}
	        });
        } else {
            $('#otherTribeFormationDiv').addClass('hidden').find('input').val('');
        }

        if ($(this).val()) {
            $('#stateFormation').prop('disabled', true);
        } else {
            $('#stateFormation').prop('disabled', false);
        }
    });

    $('#stateFirstRegistration').change(function() {
        if ($(this).val()) {
            $('#tribalJurisdictionFirstRegistration').prop('disabled', true);
        } else {
            $('#tribalJurisdictionFirstRegistration').prop('disabled', false);
        }
    });

    $('#tribalJurisdictionFirstRegistration').change(function() {
		$('input[name="otherTribeFirstRegistration"]').rules("remove", "required"); 
        if ($(this).val() === 'Other') {
            $('#otherTribeFirstRegistrationDiv').removeClass('hidden');
			$('input[name="otherTribeFirstRegistration"]').rules("add", {
	            required: true,
				messages:{
					required: "Other tribe of first registration is required",
					maxlength: "150 characters maximum"				}
	        });
        } else {
            $('#otherTribeFirstRegistrationDiv').addClass('hidden').find('input').val('');
        }

        if ($(this).val()) {
            $('#stateFirstRegistration').prop('disabled', true);
        } else {
            $('#stateFirstRegistration').prop('disabled', false);
        }
    });

    function resetForm() {
        $('#stateFormationDiv').addClass('hidden').find('select').val('').prop('disabled', false).html(`
            <option value="">Select a State</option>
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
        `);
        $('#tribalJurisdictionFormationDiv').addClass('hidden').find('select').val('').prop('disabled', false);
        $('#otherTribeFormationDiv').addClass('hidden').find('input').val('');
        $('#stateFirstRegistrationDiv').addClass('hidden').find('select').val('').prop('disabled', false);
        $('#tribalJurisdictionFirstRegistrationDiv').addClass('hidden').find('select').val('').prop('disabled', false);
        $('#otherTribeFirstRegistrationDiv').addClass('hidden').find('input').val('');
    }
});


//------------------------------------------------------------------------------------------------------------------------------
// New script added for step 10.a,b,c,d,e,f,g stepform 2 end


//13. U.S. or U.S. Territory Jquery start
$(document).ready(function() {
    // Store the original state dropdown options
    var originalStateOptions = $('#repstate').html();

    $('#repusterritory').change(function() {
        var selectedCountry = $(this).val();
        var $stateDropdown = $('#repstate');

        if (selectedCountry === 'US') {
            // Re-enable and repopulate the state dropdown with original options
			document.getElementById('repStateStar').style.display = 'inline';
            $stateDropdown.prop('disabled', false).html(originalStateOptions).val('');
        } else if (selectedCountry) {
            // Find the selected option's text and set it as the value in the state dropdown
            var territoryText = $('#repusterritory option:selected').text();
            $stateDropdown.prop('disabled', true).html('<option value="' + selectedCountry + '">' + territoryText + '</option>');
			document.getElementById('repStateStar').style.display = 'none';
        } else {
            // Reset the state dropdown if no country/territory is selected
			document.getElementById('repStateStar').style.display = 'inline';
            $stateDropdown.prop('disabled', false).val('');
        }
    });
});


//13. U.S. or U.S. Territory Jquery end

// 1 & 7. Tax Identification type value Tax Identification number to allow only 9 characters, for foreign upto 25 char start

$(document).ready(function() {
    var $taxIdNumField = $('#taxIdNum');
    var $taxIdTypeField = $('#taxIdType');
 
    // Base validation for the taxIdNum field
    $taxIdNumField.rules('add', {
        required: true,
        messages: {
            required: "This field is required."
        }
    });
 
    // Function to update validation rules based on selected taxIdType
    function updateValidationRulesForTaxIdNum() {
        var selectedType = $taxIdTypeField.val();
 
        // Remove previous specific validation rules
        $taxIdNumField.rules('remove', 'pattern minlength maxlength');
 
        // Apply new validation rules based on the selected ID type
        if (selectedType === "2" || selectedType === "1") { // EIN or SSN/ITIN
            $taxIdNumField.rules('add', {
                pattern: /^\d{9}$/, // Exactly 9 digits
                minlength: 9,
                maxlength: 9,
                messages: {
                    pattern: "Provide your 9-digit EIN/SSN/ITIN, omitting any special characters",
                    minlength: "Provide your 9-digit EIN/SSN/ITIN, omitting any special characters",
                    maxlength: "Provide your 9-digit EIN/SSN/ITIN, omitting any special characters"
                }
            });
        } else if (selectedType === "9") { // Foreign
            $taxIdNumField.rules('add', {
                pattern: /^[a-zA-Z0-9]{1,25}$/, // Up to 25 alphanumeric characters
                minlength: 1,
                maxlength: 25,
                messages: {
                    pattern: "Foreign ID can contain up to 25 alphanumeric characters.",
                    minlength: "Foreign ID must be at least 1 character.",
                    maxlength: "Foreign ID can be up to 25 characters."
                }
            });
        }
    }
 
    // Attach change event to update validation rules when taxIdType changes
    $taxIdTypeField.change(updateValidationRulesForTaxIdNum);
 
    // Trigger the change event on page load to apply rules based on initial selection
    $taxIdTypeField.trigger('change');
});

// 2nd one

$(document).ready(function() {
    var $taxIdentificationNumberField = $('#taxIdentificationNumber');
    var $taxIdentificationTypeField = $('#taxIdentificationType');
 
    // Base validation for the taxIdentificationNumber field
    $taxIdentificationNumberField.rules('add', {
        required: true,
        messages: {
            required: "This field is required."
        }
    });
 
    // Function to update validation rules based on selected taxIdentificationType
    function updateValidationRulesForTaxIdentificationNumber() {
        var selectedType = $taxIdentificationTypeField.val();
 
        // Remove previous specific validation rules
        $taxIdentificationNumberField.rules('remove', 'pattern minlength maxlength');
 
        // Apply new validation rules based on the selected ID type
        if (selectedType === "2" || selectedType === "1") { // EIN or SSN/ITIN
            $taxIdentificationNumberField.rules('add', {
                pattern: /^\d{9}$/, // Exactly 9 digits
                minlength: 9,
                maxlength: 9,
                messages: {
                    pattern: "Provide your 9-digit EIN/SSN/ITIN, omitting any special characters",
                    minlength: "Provide your 9-digit EIN/SSN/ITIN, omitting any special characters",
                    maxlength: "Provide your 9-digit EIN/SSN/ITIN, omitting any special characters"
                }
            });
        } else if (selectedType === "9") { // Foreign
            $taxIdentificationNumberField.rules('add', {
                pattern: /^[a-zA-Z0-9]{1,25}$/, // Up to 25 alphanumeric characters
                minlength: 1,
                maxlength: 25,
                messages: {
                    pattern: "Foreign ID can contain up to 25 alphanumeric characters.",
                    minlength: "Foreign ID must be at least 1 character.",
                    maxlength: "Foreign ID can be up to 25 characters."
                }
            });
        }
    }
 
    // Attach change event to update validation rules when taxIdentificationType changes
    $taxIdentificationTypeField.change(updateValidationRulesForTaxIdentificationNumber);
 
    // Trigger the change event on page load to apply rules based on initial selection
    $taxIdentificationTypeField.trigger('change');
});
 
//  1 & 7. Tax Identification type value Tax Identification number to allow only 9 characters, for foreign upto 25 char End.


// Date of birth future date block for 3rd form start

$(document).ready(function() {
    function setMaxDateForCompanyDOB() {
        var today = new Date().toISOString().split('T')[0];
        $('input[name^="companyApplicantInfo"][name$="dateOfBirth"]').attr('max', today);
    }

    // Initially set the max date when the document is ready
    setMaxDateForCompanyDOB();

    // Observe DOM changes to detect when new sections are added
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            $(mutation.addedNodes).find('input[name^="companyApplicantInfo"][name$="dateOfBirth"]').attr('max', new Date().toISOString().split('T')[0]);
        });
    });

    observer.observe(document.body, { childList: true, subtree: true });

    // Example trigger for adding a new section
    $('#addcom').on('click', setMaxDateForCompanyDOB);
});


// Date of birth future date block for 3rd form end

//-----------------------------------------------------------------------------------
// Date of birth future date block for 4th form start

$(document).ready(function() {
    function setMaxDateForDOB() {
        var today = new Date().toISOString().split('T')[0];
        $('input[name^="beneficialOwner"][name*="dateOfBirth"]').attr('max', today);
    }

    // Initially set the max date when the document is ready
    setMaxDateForDOB();

    // Observe DOM changes to detect when new sections are added
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            $(mutation.addedNodes).find('input[name^="beneficialOwner"][name*="dateOfBirth"]').attr('max', new Date().toISOString().split('T')[0]);
        });
    });

    observer.observe(document.body, { childList: true, subtree: true });

    // Example trigger for adding a new section
    $('#addBeneficial').on('click', setMaxDateForDOB);
});

// Date of birth future date block for 4th form end


