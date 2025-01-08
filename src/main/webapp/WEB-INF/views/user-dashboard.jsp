<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.Date" %>



<!DOCTYPE html>
<html lang="en">

<head>
	<%@ include file="/WEB-INF/views/css.jsp" %>
	<title>CTAHarbor | User Dashboard</title>
	
</head>

<body>
	
	<div class="ud-form-top row">
		<jsp:useBean id="currentDate" class="java.util.Date" />
		        
			   	   	<aside class="col-lg-3 col-md-4 udf-top-left"><h3>Dashboard</h3></aside>
			   	   	<aside class="col-lg-9 col-md-8 udf-top-right"><span>Last Accessed <fmt:formatDate value="${currentDate}" pattern="MM-dd-yyy HH:mm:ss"/></span></aside>
			   	   </div>
			   	   <div class="ud-stats row">
			   	   	<aside class="col-md-4 ">
					  <div class="uds-in">
			   	   	 <h4>BOI Reports Purchased</h4>
			   	   	 <p>${totalFiles}</p>
					 </div>
			   	   	</aside>
			   	   	<aside class="col-md-4">
					  <div class="uds-in">	
			   	   	 <h4>BOI Reports <br>Used</h4>
			   	   	 <p>${filesFilled}</p>
					</div>
			   	   	</aside>
			   	   	<aside class="col-md-4">
					<div class="uds-in">
			   	   	 <h4>BOI Reports Available</h4>
			   	   	 <p>${Pending}</p>
					 </div>
			   	   	</aside>
			   	   </div>
		 
		


		<%@ include file="/WEB-INF/views/right-click.jsp" %>
		<%@ include file="/WEB-INF/views/js.jsp" %>
		
	</div> <!-- /.main-page-wrapper -->
	<script>
			$( document ).ready(function() {
					   function validateEmail(email) {
					     var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
					     if (email) return emailReg.test(email);
					     return false;
					   }
	 
					   function sendLeadToFP(x){
					       var emailInput = x;
					           if (validateEmail(emailInput)) {
 					             fpr("referral", {
					               email: emailInput
					             });
 	 
					           }
					      
					      
					   }
					   
	                   sendLeadToFP('${principalName}');				   
	        });	   
					   </script>
</body>

</html>