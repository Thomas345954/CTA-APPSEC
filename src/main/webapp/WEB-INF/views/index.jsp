<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
   <head>
	  <%@ include file="/WEB-INF/views/css.jsp" %>
      <title>CTAHarbor</title>
	  
      <style>
         .amount-display {
         display: inline-block;
         margin-left: 10px;
         font-weight: bold;
         font-size: 1.2em;
         }
         .animated-number {
         display: inline-block;
         }
		 *:focus {
		  
		 outline: none;
		  
		 }	 @media (min-width: 992px) {
	     .col-lg-6 {
	         flex: 0 0 auto;
	         width: 30% !important;
	     }
	 }
		 .cookie-banner {
		             position: fixed;
		             bottom: 0;
		             width: 100%;
		             background-color: rgba(0, 0, 0, 20);
		             color: white;
		             text-align: center;
		             padding: 10px;
		             z-index: 1000;
		         }

		         .cookie-banner{
		             margin: 0;
		             display: inline;
		         }

                 .cookie-bannerflex
				 {
					display:flex;
					justify-content:center;
				 }
				 .para{
					text-align:center;
					
				 }

				 .cookie-policy-link {
				     color: red; /* Change to your desired red shade */
				     text-decoration: none; /* Optional: removes underline */
				 }
				 .foreignvehicle-modal .learnpopupsz #box-sz{
				 					width: 90%;
				 					max-width: 90%;
				 				 }
				 				 .foreignvehicle-modal .learnpopupsz h2{
				 				 	font-size: 20px;
				 					font-weight: 800;
				 				 }
				 				 .foreignvehicle-modal .learnpopupsz p{
				 				 	font-size: 14px;
				 					margin:2px;
				 					text-align: left;
				 					font-weight: 700;
				 				 }
				 				 #lefttext{
				 					text-align: left !important;
				 				 }
				 				.learnpopupsz {
				 					margin-left: 0;
				 					margin-right: auto;
				 					width: 90%;
				 					text-align:left;
				 				 }
				 				 .ffleft{
				 					text-align: left;
				 				 }
				 				 .boddyy {
				 					font-family: Arial, sans-serif;
				 					padding: 20px;
				 				}
				 				.table2 {
				 					width: 100%;
				 					border-collapse: collapse;
				 					margin: 20px 0;
				 				}
				 				.th2, .td2 {
				 					padding: 12px;
				 					text-align: center;
				 					border: 1px solid #ddd;
				 					font-size:14px;
				 				}
				 				.tr2:nth-child(even) {
				 					background-color: #f2f2f2;
				 				}
				 				.th2{
				 					background-color: #003B6A !important;
				 					color:#fff !important;
				 				}
								
								
								
      </style>
   </head>
   <body>
      <!-- Include Header -->
      <%@ include file="/WEB-INF/views/header-login.jsp" %>
	  <%@ include file="/WEB-INF/views/exemptchecker.jsp" %>
      <div class="main-page-wrapper">
         <%@ include file="/WEB-INF/views/loader.jsp" %>


			<jsp:useBean id="currentDate" class="java.util.Date" />

			<!-- Display Session Message -->
			    <c:if test="${not empty sessionScope.registerMessage}">
			        <!-- Pass the message to JavaScript -->
			        <script type="text/javascript">
			        	var message = "${sessionScope.registerMessage}";
 			        </script>
			        <!-- Clear the register message from session after displaying -->
			        <c:remove var="registerMessage" scope="session"/>
			    </c:if>
			 
			 
			<!-- Modal HTML -->
			<div class="foreignvehicle-modal modal fade" id="registerModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
				     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
				        <div class="container">
				           <div class="user-data-form step-form-modal modal-content">
				              <!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
				              <div class="modal-cont">
				                 <h2>Welcome Aboard!</h2>
				                 <p id="modal-message"></p>
				                 <div class="modal-btns step-mod-btns">
									<div id="proceedBtn"style="display:none;">
										<a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="fw-500" id="loginpopup">
									       <button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok">Proceed to Login</button>
									    </a>
									</div>
									<div>
										<button class="blue-btn" data-bs-dismiss="modal" id="regPopupOkBtn"  style="display:none;">Okay</button>
									</div>
								</div>
				              </div>
				           </div>	
				        </div>
				     </div>
				  </div>
				  
				  <!-- learn more popup -->
					  <div class="foreignvehicle-modal modal fade" id="learnmoreModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
	  				     <div class="modal-dialog modal-xl learnpopupsz">
	  				           <div class="user-data-form step-form-modal modal-content" id="box-sz">
	  				              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  				              <div class="modal-cont ffleft">
	  				                   <h2>Protect Your Business from Fraud and Future Risks</h2>
	  				                 <p id="lefttext">We urge all business owners to exercise extreme caution when filing their Beneficial Ownership Information Reports (BOIRs). Never share your sensitive data with unauthorized third-party services.</p>
	  				                 <h2>Why is this important?</h2>
	  				                 <p id="lefttext"><strong>Confidential Data:</strong> BOIRs contain highly sensitive information that can be exploited for fraudulent activities.</p>
	  				                 <p id="lefttext"><strong>Data Misuse:</strong> Unauthorized entities may use your data for identity theft, financial scams, or even to compromise your business operations.</p>
	  				                 <p id="lefttext"><strong>Future Risks:</strong> Filing your BOIR through unauthorized services could expose your business to future legal or financial liabilities.</p>
	  				                 <h2>Secure your BOIR Filing: A Checklist</h2>
	  				                 <p id="lefttext"><strong>File Directly:</strong> The most secure method is to file your BOIR directly through the authorized channels like FinCEN portal or any of its approved API participants.</p>
	  				                 <p id="lefttext"><strong>Verify Credentials:</strong> If you must use a third-party service, rigorously verify their credentials and ensure they are authorized by FinCEN,or approved API participants</p>
	  				                 <p id="lefttext"><strong>Be Cautious of Phishing Attempts:</strong> Be vigilant against unsolicited emails or calls claiming to be from government agencies. These could be phishing scams fabricated to steal your information.</p>
	  				                 <p id="lefttext"><strong>Consider carefully before selecting the lowest-cost option:</strong> Some third-party services may offer lower fees because they do not adhere to the rigorous standards set by FinCEN. This could mean that they are not following proper security protocols or may be collecting your data for unauthorized purposes.</p>
	  				                 <h2></h2>
	  				                 <p id="lefttext"> Protect your business and its valuable data. Filing your BOIR through unauthorized services could have serious consequences. Choose a secure and reputable method to safeguard your business.</p>
	  				                 <div class="modal-btns step-mod-btns">
	  				                    <button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok" onclick="enablecookie()">I Understand</button>
	  				                 </div>
	  				              </div>
	  				           </div>
	  				     </div>
	  				  </div>
				  			<!-- Start now popup -->
				  			<div class="foreignvehicle-modal table-modal modal fade" id="startnowModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
				  				<div class="modal-dialog modal-fullscreen modal-dialog-centered">
				  					
				  						<div class="user-data-form step-form-modal modal-content">
				  							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				  							<div class="modal-cont">
				  								<div class="boddy">
				  								<h3 class="modal-head">What Sets Us Apart</h3>
				  								<div class="table-responsive">
				  								<table class="table2 table">
				  								    <tr class="tr2 tab-head">
				  								        <th class="th2">Benefits of BOIR</th>
				  								        <th class="th2">CTAHarbor</th>
				  								        <th class="th2">FinCEN Portal</th>
				  								        <th class="th2">Third Party Service Providers</th>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">US Dept. Of Treasury-Approved API Participant</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2">Mostly</td>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">Intuitive BOIR Workflow</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></i></i></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></i></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">Effortless AI-powered BOIR Filing</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></i></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></i></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">Lifetime BOIR Filing Corrections/Updates</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">Auto-filled Data for Quick Corrections/Updates</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">Centralized BOIR Filing History</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								        <td class="td2">Some</td>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">Certificate of BOIR Filing (issued by NYBACS)</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								    </tr>
				  								    <tr class="tr2">
				  								        <td class="td2">Lifetime Compliance Notifications</td>
				  								        <td class="td2"><h4 style="font-weight: 600;"><i class="bi bi-check-lg" style="color: green;"></i></h4></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								        <td class="td2"><h4><i class="bi bi-x" style="color: red;font-weight: 600;"></i></h4></td>
				  								    </tr>
				  								</table>
				  								</div>
				  								</div>
				  								<div class="modal-btns step-mod-btns" style="margin-top:-20px">
				  									<!--<button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok" >Ok</button>-->
				  								</div>
				  							</div>
				  						</div>	
				  					
				  				</div>
				  			</div>
							
         <div class="hero-banner-two home-banner-sec light-bg pt-200 pb-85 position-relative">
            <div class="container position-relative">
               <div class="row">
                  <div class="col-lg-10 m-auto">
                     <h1 class="hero-heading text-center fw-bold wow fadeInUp mt-10" style="font-size: 60px;" > Effortless <span class="d-inline-block position-relative">BOIR Filing.<img src="images/lazy.svg" data-src="images/shape/shape_04.svg" alt="" class="lazy-img"></span><br>Assured CTA Compliance.</h1>
                     <p class="text-xl text-center pt-35 pb-35 wow fadeInUp" data-wow-delay="0.1s">File with a US Dept. of Treasury-approved API Participant. <a href="#" data-bs-toggle="modal" data-bs-target="#startnowModal" id="startnowpopup"><u>Compare</u></a> and <a href="/pricing"><u>Start Now!</u></a></p>
                  </div>
               </div>
            </div>
			<c:if test="${firstTimeUser == 'true'}">
			<div class="warning-cont" id="notice" name="notice" style="background: #003B6A; position: relative; padding: 20px;bottom: 40px;">
				<p style="color: white;">
					PROTECT YOUR BUSINESS FROM FRAUD AND FUTURE RISKS<br/><br/> We urge all business owners to exercise extreme caution when filing their Beneficial Ownership Information Reports (BOIRs). Never share your sensitive data with unauthorized third-party services.<br/>
					 <a href="#" data-bs-toggle="modal" data-bs-target="#learnmoreModal" class="fw-500" id="learnmorepopup"><u>Learn more</u></a>
				</p>
			</div>
			</c:if>
			<img src="images/lazy.svg" data-src="images/shape/shape_05.svg" alt="" class="lazy-img shapes shape_01">
            <img src="images/lazy.svg" data-src="images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_02">
            <img src="images/lazy.svg" data-src="images/assets/homeimg1.png" alt="" class="lazy-img shapes shape_03">
            <img src="images/lazy.svg" data-src="images/assets/homeimg2.png" alt="" class="lazy-img shapes shape_04">
         </div>
		 
		 
		 <!----Partners banner-->
		 <section class="logo-scroll-sec">
		     <div class="container">
		         <div class="title-one text-center">
		             <h2>Proudly Partnered With</h2>
		         </div>
		         <div class="partner-slider-one">
		             <c:forEach var="partner" items="${partnersObjectList}">
		                 <div class="item">
		                     <img src="${partner['c_partner_icon']}" alt="">
		                 </div>
		             </c:forEach>
		         </div>
		     </div>
		 </section>

		 
			<div class="text-feature-two hm-content-sec position-relative pt-60 pb-40">
	            <div class="container">
	               <h2>BOIR Filing Deadlines</h2>
	               <div class="row" style="justify-content: center";>
	                  <aside class="col-lg-6">
	                     <div class="hm-cont-grid">
	                        <h4>For US entities formed on or before December 31, 2023</h4>
	                        <p>The deadline for the initial BOIR report is <span><u>January 1, 2025</u>.</span></p>
	                     </div>
	                  </aside>
	                  <aside class="col-lg-6">
	                     <div class="hm-cont-grid">
	                        <h4 style="font-size: 22px;">For US entities formed from January 1, 2024 to December 31, 2024</h4>
	                        <p>The deadline to file the initial BOIR report is <u>within 90 days</u> of their entity registration.</p>
	                     </div>
	                  </aside>
					  <aside class="col-lg-6">
	  				     <div class="hm-cont-grid">
	  				        <h4>For US entities formed after January<br> 1, 2025</h4>
	  				        <p>The deadline to file the initial BOIR report is <u>within 30 days</u> of their entity registration.</p>
	  				     </div>
	  				  </aside>
	               </div>
	               <!--<div class="hm-cont-btn"><a href="#"><img src="images/calendar-icon.png"> Find your Due Date</a></div>-->
				   
				   <h2>40 Million+ entities are required to file their BOIR by December 31, 2024.</h2>
				                  <!--<p class="text-md text-center mt-20">9,300 entities file their BOIR every hour.</p>-->
				   <br>
				    <h2>Find Your Due Date</h2>
				   <div id="myForm" style="padding-top: 25px;">
					<label class="main-label" for="incorporationDate">Date Of Incorporation:</label>
					    <input class="date-field col-sm-6" type="text" id="incorporationDate" name="incorporationDate" style="border-radius:5px;padding-left: 10px;width: 15%;min-width: 200px;" readonly placeholder="MM-DD-YYYY">
					    <button class="bg-btn red-btn" id="datesubmit" type="button" value="submit">Submit</button>
					    <p id="message" style="color: #B31942;max-width: 600px;margin: auto;font-size: 14px;font-weight:700;border-radius: 8px;padding: 13px 70px;background: #fff;margin-top: 45px;margin-bottom: 30px;display:none;text-align: center;"></p>
					</div>
					<div class="warning-cont">
					    <p style="font-size: 13px;"><img src="images/scale.png" alt="" >Be Aware: The Corporate Transparency Act imposes fines of $500/day up to $10,000, and may result in imprisonment for wilful non-compliance.</p>
					</div>
	            </div>
	            <img src="images/shape/shape_05.svg" alt="" class="lazy-img shapes shape_01" style="">
	            <img src="images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_02" style="">
	         </div>
			
			 <div class="text-feature-two position-relative pt-110 lg-pt-80 pb-110 lg-pb-80">
			 				<div class="container">
			 						         <div class="row align-items-center" style="margin-top: -120px;margin-bottom: -145px;">
			 						             <div class="col-xl-6 col-lg-7">
			 						                 <div class="title-one">
			 						                     <h2 class="text-white">CTA-Compliant Entities as of <fmt:formatDate value="${currentDate}" pattern="MM/dd/yyyy"/></h2>
			 						                 </div><div class="card-style-five" style="margin-top: -50px;">
			 											<div class="main-count fw-500" style="border-top: none;"><span class="counter" style="border: none; ">${boirCount}</span>+</div>
			 						                 </div>
			 						             </div>
			 						             <div class="col-lg-5 ms-auto" style="padding-right: 80px;margin-top: -50px;">
			 						                 <div class="card-style-five text-center mt-60">
			 											<div class="btn-four red-btn button-red" style="font-size: larger;padding: 10px;line-height: 30px;border-radius: 30px;" > <a href="/boirfiling" >Be Compliant.<br>File Now.</a></div>
			 						                 </div>

			 						             </div>
			 						         </div>
			 			    

			 			         <div class="row gx-0 mt-50 lg-mt-20 md-mt-10">
			 			             <div class="col-lg-4">
			 			                 <div class="card-style-five text-center mt-60">
			 			                 </div>
			 			             </div>
			 			             <div class="col-lg-4">
			 			             </div>
			 			             <div class="col-lg-4">
			 			             </div>
			 			         </div>
			 			     </div>
			 			     <img src="images/shape/shape_07.svg" alt="" class="lazy-img shapes shape_01" style="">
			 			     <img src="images/shape/shape_08.svg" alt="" class="lazy-img shapes shape_02" style="">
			 			 </div>
         <!-- /.text-feature-two -->
         <!--Pricing start-->
		 <!-- Pricing Start -->
		 
		        <div class="price-sec price-sec-home">
					<form action="${paymenthistory.nofiles == null ? '/loadcharge' : '/loadcharge'}" method="post">
						<input type="hidden" name="plan_id" id="planId" value="" />
						<input type="hidden" name="id"  />
						<input type="hidden" name="nofiles" id="nofiles" value="1"/>


		         <div class="container">
		            <h2 class="title-sec">Pricing</h2>
		           <div class="tabs-slider-sec">
		           <!-- Tabs for Individual and Professional plans -->
		           <div class="tabs">
		             <div id="individual-tab" class="tab">Individual</div>
		             <div id="professional-tab" class="tab">Professional</div>
		           </div>

		           <div class="file-select-sec" id="file-select-sec">
		            <h3>I need to file the BOI Report for <span id="slider-value">50</span> entity</h3>	
		           </div>

		           <!-- Slider for larger screens -->
		           <div class="slider-container">
		             <div id="pricing-slider"></div>
		           </div>
		           </div>

		           <!-- Compact Selected Credits, What You Pay Display, and Pay Now Button -->
		           <div id="display-box" class="display-box">
		             <!-- <div class="credits">Selected Credits: <span id="slider-value">50</span></div> -->
		             <div class="pay-sec">
		             <div class="pay-left">
		              <h3>What You Pay:</h3>
		              <div class="price"><sup>$</sup><span id="calculated-price">0</span></div>
		             </div>
		             <div class="pay-right">
		              <button class="btn btn-four">Pay Now</button>
		             </div>
		            </div> 
		           </div>

		           <!-- Input box for smaller screens only -->
		           <div class="input-container">
		             <label for="credit-input">Enter Credits:</label>
		             <input type="number" id="credit-input" min="0" max="501" placeholder="Enter number of credits" />
		           </div>
				   </form>

		           <!-- Centered Message Box for 501+ credits with red text color -->
		           <div id="message-box" class="message-box">
		             Above 500+ please contact our sales team at <strong>sales@ctaharbor.com</strong> or call: <strong>+1 (888) 203-2246</strong>
		           </div>

		           <!-- Flex container for side-by-side content boxes -->
		           <div class="content-container">
		             <!-- What You Get Box -->
		             <div id="content-box" class="content-box cont-box">
		               <h3>What You Get</h3>
		               <ul class="style-none mb-35">                     
		                <li>Intuitive BOIR Workflow</li>
		                <li>Effortless AI-powered BOIR Filing</li>
		                <li>Lifetime BOIR Filing Corrections/Updates  </li>
		                <li>Auto-Filled Data for Quick Corrections/Updates</li>
		                <li>Centralized BOIR Filing History</li>
		                <li>Certificate of BOIR Filing (issued by NYBACS)</li>
		                <li>Lifetime Compliance Notifications</li>
		               </ul>
		             </div>

		             <!-- Our Commitment Box -->
		             <div id="commitment-box" class="commitment-box cont-box">
		               <h3>Our Commitment</h3>
		               <h4>Your Plan, Your Way:</h4>
		               <p>Choose the report filing frequency as you need, with an option to scale your plan at any time.</p>
		               <h4>More Value as You Grow:</h4>
		               <p>As you grow, your compliance needs evolve. Choose from more advanced filing plans tailored to meet your needs at higher tiers.</p>
		             </div>
		           </div>
		         </div>

		         </div>
		         
      </div>
      <div class="block-feature-five hm-icon-grid-sec light-bg position-relative md-mt-50 pt-120 lg-pt-80 pb-150 lg-pb-80">
         <div class="container">
            <div class="position-relative">
               <div class="row">
                  <div class="col-lg-8 wow fadeInLeft">
                     <div class="title-one mb-50 lg-mb-30 md-mb-10">
                        <h2>Why Most Businesses Choose CTAHarbor</h2>
                     </div>
                     <!-- /.title-one -->
                  </div>
               </div>
               <div class="row">
                  <div class="col-xl-3 col-md-6 d-flex wow fadeInUp">
                     <div class="card-style-seven text-center vstack tran3s w-100 mt-30">
                        <div class="icon tran3s rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="images/lazy.svg" data-src="images/icon/Filing_Made_Easy_cta.svg" alt="" class="lazy-img"></div>
                        <h4 class="fw-bold">Filing Made Easy</h4>
                        <p class="mb-60 md-mb-40">We simplify the BOIR, so you can focus on what matters most - Your Business.</p>
                     </div>
                     <!-- /.card-style-seven -->
                  </div>
                  <div class="col-xl-3 col-md-6 d-flex wow fadeInUp" data-wow-delay="0.1s">
                     <div class="card-style-seven text-center vstack tran3s w-100 mt-30">
                        <div class="icon tran3s rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="images/lazy.svg" data-src="images/icon/record.svg" alt="" class="lazy-img"></div>
                        <h4 class="fw-bold">Centralized BOIR Records</h4>
                        <p class="mb-60 md-mb-40">Manage and track BOIR-related activities for multiple entities in a centralized dashboard.</p>
                     </div>
                     <!-- /.card-style-seven -->
                  </div>
                  <div class="col-xl-3 col-md-6 d-flex wow fadeInUp" data-wow-delay="0.2s">
                     <div class="card-style-seven text-center vstack tran3s w-100 mt-30">
                        <div class="icon tran3s rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="images/lazy.svg" data-src="images/icon/Reduced_Errors_cta.svg" alt="" class="lazy-img"></div>
                        <h4 class="fw-bold">Avoid Costly Mistakes</h4>
                        <p class="mb-60 md-mb-40" style="margin-bottom: 33px;">We take the guesswork out of BOIR filing, so you can rest assured knowing you're protected from penalties.</p>
                     </div>
                     <!-- /.card-style-seven -->
                  </div>
                  <div class="col-xl-3 col-md-6 d-flex wow fadeInUp" data-wow-delay="0.3s">
                     <div class="card-style-seven text-center vstack tran3s w-100 mt-30">
                        <div class="icon tran3s rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="images/lazy.svg" data-src="images/icon/update.svg" alt="" class="lazy-img"></div>
                        <h4 class="fw-bold">Lifetime BOIR Updates</h4>
                        <p class="mb-60 md-mb-40">Correct or update your BOIR filing anytime at no additional <br>cost.</p>
                     </div>
                     <!-- /.card-style-seven -->
                  </div>
               </div>
            </div>
         </div>
         <img src="images/lazy.svg" data-src="images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_01">
      </div>
      <!-- /.block-feature-five -->
      <!--FAQ's Start-->
      <div class="faq-section-one mt-100 lg-mt-80">
         <div class="container">
            <div class="row">
               <div class="col-lg-5 wow fadeInLeft" style="visibility: visible; animation-name: fadeInLeft">
                  <div class="title-one mb-40 lg-mb-20">
                     <h2>BOIR 101: <br> The Essentials</h2>
                  <!-- /.title-one -->
				  <p class="text-lg mb-40 lg-mb-20 mt-30">Key Definitions
				                       <br> and Frequently Asked Questions
				                    </p>
                  <a href="contactus" class="btn-four">Contact us</a>
               </div>
			   </div>
               <div class="col-lg-7">
                  <div class="accordion accordion-style-one mt-15 md-mt-50" id="accordionOne">
                     <c:forEach var="faqObject" items="${faqObjectList}">
                        <div class="accordion-item">
                           <h2 class="accordion-header">
							<c:set var="ReplacedAns" value="${fn:replace(faqObject.c_faq, 'A. ', '')}" />
                              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObject.c_collapse}" aria-expanded="false" aria-controls="${faqObject.c_collapse}">
                              ${ReplacedAns}
                              </button>
                           </h2>
                           <div id="${faqObject.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionOne">
                              <div class="accordion-body">
								<c:choose>
								    <c:when test="${fn:contains(faqObject.c_answer, 'https://www.federalregister.gov')}">
								        <c:set var="processedContent">
								            ${fn:replace(faqObject.c_answer, 'https://www.federalregister.gov/documents/2024/01/08/2024-00109/indian-entities-recognized-by-and-eligible-to-receive-services-from-the-united-states-bureau-of', 
								            '<a href="https://www.federalregister.gov/documents/2024/01/08/2024-00109/indian-entities-recognized-by-and-eligible-to-receive-services-from-the-united-states-bureau-of" target="_blank">
								                https://www.federalregister.gov/documents/2024/01/08/2024-00109/indian-entities-recognized-by-and-eligible-to-receive-services-from-the-united-states-bureau-of
								            </a>')}
								        </c:set>
								    </c:when>
								    <c:otherwise>
								        <c:set var="processedContent">
								            ${fn:replace(faqObject.c_answer, 'www.fincen.gov/boi', '<a href="https://www.fincen.gov/boi" target="_blank">www.fincen.gov/boi</a>')}
								        </c:set>
								    </c:otherwise>
								</c:choose>
                                 <p>${processedContent}</p>
                              </div>
                           </div>
                        </div>
                     </c:forEach>
                  </div>
               </div>
            </div>
         </div>
      </div>
	  
	  
	  <!---Trusted Firms Banner-->
	  <section class="logo-scroll-sec mt-100">
	  		     <div class="container">
	  		         <div class="title-one text-center">
	  		             <h2>Trusted by Leading Firms</h2>
	  		         </div>
	  		         <div class="partner-slider-one">
	  		             <c:forEach var="partner" items="${partnersObjectList}">
	  		                 <div class="item">
	  		                     <img src="${partner['c_trusted_firms']}" alt="">
	  		                 </div>
	  		             </c:forEach>
	  		         </div>
	  		     </div>
	  		 </section>
      
      <div class="feedback-section-two position-relative mt-150 lg-mt-80">
         <div class="container">
            <div class="position-relative">
               <div class="row">
                  <div class="col-lg-8 m-auto">
                     <div class="title-one text-center mb-80 lg-mb-40 wow fadeInUp">
                        <h2>Don’t Just Take Our Word For It...</h2>
                     </div>
                     <!-- /.title-one -->
                  </div>
               </div>
            </div>
         </div>
         <div class="slider-wrapper">
            <div class="feedback-slider-two">
               <c:forEach var="testimonialObject" items="${testimonialObjectList}">
                  <div class="item">
                     <div class="feedback-block-two tran3s">
                        <div class="d-flex align-items-center">
                           <img src="<c:out value='${testimonialObject.c_icon_image}' />" alt="" class="avatar rounded-circle">
                           <div class="ps-3">
                              <div class="name fw-bold">${testimonialObject.c_name}</div>
                              <p class="m0">${testimonialObject.c_country}</p>
                           </div>
                        </div>
                        <blockquote class="text-lg">${testimonialObject.c_description}</blockquote>
                        <div class="bottom-line d-flex align-items-center justify-content-between">
                           <ul class="style-none d-flex rating">
                              <li><img src="images/star.png" alt="" class="">
                              </li>
                              <li><img src="images/star.png" alt="" class="">
                              </li>
                              <li><img src="images/star.png" alt="" class="">
                              </li>
                              <li><img src="images/star.png" alt="" class="">
                              </li>
                              <li><img src="images/star.png" alt="" class="">
                              </li>
                              <li>${testimonialObject.c_rating}</li>
                           </ul>
                           <img src="images/icon/icon_28.svg" alt="" class="icon">
                        </div>
                     </div>
                     <!-- /.feedback-block-two -->
                  </div>
               </c:forEach>
            </div>
         </div>
         <!-- /.slider-wrapper -->
         <img src="images/lazy.svg" data-src="images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_01">
      </div>
      <div class="blog-section-two position-relative mt-150 pb-150 lg-pb-80">
         <div class="container">
            <div class="position-relative">
               <div class="title-one mb-30 lg-mb-10">
                  <h2>Blogs</h2>
               </div>
               <!-- /.title-one -->
               <div class="row gx-xl-5">
                  <c:forEach var="blogObject" items="${blogObjectList}" begin="0" end="1">
                     <div class="col-md-6">
                        <article class="blog-meta-two mt-35 wow fadeInUp">
                           <figure class="post-img position-relative d-flex align-items-end m0" style="background-image: url('<c:out value='${blogObject.c_image_url}' />');">
                              <a href="blogdetails/${blogObject.id}" class="stretched-link date tran3s">${blogObject.c_blog_date}</a>
                           </figure>
                           <div class="post-data">
                              <div class="d-flex justify-content-between align-items-sm-center flex-wrap">
                                 <a href="blogdetails/${blogObject.id}" class="blog-title">
                                    <h4>${blogObject.c_title}</h4>
                                 </a>
                                 <a href="blogdetails/${blogObject.id}" class="round-btn rounded-circle d-flex align-items-center justify-content-center tran3s"><i class="bi bi-arrow-up-right"></i></a>
                              </div>
                              <div class="post-info">${blogObject.c_metadata_line}</div>
                           </div>
                        </article>
                        <!-- /.blog-meta-two -->
                     </div>
                  </c:forEach>
               </div>
               <div class="section-btn sm-mt-60">
                  <a href="blog" class="btn-seven d-inline-flex align-items-center">
                     <span class="text">See all blogs</span>
                     <div class="icon tran3s rounded-circle d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/icon_27.svg" alt="" class="lazy-img"></div>
                  </a>
               </div>
            </div>
         </div>
         <img src="images/lazy.svg" data-src="images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_01">
      </div>
	  
	  
	  <!---Featured on banners-->
	  <section class="logo-scroll-sec">
	  	  		     <div class="container">
	  	  		         <div class="title-one text-center">
	  	  		             <h2>As Featured On</h2>
	  	  		         </div>
	  	  		         <div class="partner-slider-one">
	  	  		             <c:forEach var="partner" items="${partnersObjectList}">
	  	  		                 <div class="item">
	  	  		                     <img src="${partner['c_featured']}" alt="">
	  	  		                 </div>
	  	  		             </c:forEach>
	  	  		         </div>
	  	  		     </div>
	  	  		 </section>
	        
      <!-- /.fancy-banner-three -->
      <div class="fancy-banner-three position-relative wow fadeInUp">
         <div class="container">
            <div class="contact-banner position-relative">
               <div class="row align-items-center">
                  <div class="col-lg-8">
                     <h2 class="text-white">Need help? <br>Let’s Talk!</h2>
                     <p class="text-lg m0 text-white opacity-75">If you have anything in mind, we’re here to support you.</p>
                  </div>
                  <div class="col-lg-6 text-center text-lg-end">
                     <a href="/contactus" class="btn-four red-btn">Get in touch</a>
                  </div>
               </div>
            </div>
         </div>
         <!-- </div> -->
      </div>

	  <div id="cookie-banner" class="cookie-banner">
	      <p class="para">We use cookies to enhance your experience. By continuing to visit this site you agree to our use of cookies. <a class="para1" href="/cookie" style="color: red;">Cookie Policy</a></p>
		  <div class="cookie-bannerflex">
	      <button class="bg-btn red-btn" id="accept-cookies">Accept</button>
	      <button class="bg-btn red-btn" id="reject-cookies">Reject</button>
		  </div>
	  </div>
	   

      <!-- Include Footer -->
      <%@ include file="/WEB-INF/views/footer.jsp" %>
      <!--footer end-->
      <!---Include Model-->
      <%@ include file="/WEB-INF/views/log-reg.jsp" %>
	  <%@ include file="/WEB-INF/views/right-click.jsp" %>
	  
      <button class="scroll-top">
      <i class="bi bi-arrow-up-short"></i>
      </button>
	  <%@ include file="/WEB-INF/views/js.jsp" %>
      <script src="js/authValidator.js"></script>
	  
	  
	  <script>
	  		$(document).ready(function () {
	            const slider = document.getElementById('pricing-slider');
	            const messageBox = $('#message-box');
	            const displayBox = $('#display-box');
	            const fileSelectSec = $('#file-select-sec');
	            const sliderValue = $('#slider-value');
				const sliderValueDuplicate = $('#slider-value-duplicate');
	            const calculatedPrice = $('#calculated-price');
	            const individualTab = $('#individual-tab');
	            const professionalTab = $('#professional-tab');
				const noFilesInput = $('#nofiles');
	  			const planid =$('#planId');
				const entityLable=$('#entityLable');
				const entitiesLable=$('#entitiesLable');
	            // Initialize noUiSlider
	            noUiSlider.create(slider, {
	              start: 1,
	              connect: [true, false],
	              range: {
	                'min': 1,
	                'max': 500
	              },
	              step: 1,
	              pips: {
	                mode: 'values',
	                values: [1, 100, 200, 300, 400, 500],
	                density: 4
	              }
	            });
	  
	            function updateDisplay(value) {
	              let pricePerCredit;
	  
	              if (value === 0) {
	                displayBox.hide();
	                messageBox.hide();
	                fileSelectSec.hide();
	                return;
	              } else if (value === 1) {
					entityLable.show();
					entitiesLable.hide();
	                pricePerCredit = 149;
					planid.val('f8c42e56-3a41-4782-955c-53055f70d037');
	                highlightTab(individualTab);
	              } else if (value >= 2 && value <= 5) {
					entityLable.hide();
					entitiesLable.show();
	                pricePerCredit = 139;
					planid.val('355ea4df-e5a5-4cf7-96cb-de278dccf9df');
	                highlightTab(individualTab);
	              } else if (value >= 6 && value <= 10) {
					entityLable.hide();
					entitiesLable.show();
	                pricePerCredit = 129;
					planid.val('b44ad651-6d2c-41d0-a15d-0178e14d8db1');
	                highlightTab(individualTab);
	              } else if (value >= 11 && value <= 25) {
					entityLable.hide();
					entitiesLable.show();
	                pricePerCredit = 119;
					planid.val('35993971-1060-49ca-aa46-0698549ef54a');
	                highlightTab(professionalTab);
	              } else if (value >= 26 && value <= 499) {
					entityLable.hide();
					entitiesLable.show();
	                pricePerCredit = 109;
					planid.val('0b186242-b0cb-4b5c-9852-c71fb5922698');
	                highlightTab(professionalTab);
	              } else {
	                messageBox.show();
	                displayBox.hide();
	                fileSelectSec.hide();
	                return;
	              }
	  
	              sliderValue.text(value);
				  sliderValueDuplicate.text(value);
	              calculatedPrice.text(value * pricePerCredit);
	              displayBox.show();
	              fileSelectSec.show();
	              messageBox.hide();
				  
				  
				  // Update the nofiles input with the current value
				  noFilesInput.val(value);

	            }
	  
	            // Update slider based on input field for mobile
	            $('#credit-input').on('input', function () {
	              const value = parseInt($(this).val());
	              if (!isNaN(value)) {
	                updateDisplay(value);
	                slider.noUiSlider.set(value); // Ensure slider pointer updates
	              }
	            });
	  
	            // Update display when slider moves
	            slider.noUiSlider.on('update', function (values, handle) {
	              const value = Math.round(values[handle]);
	              updateDisplay(value);
	            });
	  
	            // Tab highlighting based on selected value
	            function highlightTab(tab) {
	              $('.tab').removeClass('active');
	              tab.addClass('active');
	            }
	          });
	  	  	        </script>
	  	  	  
	  	  
	  
	  <!--Regiseration success and failure message-->
	  <script>
	  	 $(document).ready(function() {
	  	  // Trigger the modal if there's a message
	  	  if (typeof message !== 'undefined' && message.length > 0) {
	  		$('#modal-message').text(message);
	  	    $('#registerModal').modal('show');
			// Dynamic <h2> message based on the content of the message
		        var headerMessage = "Attention"; // Default header message
		        if (message === "There is already an account registered with this Email") {
		            headerMessage = "Attention"; // Change this if needed
		        } else if (message === "Your registration was successful. You’re all set—go ahead and log in to get started!") {
		            headerMessage = "Welcome Aboard!";
		        }
				// Update the <h2> in the modal with the dynamic message
				$('.modal-cont h2').text(headerMessage); // Adjust this selector based on your modal structure
				// Dynamically show the appropriate button based on the message
		        if (message === "Your registration was successful. You’re all set—go ahead and log in to get started!") {
					document.getElementById('proceedBtn').style.display="block";
		        } else {
					document.getElementById('regPopupOkBtn').style.display="block";
				}
	  	   }
	  	 });
		 
		 //  learn more popup
		 $(document).ready(function() {
		 	  $('#learnmorepopup').on('click', function(event) {
		 		//event.preventDefault(); // Prevent the default link behavior
		 		 	$('#learnmoreModal').modal('show'); // Show the modal manually
		 		});
		 });
		 		
		 //  compare more popup
		 $(document).ready(function() {
		 	$('#startnowpopup').on('click', function(event) {
		 		//event.preventDefault(); // Prevent the default link behavior
		 		 	$('#startnowModal').modal('show'); // Show the modal manually
		 	});
		 });
		 
		 //Compare popup endpoint (?compare=true) URL code
		 		 $(document).ready(function() {
		 		       if (window.location.search.indexOf('compare=true') !== -1) {
		 		           $('#startnowModal').modal('show');
		 		       }
		 		   });
				   
	   //exapmt entity popup (?exampt entity = true) URL code)	   
	         $(document).ready(function() {
	                  if (window.location.search.indexOf('exemptchecker=true') !== -1) {
	                     $('#exemptcheckerModal').modal('show');
	                  }
	            });
				   
		 $(document).ready(function() {
		     // Trigger modal when the Exempt Checker button is clicked
		     $('#exemptCheckerButton').click(function() {
		         $('#startnowModal').modal('show');
		     });

		     // Close modal when the close button inside modal is clicked
		     $('#closeModalBtn, .btn-close').click(function() {
		         $('#startnowModal').modal('hide');
		     });
		 });

	  </script>
			  
      <!----Drop down script-->
      <script>
        /*  Old Payment script
		$(document).ready(function() {
             var filePrice1 = 119; // Price per file for 10-25 files
             var filePriceA = 149; // Price per file for exactly 1 file
         
             // Function to animate numbers
             function animateNumber(element, start, end, duration) {
                 var range = end - start;
                 var minTimer = 50;
                 var stepTime = Math.abs(Math.floor(duration / range));
                 stepTime = Math.max(stepTime, minTimer);
                 var startTime = new Date().getTime();
                 var endTime = startTime + duration;
                 var timer;
         
                 function run() {
                     var now = new Date().getTime();
                     var remaining = Math.max((endTime - now) / duration, 0);
                     var value = Math.round(end - (remaining * range));
                     element.text(value);
                     if (value === end) {
                         clearInterval(timer);
                     }
                 }
         
                 timer = setInterval(run, stepTime);
                 run();
             }
         
             // Function to update the amount display for 10-25 files dropdown
             function updateAmountDisplay(selectedAmount) {
                 if (selectedAmount >= 10 && selectedAmount <= 25) {
                     var totalAmount = selectedAmount * filePrice1;
                     animateNumber($('#amountDisplay'), 0, totalAmount, 1000);
                 } else {
                     alert('Please select an amount between 10 and 25.');
                     $('#nofiles').val(''); // Reset the dropdown to default option
                     $('#amountDisplay').text('0');
                 }
             }
         
             // Function to update the amount display for 1 file dropdown
             function updateAmountDisplayA(selectedAmount) {
                 if (selectedAmount === 1) {
                     var totalAmount = selectedAmount * filePriceA;
                     animateNumber($('#amountDisplayA'), 0, totalAmount, 1000);
                 } else {
                     alert('Please select exactly 1 file.');
                     $('#nofilesA').val(1); // Reset the dropdown to default option
                     $('#amountDisplayA').text('0');
                 }
             }
         
             // Set default values and update displays on page load
             $('#nofiles').val(10);
             localStorage.setItem('nofiles', 10);
             updateAmountDisplay(10); // Update amount display for default value of 10-25 files
         
             $('#nofilesA').val(1);
             localStorage.setItem('nofilesA', 1);
             updateAmountDisplayA(1); // Update amount display for default value of 1 file
         
             // Event listener for 10-25 files dropdown change
             $('#nofiles').change(function() {
                 var selectedAmount = parseInt($(this).val());
                 if (selectedAmount >= 10 && selectedAmount <= 25) {
                     localStorage.setItem('nofiles', selectedAmount);
                     updateAmountDisplay(selectedAmount);
                 } else {
                     alert('Please select an amount between 10 and 25.');
                     $(this).val(10); // Reset the dropdown to default option
                     $('#amountDisplay').text('0');
                 }
             });
         
             // Event listener for 1 file dropdown change
             $('#nofilesA').change(function() {
                 var selectedAmount = parseInt($(this).val());
                 updateAmountDisplayA(selectedAmount);
             });
         
             // Prevent user from entering invalid values manually in 10-25 files dropdown
             $('#nofiles').on('input', function() {
                 var selectedAmount = $(this).val();
                 if (selectedAmount < 10 || selectedAmount > 25) {
                     alert('Invalid amount. Please select a valid amount between 10 and 25.');
                     $(this).val(''); // Reset the dropdown to default option
                     $('#amountDisplay').text('0');
                 }
             });
         
             // Prevent user from entering invalid values manually in 1 file dropdown
             $('#nofilesA').on('input', function() {
                 var selectedAmount = $(this).val();
                 if (selectedAmount !== '1') {
                     alert('Invalid amount. Please select exactly 1 file.');
                     $(this).val(''); // Reset the dropdown to default option
                     $('#amountDisplayA').text('0');
                 }
             });
         
             // Validate if the user tries to change the value using browser developer tools
             $('#paymentForm').submit(function(event) {
                 var selectedAmount = parseInt($('#nofiles').val());
                 if (selectedAmount < 10 || selectedAmount > 25) {
                     alert('Invalid amount. Please select a valid amount between 10 and 25.');
                     event.preventDefault();
                 }
                 var selectedAmountA = parseInt($('#nofilesA').val());
                 if (selectedAmountA !== 1) {
                     alert('Invalid amount. Please select exactly 1 file.');
                     event.preventDefault();
                 }
             });
         });
		 */
	//datepicker code
	$(document).ready(function() {
	    // Initialize the Datepicker
	    $("#incorporationDate").datepicker({
	        dateFormat: "mm-dd-yy",
	        maxDate: 0,
	        onSelect: function(dateText) {
	            $(this).val(dateText); // Set the input value when a date is selected
	        }
	    });

	    // Handle the submit button click
	    $("#datesubmit").click(function() {
	        const dateText = $("#incorporationDate").val();
	        const messageElement = $("#message");

	        if (dateText) {
	            // Parse the selected date
	            const selectedDate = $.datepicker.parseDate("mm-dd-yy", dateText);
	            const januaryFirst2024 = new Date(2024, 0, 1); // January 1, 2024
	            const januaryFirst2025 = new Date(2025, 0, 1); // January 1, 2025
	            const ninetyDays = 90 * 24 * 60 * 60 * 1000; // 90 days in milliseconds
	            const thirtyDays = 30 * 24 * 60 * 60 * 1000; // 30 days in milliseconds
	            let dueDate;
	            let formattedDueDate;

	            if (selectedDate >= januaryFirst2024 && selectedDate < januaryFirst2025) {
	                // If date is in 2024, add 90 days
	                dueDate = new Date(selectedDate.getTime() + ninetyDays);
	                formattedDueDate = $.datepicker.formatDate("mm-dd-yy", dueDate);
	                messageElement.text("Your due date for the BOIR Filing is " + formattedDueDate + ".").show();
	            } else if (selectedDate < januaryFirst2024) {
	                // Before January 1, 2024
	                messageElement.text("Please File BOIR Before January 01, 2025.").show();
	            } else if (selectedDate >= januaryFirst2025) {
	                // If the selected date is in 2025 or later, add 30 days
	                dueDate = new Date(selectedDate.getTime() + thirtyDays);
	                formattedDueDate = $.datepicker.formatDate("mm-dd-yy", dueDate);
	                messageElement.text("Your due date for the BOIR Filing is " + formattedDueDate + ".").show();
	            }
	        } else {
	            // Update and show the message if no date is selected
	            messageElement.text("Please select a date.").show();
	        }
	    });
	});
      </script>


	  <script>
	      document.addEventListener("DOMContentLoaded", function() {
	          var cookieBanner = document.getElementById('cookie-banner');
	          var acceptButton = document.getElementById('accept-cookies');
	          var rejectButton = document.getElementById('reject-cookies');

	          // Check if the user has already accepted or rejected cookies
	          if (localStorage.getItem('cookiesAccepted') === 'true') {
	              cookieBanner.style.display = 'none';
	          } else if (localStorage.getItem('cookiesRejected') === 'true') {
	              cookieBanner.style.display = 'none';
	              // Additional actions can be taken here to disable non-essential cookies
	          } else {
	              cookieBanner.style.display = 'block';
	          }

	          // Handle acceptance
	          acceptButton.addEventListener('click', function() {
	              localStorage.setItem('cookiesAccepted', 'true');
	              cookieBanner.style.display = 'none';
	          });

	          // Handle rejection
	          rejectButton.addEventListener('click', function() {
	              localStorage.setItem('cookiesRejected', 'true');
	              cookieBanner.style.display = 'none';
	              // Additional actions can be taken here to disable non-essential cookies
	          });
	      });
		  
		      // Attach a click event handler to the element with the ID "foreignvehicleok"
		      function enablecookie() {
		          // Your custom logic here
				  // Create a cookie named "firstTimeVisitor" with the value "true"
				  	 
											document.cookie = "firstTimeVisitor=true; path=/; max-age=" + 60*60*24*365; // Cookie valid for 1 year
											$('#notice').hide();
											       // Redirect to the "Learn More" page
											    //   window.location.href = "/home";
		          // Example: Perform some action
		          // You can add your custom code here
		     }
		  
		  
		  
		  
	  </script>

      </div>
      <!-- /.main-page-wrapper -->
   </body>
</html>