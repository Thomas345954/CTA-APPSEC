<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <!----External styles-->
      <%@ include file="/WEB-INF/views/css.jsp" %>
      <title>CTAHarbor | Receipt</title>
      <style>
         body {
         font-family: Arial, sans-serif;
         color: #235789;
         margin: 0;
         padding: 0;
         background-color: #f5f5f5;
         box-sizing: border-box;
         display: flex;
         flex-direction: column; /* Ensure the header and main content stack vertically */
         min-height: 100vh; /* Ensure body takes at least the full height of the viewport */
         }
         header {
         width: 100%;
         background-color: #fff; /* Adjust background color if needed */
         box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Add shadow to header for visual separation */
         z-index: 1000; /* Ensure header is above other content */
         }
         .receipt-container {
         padding: 20px;
         max-width: 700px;
         width: 100%;
         box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
         background-color: #fff;
         box-sizing: border-box;
         margin: 20px auto; /* Center align and add margin for spacing */
         overflow-x: auto;
         }
         .header {
         display: flex;
         justify-content: space-between;
         align-items: center;
         flex-wrap: wrap;
         }
         .header img {
         max-height: 25px;
         margin-top: 0;
         }
         .step {
         display: none;
         }
         .step.active {
         display: block;
         }
         .details, .contact-info {
         margin: 20px 0;
         }
         .details div, .contact-info div {
         margin: 5px 0;
         }
         .paid-amount {
         font-size: 30px;
         font-weight: bold;
         margin: 20px 0;
         color: #005FAA;
         text-align: center;
         }
         .table {
         width: 100%;
         border-collapse: collapse;
         table-layout: auto;
         }
         .table th, .table td {
         border-bottom: 1px solid #235789;
         padding: 10px;
         text-align: left;
         box-sizing: border-box;
         }
         .table th {
         background-color: #f0f0f0;
         }
         .total {
         font-weight: bold;
         }
         @media (max-width: 600px) {
         .receipt-container {
         padding: 15px;
         }
         .header {
         flex-direction: column;
         align-items: flex-start;
         }
         .header img {
         margin-top: 10px;
         }
         .paid-amount {
         font-size: 20px;
         margin: 15px 0;
         }
         .table th, .table td {
         padding: 8px;
         font-size: 14px;
         }
         }
         @media (max-width: 400px) {
         .paid-amount {
         font-size: 18px;
         margin: 10px 0;
         text-align: center;
         }
         .table th, .table td {
         padding: 6px;
         font-size: 12px;
         }
         .details div, .contact-info div {
         font-size: 14px;
         }
         .details {
         text-align: center;
         }
         .contact-info {
         text-align: center;
         }
         }
      </style>
   <body>
      <!-- Include External Header -->
      <%@ include file="/WEB-INF/views/header-login.jsp" %>
      <br>
      <br>
      <br>
      <br>
      <br>
      <!-- Ensure the path is correct -->
         <div class="receipt-container">
            <div class="header">
               <h3>Receipt</h3>
               <img class="logo" src="https://micassets.micnxt.com/CTA/CTA-logo.png" alt="CTAHarbor Logo">
            </div>
            <div class="header">
               <div>
                  <div class="details">
                     <div>Invoice number: <strong>${sessionId}</strong></div>
                     <div>Date paid: <strong><fmt:formatDate value="${created_date}" pattern="MM/dd/YYYY HH:mm:ss"/></strong></div>
                     <div>Payment method: <strong>${paymentMethod}</strong></div>
                  </div>
               </div>
            </div>
            <div class="header">
               <div class="paid-amount">Amount Paid $${amountTotal}</div>
               <div class="contact-info">
                  <div>CTAHarbor</div>
                  <div><a href="tel:+1 (888) 203-2246">+1 (888) 203-2246</a></div>
                  <div><a href="mailto:support@ctaharbor.com" style="color: #235789; text-decoration: none;">support@ctaharbor.com</a></div>
               </div>
            </div>
            <table class="table">
               <thead>
                  <tr>
                     <th>Description</th>
                     <th>Qty</th>
                     <th>Unit Price</th>
                     <th>Amount</th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <td>
                        <c:if test="${pricingname == 'A'}">
                           Individual
                        </c:if>
                        <c:if test="${pricingname == 'B'}">
                           Professional
                        </c:if>
						
                     </td>
                     <td>${Quantity}</td>
                     <td>$${costPerfile}</td>
                     <td>$${amountTotal}</td>
                  </tr>
                  <tr>
                     <td colspan="3" class="total">Amount</td>
                     <td>$${amountTotal}</td>
                  </tr>
               </tbody>
            </table>
         </div>
      <c:if test="${canfile == 'true'}">
         <div>
            <button class="btn-four receipt-container" id=""><a href="/boirfiling">File BOIR</a></button >
         </div>
      </c:if>
      <c:if test="${canfile == 'false'}">
         <div>
            <button class="btn-four receipt-container" id=""><a href="/pricing">Pay and File BOIR</a></button >
         </div>
      </c:if>
      <br>
      <!-- Include External Footer -->
      <%@ include file="/WEB-INF/views/footer.jsp" %>
      <!--footer end-->
      <!--external Java script-->
      <%@ include file="/WEB-INF/views/js.jsp" %>
	  <%@ include file="/WEB-INF/views/right-click.jsp" %>

	
   </body>
</html>