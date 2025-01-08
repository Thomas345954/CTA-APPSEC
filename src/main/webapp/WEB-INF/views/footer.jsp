<!DOCTYPE html>
<html lang="en">
   <head>
	  <%@ include file="/WEB-INF/views/css.jsp" %>
	  <%@ page import="java.util.List" %>
	  <%@ page import="java.util.Map" %> 
	  <%@ page import="com.cta.boir.util.GlobalVariables" %>
	  <link rel="stylesheet" type="text/css" href="/css/customStyle.css"/> 
	  <title>footer</title>
      <style>
         .step {
         display: none;
         }
         .step.active {
         display: block;
         }
		 .image-container{
			display: flex;
			justify-content: center;
			align-items: center;
			
		 }
      </style>
   </head>
   <body>
      <!--
         =====================================================
         	Footer Two
         =====================================================
         -->
      <div class="footer-two">
         <div class="container">
            <div class="bg-wrapper position-relative">
               <div class="container footercontainer">
                  <div class="row justify-content-between">
                     <div class="col-xl-3 col-lg-4 footer-intro mb-30">
                        <div class="logo mb-35 md-mb-20">
                           <a href="home">
                           <img src="/images/logo/CTA_logo.svg" alt="">
                           </a>
                        </div>
                        <!-- logo -->
                        <p class="lh-sm mb-40 md-mb-20"><p class="footer-addres"><a href="https://maps.google.com/maps?ll=40.752549,-73.979199&z=12&t=m&hl=en&gl=US&mapclient=embed&q=315%20Madison%20Ave%20%234005%20New%20York%2C%20NY%2010165%20USA" target="_blank">315 Madison Avenue<br> Suite 4005<br>New York, NY 10017</a>
                           <br><a href="tel:+1 (888) 203-2246">+1 (888) 203-2246</a>
						   <p></p>
                        </p>
                        <!--<ul class="style-none d-flex align-items-center social-icon">
						   <li><a href="https://www.facebook.com/profile.php?id=61562918141574"><img src="/images/icon/Facebook.svg"></a></li>
						   <li><a href="https://www.linkedin.com/company/104102290/"><img src="/images/icon/linked-in.svg"></a></li>
                        </ul>-->
                     </div>
                     <div class="col-lg-2 col-sm-4 mb-20">
                        <h5 class="footer-title">Links</h5>
                        <ul class="footer-nav-link style-none">
                           <li><a href="/home">Home</a></li>
                           <li><a href="/aboutus">About Us</a></li>
                           <li><a href="/pricing">Pricing</a></li>
                           <li><a href="/blog">Blog</a></li>
                           <li><a href="/contactus">Contact Us</a></li>
                           <li><a href="/faq">FAQ</a></li>
                           <li><a href="#"></a></li>
                        </ul>
                     </div>
                     <div class="col-xxl-2 col-lg-3 col-sm-4 mb-20">
                        <h5 class="footer-title">Legal</h5>
                        <ul class="footer-nav-link style-none">
                           <li><a href="/termsuse">Terms of Use</a></li>
                           <li><a href="/terms">Terms & Conditions</a></li>
                           <li><a href="/privacy">Privacy Policy</a></li>
                           <li><a href="/cookie">Cookie Policy</a></li>
                        </ul>
                     </div>
					 <div class="col-xxl-2 col-lg-3 col-sm-4 mb-20">
                         <h5 class="footer-title">Powered by MicroGrid</h5>
						 <div class="cert-logos text-center">
							<%List<Object> certImages = GlobalVariables.certProvideByImageURL;
						       for (Object cert : certImages) {
								// Cast to Map to access properties
					               Map<String, Object> certMap = (Map<String, Object>) cert;
					               String logoUrl = (String) certMap.get("c_logo_url"); // Fetch c_logo_url
							%>
								      <img src="<%= logoUrl %>" alt="Certified By Image">
						    <%
					       		}
						    %>
					     </div>
                      </div>
                  </div>
               </div>
			   
			   <div class="bottom-footer">
                  <div class="row">
                     <div class="col-xl-4 col-lg-3 order-lg-3 mb-15">
                        <ul class="style-none d-flex align-items-center justify-content-center justify-content-lg-end social-icon">
                           <li><a href="https://www.facebook.com/profile.php?id=61562918141574"><img src="/images/icon/Facebook_1.svg" alt="" ></a></li>
						   <li><a href="https://www.instagram.com/ctaharbor/"><img src="/images/icon/Insta_1.svg" alt="" ></a></li>
                           <li><a href="https://www.linkedin.com/company/104102290/"><img src="/images/icon/linkedin_1.svg" alt="" ></a></li>
						   <li><a href="https://x.com/CtaHarbor"><img src="/images/icon/Twitter.svg" alt="" ></a></li>
                        </ul>
                     </div>
                     <div class="col-xl-4 col-lg-6 order-lg-2 mb-15">
                       <!-- <ul class="style-none bottom-nav d-flex justify-content-center order-lg-last">
                           <li><a href="#">Privacy &amp; Terms</a></li>
                           <li><a href="#">Cookies</a></li>
                           <li><a href="contactus">Contact Us</a></li>
                        </ul> -->
                     </div>
                     <div class="col-xl-4 col-lg-3 order-lg-1 mb-15">
                        <div class="copyright text-center text-lg-start order-lg-first">Copyright &copy; 2024 CTAHarbor, a d.b.a. of New York Business Advisory & Corporate Services Inc.</div>
                     </div>
                  </div>
               </div>
			   <div class="image-container">
				   <a href="https://www.bbb.org/us/ny/new-york/profile/business-consultants/new-york-business-advisory-corporate-services-inc-0121-87174863/#sealclick" id="bbblink" class="ruhzbum" target="_blank" rel="nofollow">
						<img  src="https://seal-newyork.bbb.org/logo/ruhzbum/bbb-87174863.png" style="border: 0;" alt="New York Business Advisory & Corporate Services Inc. BBB Business Review" />
				   </a>
				</div>
			   
              <!-- <img src="/images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_01" style="">
               <img src="/images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_02" style="">-->
            </div>
            <!-- /.bg-wrapper -->
         </div>
      </div>
      <!-- /.footer-two -->
     <!-- <div class="footer-three">
         <div class="container">
            <div class="bottom-footer">
               <div class="row">
                  <div class="col-xl-4 col-lg-3 order-lg-3 mb-15">
                     <ul class="style-none d-flex align-items-center justify-content-center justify-content-lg-end social-icon">
                        <li><a href="https://www.facebook.com/profile.php?id=61562918141574"><img src="/images/icon/Facebook.svg"></a></li>
                        <li><a href="https://www.linkedin.com/company/104102290/"><img src="/images/icon/linked-in.svg"></a></li>
                     </ul>
                  </div>
                  <div class="col-xl-4 col-lg-6 order-lg-2 mb-15">
                     <ul class="style-none bottom-nav d-flex justify-content-center order-lg-last">
                        <li><a href="#">Privacy &amp; Terms</a></li>
                        <li><a href="#">Cookies</a></li>
                        <li><a href="contactus">Contact Us</a></li>
                     </ul>
                  </div>
                  <div class="col-xl-4 col-lg-3 order-lg-1 mb-15">
                     <div class="copyright text-center text-lg-start order-lg-first">Copyright @2024 CTAharbor</div>
                  </div>
               </div>
            </div>
         </div>
      </div> -->
      <!--footer end-->
   </body>
</html>