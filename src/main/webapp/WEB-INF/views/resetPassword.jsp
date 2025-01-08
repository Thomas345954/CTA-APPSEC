<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External style tags-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>Reset Password</title>
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
							
							.form-group {
							    position: relative; /* Ensure the container is relative for absolute positioning */
							}
							.input-group-meta .placeholder_icon {
							    position: absolute;
							   	top:24px;
							    right: 10px; /* Adjust as needed for padding */
							    cursor: pointer;
							    z-index: 10;
							}
							.input-group-meta .placeholder_icon img {
							   display: inline !important;
							    width: 20px; /* Adjust icon size as needed */
							    height: 20px;
							}
							.eyecon{
							
								display:inline-flex !important;
							}

							#checkbox-error1{
								color: #B31942;
								font-size: 20px;
								display: none; 
							}
							#resetcheckbox-error{
								display:none !important;
							}
							.text-color{
								color:#19352D !important;
							}
							.agreement-checkbox {
							  display: flex;
							  align-items: flex-start; /* Aligns items at the top */
							}

							.agreement-checkbox input[type="checkbox"] {
							  margin-top: 0; /* Ensures no extra margin is added above the checkbox */
							  margin-right: 10px; /* Space between checkbox and text */
							}

							.agreement-checkbox label {
							  margin: 0; /* Removes default margin around the label */
							  font-size: 14px; /* Adjust font size as needed */
							}

			      </style>
			      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
				  <link rel="stylesheet" href="/css/jquery-ui.css">
    </head>

    <body>
        <!-- Include Header -->
        <%@ include file="/WEB-INF/views/header-login.jsp" %>
            <div class="main-page-wrapper">
                <!-- ===================================================
            Loading Transition
            ==================================================== -->
			<!-- Include loader -->
			 <%@ include file="/WEB-INF/views/loader.jsp" %>
			 <div class="mid-content ud-main">
			         <div class="container input-group-meta position-relative mt-30 mb-25">
			             <h3 class="center-text mb-30">Reset Password</h3>
			             <form id="resetpassword" action="/resetPassword" method="post" class="center-form reset-aft-otp"  onsubmit="return resetForm()">
			 				<div class="col-12">
			 					<div class="input-group-meta position-relative mb-20 form-group">
			 						<label for="password">New Password <em style="color: #ff0000;">*</em></label>
			 						<input id="npassword" type="password" class="form-control pl-4 text-color" name="password">                          
			 						<span class="placeholder_icon"><span class="passVicon"><div><img class="eyecon" src="/images/icon/icon_13.svg" alt="" style="height: 50px;position: relative;display: inline-block;"><span class="eyecloseicon" style="position: absolute;top: 4px;left: 24%;font-size: 28px;pointer-events: none;transform: rotate(30deg);font-weight: 500;">/</span></div>
			 				</div>
			 				<div class="col-12">
			 				    <div class="input-group-meta position-relative mb-20 form-group">
			 				        <label for="password">Confirm New Password<em style="color: #ff0000;">*</em></label>
			 				        <input type="password" class="form-control pl-4 text-color" id="cpassword" name="cpassword">
			 						<span class="placeholder_icon"><span class="passVicon"><div><img class="eyecon" src="/images/icon/icon_13.svg" alt="" style="height: 50px;position: relative;display: inline-block;"><span class="eyecloseicon" style="position: absolute;top: 4px;left: 24%;font-size: 28px;pointer-events: none;transform: rotate(30deg);font-weight: 500;">/</span></div>
			 				</div>
							<div class="col-12">
							  <div class="agreement-checkbox d-flex align-items-center">
							    <input type="checkbox" id="resetcheckbox" name="resetcheckbox" required>
							    <label for="resetcheckbox" class="mb-0 ms-2" style="font-size:16px;">By hitting the "Reset Password" button, you agree to the <a href="/terms" target="_blank"><u>Terms & Conditions</u></a> and <a href="/privacy" target="_blank"><u>Privacy Policy</u></a></label>
							  </div>
							  <span id="checkbox-error1"></span>
							</div>
			 				<!--<p>${message}</p>-->
			                 <button class="btn-four tran3s center-button" type="submit">Reset Password</button>
			             </form>
			         </div>
			     </div>
				 <div class="foreignvehicle-modal modal fade" id="foreigninvevehicleModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
				     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
				         <div class="container">
				             <div class="user-data-form step-form-modal modal-content">
				                 <!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
				                 <div class="modal-cont">
									<c:choose>
									   <c:when test="${message == 'New Password cannot be the same as Old Password'}">
									      <h2>Attention</h2>
									   </c:when>
									   <c:when test="${fn:startsWith(message, 'Your password has been changed')}">
									      <h2> Success! </h2>
									   </c:when>
									   <c:otherwise>
									      <h2>Attention</h2>
									   </c:otherwise>
									</c:choose>
				                     <p>${fn:escapeXml(message)}</p>
				                     <div class="modal-btns step-mod-btns">
				                         <c:choose>
				                             <c:when test="${fn:startsWith(message, 'Your password has been changed')}">
				                                 <a class="nav-link" href="/home">
				                                     <button class="blue-btn" id="foreignvehicleok">Okay</button>
				                                 </a>
				                             </c:when>
				                             <c:otherwise>
				                                 <button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok">Okay</button>
				                             </c:otherwise>
				                         </c:choose>
				                     </div>
				                 </div>
				             </div>  
				         </div>
				     </div>
				 </div>
                <!-- Include Footer -->
                <%@ include file="/WEB-INF/views/footer.jsp" %>
				<%@ include file="/WEB-INF/views/log-reg.jsp" %>
                    <button class="scroll-top">
                        <i class="bi bi-arrow-up-short"></i>
                    </button>
                    <!--external Java script-->
                    <%@ include file="/WEB-INF/views/js.jsp" %>
					<script>
							$(document).ready(function() {
					            $("#resetpassword").validate({
					                rules: {
					                    password: {
					                        required: true,
					  						pattern: /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%&*])[a-zA-Z0-9!@#$%&*]+$/,
											minlength: 8,
											maxlength: 15
					                    },
					                    cpassword: {
					                        required: true,
											equalTo: "#npassword",
											minlength: 8,
											maxlength: 15  
					                    }
					                },
					                messages: {
					                    password: {
					                        required: "Please enter your Password",
					                        pattern: "The password must contain at least one number, one upper case, and one special character",
											minlength: "Your password must consist of at least 8 characters",
											maxlength: "Your password must be below 15 characters"
					                    },
					                    cpassword: {
					                        required: "Please confirm your Password",
											minlength: "Your password must consist of at least 8 characters",
											maxlength: "Your password must be below 15 characters",
					                        equalTo: "Passwords do not match"
					                    }
					                }
					            });
									// Toggle password visibility
								            $('.placeholder_icon').click(function() {
								                const passwordInput = $(this).siblings('input');
												const eyeSlashIcon = $(this).find('.eyecloseicon');
												
								                if (passwordInput.attr('type') === 'password') {
								                    passwordInput.attr('type', 'text');
													 eyeSlashIcon.hide(); 
								                } else {
								                    passwordInput.attr('type', 'password');
													 eyeSlashIcon.show();
								                }
								            });
								      
										 var message = "${message}";  
										 if(message.length>0){
									     $('.foreignvehicle-modal').modal('show');
										 }
									   });
									   
									   function resetForm() {
									   		const checkbox = document.getElementById('resetcheckbox');
									   		const errorSpan = document.getElementById('checkbox-error1');
									   										    
									   		if (!checkbox.checked) {
									   			errorSpan.textContent = 'You must agree to the Terms & Conditions and Privacy Policy';
									   			errorSpan.style.display = 'inline'; // Show the error message
									   			return false; // Prevent form submission
									   		} else {
									   			errorSpan.style.display = 'none'; // Hide the error message if no error
									   			return true; // Allow form submission
									   		}
									   	}
								</script>
            </div>
            <!-- /.main-page-wrapper -->
    </body>
    </html>