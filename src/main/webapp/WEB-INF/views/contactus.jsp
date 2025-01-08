<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%@ include file="/WEB-INF/views/css.jsp" %>
      <title>CTAHarbor | Contact Us</title>
	  <script src="https://www.google.com/recaptcha/api.js"></script>
	  <style>
		.map-overlay {
		            position: absolute;
		            top: 59%;
		            left: 10px;
		            background-color: rgba(255, 255, 255, 0.9);
		            padding: 10px;
		            border-radius: 4px;
		            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
		        }
		    
		        .overlay-image {
		            width: 240px; /* Adjust the size */
		            height: 180px;
		            border-radius: 4px;
		        }
		        .gmap_iframe{
		            width: 100%;
		            height: 100vh;
		        }

		</style>
   </head>
   <body>
      <!-- Include Header -->
      <%@ include file="/WEB-INF/views/header-login.jsp" %>
      <div class="main-page-wrapper">
         
         <%@ include file="/WEB-INF/views/loader.jsp" %>
         		
			<br>

			<!-- Display Session Message -->
			<c:if test="${not empty sessionScope.contactusMessage}">
				<!-- Pass the message to JavaScript -->
				<script type="text/javascript">
					var message = "${sessionScope.contactusMessage}";
 				</script>
				<!-- Clear the register message from session after displaying -->
				<c:remove var="contactusMessage" scope="session"/>
			</c:if>
			
			<div class="foreignvehicle-modal modal fade" id="foreigninvevehicleModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
					<div class="modal-dialog modal-fullscreen modal-dialog-centered">
							<div class="container">
								<div class="user-data-form step-form-modal modal-content">
								<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
									<div class="modal-cont">
										<h3 class="modal-head">Great - Your Request is Submitted!</h3>
							            <p id="contactus-popup-message"></p>
							            <div class="modal-btns step-mod-btns"><button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok">Okay</button></div>
									</div>
								</div>	
							</div>
					</div>
			</div>
			
        
         <div class="contact-us-section pt-180 sm-pt-120 pb-60">
            <div class="container">
               <div class="position-relative">
                  <div class="row">
                     <div class="col-12 m-auto">
                        <div class="row">
                           <div class="col-md-4">
                              <div class="address-block-one text-center mb-40 wow fadeInUp">
                                 <div class="icon rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="images/lazy.svg" data-src="images/icon/icon_90.svg" alt="" class="lazy-img"></div>
                                 <h5 class="title">Our Address</h5>
                                 <a href="https://maps.google.com/maps?ll=40.752549,-73.979199&z=12&t=m&hl=en&gl=US&mapclient=embed&q=315%20Madison%20Ave%20%234005%20New%20York%2C%20NY%2010165%20USA" target="_blank"><p>315 Madison Avenue Suite 4005
                                    <br>New York, NY 10017
                                 </p></a>
                              </div>
                           </div>
                           <div class="col-md-4">
                              <div class="address-block-one text-center mb-40 wow fadeInUp">
                                 <div class="icon rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="images/lazy.svg" data-src="images/icon/icon_91.svg" alt="" class="lazy-img"></div>
                                 <h5 class="title">Contact Info</h5>
                                 <p>Give us a call at
                          
									<br>Toll-Free: <a href="tel:310.841.5500" class="call text-lg fw-500">+1 (888) 203-2246</a>
                                 </p>
                              </div>
                           </div>
                           <div class="col-md-4">
                              <div class="address-block-one text-center mb-40 wow fadeInUp">
                                 <div class="icon rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="images/lazy.svg" data-src="images/icon/Message.svg" alt="" class="lazy-img"></div>
                                 <h5 class="title">E-Mail Support</h5>
                                 <p>Reach us at
                                    <br><a href="mailto:support@ctaharbor.com" class="webaddress">support@ctaharbor.com</a>
                                 </p>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
				  <div id="help"></div>
                  <div class="bg-wrapper light-bg mt-80 lg-mt-40">
                     <div class="row">
                        <div class="col-lg-5">
                           <div class="d-flex flex-column flex-lg-column-reverse">
                              <div class="title-one text-center text-lg-start md-mt-20 mb-70 md-mb-30">
                                 <h2>Need Help? Let’s Talk!</h2>
                              </div>
                              <!-- /.title-one -->
                           </div>
                        </div>
                        <div class="col-lg-7">
                           <div class="form-style-one ps-xl-5">
                              <form id="contactusjq" action="${contactus.id == null ? '/savecontact' : '/savecontact' + contactus.id}" method="post">
                                 <input type="hidden" name="id" value="${contactus.id}" />
                                 <div class="messages"></div>
                                 <div class="row controls">
                                    <div class="col-12">
                                       <div class="input-group-meta form-group mb-30">
                                          <label for="conname">Name<em style="color: #ff0000;">*</em></label>
                                          <input type="text" placeholder="Your Name*" id="name" name="name" value="${contactus.name}" required="required" data-error="Name is required." style="color: black !important;">
                                          <div class="help-block with-errors"></div>
                                       </div>
                                    </div>
                                    <div class="col-12">
                                       <div class="input-group-meta form-group mb-40">
                                          <label for="conemail">Email<em style="color: #ff0000;">*</em></label>
                                          <input type="email" placeholder="Email Address*" id="email_id" name="email_id" value="${contactus.email_id}" required="required" data-error="Valid email is required." style="color: black !important;">
                                          <div class="help-block with-errors"></div>
                                       </div>
                                    </div>
                                    <div class="col-12">
                                       <div class="input-group-meta form-group mb-35">
										<label for="conemail">Message<em style="color: #ff0000;">*</em></label>
                                          <textarea placeholder="Your message*" name="comments" id="comments" value="${contactus.comments}" required="required" data-error="Please leave us a message." minlength="10" maxlength="500" style="color: black !important;"></textarea>
                                          <div class="help-block with-errors"></div>
                                       </div>
                                    </div>
									<div class="col-12">
										<div class="input-group-meta form-group mb-35" id="captcha">
											<div class="g-recaptcha" data-sitekey="${sitekey}"></div>
											<span id="recaptcha-error" style="color: #B31942; font-size: 16px; font-weight: 500;"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-12">
                                       <button class="btn-four tran3s w-100 d-block"  type="submit" value="submit">Send Message</button>
                                    </div>
                                 </div>
                              </form>
                           </div>
                           <!-- /.form-style-one -->
                        </div>
                     </div>
                  </div>
               </div>
            </div>
			<div class="map-banner mt-120 lg-mt-80">
			        <div class="gmap_canvas h-100 w-100">
			            <iframe class="gmap_iframe h-100 w-100" src="https://maps.google.com/maps?width=600&amp;height=400&amp;hl=en&amp;q=315 Madison Avenue Suite 4005
			                     New York, NY 10017&amp;t=&amp;z=12&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"
								 title="Google Map showing the location of 315 Madison Avenue Suite 4005"></iframe>
			            <div class="map-overlay">
			                <img src="images/CTA-building.jpg" alt="Building Image" class="overlay-image">
			            </div>
			        </div>
			</div>
         </div>
         <%@ include file="/WEB-INF/views/footer.jsp" %>
         <%@ include file="/WEB-INF/views/log-reg.jsp" %>
         <button class="scroll-top">
         <i class="bi bi-arrow-up-short"></i>
         </button>
         
		 <%@ include file="/WEB-INF/views/right-click.jsp" %>
		 <%@ include file="/WEB-INF/views/js.jsp" %>
         <script src="js/contactUsValidator.js"></script>
			<!-- Contactus popup message -->
						<script>
						  	 $(document).ready(function() {
						  	  // Trigger the modal if there's a message
						  	  if (typeof message !== 'undefined' && message.length > 0) {
						  		$('#contactus-popup-message').text(message);
						  	    $('.foreignvehicle-modal').modal('show');
						  	   }
						  	 });
						  </script>
						  
			<!--captcha code-->
				<script>
				  $(document).ready(function () {
				      $('#contactusjq').on('submit', function (e) {
				          var response = grecaptcha.getResponse();

				          if (response.length === 0) {
				              $('#recaptcha-error').text('Please confirm you are not a robot.');
				              e.preventDefault();
				          } else {
				              $('#recaptcha-error').text('');  // Clear the error message
				          }
				      });
				  });
				  </script>
      </div>
      <!-- /.main-page-wrapper -->
   </body>
</html>