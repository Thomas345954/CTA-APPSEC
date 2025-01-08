<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%@ include file="/WEB-INF/views/css.jsp" %>
	  <%@ include file="/WEB-INF/views/right-click.jsp" %>
      <title>CTAHarbor</title>
      <style>
         .step {
            display: none;
         }
         .step.active {
            display: block;
         }
         /* Loader styling */
         #loader {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
         }
		 .disabled {
		     color: gray; /* Change text color to gray */
		     pointer-events: none; /* Disable pointer events to make it non-clickable */
		     opacity: 0.6; /* Make it semi-transparent */
		 }
		 .disabled a {
		     text-decoration: none; /* Remove underline from links */
		     color: gray; /* Ensure link color is also gray */
		 }

      </style>
   </head>
   <body>
	
      <div class="main-page-wrapper">
         <!-- Include Header -->
         <%@ include file="/WEB-INF/views/header-login.jsp" %>
		
		 <!-- Display Session Message -->
		     <c:if test="${not empty sessionScope.editProfileMessage}">
		         <!-- Pass the message to JavaScript -->
		         <script type="text/javascript">
	             	var message = "${sessionScope.editProfileMessage}";
 		         </script>
		         <!-- Clear the edit profile message from session after displaying -->
		         <c:remove var="editProfileMessage" scope="session"/>
		     </c:if>
			 <!--<script src="scripts.js"></script>-->
			 
		 <!-- Modal HTML -->
		 <div class="foreignvehicle-modal modal fade" id="foreigninvevehicleModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
		 		<div class="modal-dialog modal-fullscreen modal-dialog-centered">
		 				<div class="container">
		 					<div class="user-data-form step-form-modal modal-content">
		 					<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
		 						<div class="modal-cont">
		 							<h2>Profile Updated!</h2>
		 				            <p id="modal-message"></p>
		 				            <div class="modal-btns step-mod-btns"><button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok">Okay</button></div>
		 						</div>
		 					</div>	
		 				</div>
		 		</div>
		 </div>
			 
         <!-- Loader -->
         <div id="loader" class="container text-center">
            <div class="spinner-border text-primary" role="status">
            </div>
         </div>

         <!-- Main Content -->
         <div class="mid-content ud-main">
            <div class="container">
               <div class="step-form-main">
                  <div class="sf-main">
                     <div class="row">
                        <aside class="col-lg-3 sf-main-left">
                           <ul>
                              <li class="active"><a href="/userdashboard" class="tab-link" data-tab="tab1">Dashboard</a></li>
                              <c:if test="${canFile == 'true'}">
                                 <li class="active"><a href="/boirfiling">File BOIR</a></li>
                              </c:if>
                              <c:if test="${canFile != 'true'}">
                                 <li class="active"><a href="/dashboardpricing" class="tab-link" data-tab="tab2">Pay and File BOIR</a></li>
                              </c:if>
							  <c:if test="${hasFiles == 0 }">
								 <li class="disabled"><a href="/inprogress" class="tab-link" data-tab="tab4">In Progress Reports</a></li>
		                         <li class="disabled"><a href="/insubmit" class="tab-link" data-tab="tab5">Submitted Reports</a></li>
								 <li class="disabled"><a href="/paymenthistory" class="tab-link" data-tab="tab6">Payment History</a></li>
								 <li class="disabled"><a href="/dashboardpricing" class="tab-link" data-tab="tab7">Pricing Plan</a></li>
	                          </c:if>
							  <c:if test="${hasFiles > 0 }">
  								 <li class="active"><a href="/inprogress" class="tab-link" data-tab="tab4">In Progress Reports</a></li>
  	                             <li class="active"><a href="/insubmit" class="tab-link" data-tab="tab5">Submitted Reports</a></li>
  								 <li class="active"><a href="/paymenthistory" class="tab-link" data-tab="tab6">Payment History</a></li>
  								 <li class="active"><a href="/dashboardpricing" class="tab-link" data-tab="tab7">Pricing Plan</a></li>
  	                          </c:if>
								
	                              <!--<li class="active"><a href="/inprogress" class="tab-link" data-tab="tab4">In Progress Reports</a></li>
	                              <li class="active"><a href="/insubmit" class="tab-link" data-tab="tab5">Submitted Reports</a></li>
	                              <li class="active"><a href="/paymenthistory" class="tab-link" data-tab="tab6">Payment History</a></li>-->
							  
                              <!--<li class="active"><a href="/dashboardpricing" class="tab-link" data-tab="tab7">Pricing Plan</a></li>-->
<!--                              <li class="active"><a href="/forgotpwd">Reset Password</a></li>-->
<!--                              <li class="active"><a href="/editprofile" class="tab-link" data-tab="tab8">Edit Profile</a></li>-->
                           </ul>
                        </aside>
                        <aside class="col-lg-9 sf-main-right">
                           <div id="tabContent">
                              <!-- Content will be loaded here -->
                              <div>
                              </div>
                           </div>
                        </aside>
                     </div>
                  </div>
               </div>
            </div>
         </div>
		 
		 
         <!-- Include Footer -->
         <%@ include file="/WEB-INF/views/footer.jsp" %>
      </div>
	  
      <%@ include file="/WEB-INF/views/js.jsp" %>
      <!-- Dependencies for loader -->
      <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	  
	  <!-- script for success message-->
	  <script>
	          $(document).ready(function() {
	              // Trigger the modal if there's a message
	              if (typeof message !== 'undefined' && message.length > 0) {
					  $('#modal-message').text(message);
	                  $('.foreignvehicle-modal').modal('show');
	              }
	          });
	      </script>
		  
      <script>
         $(document).ready(function() {
             let currentTabHref;

             function showLoader() {
                 $('#tabContent').hide();  // Hide the current tab content
                 $('#loader').show();  // Show the loader
             }

             function hideLoader() {
                 $('#loader').hide();  // Hide the loader
                 $('#tabContent').show();  // Show the tab content after loading
             }

             function loadTabContent(href) {
                 showLoader();
                 $('#tabContent').load(href, function(response, status, xhr) {
                     hideLoader();
                     if (status === "error") {
                         console.error("Failed to load content: " + xhr.status + " " + xhr.statusText);
                     } else {
                         $('#tabContent').find("script").each(function() {
                             let script = document.createElement("script");
                             script.type = "text/javascript";
                             if (this.src) {
                                 script.src = this.src;
                             } else {
                                 script.text = this.innerHTML;
                             }
                             document.head.appendChild(script);
                             document.head.removeChild(script);
                         });
                     }
                 });
             }

             function attachFormHandler() {
                 $('#tabContent').on('submit', 'form', function(event) {
                     event.preventDefault(); // Prevent the default form submission
                     this.target = '_blank'; // Set the target to '_blank' to open in a new tab
                     this.submit(); // Submit the form
                 });
             }

             function setActiveTab(tabData) {
                 const tabLink = $(`.tab-link[data-tab="${tabData}"]`);
                 if (tabLink.length) {
                     const href = tabLink.attr('href');
                     loadTabContent(href);
                     $('.tab-link').removeClass('active');
                     tabLink.addClass('active');
                 } else {
                     console.warn("No tab link found for data-tab: " + tabData);
                 }
             }

             $('.tab-link').click(function(e) {
                 e.preventDefault();
                 const href = $(this).attr('href');
                 currentTabHref = href;
                 loadTabContent(href);
                 $('.tab-link').parent().removeClass('active');
                 $(this).parent().addClass('active');
             });

             const defaultTabHref = $('.tab-link[data-tab="tab1"]').attr('href');
             loadTabContent(defaultTabHref);
             currentTabHref = defaultTabHref;
             $('.tab-link[data-tab="tab1"]').parent().addClass('active');

             $('#refreshTab').click(function() {
                 if (currentTabHref) {
                     loadTabContent(currentTabHref);
                 }
             });

             const defaultTabData = 'tab1';
             setActiveTab(defaultTabData);
             currentTabHref = $(`.tab-link[data-tab="${defaultTabData}"]`).attr('href');
         });
      </script>
      <script>
         document.addEventListener("DOMContentLoaded", function () {
             const menuItems = document.querySelectorAll("li");

             function setDefaultActiveItem() {
                 menuItems.forEach(item => item.classList.remove("active"));
                 menuItems[0].classList.add("active");
             }

             setDefaultActiveItem();

             menuItems.forEach(item => {
                 item.addEventListener("click", function () {
                     menuItems.forEach(item => item.classList.remove("active"));
                     this.classList.add("active");
                 });
             });
         });
      </script>
   </body>
</html>
