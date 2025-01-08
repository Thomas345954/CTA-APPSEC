<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <!----External styles-->
      <%@ include file="/WEB-INF/views/css.jsp" %>
      <title>CTAHarbor | Pricing</title>
   </head>
   <body>   <style>
   					*:focus {
   					    outline: none;
   					}
					
   				</style>
      <!-- Include External Header -->
      <div class="main-page-wrapper">
		
		<form action="${paymenthistory.nofiles == null ? '/loadcharge' : '/loadcharge'}" method="post">
 			<input type="hidden" name="plan_id" id="planId" value="" />
 			<input type="hidden" name="id"  />
 			<input type="hidden" name="nofiles" id="nofiles" value="1"/>
			
         <!-- Pricing Start -->
        <div class="price-sec price-sec-dashboard">

         <div class="container">
            <h2 class="title-sec">Pricing</h2>
           <div class="tabs-slider-sec">
           <!-- Tabs for Individual and Professional plans -->
           <div class="tabs">
             <div id="individual-tab" class="tab">Individual</div>
             <div id="professional-tab" class="tab">Professional</div>
           </div>
 
           <div class="file-select-sec" id="file-select-sec">
			<h3 id="entityLable">I need to file the BOI Report for <span id="slider-value">50</span> entity</h3>
			<h3 id="entitiesLable">I need to file the BOI Report for <span id="slider-value-duplicate">50</span> entities</h3>	
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
         
         <!-- /.pricing-section -->
         
		 <!---Include Model-->
		 <%@ include file="/WEB-INF/views/log-reg.jsp" %>
		 <%@ include file="/WEB-INF/views/right-click.jsp" %>
         <button class="scroll-top">
         <i class="bi bi-arrow-up-short"></i>
         </button>
         <!-- Optional JavaScript _____________________________  -->
         <%@ include file="/WEB-INF/views/js.jsp" %>
		 
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
	   	  

      </div>
      <!-- /.main-page-wrapper -->
   </body>
</html>