<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/css.jsp" %>
	<%@ include file="/WEB-INF/views/right-click.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submitted Lists</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
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
        .table-center-align th,
        .table-center-align td {
            text-align: center;
        }
    </style>
</head>
<body>
	
<div>
    <div class="header-container head-with-search">
        <aside class="col-md-6 udf-top-left ud-form-top"><h3>Submitted Reports</h3></aside>
        <div class="search-box-container">
            <label for="searchBox" class="sr-only">Search</label>
            <input type="text" class="form-control search-box" id="searchBox" placeholder="Search">
        </div>
    </div>

	<div class="table-responsive new-tab-layout">
		<table>
			<thead>
				<tr>
				<th>Company Name</th>
<!--				<th>Beneficial Owner</th>-->
				<th>Date Submitted</th>
				<th>Filed With FinCEN</th>
				<th>Status</th>
				<th>BOIR ID</th>
				<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody id="reportTableBody"> 
				<c:forEach var="filing_info" items="${filingInfo}">
					<c:set var="originalString" value="A${filing_info.filingInfoId}" />
					<c:set var="finalString" value="${originalString}" />
					<fmt:parseDate var="parsedDate" value="${filing_info.datePrepared}" pattern="yyyy-MM-dd" />
					<tr>
					<td>
						<a href="#">${filing_info.userId}</a>
						<span class="small-txt">${filing_info.taxIdNum}</span>
					</td>
					<!--Commented below beneficial onwer details in submitted report because these details are only necessary for inprogress reports-->
<!--					<td>-->
<!--						<div class="dropdown">-->
<!--							<button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">-->
<!--								Feroz Shaik-->
<!--							</button>-->
<!--							<ul class="dropdown-menu">-->
<!--								<li class="dd-title">All Beneficial Owners</li>-->
<!--								<li>Feroz Shaik <a class="dropdown-item" href="#">Send Invite</a></li>-->
<!--								<li>Bharat Vedula <a class="dropdown-item" href="#">Send Reminder</a></li>-->
<!--								<li>Mukund Srinivas <a class="dropdown-item" href="#">Resend Invite</a></li>-->
<!--							</ul>-->
<!--						</div>-->
<!--					</td>-->
					<td><fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy" /></td>
					<c:choose>
							<c:when test="${fn:contains(filing_info.status, 'submission_accepted')}">
								<td><img src="/images/tick-icon.svg" alt="">Filed</td>
								<td><img src="/images/tick-icon.svg" alt="">Accepted</td>
								<td>${filing_info.boirId}</td>
							</c:when>
							<c:when test="${fn:contains(filing_info.status, 'submission_rejected')}">
								<td><img src="/images/close-icon.svg" alt=""> Not Filed</td>
								<td><img src="/images/close-icon.svg" alt=""> Rejected</td>
								<td>XXXXXXXXXXXX</td>
							</c:when>
							<c:when test="${fn:contains(filing_info.status, 'submission_validation_failed')}">
								<td><img src="/images/close-icon.svg" alt=""> Not Filed</td>
								<td><img src="/images/close-icon.svg" alt=""> Submission Failed</td>
								<td>XXXXXXXXXXXX</td>
							</c:when>
							<c:otherwise>
								<td>Failed</td>
								<td>XXXXXXXXXXXX</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${filing_info.status == 'submission_accepted'}">
								<td>
									<div class="dropdown fd-dropdown">
										<button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
										<img src="/images/three-dots.svg" alt="">
										</button>
										<ul class="dropdown-menu">
										<li><a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" title="Add this item" class="dropdown-item open-AddBookDialogForSub" title="Edit BOIR" style="cursor:pointer;">Edit Report</a></li>
										<li><a class="dropdown-item" href="/transcript/${filing_info.filingInfoId}"   target="_blank">Download Transcript</a></li>
										<li><a class="dropdown-item" href="/certificate/${filing_info.filingInfoId}/XXXXXXXX"  target="_blank" >Download Certificate</a></li>
										</ul>
									</div>
								</td>
							</c:when>
							<c:otherwise>
								<td>
									<div class="dropdown fd-dropdown">
										<button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
										<img src="/images/three-dots.svg" alt="">
										</button>
										<ul class="dropdown-menu">
										<li><a data-toggle="modal" data-id="${filing_info.filingInfoId}" data-email="${principalName}" title="Add this item" class="dropdown-item open-AddBookDialogForSub" title="Edit BOIR" style="cursor:pointer;">Edit Report</a></li>
										</ul>
									</div>
								</td>
							</c:otherwise>
						</c:choose>
					
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
	</div>

    <div class="footer-container tab-footer">
        <div class="rows-per-page-container">
            <label for="rowsPerPageSelect">Rows per page:</label>
            <select class="form-control  form-field rows-per-page lab-select" id="rowsPerPageSelect">
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
				<option value="1000">1000</option>
            </select>
        </div>
    </div>
</div>

<div class="addBookDialogForSub-modal val-form-sec modal fade" data-id="ISBN564541" id="addBookDialogForSub" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="container">
            <div class="user-data-form step-form-modal modal-content">
                <button type="button" class="btn-close edit-modal-close" data-bs-dismiss="modal" aria-label="Close" id="close-sub-popup"></button>
                <div class="modal-cont">
                    <div class="boddyone">
                        <input type="hidden" name="bookId" id="bookIdSub" value="" />
                        <h2>Verify Your Identity</h2>
                        <p style=" text-align: left;" id="textemail"></p>
                        <div>
                            <input class="form-control blackinput" value="" id="otpsub" name="otp" placeholder="Enter OTP" maxlength="6">
                        </div>
                        <span id="alertValidateForSub" style="display:none; font-weight: bold; font-size: 14px;  color: #B31942;">Oops! It seems the OTP is incorrect. Please double-check and enter the correct code</span>
                        <a href="#" id="validateSub" name="validate" class="btn-four">Validate</a>
                        <a href="#" id="resendBtnSub" class="btn-four" style="display:none;" data-email="${principalName}">Resend OTP</a>
                        <p id="timerFieldForSub" style="text-align: center; font-weight: bold; margin: 10px 0; color: #033963;">Your OTP expires in <span id="subTimer"></span> seconds.</p>
                        <p id="messageAfterTimeoutForSub" style="display: none; text-align: center; font-weight: bold; margin: 10px 0; color: #B31942;"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--<div class="modal fade" id="verifyIdentityModal" tabindex="-1" aria-modal="true" style="display: block; padding-left: 0px;">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="container">
            <div class="user-data-form step-form-modal modal-content">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                <div class="modal-cont">
                    <div class="boddyone">
                        <h2 style="text-align: center;margin-bottom: -10px;">Verify Your Identity</h2><br>
                        <p style=" text-align: left;">Enter the 6-digit code we just sent to your email address v***********b@g***l.com to verify your identity.</p>
                        <div><input class="form-control blackinput" value="" placeholder="Enter otp" style="width: 60%;margin-left: 20%;">
                        </div>
                        <a href="/boirfiling" class="btn-four" style="border-radius: 0px;margin: 20px;">File Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>-->



<%@ include file="/WEB-INF/views/js.jsp" %>

<script>
	const addBookDialogForSub = new bootstrap.Modal(document.getElementById('addBookDialogForSub'));
			
	let countdown; // Global variable for countdown interval
	let isTimerRunning = false; // Flag to check if timer is running
	
	$(document).ready(function() {	
		$('#validateSub').on('click', function(event) {
			var id=$("#bookIdSub").val();
			var otp=$("#otpsub").val();
			$.ajax({
				url: '/checkotp',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ filingInfoId: id, otp: otp }),
		        success: function(response) {
		           if(response.valid){
					  if(response.redirectUrl != null && response.redirectUrl != "undefined" ){
		                  window.location.href = response.redirectUrl;
					  }else{
						  window.location.href = "/dashboard";
					  }
		            } else{
						document.getElementById('alertValidateForSub').style.display = 'block';
					}
				 },
	             error: function(xhr, status, error) {
	              }
	         });
		  });
	 	});
	
	$(document).ready(function(){
		$(document).on("click", ".open-AddBookDialogForSub", function () {
			addBookDialogForSub.show();
			
			 $("#validateSub").show(); //Show validate button field when close popup and come again by click second scenario  
			 $("#resendBtnSub").hide(); //Hide resend OTP button field when close popup and come again by click second scenario
			 $('#messageAfterTimeoutForSub').hide(); // Hide expire time up message
			 $('#addBookDialogForSub').find('#otpsub').val('');// Reset the input field
			 $("#alertValidateForSub").hide(); //Hide error message
		     var myBookId = $(this).data('id');
			 var email = $(this).data('email');
			 if (email) {
			     // Check if the #textemail contains a message
			     var textEmailElement = document.getElementById("textemail");
	
			     if (textEmailElement.innerHTML.includes('Enter the 6-digit code we just sent to your email address')) {
			         // Clear the message first if it exists
			         textEmailElement.innerHTML = '';
			     }
	
			     // Append the new message
			     textEmailElement.innerHTML += 'Enter the 6-digit code we just sent to your email address "' + email + '".';
			     
 			 } else {
			         document.getElementById("textemail").innerHTML = 'Email address not found.';
			     }
				 
		 // Clear any existing timer if it's running
 	 		 if (isTimerRunning) {
 	 		     clearInterval(countdown);
 	 		 } else {
 	 		     $('#subTimer').text(''); // Clear the timer display
 	 		 }
 			$("#timerFieldForSub").show(); //Show timer field when close popup and come again by click second scenario 
 	 	 	startTimerForSub(90);  // Start the new timer with 90 seconds
 				
 	     $(".boddyone #bookIdSub").val( myBookId );
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
	function startTimerForSub(duration) {
	    var timerDisplay = $('#subTimer');
	    var timer = duration, minutes, seconds;

		isTimerRunning = true; // Set the flag to true
		
	     countdown = setInterval(function () {
	        minutes = parseInt(timer / 60, 10);
	        seconds = parseInt(timer % 60, 10);

	        minutes = minutes < 10 ? "0" + minutes : minutes;
	        seconds = seconds < 10 ? "0" + seconds : seconds;

	        timerDisplay.text(minutes + ":" + seconds);

	        if (--timer < 0) {
	            clearInterval(countdown);
	             $('#subTimer').text(''); // Clear the timer display
				 $("#alertValidateForSub").hide(); //Hide error message
 				 $("#timerFieldForSub").hide(); //Hide timer field 
 				 $("#validateSub").hide(); //Hide Validate button field 
				 $("#resendBtnSub").show(); // show resend OTP button
				 $('#addBookDialogForSub').find('#otpsub').val('');// Reset the input field
				 $('#messageAfterTimeoutForSub').text('Your OTP has expired. Please request a new one').show(); // Show a different message after time is up
				 isTimerRunning = false; // Reset the timer flag
	        }
	    }, 1000);
	}
	// resend button functionality
	$(document).ready(function() {	
		$('#resendBtnSub').on('click', function(event) {
			var email = $(this).data('email');
			$("#resendBtnSub").hide(); //Hide resend OTP button field 
			$('#messageAfterTimeoutForSub').hide(); // Hide expire time up message
			$("#timerFieldForSub").show(); //show timer field 
			$("#validateSub").show(); //show Validate button field 
			$('#addBookDialogForSub').find('#otpsub').val('');// Reset the input field
			startTimerForSub(90);  // Start the new timer with 90 seconds again
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
		$('#close-sub-popup').on('click', function(event) {
 		//event.preventDefault(); // Prevent the default link behavior
		addBookDialogForSub.hide();// Hide the modal manually

		// Reset the input field
		$('#addBookDialogForSub').find('#otpsub').val('');

		// Clear error messages
		$("#alertValidateForSub").hide(); //Hide error message
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
