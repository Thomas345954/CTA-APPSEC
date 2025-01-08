<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.cta.boir.util.GlobalVariables" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
   <head>
	<title>CTAHarbor</title>
	<%@ include file="/WEB-INF/views/css.jsp" %>
	  <style>
	      .submenu {
	          display: none;
	          position: absolute;
	          background-color: white;
	          box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	          z-index: 1;
	      }
		  .logout1{
			padding-right: 85px;
		  }
	      .submenu li {
	          list-style: none;
	      }
	      .submenu li a {
	          display: block;
	          padding: 10px;
			  padding-right:40px;
	          text-decoration: none;
	      }
	      .submenu li a:hover {
	          background-color: #f1f1f1;
	      }
	  </style>

   </head>
   <body>
	<%@ include file="/WEB-INF/views/right-click.jsp" %>
	<% 
		String referralLink = (String) session.getAttribute("referralLink"); 
		pageContext.setAttribute("referralLink", referralLink);
	%>
	<div class="referal-modal modal fade" id="referal-popup" tabindex="-1" aria-hidden="true" style="padding-left: 0px;"data-bs-backdrop="static">
     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
       <div class="container">
         <div class="user-data-form step-form-modal modal-content">
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
           <div class="modal-cont">
             <div class="boddyone">
               <h2>Refer a Business Owner &amp; Get Rewarded</h2>
               <h3>No Strings Attached!</h3>
               <p class="text-left">It's simple: Refer a business owner to CTAHarbor, and earn a $10 Amazon Gift
                 Card when they successfully purchase a report.
                 No hoops to jump through.</p>
               <div class="form-fields d-flex row">
                 <div class="normal-field col-md-9">
                   <input type="text" id="referralLink" placeholder="REFERAL LINK" value="<%= referralLink %>"class="alternate-name form-field form-control" style="height: 54px;background: #dee6ec;border-color: #003B6A; margin:3px;" readonly>
                 </div>
                 <div class="col-md-3 text-left">
                   <button data-index="0" id="copyLinkBtn" class="remove-alternate-name  btn-primary  bg-btn" style="margin:3px; padding:11px;">COPY LINK</button>
                 </div>
               </div>
               <div class="bottom-footer">
				<c:choose>
				    <c:when test="${fn:contains(referralLink, 'https://ctaharbor.firstpromoter.com/')}">
						<p class="mt-5	">
							To get started, please copy the above link and register for your affiliate account. Happy referring!
						</p>
					</c:when>
				    <c:otherwise>
						<div>
		                   <div class=" order-lg-3 mb-15 mt-50">
		                     <ul
		                       class="style-none d-flex align-items-center justify-content-center justify-content-lg-end social-icon"
		                       style=" justify-content: center !important;">
		                       <li style="padding: 10px;"><a href="https://www.facebook.com" target="_blank"><img src="/images/icon/Facebook_1.svg" alt="" ></a></li>
							   <li style="padding: 10px;"><a href="https://x.com" target="_blank"><img src="/images/icon/Twitter.svg" alt="" ></a></li>
		                       <li style="padding: 10px;"><a href="https://www.instagram.com" target="_blank"><img src="/images/icon/Insta_1.svg" alt="" ></a></li>
		                       <li style="padding: 10px;"><a href="https://www.linkedin.com" target="_blank"><img src="/images/icon/linkedin_1.svg" alt="" ></a></li>
		                     </ul>
		                   </div>
		                 </div>
				    </c:otherwise>
				</c:choose>  
               </div>
             </div>
           </div>
         </div>
       </div>
     </div>
   </div>
      <header class="theme-main-menu menu-overlay menu-style-two sticky-menu">
		
		
    <script type="text/javascript" src="https://seal-newyork.bbb.org/inc/legacy.js"></script>
	
         <div class="gap-fix info-row pb-0">
			
            <div class="d-md-flex justify-content-between">
      <a href="https://www.bbb.org/us/ny/new-york/profile/business-consultants/new-york-business-advisory-corporate-services-inc-0121-87174863/#sealclick" id="bbblink" class="ruhzbum" target="_blank" rel="nofollow"><img src="https://seal-newyork.bbb.org/logo/ruhzbum/bbb-87174863.png" style="border: 0;" alt="New York Business Advisory & Corporate Services Inc. BBB Business Review" /></a>
						  <div class="greetings text-center">
              </div>
             <ul class="style-none d-none d-md-flex contact-info">
				
				  <li class="d-flex align-items-center"><img src="/images/icon/icon_14.svg" alt="" class="lazy-img icon me-2" style=""> <a href="mailto:support@ctaharbor.com" class="fw-500">support@ctaharbor.com</a></li>
                  <li class="d-flex align-items-center"><img src="/images/icon/icon_15.svg" alt="" class="lazy-img icon me-2" style=""> <a href="tel:+1 (888) 203-2246" class="fw-500">+1 (888) 203-2246</a></li>
               </ul>
            </div>
         </div>
		 <div class="content announcement" style="">
			<!--<marquee>
				<%
				    List<String> announcements = GlobalVariables.announcement; // Get the global variable
	
				    if (announcements != null && !announcements.isEmpty()) {
				        // Assuming you have three entries for each announcement
				        for (int i = 0; i < announcements.size(); i += 3) {
							String announcementText = announcements.get(i); // c_announcement
				            String navigationUrl = announcements.get(i + 1);         // c_navigation_url
				            String hyperlinkText = announcements.get(i + 2);    // c_hyperlink_text 
				%>
				            <span class="fw-bold m-3" style="">
				                <%= announcementText %> 
				                <a href="<%= navigationUrl %>"class="" style="">
				                    <%= hyperlinkText %>
				               </a>
						   </span>
				<%
				        }
				    } 
				%>
			</marquee>-->
				
		</div>
		 <div class="inner-content gap-fix">
            <div class="top-header position-relative">
               <div class="d-flex align-items-center">
                  <div class="logo order-lg-0">
                     <a href="/home" class="d-flex align-items-center">
                     <img src="/images/logo/CTA_logo.svg" alt="">
                     </a>
                  </div>
                  <!-- logo -->

                     <c:choose>
                        <c:when test="${isAuthenticated}">
						   <div class="right-widget order-lg-3 ms-auto">
						      <ul class="d-flex file-list-dd align-items-center style-none">
						          <li class="dropdown">
						              <span class="logout1" id="dropdownTriggertwo"><img src="/images/fileicon.svg" alt="" >
						                  <p>${sessionScope.Pending}</p>
						              </span>
						              <ul class="submenu" id="submenutwo">
						                  <li><a href="#" class="" data-tab="">														
						                          <div class="dropdownfile-head" id="totalFiles">
						                              <div>Total Files Bought</div>
						                              <div class="numberfile">${sessionScope.totalFiles}</div>
						                          </div>
						                  </a></li>
						                  <li><a href="#">															  
						                          <div class="dropdownfile-head" id="filesUsed">
						                              <div>Files Used</div>
						                              <div class="numberfile">${sessionScope.filesFilled}</div>
						                          </div>
						                  </a></li>
						                  <li><a href="#">
						                          <div class="dropdownfile-head" id="filesAvailable">
						                              <div>Files Available</div>
						                              <div class="numberfile">${sessionScope.Pending}</div>
						                          </div>
						                  </a></li>
						                  <li class="need-more-btn">
						                      <a href="/pricing" id="needMore">Need More?</a>
						                  </li>
						              </ul>
						          </li>
						      </ul>
						  </div>
							  
						  <div class="right-widget order-lg-3 ms-auto">
						     <ul class="d-flex align-items-center style-none">
						        <li class="dropdown">
						              <span class="logout1" style="display: flex;" id="dropdownTrigger"><img src="${image}" alt=""  onerror="this.src='/images/profileperson.svg';" width="40px" height="40px" style="border-radius: 50px;width: 50px;height: 50px;">
						                 <img src="/images/arrow-down.png" alt=""  style="height: 10px;width: auto;margin: 20px;">
						              </span>
						              <ul class="submenu" id="submenu" style="font-size: 14px; white-space: nowrap; font-weight: 500; margin-left: -16px; padding-left: 0px;">
						                 <c:if test ="${dashboard == 'true'}">
						                    <li><a href="/editprofile" class="tab-link" data-tab="tab8">Edit Profile</a></li>
						                 </c:if>
						                 <li><a href="/forgotpwd">Reset Password</a></li>
						                 <li><a href="/logout" id="logout">Logout</a></li>
										 <c:if test="${refferalOptionHide == null}">
										     <li style="background-color: #B8D5EC;color: #B31942;font-weight: 900;">
										         <a href="#" data-bs-toggle="modal" data-bs-target="#referal-popup" id="referalpopup">Refer & Earn $10</a>
										     </li>
										 </c:if>
						                 <input type="file" id="fileInput" accept="image/*" style="display: none;"/>
						                 <img src="${image}" width="50px" height="50px" id="profileImage" style="display:none;" alt="Profile Image">
						              </ul>
						        </li>
						     </ul>
						  </div>
                           <!--/.right-widget-->
                           <nav class="navbar navbar-expand-lg p0 ms-lg-5 order-lg-2">
                              <button class="navbar-toggler d-block d-lg-none" type="button" data-bs-toggle="collapse"
                                 data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                                 aria-label="Toggle navigation">
                              <span></span>
                              </button>
                              <div class="collapse navbar-collapse" id="navbarNav">
                                 <ul class="navbar-nav align-items-lg-center">
                                    <li class="d-block d-lg-none">
                                       <div class="logo"><a href="/home" class="d-block"><img src="/images/logo/CTA_logo.svg" alt=""></a></div>
                                    </li>
                                    <li class="nav-item dropdown">
                                       <a class="nav-link" href="/home">
                                          Home
                                          <!--<c:out value="${name}"/>-->
                                       </a>
                                    </li>
                                    <li class="nav-item dropdown mega-dropdown-sm">
                                       <a class="nav-link" href="/aboutus">About Us
                                       </a>
                                    </li>
                                    <li class="nav-item dropdown">
                                       <a class="nav-link" href="/pricing">Pricing
                                       </a>
                                    </li>
                                    <li class="nav-item dropdown">
                                       <a class="nav-link" href="/blog">Blog
                                       </a>
                                    </li>
                                    <li class="nav-item">
                                       <a class="nav-link" href="/contactus" role="button">Contact Us</a>
                                    </li>
                                    <li class="nav-item">
                                       <a class="nav-link" href="/faq" role="button">FAQ</a>
                                    </li>
                                    <li class="nav-item">
                                       <a class="nav-link" href="/dashboard" role="button">Dashboard</a>
                                    </li>
                                    <li class="d-md-none ps-2 pe-2">
										<c:if test="${isAuthenticated != true}">
										<a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="signup-btn-one icon-link w-100 mt-20">
                                          <span class="flex-fill text-center">Register</span>
                                          <div class="icon rounded-circle d-flex align-items-center justify-content-center"><i class="bi bi-arrow-right"></i></div>
                                       </a>
									   </c:if>
                                       <ul class="style-none contact-info m0 pt-30">
                                          <li class="d-flex align-items-center p0 mt-15"><img src="/images/lazy.svg" data-src="/images/icon/icon_14.svg" alt="" class="lazy-img icon me-2"> <a href="mailto:support@ctaharbor.com" class="fw-500">support@ctaharbor.com</a></li>
                                          <li class="d-flex align-items-center p0 mt-15"><img src="/images/lazy.svg" data-src="/images/icon/icon_15.svg" alt="" class="lazy-img icon me-2"> <a href="tel:+1 (888) 203-2246" class="fw-500">+1 (888) 203-2246</a></li>
                                       </ul>
                                    </li>
                                 </ul>
                              </div>
                           </nav>
                        </c:when>
                        <c:otherwise>
                           <!-- Content to display if none of the above conditions are true -->
                           <div class="right-widget order-lg-3 ms-auto">
                              <ul class="d-flex align-items-center style-none">
                                 <li class="d-flex align-items-center login-btn-one me-3 me-md-0">
                                    <img src="/images/lazy.svg" data-src="/images/icon/icon_16.svg" alt="" class="lazy-img icon me-2"> 
                                    <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="fw-500" id="loginpopup">Login</a>
                                 </li>
								 <c:if test="${isAuthenticated != true}">
								 <li class="d-none d-md-inline-block ms-3 ms-lg-5 me-3 me-lg-0">
                                    <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="signup-btn-one icon-link" id="signuppopup">
                                       <span>Register</span>
                                       <div class="icon rounded-circle d-flex align-items-center justify-content-center"><i class="bi bi-arrow-right"></i></div>
                                    </a>
                                 </li>
								 </c:if>
                              </ul>
                           </div>
                        
                           <!--/.right-widget-->
                           <nav class="navbar navbar-expand-lg p0 ms-lg-5 order-lg-2">
                              <button class="navbar-toggler d-block d-lg-none" type="button" data-bs-toggle="collapse"
                                 data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                                 aria-label="Toggle navigation">
                              <span></span>
                              </button>
                              <div class="collapse navbar-collapse" id="navbarNav">
                                 <ul class="navbar-nav align-items-lg-center">
                                    <li class="d-block d-lg-none">
                                       <div class="logo"><a href="/home" class="d-block"><img src="/images/logo/CTA_logo.svg" alt=""></a></div>
                                    </li>
                                    <li class="nav-item dropdown">
                                       <a class="nav-link" href="/home">
                                          Home
                                          <!--<c:out value="${name}"/>-->
                                       </a>
                                    </li>
                                    <li class="nav-item dropdown mega-dropdown-sm">
                                       <a class="nav-link" href="/aboutus">About Us
                                       </a>
                                    </li>
                                    <li class="nav-item dropdown">
                                       <a class="nav-link" href="/pricing">Pricing
                                       </a>
                                    </li>
                                    <li class="nav-item dropdown">
                                       <a class="nav-link" href="/blog">Blog
                                       </a>
                                    </li>
                                    <li class="nav-item">
                                       <a class="nav-link" href="/contactus" role="button">Contact Us</a>
                                    </li>
                                    <li class="nav-item">
                                       <a class="nav-link" href="/faq" role="button">FAQ</a>
                                    </li>

                                    <li class="d-md-none ps-2 pe-2">
										<c:if test="${isAuthenticated != true}">
                                       <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="signup-btn-one icon-link w-100 mt-20">
                                          <span class="flex-fill text-center">Register</span>
                                          <div class="icon rounded-circle d-flex align-items-center justify-content-center"><i class="bi bi-arrow-right"></i></div>
                                       </a>
									   </c:if>
                                       <ul class="style-none contact-info m0 pt-30">
                                          <li class="d-flex align-items-center p0 mt-15"><img src="/images/lazy.svg" data-src="/images/icon/icon_14.svg" alt="" class="lazy-img icon me-2"> <a href="mailto:support@ctaharbor.com" class="fw-500">support@ctaharbor.com</a></li>
                                          <li class="d-flex align-items-center p0 mt-15"><img src="/images/lazy.svg" data-src="/images/icon/icon_15.svg" alt="" class="lazy-img icon me-2"> <a href="tel:+1 (888) 203-2246" class="fw-500">+1 (888) 203-2246</a></li>
                                       </ul>
                                    </li>
									
                                 </ul>
                              </div>
                           </nav>
               </c:otherwise>
            </c:choose>
               </div>
            </div>
            <!--/.top-header-->
         </div>
         <!-- /.inner-content -->
		 </header>
		 <script>
		
			document.addEventListener('DOMContentLoaded', function() {
			    var dropdownTrigger = document.getElementById('dropdownTrigger');
			    var submenu = document.getElementById('submenu');
				var dropdownTriggertwo = document.getElementById('dropdownTriggertwo');
			    var submenutwo = document.getElementById('submenutwo');
				// var fileInput = document.getElementById('fileInput');
			    //var profileImage = document.getElementById('profileImage');

			    // Example profile image URL - in a real scenario, you might fetch this from a server or other source


			    // Toggle submenu visibility
			    dropdownTrigger.addEventListener('click', function(event) {
			        event.preventDefault();
			        submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
			    });
				
				dropdownTriggertwo.addEventListener('click', function(event) {
			        event.preventDefault();
			        submenutwo.style.display = submenutwo.style.display === 'block' ? 'none' : 'block';
			    });

			    // Close submenu if clicked outside
			    window.addEventListener('click', function(event) {
			        if (!event.target.matches('#dropdownTrigger') && !event.target.closest('.dropdown')) {
			            submenu.style.display = 'none';
			        }
					if (!event.target.matches('#dropdownTriggertwo') && !event.target.closest('.dropdown')) {
			            submenutwo.style.display = 'none';
			        }
			    });
			});
			
			// For Referral link popup
			document.getElementById("copyLinkBtn").addEventListener("click", function() {
		       var referralLink = document.getElementById("referralLink");
			   
			   // Select the text field
		       referralLink.select();
		       referralLink.setSelectionRange(0, 99999); // For mobile devices

		       // Copy the text inside the text field
		       document.execCommand("copy");
			   
		   });
		
		 </script>
		
   </body>
</html>	