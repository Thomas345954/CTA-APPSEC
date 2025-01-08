
$(document).ready(function() {

	function loadSelectData() {
		$.ajax({
			url: '/js/countryStatesOptions.json', // Path to your JSON file
			method: 'GET',
			dataType: 'json',
			success: function(data) {

				var tribeDropdown = $('#tribalJurisdictionFormation');
				var statesRegistrationDropdown = $('#stateFirstRegistration');
				var repCountryOrJurisdictionRepDropdown = $('#countryOrJurisdiction');

				$.each(data.countryJurisdiction, function(index, countryOrJurisdiction) {
					repCountryOrJurisdictionRepDropdown.append('<option value="' + countryOrJurisdiction.value + '">' + countryOrJurisdiction.name + '</option>');
				});
				$.each(data.tribalJurisdictionFormations, function(index, tribe) {
					tribeDropdown.append('<option value="' + tribe.value + '">' + tribe.name + '</option>');
				});
				$.each(data.statesRegistration, function(index, statesRegistration) {
					statesRegistrationDropdown.append('<option value="' + statesRegistration.value + '">' + statesRegistration.name + '</option>');
					//stateFormation
				});


				$('select[name="countryOrJurisdiction"] option').clone().appendTo('select[name="countryOrJurisdictionFormation"]');


				// $('select[name="countryOrJurisdiction"] option').clone().appendTo('select[name="countryOrJurisdictionRep"]');
				$('select[name="countryOrJurisdiction"] option')
					.filter(function() {
						return this.value !== "US";
					})
					.clone()
					.appendTo('select[name="countryOrJurisdictionRep"]');
				$('select[name="countryOrJurisdiction"] option').clone().appendTo('select[name="companyApplicantInfo[0].identificationDocuments.issuerCountry"]');
				$('select[name="countryOrJurisdiction"] option').clone().appendTo('select[name="companyApplicantInfo[0].address.country"]');
				$('select[name="countryOrJurisdiction"] option').clone().appendTo('select[name="beneficialOwner[0].identificationDocuments.issuerCountry"]');
				$('select[name="countryOrJurisdiction"] option').clone().appendTo('select[name="beneficialOwner[0].address.country"]');


				$('select[name="stateFirstRegistration"] option').clone().appendTo('select[name="stateFormation"]');
				$('select[name="stateFirstRegistration"] option').clone().appendTo('select[name="reportingAddress.state"]');
				$('select[name="stateFirstRegistration"] option').clone().appendTo('select[name="companyApplicantInfo[0].identificationDocuments.issuerState"]');
				$('select[name="stateFirstRegistration"] option').clone().appendTo('select[name="companyApplicantInfo[0].address.state"]');
				$('select[name="stateFirstRegistration"] option').clone().appendTo('select[name="beneficialOwner[0].identificationDocuments.issuerState"]');
				$('select[name="stateFirstRegistration"] option').clone().appendTo('select[name="beneficialOwner[0].address.state"]');

				$('select[name="tribalJurisdictionFormation"] option').clone().appendTo('select[name="tribalJurisdictionFirstRegistration"]');
				$('select[name="tribalJurisdictionFormation"] option').clone().appendTo('select[name="companyApplicantInfo[0].identificationDocuments.issuerLocalOrTribal"]');
				$('select[name="tribalJurisdictionFormation"] option').clone().appendTo('select[name="beneficialOwner[0].identificationDocuments.issuerLocalOrTribal"]');

			},
			error: function(error) {
 			}
		});



	}

	function loadEditData() {

		const urlParams = new URLSearchParams(window.location.search);
		const filingInfoId = urlParams.get('filingInfoId');
		if (filingInfoId !== null) {
			$.ajax({
				url: '/updatefilingInfo/' + filingInfoId, // Path to your JSON file
				method: 'GET',
				dataType: 'json',
				success: function(data) {
					var fileTypeEdit = false;
					populateForm(data.filingInfo, '', '', fileTypeEdit);
					if (data.filingInfo.prevSubmissionStatus == 'submission_accepted') {
						fileTypeEdit = true;
						$('#Initial').prop('checked', false).prop('disabled', true);
						$('#exemptRadio').prop('checked', false).prop('disabled', true);

						if (data.filingInfo.filingType == 'correct' || data.filingInfo.filingType == 'Update') {
							//$('#' + data.filingInfo.filingType).prop('checked', true).trigger('change');
							$('input[name="filingType"][value="' + data.filingInfo.filingType + '"]').prop('checked', true).trigger('change');
						}

						try {
 							const originalFincenValue = data.filingInfo.fincenId;
							const formattedFincenValue = originalFincenValue.replace(/(\d{4})(\d{4})(\d{4})/, '$1-$2-$3');
 							$("#fincenidspan").text(formattedFincenValue);
						} catch (err) { }


						$("#reqFincenInitial").hide();
						$("#reqFincenEdit").show();

					} else {
						$('#' + data.filingInfo.filingType).prop('checked', true);
					}




					populateForm(data.reportingCompany, '', 'add-alternate-name', fileTypeEdit);
					populateForm(data.companyApplicant, '', 'addcom', fileTypeEdit);
					var beneficialOwner = data.beneficialOwner;
					var transformedObject = { "createdDate": 1726774636527, "createdBy": "yashwanth.s@microgridtechsol.com" };

					// Add a key-value pair to the object
					transformedObject['beneficialOwner'] = beneficialOwner;

					// Convert the object to a JSON string
					var beneficialOwnerJsonString = JSON.stringify(transformedObject);
					populateForm(JSON.parse(beneficialOwnerJsonString), '', 'addBeneficial', fileTypeEdit);
					populateForm(data.submitterDetails, '', '', fileTypeEdit);
					$("#subconemail").val($("#subemail").val());
				},
				error: function(error) {
 				}
			});
		}

	}

	loadEditData();

	function populateForm(data, parentKey, btnId, fileTypeEdit) {

		$.each(data, function(key, value) {
            var indexval=0;
			var elementName = parentKey ? parentKey + '.' + key : key;
			if (value !== "" && value !== null && typeof value === 'object' && value.constructor === Object) {
				// If the value is a JSON object, recursively call the function
				populateForm(value, elementName);
			} else if (value !== "" && value !== null && typeof value === 'object' && value.constructor === Array) {
				// If the value is a JSON array, iterate over the array and recursively call the function
				$.each(value, function(index, item) {
					var ind = 0;
					if (index > 0) {
						ind = index + 1;
						$('#' + btnId).trigger('click');
					}
					indexval = ind;
					populateForm(item, elementName + '[' + ind + ']', '');
				});
			} else {
				//var $element = $('input[name="' + elementName + '"]');
				var $element = $('form [name="' + elementName + '"]');
				if ($element.length > 0) {
					if ($element.is('select')) {
 						// If the element is a select box, find the option with the matching value
						var $option = $element.find('option[value="' + value + '"]');
						if ($option.length > 0 && !$element.is(':disabled') && value !== 'US') {
							$element.val(value);
 							try {
								$element.trigger('change');
								if (elementName == 'countryOrJurisdictionFormation') {
									$("#countryOrJurisdictionFormation").trigger('change');
								}
							} catch (err) { }
						} else {
							$element.val(value);
							if (elementName == 'countryOrJurisdictionFormation') {
								$("#countryOrJurisdictionFormation").trigger('change');
							}
 						}
					} else if ($element.is('input[type="radio"]')) {



						// If the element is a radio button, check if the value matches the radio button's value
						$element.filter('[value="' + value + '"]').prop('checked', true);


						//pop up click step 1
						if (elementName == "filingType" && value == "newly") {
							$("#exemptyes").trigger('click');
						}

						//pop up click step3
						if (elementName == "foreignPooledInvestmentVehicle" && value == true) {
							$("#foreignvehicleok").trigger('click');
						}
						//pop up click step 4
						if (elementName == "existingRepoCompany" && value == true) {
							$("#existok").trigger('click');
						}

						if (elementName == "existingRepoCompany" && value == true) {
							$("#existyes").trigger('click');
						}
						if (elementName.indexOf("exemptEntity") !== -1 && value == true) {
 							//$element.click();
							//$element.filter('[value="true"]').trigger('change');
							$element.filter('[value="true"]').prop('checked', true).trigger('change');
						}

					} else {
						// If the element is not a select box or radio button, assign the value using the val() method
						$element.val(value);
						$element.trigger('blur');
						if (elementName.indexOf("finCenId") !== -1 && !fileTypeEdit) {
							$element.prop('readonly', true);
						}
 						if (elementName.indexOf("identificationDocuments.documentName") !== -1) {
							
							var container = $element.closest('.fileinput');
							container.find('input[type="file"]').hide();
							container.find('button#edit-button').show();
							container.find('span#file-name-display').show();
 							container.find('span#file-name-display').text(value);
						} 
						
						if (elementName.indexOf("beneficialStatus") !== -1 && value == "pending") {
 							var indexMatch = elementName.match(/beneficialOwner\[(\d+)\]/);

							if (indexMatch) {
								var index = indexMatch[1]; // This will be "0" as a string
 							}
							var checkbox = $('.checkBeneficialEmail[data-index="' + index + '"]');
							checkbox.prop("checked", true);
							checkbox.trigger('change');
						}
					}
				}
			}
		});
	}
	//loadSelectData();
});