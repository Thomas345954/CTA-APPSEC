<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/right-click.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>In Progress List</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .header-container h3 {
            margin: 0;
            padding: 0;
        }
        .search-box-container {
            width: 25%;
            display: flex;
            justify-content: flex-end;
        }
        .search-box {
            width: 100%;
        }
        .rows-per-page-container {
            width: auto;
        }
        .rows-per-page {
            width: 75px;
        }
        .table-responsive {
            margin-top: 10px;
        }
        .footer-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }
        .pagination-container {
            display: flex;
            justify-content: flex-end;
        }
        .pagination-btn {
            margin-left: 5px;
        }
        .table-center-align th,
        .table-center-align td {
            text-align: center;
        }
    </style>
</head>
<body>
<div>
	
    <div class="header-container head-with-search">
        <aside class="col-md-6 udf-top-left ud-form-top"><h3>In Progress Reports</h3></aside>
        <div class="col-md-6 search-box-container">
            <input type="text" class="form-control search-box" id="searchBox" placeholder="Search">
        </div>
    </div>

	<div class="table-responsive new-tab-layout">
		<table>
		 <thead>
		  <tr>
		   <th class="company-th">Company Name</th>
		   <th >Beneficial Owner</th>
<!--		   <th>Date Started</th>-->
		   <th class="status-th">Status</th><!--<img src="/images/filter-icon.svg" alt="" />--> 
		   <th>Progress</th>
		   <th>Last Updated</th>
		   <th>Last Reminder</th>
		 </tr>
	   </thead>
	   <tbody id="reportTableBody">
			<c:forEach var="filing_info" items="${filingInfo}">
				<tr>
					<td>
						<a href="#">${filing_info.userId}</a>
						<span class="small-txt">${filing_info.taxIdNum}</span>
					</td>
					<td>
						<input type="hidden" value="${filing_info.filingInfoId}" class="filingInfoIdField" />
						<div class="dropdown">
							<button class="btn btn-secondary dropdown-toggle beneficialDropDownBtn" data-id="${filing_info.filingInfoId}" type="button" data-bs-toggle="dropdown" aria-expanded="false">
								Beneficial Owner
							</button>
							<ul class="dropdown-menu beneficialDropDown">
								<!--Here Dynamically Append the beneficial onwers name-->
							</ul>
						</div>
<!--						<a href="#" class="text-link">Send Reminder</a>-->
					</td>
<!--					<td><fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy" /></td>-->
					<c:choose>
					    <c:when test="${not empty filing_info.legalName}"> <!-- here legal name is submitter value-->
							<td>General Information Submitted</td>
							<td class="perc-td-sec">
								<span>83%</span>
								<div class="progress-container">
									<div class="progress-bar-wrapper">
										<div class="progress-bar" id="progress3" style="width:83.33%;">
										</div>
									</div>
								</div>
								<a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" class="open-AddBookDialogForProg text-link"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;cursor:pointer;">Resume</a>
							</td>
					    </c:when>
					    <c:when test="${not empty filing_info.updatedBy}"> <!-- here updatedBy is ownerid value-->
							<td>Owner Information Submitted</td>
							<td class="perc-td-sec">
								<span>67%</span>
								<div class="progress-container">
									<div class="progress-bar-wrapper">
										<div class="progress-bar" id="progress3" style="width:66.67%;">
										</div>
									</div>
								</div>
								<a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" class="open-AddBookDialogForProg text-link"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;cursor:pointer;">Resume</a>
							</td>
					    </c:when>
					    <c:when test="${not empty filing_info.currentStatus}"> <!-- here currentStatus is applicantid value-->
							<td>Company Information Submitted</td>
							<td class="perc-td-sec">
								<span>50%</span>
								<div class="progress-container">
									<div class="progress-bar-wrapper">
										<div class="progress-bar" id="progress3" style="width:50%;">
										</div>
									</div>
								</div>
								<a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" class="open-AddBookDialogForProg text-link"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;cursor:pointer;">Resume</a>
							</td>
					    </c:when>
					    <c:when test="${not empty filing_info.countryOrJurisdiction}"> <!-- here countryOrJurisdiction is reportingcompanyid value-->
							<td>Reporting Information Submitted</td>
							<td class="perc-td-sec">
								<span>33%</span>
						   		<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress3" style="width:33.33%;">
						   				</div>
						   			</div>
						   		</div>
								<a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" class="open-AddBookDialogForProg text-link"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;cursor:pointer;">Resume</a>
							</td>
					    </c:when>
						<c:when test="${not empty filing_info.filingInfoId}">
							<td>Pending</td>
							<td class="perc-td-sec">
								<span>17%</span>
								<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress3" style="width:16.67%;">
						   				</div>
						   			</div>
						   		</div> 
								<a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" class="open-AddBookDialogForProg text-link"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;cursor:pointer;">Resume</a>
							</td>
					    </c:when>
						<c:otherwise> 
							<td>Did not start</td>
							<td class="perc-td-sec">
								<span>0%</span>
								<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress3" style="width:4%;">
						   				</div>
						   			</div>
						   		</div>
								<a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" class="open-AddBookDialogForProg text-link"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;cursor:pointer;">Resume</a>
							</td>
						</c:otherwise>
					</c:choose>
					<!--<td>Did not start</td>
					<td>
						<span>0%</span>
						<a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" title="Add this item" class="open-AddBookDialogForProg text-link"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;">Resume</a>
					</td>-->
					<fmt:parseDate var="parsedDate" value="${filing_info.datePrepared}" pattern="yyyy-MM-dd" />
					<td><fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy" /></td>
					<c:choose>
					    <c:when test="${not empty filing_info.prevSubmissionStatus}">
<!--							<fmt:parseDate var="beneficialemailsentdate" value="${filing_info.prevSubmissionStatus}" pattern="yyyy-MM-dd" />-->
<!--							<td><fmt:formatDate value="${beneficialemailsentdate}" pattern="MM/dd/yyyy" /></td>-->
							<td>${filing_info.prevSubmissionStatus}</td>
						</c:when>
						<c:otherwise> 
							<td>No reminder sent <span>N/A</span></td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>	 
	   </tbody>
		</table>
	   </div>

    <!-- <div class="table-responsive cust-table">
        <table class="table table-striped table-center-align">
            <thead>
                <tr>
                   
                    <th>Company Name</th>
                    <th>Date Started</th>
                    <th>Status</th>
					<th>Action</th>
                </tr>
            </thead>
            <tbody >
                <c:forEach var="filing_info" items="${filingInfo}">
					<fmt:parseDate var="parsedDate" value="${filing_info.datePrepared}" pattern="yyyy-MM-dd" />
                    <tr>
                        <td>${filing_info.userId}</td>
                        <td><fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy" /></td>
						<c:choose>
						    <c:when test="${fn:contains(filing_info.status, 'submission_processing') || fn:contains(filing_info.status, 'In Progress') || fn:contains(filing_info.status, 'submission_initiated')}">
						       <td>In Progress</td>
						    </c:when>
						    <c:otherwise>
								<td>${filing_info.status}</td>
						    </c:otherwise>
						</c:choose>
						<td><a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" title="Add this item" class="open-AddBookDialogForProg btn btn-four"  title="Edit BOIR" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;">Resume</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div> -->
    <div class="footer-container tab-footer">
        <div class="rows-per-page-container">
            <label for="rowsPerPageSelect">Rows per page:</label>
            <select class="form-control form-field rows-per-page lab-select" id="rowsPerPageSelect">
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
				<option value="1000">1000</option>
            </select>
        </div>
        <div class="pagination-container">
            <!-- Pagination buttons will be added here dynamically -->
        </div>
    </div>
</div>
<div class="addBookDialogForProg-modal val-form-sec modal fade" data-id="ISBN564541" id="addBookDialogForProg" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="container">
            <div class="user-data-form step-form-modal modal-content">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close-prog-popup"></button>
                <div class="modal-cont">
                    <div class="boddyone">
                        <input type="hidden" name="bookId" id="bookIdProg" value="" />
                        <h2>Verify Your Identity</h2>
                        <p style=" text-align: left;" id="inprogresstextemail"></p>
                        <div>
                            <input class="form-control blackinput" value="" id="otpProg" name="otp" placeholder="Enter OTP" style="width: 60%;margin-left: 20%;" maxlength="6">
                        </div>
                        <span id="alertValidateForProg" style="display:none; font-weight: bold; font-size: 14px;  color: #B31942;">Oops! It seems the OTP is incorrect. Please double-check and enter the correct code</span>
                        <a href="#" id="validateProg" name="validate" class="btn-four mt-20">Validate</a>
                        <a href="#" id="resendBtnProg" class="btn-four mt-20" style="display:none;" data-email="${principalName}">Resend OTP</a>
                        <p id="timerFieldForProg" style="text-align: center; font-weight: bold; margin: 10px 0; color: #033963;">Your OTP expires in <span id="progTimer"></span> seconds.</p>
                        <p id="messageAfterTimeoutForProg" style="display: none; text-align: center; font-weight: bold; margin: 10px 0; color: #B31942;"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="manualRemainderEmailPopup" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-fullscreen modal-dialog-centered">
		<div class="container">
			<div class="user-data-form step-form-modal modal-content">
			<div class="modal-cont">
				<div class="boddy">
				<h3 class="modal-head">Mail sent!</h3>
				<p class="text-left">Your form has been recorded. We'll notify you once the beneficial owner submits their form, so you can complete the final BOIR filing.</p>
				<button class="btn-four" data-bs-dismiss="modal">Done</button>
				</div>
				</div>
			</div>	
		</div>
	</div>
</div>
<script>
	
	const addBookDialogForProg = new bootstrap.Modal(document.getElementById('addBookDialogForProg'));
			
	let countdownforprog; // Global variable for countdown interval
	let isTimerRunningForProg = false; // Flag to check if timer is running
	
	$(document).ready(function() {
	  $('#validateProg').on('click', function(event) {
		  var id = $("#bookIdProg").val();
	      var otp = $("#otpProg").val();
	      $.ajax({
			url: '/checkotp',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ filingInfoId: id, otp: otp }),
	        success: function(response) {
	           if(response.valid){
			      if(response.redirectUrl!=null && response.redirectUrl != "undefined" ){
	                  window.location.href = response.redirectUrl;						
				  }else{
					  window.location.href = "/dashboard";
				  }
	           } else {
	                  document.getElementById('alertValidateForProg').style.display = 'block';
	          }
          },
          error: function(xhr, status, error) {
         }
	    });
	  });
	  $('.beneficialDropDownBtn').on('click', function(event) {
		var id=$(this).data('id')
  	      var filingInfoId = id;
  	      $.ajax({
  	          url: '/getBeneficalDetails/'+filingInfoId,
  	          type: 'GET',
  	          success: function(response) {
				$('.beneficialDropDown').empty();
	            $('.beneficialDropDown').append('<li class="dd-title">All Beneficial Owners</li>');
				var condition=true;
				response.beneficialOwnerList.forEach(function(owner) {
	                let listItemContent;
					if(owner.legalName && !owner.firstName){
						listItemContent = owner.legalName;
					}else if (owner.legalName && owner.firstName) {
                    	listItemContent = owner.firstName+" "+owner.legalName;
	                } else if (owner.flegalName && owner.ffirstName) {
	                    listItemContent = owner.ffirstName+" "+owner.flegalName;
	                } else if (owner.benficialEmail) {
	                   var email = owner.benficialEmail;
					   var emailNameOnly = email.replace(/@.*/, '');

					   listItemContent = emailNameOnly + ` <a href="#" class="text-link manual-remainder">Send Reminder</a>`;
	                }
	
	                let listItem = `<li class="email-field-ben" data-email="`+email+`" data-id="`+filingInfoId+`">`+listItemContent+`</li>`;
	                $('.beneficialDropDown').append(listItem);
					condition=false;
	            });
					if(condition){
						listItemContent = `No details available`;
						let listItem = `<li>`+listItemContent+`</li>`;
		                $('.beneficialDropDown').append(listItem);
					}
					
  	              
  	          },
  	          error: function(xhr, status, error) {
  	          }
  	      });
  	  });
  });
  
  $(document).ready(function() {
      $(document).on('click', '.manual-remainder', function() {
          
          var email = $(this).closest('.email-field-ben').data('email');
          var filingInfoId = $(this).closest('.email-field-ben').data('id');
          
          $.ajax({
              url: '/manualBeneficialFormRemainder',
              method: 'POST',
              data: { email: email, id: filingInfoId },
              success: function(response) {
				  alert("Mail Sent to beneficial owner")
                  /*$('#manualRemainderEmailPopup').modal('show');*/
              },
              error: function(error) {
              }
          });
      });
  });

   
   
	 $(document).ready(function(){
		$(document).on("click", ".open-AddBookDialogForProg", function () {
			 addBookDialogForProg.show();
			
			 $("#validateProg").show(); //Show validate button field when close popup and come again by click second scenario  
 			 $("#resendBtnProg").hide(); //Hide resend OTP button field when close popup and come again by click second scenario
 			 $('#messageAfterTimeoutForProg').hide(); // Hide expire time up message
			 $('#addBookDialogForProg').find('#otpProg').val('');// Reset the input field
			 $("#alertValidateForProg").hide(); //Hide error message
		     var myBookId = $(this).data('id');
			 var email = $(this).data('email');
	 		 if (email) {
						 // Check if the #textemail contains a message
	 		     var inprogresstextemail = document.getElementById("inprogresstextemail");

	 		     if (inprogresstextemail.innerHTML.includes('Enter the 6-digit code we just sent to your email address')) {
	 		         // Clear the message first if it exists
	 		         inprogresstextemail.innerHTML = '';
	 		     }

	 		     // Append the new message
	 		     inprogresstextemail.innerHTML += 'Enter the 6-digit code we just sent to your email address "' + email + '". ';
	 		     
	 		     } else {
	 		         document.getElementById("textemail").innerHTML = 'Email address not found.';
	 		     }
				
			 // Clear any existing timer if it's running
	  	 		 if (isTimerRunningForProg) {
	  	 		     clearInterval(countdownforprog);
	  	 		 } else {
	  	 		     $('#progTimer').text(''); // Clear the timer display
	  	 		 }
	  			$("#timerFieldForProg").show(); //Show timer field when close popup and come again by click second scenario 
	  	 	 	startTimerForProg(90);  // Start the new timer with 90 seconds
			  					 
		     $(".boddyone #bookIdProg").val( myBookId );
	         $.ajax({
	             url: '/customOTP',
	             type: 'POST',
	             data: { email: '' }, // Ensure ${userEmail} is correctly replaced
	             success: function(response) {
					            },
	             error: function(xhr, status, error) {
	             }
	         });
		});
	});
	// Timer functionality	  
	function startTimerForProg(duration) {
	    var timerDisplay = $('#progTimer');
	    var timer = duration, minutes, seconds;

		isTimerRunningForProg = true; // Set the flag to true
		
	     countdownforprog = setInterval(function () {
	        minutes = parseInt(timer / 60, 10);
	        seconds = parseInt(timer % 60, 10);

	        minutes = minutes < 10 ? "0" + minutes : minutes;
	        seconds = seconds < 10 ? "0" + seconds : seconds;

	        timerDisplay.text(minutes + ":" + seconds);

	        if (--timer < 0) {
	            clearInterval(countdownforprog);
	             $('#progTimer').text(''); // Clear the timer display
				 $("#alertValidateForProg").hide(); //Hide error message
 				 $("#timerFieldForProg").hide(); //Hide timer field 
 				 $("#validateProg").hide(); //Hide Validate button field 
				 $("#resendBtnProg").show(); // show resend OTP button
				 $('#addBookDialogForProg').find('#otpProg').val('');// Reset the input field
				 $('#messageAfterTimeoutForProg').text('Your OTP has expired. Please request a new one').show(); // Show a different message after time is up
				 isTimerRunningForProg = false; // Reset the timer flag
	        }
	    }, 1000);
	}
	// resend button functionality
	$(document).ready(function() {	
		$('#resendBtnProg').on('click', function(event) {
			var email = $(this).data('email');
			$("#resendBtnProg").hide(); //Hide resend OTP button field 
			$('#messageAfterTimeoutForProg').hide(); // Hide expire time up message
			$("#timerFieldForProg").show(); //show timer field 
			$("#validateProg").show(); //show Validate button field 
			$('#addBookDialogForProg').find('#otpProg').val('');// Reset the input field
			startTimerForProg(90);  // Start the new timer with 90 seconds again
			$.ajax({
	            url: '/customOTP',
	            type: 'POST',
	            data: { email: 'email' }, // Ensure ${userEmail} is correctly replaced
	            success: function(response) {
				            },
	            error: function(xhr, status, error) {
	            }
		     });
		});
	});
		
		$(document).ready(function() {	
			$('#close-prog-popup').on('click', function(event) {
	 		//event.preventDefault(); // Prevent the default link behavior
	 		 	addBookDialogForProg.hide(); // Hide the modal manually

				// Reset the input field
				$('#addBookDialogForProg').find('#otpProg').val('');

				// Clear error messages
				$("#alertValidateForProg").hide(); //Hide error message
	 		})
		});	
		  
    $(document).ready(function() {
        var rowsPerPage = parseInt($('#rowsPerPageSelect').val());

        function updateTable() {
            var searchValue = $('#searchBox').val().toLowerCase();
            var visibleRows = $('#reportTableBody tr').filter(function() {
                return $(this).text().toLowerCase().indexOf(searchValue) > -1;
            });

            $('#reportTableBody tr').hide();
            visibleRows.slice(0, rowsPerPage).show();
        }

        $('#rowsPerPageSelect').change(function() {
            rowsPerPage = parseInt($(this).val());
            updateTable();
        });

        $('#searchBox').on('keyup', function() {
            updateTable();
        });

        // Initialize to show rows per page on page load
        updateTable();
		
		/* When the user clicks on the button, 
		closes every dropdowns and open the only one passed as argument */
		 
		/* Javascript only */
		function myFunction(element) {
		  var dropdowns = document.getElementsByClassName("dropdown-menu");
		  // element.nextSibling is the carriage return… The dropdown menu is the next next.
		  var thisDropdown = element.nextSibling.nextSibling;
		  if (!thisDropdown.classList.contains('show')) {  // Added to hide dropdown if clicking on the one already open
		    var i;
		    for (i = 0; i < dropdowns.length; i++) {
		      dropdowns[i].classList.remove('show');
		    }
		  }
		  // Toggle the dropdown on the element clicked
		  thisDropdown.classList.toggle("show");
		}
		 
		/* W3Schools function to close the dropdown when clicked outside. */
		window.onclick = function(event) {
		  if (!event.target.matches('.dropdown-toggle')) {
		    var dropdowns = document.getElementsByClassName("dropdown-menu");
		    var i;
		    for (i = 0; i < dropdowns.length; i++) {
		      var openDropdown = dropdowns[i];
		      if (openDropdown.classList.contains('show')) {
		        openDropdown.classList.remove('show');
		      }
		    }
		  }
		}
		
    });
	
	
</script>

</body>
</html>
