$(document).ready(function() {
	
//PopUps fields

	var autoPopulateResponse;
	var autoDataExtractModal;
	var extractModal = "";
	var unsupportedType;
	
	//DOCAI fields
	
	var docnumId;
	var fnameId ;
	var countryId ;
	var lastnameId;
	var dobId;
	var addressId;
	var addressCountryId;
	var issuerCountryId;
	var docTypeID;
	var stateId;
	var issuerStateId;
	var documentType;
	var middleNameId;
	var issuerLocalOrTribalId;
	var otherLocalDescId;
	var suffixId;
	var postalCodeId;
	var cityId;
	
	//file fields
	
	var nameAttr;
	var index;
	var fileInput;
	var entity;
	var file;
	var modalSelector;
	var maxSize;
	var container;
	var formData;
	function setFieldValue(selector, value, triggerChange= false) {
		const field = $(selector);
		field.val(value); // Set the value

		// Change the background color based on whether there's a value
		if(!field.prop('disabled')){
		if (value) {
			field.css({
				'background-color': '#C6FFCF', // Green if there's a value
				'background-image': 'none' // Remove the background image
			});
		} else {
			field.css({
				'background-color': '#FFFDC6', // Yellow if empty
				'background-image': 'url(../images/warning.svg)',
				'background-repeat': 'no-repeat',
				'background-position': 'right 15px center',
				'padding-right': '45px',
				'appearance': 'none' // Set appearance to none
			}).attr('title', 'We could not extract this field accurately. Please review.');// Yellow if empty

		}
		if(triggerChange && field.is('select')){
			field.trigger('change');
		}
		}
	}

	function resetFields(selector, clearValue = true) {
		const field = $(selector);
		if (clearValue) {
			field.val('');
		}
		field.css({
			'background-color': '', // Reset to default
			'background-image': '', // Remove any background images
			'background-repeat': '',
			'background-position': '',
			'padding-right': '',
			'appearance': ''
		}).removeAttr('title'); // Remove the title attribute
	}

	$(document).on('change', "[id*='identificationDocuments\\.document']", function() {
		 nameAttr = $(this).attr('id');
		 index = getIndexFromName(nameAttr);
		 fileInput = $(this)[0];
		 entity = getEntityFromName(nameAttr); // e.g., companyApplicantInfo or beneficialOwner
		 file = fileInput.files[0];
		
		

		if (nameAttr.startsWith('companyApplicantInfo')) {

			 docnumId = 'companyApplicantInfo[' + index + '].identificationDocuments.documentNumber';
			 fnameId = 'companyApplicantInfo[' + index + '].firstName';
			 countryId = 'companyApplicantInfo[' + index + '].identificationDocuments.issuerCountry';
			 lastnameId = 'companyApplicantInfo[' + index + '].individualsLastName';
			 dobId = 'companyApplicantInfo[' + index + '].dateOfBirth';
			 addressId = 'companyApplicantInfo[' + index + '].address.address';
			 addressCountryId = 'companyApplicantInfo[' + index + '].address.country';
			 issuerCountryId = 'companyApplicantInfo[' + index + '].identificationDocuments.issuerCountry';

			 docTypeID = 'companyApplicantInfo[' + index + '].identificationDocuments.documentType';
			 stateId = 'companyApplicantInfo[' + index + '].address.state';
			 issuerStateId = 'companyApplicantInfo[' + index + '].identificationDocuments.issuerState';


			 documentType = $('select[name*="' + docTypeID + '"]').val();

			//DOCAI not enabled fields
			 middleNameId = 'companyApplicantInfo[' + index + '].middleName';
			 issuerLocalOrTribalId = 'companyApplicantInfo[' + index + '].identificationDocuments.issuerLocalOrTribal';
			 otherLocalDescId = 'companyApplicantInfo[' + index + '].identificationDocuments.otherLocalDesc';
			 suffixId = 'companyApplicantInfo[' + index + '].suffix';
			 postalCodeId = 'companyApplicantInfo[' + index + '].address.postalCode';
			 cityId = 'companyApplicantInfo[' + index + '].address.city';

		} else if (nameAttr.startsWith('beneficialOwner')) {
			 docnumId = 'beneficialOwner[' + index + '].identificationDocuments.documentNumber';
			 fnameId = 'beneficialOwner[' + index + '].firstName';
			 countryId = 'beneficialOwner[' + index + '].identificationDocuments.issuerCountry';
			 lastnameId = 'beneficialOwner[' + index + '].legalName';
			 dobId = 'beneficialOwner[' + index + '].dateOfBirth';
			 addressId = 'beneficialOwner[' + index + '].address.address';
			 addressCountryId = 'beneficialOwner[' + index + '].address.country';
			 issuerCountryId = 'beneficialOwner[' + index + '].identificationDocuments.issuerCountry';
			 docTypeID = 'beneficialOwner[' + index + '].identificationDocuments.documentType';
			 stateId = 'beneficialOwner[' + index + '].address.state';
			 issuerStateId = 'beneficialOwner[' + index + '].identificationDocuments.issuerState';

			 documentType = $('select[name*="' + docTypeID + '"]').val();

			//DOCAI not enabled fields
			 middleNameId = 'beneficialOwner[' + index + '].middleName';
			 issuerLocalOrTribalId = 'beneficialOwner[' + index + '].identificationDocuments.issuerLocalOrTribal';
			 otherLocalDescId = 'beneficialOwner[' + index + '].identificationDocuments.otherLocalDesc';
			 suffixId = 'beneficialOwner[' + index + '].suffix';
			 postalCodeId = 'beneficialOwner[' + index + '].address.postalCode';
			 cityId = 'beneficialOwner[' + index + '].address.city';
		}


		if (file) {
			// Validate file size

			 maxSize = 4 * 1024 * 1024; // 4MB in bytes
			if (file.size > maxSize) {
 				modalSelector = "";
				if (entity == "companyApplicantInfo") {
					modalSelector = `#fileSizeTooLargeModal${entity ? `\\[${index}\\]` : ''}`;
				} else {
					modalSelector = `#fileSizeTooLargeModal2${entity ? `\\[${index}\\]` : ''}`;
				}
				$(modalSelector).modal('show'); // Show the file size too large modal
				$(fileInput).val(''); // Clear the file input
				return; // Exit the function
			}

			// var autoPopulateResponse = confirm("Are you sure you want to proceed to Auto populate data?");

			autoDataExtractModal = "";
			if (entity == "companyApplicantInfo") {
				autoDataExtractModal = `#auto-data-extract-popup${entity ? `\\[${index}\\]` : ''}`;
			} else {
				autoDataExtractModal = `#auto-data-extract-popup2${entity ? `\\[${index}\\]` : ''}`;
			}
			$(autoDataExtractModal).modal('show');



			if (entity == "companyApplicantInfo") {
				extractModal = `#extract-info-popup${entity ? `\\[${index}\\]` : ''}`;
			} else {
				extractModal = `#extract-info-popup2${entity ? `\\[${index}\\]` : ''}`;
			}

			container = $(this).closest('.fileinput');
			// Prepare form data
			formData = new FormData();
			formData.append('file', file);
			formData.append('documentType', documentType);
			// Show the progress bar
			$('#progressWrapper, #progressWrapperBen').show();
			$('#progressBar, #progressBarBen').val(0);
			$('#progressText, #progressTextBen').text('0%');
			// Send the AJAX request to upload the file
			
		}
	});
	

		function ajax(){
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
							
							try {
							// Extract the document name and path based on the file input name
							let lastIndex = nameAttr.lastIndexOf(".");
							let fileNameField = nameAttr.substring(0, lastIndex + 1) + "documentName";
							let filePathField = nameAttr.substring(0, lastIndex + 1) + "documentPath";
							 
							let inputField1 = $(`[name="${fileNameField}"]`);
							let inputField2 = $(`[name="${filePathField}"]`);

							// Hide the progress bar
							$('#progressWrapper, #progressWrapperBen').hide();
							inputField1.val(response.fileName);
							inputField2.val(response.fileUrl);
	 						var originalName = container.find('input[type="file"]').val();
							//edit button functionality
							container.find('input[type="file"]').hide();
							container.find('button#edit-button').show();
							container.find('span#file-name-display').show();
	 						container.find('span#file-name-display').text(response.fileName);

							} catch (error) {
							    // Code to handle the error
	 						}
	 
							if (autoPopulateResponse) {
								
								try{
								// Apply values and colors
								setFieldValue('input[name="' + docnumId + '"]', response.response.docNumber);
								setFieldValue('input[name="' + fnameId + '"]', response.response.firstName);
								setFieldValue('select[name*="' + countryId + '"]', response.response.country, true);
								setFieldValue('input[name="' + lastnameId + '"]', response.response.lastName);
								setFieldValue('input[name="' + dobId + '"]', response.response.dob);
								setFieldValue('input[name="' + addressId + '"]', response.response.streetAddress);
								setFieldValue('select[name*="' + addressCountryId + '"]', response.response.country, true);
								setFieldValue('select[name*="' + issuerCountryId + '"]', response.response.country, true);
								setFieldValue('select[name*="' + stateId + '"]', response.response.state);
								setFieldValue('select[name*="' + issuerStateId + '"]', response.response.state);


								setFieldValue('input[name="' + middleNameId + '"]', response.response.middleName);
								setFieldValue('select[name*="' + issuerLocalOrTribalId + '"]', response.response.issuerLocalOrTribal);
								setFieldValue('input[name="' + otherLocalDescId + '"]', response.response.otherLocalDesc);
								setFieldValue('input[name="' + suffixId + '"]', response.response.suffix);
								setFieldValue('input[name="' + cityId + '"]', response.response.city);
								setFieldValue('input[name="' + postalCodeId + '"]', response.response.postalCode);


								$(extractModal).modal('hide'); //hiding extract loading modal

								var extractComplete = "";
								if (entity == "companyApplicantInfo") {
									extractComplete = `#extract-info-complete${entity ? `\\[${index}\\]` : ''}`;
								} else {
									extractComplete = `#extract-info-complete2${entity ? `\\[${index}\\]` : ''}`;
								}

								// shows auto population success popup
								$(extractComplete).modal('show');
								
							} catch (error) {
							    // Code to handle the error
	 						}

							} else {
	 							// reseting the fields again to default state
								resetFields('input[name="' + docnumId + '"]');
								resetFields('input[name="' + fnameId + '"]');
								/* resetFields('select[name*="' + countryId + '"]');*/
								if (documentType === '39') {
									// Only reset styles for countryId
									resetFields('select[name*="' + countryId + '"]', false);
									resetFields('select[name*="' + issuerCountryId + '"]', false);
								} else {
									resetFields('select[name*="' + countryId + '"]');
									resetFields('select[name*="' + issuerCountryId + '"]');
								}
								resetFields('input[name="' + lastnameId + '"]');
								resetFields('input[name="' + dobId + '"]');
								resetFields('input[name="' + addressId + '"]');
								resetFields('select[name*="' + addressCountryId + '"]');
								/*resetFields('select[name*="' + issuerCountryId + '"]');*/
								resetFields('input[name="' + middleNameId + '"]');
								resetFields('select[name="' + issuerStateId + '"]');
								resetFields('select[name*="' + issuerLocalOrTribalId + '"]');
								resetFields('input[name="' + otherLocalDescId + '"]');
								resetFields('input[name="' + suffixId + '"]');
								resetFields('input[name="' + cityId + '"]');
								resetFields('input[name="' + postalCodeId + '"]');
								resetFields('select[name*="' + stateId + '"]');
							}
							
							

						} else {
							unsupportedType = new bootstrap.Modal(document.getElementById('unsupportedTypePopup'));
							//alert(response.errorMessage);
							setTimeout(function() {
								$(fileInput).val('');
								$(autoDataExtractModal).modal('hide');
								$(extractModal).modal('hide');
								unsupportedType.show();
							}, 11000);
	 					}
						// Hide the progress bar
						$('#progressWrapper, #progressWrapperBen').hide();
					},
					error: function(jqXHR, textStatus, errorThrown) {
	 					$(fileInput).val('');

					}
			});
		}

	$(document).on('click', '#auto-data-extract-proceed', function(event) {
		event.preventDefault();
 		$(autoDataExtractModal).modal('hide'); // hide auto data extract modal popup
		$(extractModal).modal('show');
		//Making auto Populate Response to true
		autoPopulateResponse = true;
		ajax();
	});

	$(document).on('click', '#auto-data-extract-manual', function(event) {
		event.preventDefault();
 		$(autoDataExtractModal).modal('hide'); // hide auto data extract modal popup
		autoPopulateResponse = false;
		ajax();
	});

	$(document).on('click', '#unsupportedTypeUpload', function(event) {
		unsupportedType.hide();
		//upload document code need write if wanted
	})

	/*setTimeout(function() {
		 $(extractModal).modal('hide');
	 }, 60000); */

	function getIndexFromName(nameAttr) {
		var match = nameAttr.match(/\[(\d+)\]/);
		return match ? match[1] : 0;  // Return 0 if no index found, though this should never happen
	}

	// Extract entity type (companyApplicantInfo or beneficialOwner) from the element's ID
	function getEntityFromName(nameAttr) {
		if (nameAttr.includes('companyApplicantInfo')) {
			return 'companyApplicantInfo';
		} else if (nameAttr.includes('beneficialOwner')) {
			return 'beneficialOwner';
		}
	}

	//file edit button    
	$(document).on('click', "[id*='edit-button']", function() {
		var editContainer = $(this).closest('.fileinput');
		editContainer.find('button#edit-button').hide();
		editContainer.find('input[type="file"]').show();
		editContainer.find('span#file-name-display').hide();
	});

});