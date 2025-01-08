<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns:th="http://www.thymeleaf.org">
   <head>
	  <%@ include file="/WEB-INF/views/css.jsp" %>
	  <title>ExemptChecker</title>
	  <style>
		.floating2-btn2 {
		  	    position: fixed;
				writing-mode: vertical-rl;
		  	    right: 20px;
		  	    top: 32%;
		  	    background-color: #b31942;
		  	    color: white;
		  	    border: none;
		  	    border-radius: 30px;
		  	    width: 30px;
		  	    height: 150px;
		  	    display: flex;
		  	    justify-content: center;
		  	    align-items: center;
		  	    font-size: 12px;
		  	    text-align: center;
		  	    text-decoration: none;
		  	    box-shadow: 19px -20px 8px rgba(0, 0, 0, 0.2);
		  	    transition: background-color 0.3s ;
		  	    z-index: 2;
				}
				.accordion-style-one .accordion-item .accordion-button:after {
					margin-right: 8px;
					}

	  	</style>
	
		</head>
		<body>
	  	<a href="#" data-bs-toggle="modal" data-bs-target="#exemptcheckerModal" class="floating2-btn2" id="exemptcheckerpopup">Exempt Entity Checker</a>
	  	<!--<a href="#" class="floating-btn">Exempt Entity Checker</a>-->
	  		 		
	  <!-- Exempt Checker Pop up-->
	  <div class="foreignvehicle-modal modal-lg-sec modal fade" id="exemptcheckerModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
	  				<div class="modal-dialog modal-fullscreen modal-dialog-centered">
	  					<div class="container">
	  						<div class="user-data-form step-form-modal modal-content">
	  							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  							<div class="modal-cont">
	  								<div class="boddy">
	  			                        <h3 class="modal-head">Does Your Business Need to File a BOI Report?</h3>
	  			                        
	  			                        <p style="text-align: left;">Before you proceed, answer a few quick questions to check if your business is exempt from filing a FinCEN BOI report. While most companies need to file, there are some exceptions. Hover over the tooltips for more details on each
	  			                            exemption.</p>
	  			                        <br>
	  			                        
	  			                        <div style="text-align: left;">
	  			                            <form action="#" id="" method="get" novalidate="novalidate">
	  			                                <div class="sf-form-sec">
	  			                                     <div class="sf-form-body">
	  			                                        <div class="form-rows">
	  			                                            <div style="display: flex;">
	  			                                                <label class="main-label col-10" for="filingType1">1.Does your business have 20 or more full-time employees?<em>*</em></label>
	  			                                                <aside class="col-sm-2 col-2 bb-right" style="">
	  																<a title="Your entity must employ more than 20 full-time employees in the United States, as defined in 26 CFR § 54.4980H-1(a) and § 54.4980H-3.">
																		<img src="images/help.png" alt="help"> </a>
	  			                                                </aside>
	  			                                            </div>
	  			                                            <div class="form-fields">
	  			                                                <div class="row">
	  			                                                    <div class="col-md-3 col-sm-6">
	  			                                                        <label class="radio-box" title="Item 1a - Type of filing - Initial report: Check box 1a “Initial report” if this is the first BOIR filed for the reporting company">
	  			                                                            <input type="radio" id="Initial" checked name="filingType1" value="initial" autocomplete="new-password"> Yes
	  			                                                        </label>
	  			                                                    </div>
	  			                                                    <div class="col-md-3 col-sm-6">
	  			                                                        <label class="radio-box" title="Item 1b - Type of filing - Correct prior report: Check box 1b “Correct prior report” if the report corrects inaccurate information from a previously filed BOIR.">
	  			                                                            <input type="radio" id="Correct" name="filingType1" value="correct" autocomplete="new-password"> No
	  			                                                        </label>
	  			                                                    </div>
	  			                                                </div>
	  			                                            </div>
	  			                                        </div>
	  			                                    </div>
	  			                                </div>
	  			                            </form>
	  			                        </div>
	  			 
	  			                        <br>
	  			                        <div style="text-align: left;">
	  			                            <form action="#" id="" method="get" novalidate="novalidate">
	  			                                <div class="sf-form-sec">
	  			                                    <div class="sf-form-body">
	  			                                        <div class="form-rows">
	  			                                            <div style="display: flex;">
	  			                                                <label class="main-label" for="filingType2">2. Did your business report over $5 million in revenue, gross receipts, or sales from within the United States on last year’s tax return?<em>*</em></label>
	  			                                              <aside class="col-sm-2 col-2 bb-right" >
	  			                                                    <a title="Your entity must have filed a U.S. Federal income tax or information return showing over $5 million in gross receipts or sales from U.S. sources, as reported on IRS Forms 1120, 1120-S, 1065, or similar, after returns and allowances.">
																		<img src="images/help.png" alt="help"></a>
	  			                                                </aside>
	  			                                            </div>
	  			                                            <div class="form-fields">
	  			                                                <div class="row">
	  			                                                    <div class="col-md-3 col-sm-6">
	  			                                                        <label class="radio-box" title="Item 1a - Type of filing - Initial report: Check box 1a “Initial report” if this is the first BOIR filed for the reporting company">
	  			                                                            <input type="radio" id="Initial" checked name="filingType2" value="initial" autocomplete="new-password"> Yes
	  			                                                        </label>
	  			                                                    </div>
	  			                                                    <div class="col-md-3 col-sm-6">
	  			                                                        <label class="radio-box" title="Item 1b - Type of filing - Correct prior report: Check box 1b “Correct prior report” if the report corrects inaccurate information from a previously filed BOIR.">
	  			                                                            <input type="radio" id="Correct" name="filingType2" value="correct" autocomplete="new-password"> No
	  			                                                        </label>
	  			                                                    </div>
	  			                                                </div>
	  			                                            </div>
	  			                                        </div>
	  			                                    </div>
	  			                                </div>
	  			                            </form>
	  			                        </div>
	  									<br>
										<div style="text-align: left;">
										    <form action="#" method="get" novalidate="novalidate">
										        <div class="sf-form-sec">
										            <div class="sf-form-body">
										                <div class="form-rows">
										                    <div style="display: flex; align-items: center;">
										                        <label class="main-label" for="filingType3">3. Is your business physically operating from a U.S. office?</label>
										                       <aside class="col-sm-4 col-4 bb-right" style="margin-left: auto;">
										                            <a title="Your entity must have an operating physical office within the United States."><img src="images/help.png" alt="Help Icon"> </a>
										                        </aside>
										                    </div>
										                    <div class="form-fields">
										                        <div class="row">
										                            <div class="col-md-3 col-sm-6">
										                                <label class="radio-box" title="Item 1a - Type of filing - Initial report: Check box 1a 'Initial report' if this is the first BOIR filed for the reporting company">
										                                    <input type="radio" id="Initial" checked name="filingType3" value="initial" autocomplete="new-password"> Yes
										                                </label>
										                            </div>
										                            <div class="col-md-3 col-sm-6">
										                                <label class="radio-box" title="Item 1b - Type of filing - Correct prior report: Check box 1b 'Correct prior report' if the report corrects inaccurate information from a previously filed BOIR.">
										                                    <input type="radio" id="Correct" name="filingType3" value="correct" autocomplete="new-password"> No
										                                </label>
										                            </div>
										                        </div>
										                    </div>
										                </div>
										            </div>
										        </div>
										    </form>
										</div>

										<br>

										<div style="text-align: left;">
										    <form action="#" method="get" novalidate="novalidate">
										        <div class="sf-form-sec">
										            <div class="sf-form-body">
										                <div class="form-rows">
										                    <div style="display: flex; align-items: center;">
										                        <label class="main-label" for="filingType4">4. Can your business be classified under any of the following categories?<em>*</em></label>
										                        <aside class="col-sm-4 col-4 bb-right" style="margin-left: auto;">
										                            <a target="_blank" href="https://micassets.micnxt.com/CTA/Exempt_Entity_Questions_and_answers.pdf" title="Click here to know more."><img src="images/help.png" alt="Help Icon"> </a>
										                        </aside>
										                    </div>
										                    <div class="form-fields">
										                        <div class="row">
										                            <div class="col-md-3 col-sm-6">
										                                <label class="radio-box" title="Item 1a - Type of filing - Initial report: Check box 1a 'Initial report' if this is the first BOIR filed for the reporting company">
										                                    <input type="radio" id="Initial" checked name="filingType4" value="initial" autocomplete="new-password"> Yes
										                                </label>
										                            </div>
										                            <div class="col-md-3 col-sm-6">
										                                <label class="radio-box" title="Item 1b - Type of filing - Correct prior report: Check box 1b 'Correct prior report' if the report corrects inaccurate information from a previously filed BOIR.">
										                                    <input type="radio" id="Correct" name="filingType4" value="correct" autocomplete="new-password"> No
										                                </label>
										                            </div>
										                        </div>
										                    </div>
										                </div>
										            </div>
										        </div>
										    </form>
										</div>

	  			                                        </div>
												<div class="tab-content mt-60 lg-mt-40">
										            <div class="tab-pane fade show active" id="nav-general-questions" role="tabpanel" tabindex="0">
	  			                                        <div class="accordion accordion-style-one" id="accordionOne" style="text-align: left;">
	  			                                            <div class="accordion-item">
	  			                                                  <h2 class="accordion-header"><button class="accordion-button collapsed " type="button" data-bs-toggle="collapse" data-bs-target="#collapseZ" aria-expanded="false" aria-controls="collapseZ" style="padding-left: 10px;background: #81BAE733;">Financial Institutions </button></h2>
	  			                                                <div id="collapseZ" class="accordion-collapse collapse" data-bs-parent="#accordionOne" style="">
	  			                                                    <div class="accordion-body">
																		<ul>
		  			                                                        <li style="color: #003B6A;">Bank – Registered banking institution.</li>
		  			                                                        <li style="color: #003B6A;">Credit Union – Registered credit union.</li>
		  			                                                        <li style="color: #003B6A;">Depository Institution Holding Company – Entity holding ownership in depository institutions.</li>
		  			                                                        <li style="color: #003B6A;">Money Services Business – Business providing money transfer or exchange services.</li>
	  			                                                    	</ul>
																	</div>
	  			                                                </div>
	  			                                            </div>
	  			                                            <div class="accordion-item">
	  			                                                <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseY" aria-expanded="false" aria-controls="collapseY" style="padding-left: 10px;background: #81BAE733;">Securities &amp; Investment Entities </button></h2>
	  			                                                <div id="collapseY" class="accordion-collapse collapse" data-bs-parent="#accordionOne" style="">
	  			                                                    <div class="accordion-body">
																		<ul>
		  			                                                        <li style="color: #003B6A;">Broker or Dealer in Securities – SEC-registered broker or dealer for securities transactions.</li>
		  			                                                        <li style="color: #003B6A;">Securities Exchange or Clearing Agency – Registered entity for securities exchange or clearing operations.</li>
		  			                                                        <li style="color: #003B6A;">Investment Company or Adviser – SEC-registered investment company or adviser.</li>
		  			                                                        <li style="color: #003B6A;">Venture Capital Fund Adviser – SEC-registered adviser for venture capital funds.</li>
		  			                                                        <li style="color: #003B6A;">Pooled Investment Vehicle – Investment entity managed by an SEC-registered person.</li>
		  			                                                        <li style="color: #003B6A;">Commodity Exchange Act Registered Entity – Registered under the Commodity Exchange Act.</li>
		  			                                                        <li style="color: #003B6A;">Other Exchange Act Registered Entity – Entity registered under the Securities Exchange Act.</li>
	  			                                                    	</ul>
																	</div>
	  			                                                </div>
	  			                                            </div>
	  			                                            <div class="accordion-item">
	  			                                                <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseX" aria-expanded="false" aria-controls="collapseX" style="padding-left: 10px;background: #81BAE733;">Insurance &amp; Professional Services </button></h2>
	  			                                                <div id="collapseX" class="accordion-collapse collapse" data-bs-parent="#accordionOne" style="">
	  			                                                    <div class="accordion-body">
																		<ul>
		  			                                                        <li style="color: #003B6A;">Insurance Company – Registered insurance provider.</li>
		  			                                                        <li style="color: #003B6A;">State-Licensed Insurance Producer – Insurance producer licensed by a state authority.</li>
		  			                                                        <li style="color: #003B6A;">Accounting Firm – Registered firm providing attestation or accounting services.</li>
	  			                                                    	</ul>
																	</div>
	  			                                                </div>
	  			                                            </div>
	  			                                            <div class="accordion-item">
	  			                                                <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseW" aria-expanded="false" aria-controls="collapseW" style="padding-left: 10px;background: #81BAE733;">Public &amp; Governmental Entities </button></h2>
	  			                                                <div id="collapseW" class="accordion-collapse collapse" data-bs-parent="#accordionOne" style="">
	  			                                                    <div class="accordion-body">
																		<ul>
		  			                                                        <li style="color: #003B6A;"> Securities Reporting Issuer – Required to file reports under section 15(d) of the Securities Exchange Act.</li>
		  			                                                        <li style="color: #003B6A;"> Governmental Authority – Company authorized to act on behalf of a State or Tribe.</li>
		  			                                                        <li style="color: #003B6A;"> Public Utility Company – Registered provider of essential public services.</li>
		  			                                                        <li style="color: #003B6A;"> Financial Market Utility Company – Designated by the Financial Stability Oversight Council.</li>
	  			 														</ul>
	  			                                                    </div>
	  			                                                </div>
	  			                                            </div>
	  			                                            <div class="accordion-item">
	  			                                                <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseV" aria-expanded="false" aria-controls="collapseV" style="padding-left: 10px;background: #81BAE733;">Tax-Exempt &amp; Related Entities </button></h2>
	  			                                                <div id="collapseV" class="accordion-collapse collapse" data-bs-parent="#accordionOne" style="">
	  			                                                    <div class="accordion-body">
																		<ul>
		  			                                                        <li style="color: #003B6A;">Tax-Exempt Entity – Recognized as tax-exempt under federal law.</li>
		  			                                                        <li style="color: #003B6A;">Entity Assisting a Tax-Exempt Entity – Exists solely to assist tax-exempt entities.</li>
		  			                                                        <li style="color: #003B6A;">Subsidiary of Certain Exempt Entities – Fully owned by a tax-exempt organization.</li>
	  			                                                    	</ul>
																	</div>
	  			                                                </div>
	  			                                            </div>
															<div class="accordion-item">
	  			                                                <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUNQ" aria-expanded="false" aria-controls="collapseUNQ" style="padding-left: 10px;background: #81BAE733;">Inactive Entities </button></h2>
	  			                                                <div id="collapseUNQ" class="accordion-collapse collapse" data-bs-parent="#accordionOne" style="">
	  			                                                    <div class="accordion-body">
																		<ul>
	  			                                                        	<li style="color: #003B6A;">Inactive Entity – Formed before 2020, with no assets or activity in the past year.</li>
	  			                                                    	</ul>
																	</div>
	  			                                                </div>
	  			                                            </div>
															
															
	  			                                        </div>
	  			                                  </div>
												</div>
											    </div>
													<div class="modal-btns step-mod-btns" style="margin-top:-20px">
																	  			                       <button class="blue-btn" data-bs-dismiss="modal" id="checkEligibilityBtn" >Check Eligibility</button>
																	  			                    </div>
												</div>
												
	  			                            </form>
	  			                        </div>
	  			                    </div>
	  							</div>
	  						</div>	
	  					</div>
	  				</div>
	  			</div>
				
				<!-- Success Now Popup Modal -->
				<div class="modal modal-lg-sec fade" id="sucesssModal" tabindex="-1" aria-modal="true" role="dialog" data-bs-backdrop="static">
				  <div class="modal-dialog modal-fullscreen modal-dialog-centered">
				    <div class="container">
				      <div class="user-data-form step-form-modal modal-content">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				        <div class="modal-cont">
				          <div class="boddy">
				            <h3 class="modal-head">You <strong>May Not Need</strong> to File a BOI Report!</h3>
							<p style="text-align: left;">
							Your business appears to be exempt from filing based on the information you provided.</p><p style="text-align: left;">
							    
							However, you may need to reassess your exemption status under the following circumstances:</p><ul style="font-size: 16px;color: #003B6A;color: #003B6A; text-align: left;">
							    
							  
							  <li style="color: #003B6A;">
							    
							If your business status changes before January 1, 2025, you will be required to file within 90 days</li>
							  <li>If your business status changes on or after January 1, 2025, you will be required to file within 30 days.</li>
							 
							</ul><p style="  text-align: left;">
							   
							If you think any answers were incorrect, click below to review and update your responses</p>
							<a href="#" data-bs-toggle="modal" data-bs-target="#exemptcheckerModal" id="exemptcheckerpopup" class="btn-four  mb-20">
							Update my Responses</a>		
							<p style=" color: #989898; text-align: left;">
							   
							   
						This BOI Business Qualification Quiz is an automated tool based on the limited information you’ve provided. It is not a substitute for professional or legal advice and should not be considered as such. For a thorough assessment of your filing requirements, it’s recommended that you consult with a legal professional.<br>

							</p><p style="text-align: left; color: #989898;">
							    
						If you’re unsure about your exemption status, you can find more information in FinCEN’s <b style="color: #2989d6;"><a href="https://micassets.micnxt.com/CTA/BOI-FAQs-QA-508C.pdf" style="color: #2989d6;" target="_blank">BOI Reporting Guidelines.</a></b></p></div>
											  								
											  							</div>
											  						</div>	
											  					</div>
											  				</div>
											  			</div>
				<!-- Failure Popup Modal -->
				<div class="modal modal-lg-sec fade" id="failureModal" tabindex="-1" aria-modal="true" role="dialog" data-bs-backdrop="static">
				  <div class="modal-dialog modal-fullscreen modal-dialog-centered">
				    <div class="container">
				      <div class="user-data-form step-form-modal modal-content">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				        <div class="modal-cont">
				          <div class="boddyone">
							<h3 class="modal-head">You <b style="font-weight: bolder;">
							 
							May Need</b> to File a BOI Report!</h3>
							<p style=" text-align: left;">
							    
							Based on your responses, your business is likely required to file a Beneficial Ownership Information (BOI) Report. Our streamlined process will guide you through each step smoothly, ensuring you get the help you need along the way. You’ll be done in no time!</p><a href="/boirfiling" class="btn-four mb-20">


							File Now</a><br>
											  								
											  								<p style="color: #989898; text-align: left;">
							 
							This BOI Business Qualification Quiz is an automated tool based on the limited information you’ve provided. It is not a substitute for professional or legal advice and should not be considered as such. For a thorough assessment of your filing requirements, it’s recommended that you consult with a legal professional.<br>

							</p><p style="text-align: left;color: #989898;">
							   
							If you’re unsure about your exemption status, you can find more information in FinCEN’s <b style="color: #2989d6;"><a href="https://micassets.micnxt.com/CTA/BOI-FAQs-QA-508C.pdf" style="color: #2989d6;" target="_blank">BOI Reporting Guidelines.</a></b></p>
				          </div>
				        </div>
				      </div>
				    </div>
				  </div>
				</div>
	  <script>
	    // exempt checker popup
	     $(document).ready(function() {
	    	$('#exemptcheckerpopup').on('click', function(event) {
	    	//event.preventDefault(); // Prevent the default link behavior
	    	$('#exemptcheckerModal').modal('show'); // Show the modal manually
	    	});
	    });
		
		document.addEventListener("DOMContentLoaded", function() {
		    // Function to check answers and show the modal
		    function checkAnswers() {
		      // Get all the radio button answers
		      const filingType1 = document.querySelector('input[name="filingType1"]:checked');
		      const filingType2 = document.querySelector('input[name="filingType2"]:checked');
		      const filingType3 = document.querySelector('input[name="filingType3"]:checked');
		      const filingType4 = document.querySelector('input[name="filingType4"]:checked');
		      
		      // Initialize the modal
		      const startNowModal = new bootstrap.Modal(document.getElementById('sucesssModal'));
			  const failureModal = new bootstrap.Modal(document.getElementById('failureModal'));

		      // Check if all answers are 'Yes'
		      if (filingType1 && filingType2 && filingType3 && filingType4 &&
		          filingType1.value === 'initial' && filingType2.value === 'initial' &&
		           filingType4.value === 'initial') {

		        // If all conditions are met, show the 'Start Now' modal with success content
		        //document.querySelector('.boddy h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
		        //document.querySelector('.boddy p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
		        startNowModal.show();
		      } 
			  // Check if all answers are 'Yes'
  		   	 else if (filingType1 && filingType2 && filingType3 && filingType4 &&
  		          filingType1.value === 'initial' && filingType2.value === 'initial' &&
  		            filingType4.value === 'correct') {

  		        // If all conditions are met, show the 'Start Now' modal with success content
  		        //document.querySelector('.boddy h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
  		        //document.querySelector('.boddy p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
  		        startNowModal.show();
  		      } 
			  else if (filingType1 && filingType2 && filingType3 && filingType4 &&
	  		          filingType1.value === 'initial' && filingType2.value === 'correct' &&
	  		            filingType4.value === 'initial') {

	  		        // If all conditions are met, show the 'Start Now' modal with success content
	  		        //document.querySelector('.boddy h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
	  		        //document.querySelector('.boddy p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
	  		        startNowModal.show();
	  		      }
			  	else if (filingType1 && filingType2 && filingType3 && filingType4 &&
	  		          filingType1.value === 'initial' && filingType2.value === 'initial' &&
	  		            filingType4.value === 'correct') {

	  		        // If all conditions are met, show the 'Start Now' modal with success content
	  		        //document.querySelector('.boddy h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
	  		        //document.querySelector('.boddy p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
	  		        startNowModal.show();
	  		      } 
				  else if (filingType1 && filingType2 && filingType3 && filingType4 &&
    		          filingType1.value === 'initial' && filingType2.value === 'correct' &&
    		            filingType4.value === 'correct') {

    		        // If all conditions are met, show the 'Start Now' modal with success content
    		        //document.querySelector('.boddyone h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
    		        //document.querySelector('.boddyone p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
    		        failureModal.show();
    		      } 
				  else if (filingType1 && filingType2 && filingType3 && filingType4 &&
    		          filingType1.value === 'correct' && filingType2.value === 'initial' &&
    		            filingType4.value === 'initial') {

    		        // If all conditions are met, show the 'Start Now' modal with success content
    		        //document.querySelector('.boddy h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
    		        //document.querySelector('.boddy p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
    		        startNowModal.show();
    		      } 
				  else if (filingType1 && filingType2 && filingType3 && filingType4 &&
	    		          filingType1.value === 'correct' && filingType2.value === 'initial' &&
	    		            filingType4.value === 'correct') {

	    		        // If all conditions are met, show the 'Start Now' modal with success content
	    		        //document.querySelector('.boddyone h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
	    		        //document.querySelector('.boddyone p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
	    		        failureModal.show();
    		      } 
				  else if (filingType1 && filingType2 && filingType3 && filingType4 &&
	    		          filingType1.value === 'correct' && filingType2.value === 'correct' &&
	    		            filingType4.value === 'initial') {

	    		        // If all conditions are met, show the 'Start Now' modal with success content
	    		       // document.querySelector('.boddy h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
	    		       // document.querySelector('.boddy p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
	    		        startNowModal.show();
				 } 
				 else if (filingType1 && filingType2 && filingType3 && filingType4 &&
	    		          filingType1.value === 'correct' && filingType2.value === 'correct' &&
	    		            filingType4.value === 'correct') {

	    		        // If all conditions are met, show the 'Start Now' modal with success content
	    		        //document.querySelector('.boddyone h2').innerHTML = 'You <b>May Need</b> to File a BOI Report!';
	    		        //document.querySelector('.boddyone p').innerText = 'Your business appears to be exempt from filing based on the information you provided.';
	    		        failureModal.show();
				 }       
		    }

	// Add event listener for the button
	    document.getElementById('checkEligibilityBtn').addEventListener('click', function(event) {
	      event.preventDefault();
	      checkAnswers();
		});

		});
	  </script>
	 <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>-->
   </body>
</html>