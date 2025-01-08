<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
   <head>
      
      <title>Refund</title>
      
      <style>
         .step {
         display: none;
         }
         .step.active {
         display: block;
         }
         body {
         padding: 0 20px;
         }
         h3, h5, p {
         font-family: 'Satoshi', sans-serif;
         }
         h3 {
         font-weight: bold;
         text-decoration: underline;
         text-align: center;
         }
         h5 {
         font-weight: bold;
         }
         p {
         margin-left: 20px;
         margin-right: 20px;
         }
      </style>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <%@ include file="/WEB-INF/views/css.jsp" %>
	  <%@ include file="/WEB-INF/views/header-login.jsp" %>
	  <%@ include file="/WEB-INF/views/js.jsp" %>
   </head>
   <body>
      <div>
		<br>
		<br>
         <br>
         <br>
         <br>
         <h3>CTAHarbor Refund Policy</h3>
		 <p><strong>Effective Date: 08/20/2024</strong></p>
		         <p>At CTAHarbor, customer satisfaction is our priority. If you are not entirely satisfied with your purchase, we’re here to help.</p>
		         <p>This refund policy outlines the circumstances under which a refund may be issued for services provided by CTAHarbor related to the filing of Beneficial Ownership Information Reports (BOIR) on behalf of our clients.</p>
		         <br>
		         <h5>1. Refund Eligibility</h5>
		         <ul>
		             <li><strong>Service Non-Delivery:</strong> If CTAHarbor fails to file the BOIR with the Financial Crimes Enforcement Network (FinCEN) as agreed, a full refund will be provided.</li>
		             <li><strong>Incorrect Filing:</strong> If the BOIR is filed incorrectly due to an error on the part of CTAHarbor, we will either:
		                 <ul>
		                     <li>Correct the filing at no additional cost, or</li>
		                     <li>Issue a full refund if the error cannot be rectified.</li>
		                 </ul>
		             </li>
		             <li><strong>Cancellation by Client:</strong> Refunds for cancellations initiated by the client are subject to the following conditions:
		                 <ul>
		                     <li>A full refund will be provided if the cancellation is requested before CTAHarbor has commenced the filing process.</li>
		                     <li>A partial refund may be issued if the filing process has begun, but the report has not yet been submitted to FinCEN. The refund amount will be determined based on the work completed.</li>
		                     <li>No refund will be issued if the report has already been submitted to FinCEN.</li>
		                 </ul>
		             </li>
		         </ul>
		         <br>
		         <h5>2. Non-Refundable Services</h5>
		         <ul>
		             <li><strong>Government Fees:</strong> Any government fees paid to FinCEN or other regulatory bodies are non-refundable.</li>
		             <li><strong>Consultation Fees:</strong> Fees for consultation or advisory services provided prior to the filing process are non-refundable.</li>
		             <li><strong>Late Filings and Penalties:</strong> If the filing is delayed due to client action or inaction, and penalties are incurred, those penalties are non-refundable.</li>
		         </ul>
				 <br>
		         <h5>3. Refund Request Process</h5>
		         <ul>
		             <li><strong>How to Request a Refund:</strong> Clients must submit a refund request in writing to CTAHarbor at <a href="mailto:service@ctaharbor.com">service@ctaharbor.com</a> within 30 days of the filing date.</li>
		             <li><strong>Processing Time:</strong> Refund requests will be reviewed and processed within 10 business days. Approved refunds will be issued via the original payment method.</li>
		         </ul>
				 <br>
		         <h5>4. Exceptions</h5>
		         <ul>
		             <li><strong>Force Majeure:</strong> No refunds will be issued for delays or failures in filing caused by events beyond the control of CTAHarbor, such as natural disasters, government actions, or technical failures.</li>
		             <li><strong>Client Misrepresentation:</strong> If the client provides incorrect or misleading information that affects the filing, CTAHarbor reserves the right to deny a refund.</li>
		         </ul>
				 <br>
		         <h5>5. Changes to This Policy</h5>
		         <p>CTAHarbor reserves the right to modify this refund policy at any time. Any changes will be communicated to clients and will apply to future transactions.</p>
		         
		         <div class="contact-info">
		             <p>For any questions or concerns regarding this refund policy, please contact us at <a href="mailto:service@ctaharbor.com">service@ctaharbor.com</a> or <a href="tel:+1 (888) 203-2246">+1 (888) 203-2246</a></p>
		             <p><strong>Updates:</strong> We reserve the right to update this refund policy at any time. Please review this policy periodically for changes.</p>
		         </div>
				 <br>
		     </div>
      <!-- Include Footer -->
      <%@ include file="/WEB-INF/views/footer.jsp" %>
	  <%@ include file="/WEB-INF/views/right-click.jsp" %>
   </body>
</html>