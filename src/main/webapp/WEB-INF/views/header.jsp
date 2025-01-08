<!DOCTYPE html>
<html lang="en">
   <head>
	  <%@ include file="/WEB-INF/views/css.jsp" %>
      <!-- Fix Internet Explorer ______________________________________-->
	  <title>header</title>
      <style>
         .step {
         display: none;
         }
         .step.active {
         display: block;
         }
      </style>
   </head>
   <body>
      
	<header class="theme-main-menu menu-overlay menu-style-two sticky-menu">
	         <div class="gap-fix info-row">
	            <div class="d-md-flex justify-content-between">
	               <div class="greetings text-center">
	               </div>
				   <ul class="style-none d-none d-md-flex contact-info">
				      <li class="d-flex align-items-center active"><img src="/images/icon/icon_14.svg" alt="" class="lazy-img icon me-2" style=""> <a href="mailto:babuninc@company.com" class="fw-500">support@ctaharbor.com</a></li>
				      <li class="d-flex align-items-center"><img src="/images/icon/icon_15.svg" alt="" class="lazy-img icon me-2" style=""> <a href="tel:+757 699-4478" class="fw-500">+1 917-675-1888</a></li>
				   </ul>
	            </div>
	         </div>
	         <div class="inner-content gap-fix">
	            <div class="top-header position-relative">
	               <div class="d-flex align-items-center">
	                  <div class="logo order-lg-0">
	                     <a href="home" class="d-flex align-items-center">
	                     <img src="/images/logo/CTA_logo.svg" alt="">
	                     </a>
	                  </div>
	                  <!-- logo -->
	                  <div class="right-widget order-lg-3 ms-auto">
	                     <ul class="d-flex align-items-center style-none">
	                        <li>
	                           <a href="#"><img src="/images/notification-icon.png" alt="" /></a>
	                        </li>
	                        <li>
	                           <a href="#"><img src="/images/profile-img.png" alt="" ><span><img src="/images/arrow-down.png" alt="" ></span></a>
	                        </li>
	                     </ul>
	                  </div>
	                  <!--/.right-widget-->
	                  <nav class="navbar navbar-expand-lg p0 ms-lg-5 order-lg-2">
	                     <button class="navbar-toggler d-block d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	                     <span></span>
	                     </button>
	                     <div class="collapse navbar-collapse" id="navbarNav">
	                        <ul class="navbar-nav align-items-lg-center">
	                           <li class="d-block d-lg-none">
	                              <div class="logo">
	                                 <a href="/home" class="d-block"><img src="images/logo/CTA_logo.svg" alt=""></a>
	                              </div>
	                           </li>
	                           <li class="nav-item dropdown">
	                              <a class="nav-link" href="/home">Home
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
	                              <a class="nav-link " href="/blog">Blog
	                              </a>
	                           </li>
	                           <li class="nav-item">
	                              <a class="nav-link" href="/contactus" role="button">Contact Us</a>
	                           </li>
	                           <li class="nav-item">
	                              <a class="nav-link" href="/faq" role="button">FAQ</a>
	                           </li>
	                           <li class="d-md-none ps-2 pe-2">
	                              <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="signup-btn-one icon-link w-100 mt-20">
	                                 <span class="flex-fill text-center">Register</span>
	                                 <div class="icon rounded-circle d-flex align-items-center justify-content-center"><i class="bi bi-arrow-right"></i></div>
	                              </a>
	                              <ul class="style-none contact-info m0 pt-30">
	                                 <li class="d-flex align-items-center p0 mt-15"><img src="images/lazy.svg" data-src="images/icon/icon_14.svg" alt="" class="lazy-img icon me-2"> <a href="mailto:babuninc@company.com" class="fw-500">babuninc@company.com</a></li>
	                                 <li class="d-flex align-items-center p0 mt-15"><img src="images/lazy.svg" data-src="images/icon/icon_15.svg" alt="" class="lazy-img icon me-2"> <a href="tel:+757 699-4478" class="fw-500">+757 699-4478</a></li>
	                              </ul>
	                           </li>
	                        </ul>
	                     </div>
	                  </nav>
	               </div>
	            </div>
	            <!--/.top-header-->
	         </div>
	         <!-- /.inner-content -->
	      </header> 
	  
   </body>
</html>