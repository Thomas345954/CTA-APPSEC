<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!--External Styles-->
<%@ include file="/WEB-INF/views/css.jsp"%>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css"
	rel="stylesheet">
<title>CTAHarbor</title>

</head>
<body>

	<!--<div id="loader" class="loading"></div>-->
	<div class="main-page-wrapper">
		<%@ include file="/WEB-INF/views/loader.jsp"%>
		<%@ include file="/WEB-INF/views/right-click.jsp"%>
		<!--step4-->
		

		<!--popup for 3rd form Existing reporting company -->
		<div class="modal fade" id="existingrepotModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-fullscreen modal-dialog-centered">
				<div class="container">
					<div class="user-data-form step-form-modal modal-content">
						<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
						<div class="modal-cont">
							<h2 style="font-size: 30px;">Link Expired</h2>
							<p>The link you have clicked has expired. For security reasons, this link is only valid for a limited time. If you need assistance please contact our support team at <a href="mailto:support@ctaharbor.com">support@ctaharbor.com</a> or visit our website <a href="https://www.ctaharbor.com">www.ctaharbor.com</a> for further instructions.</p>
							<p>Thank you for your understanding.</p><br>
							<a href="/home" id="" class="btn-four" style=" border-radius: 0px;margin: 20px;">Close</a>	
						</div>
					</div>
				</div>
			</div>
		</div>
		
</body>
<!-- Include Footer -->
<!--footer end-->
<button class="scroll-top">
	<i class="bi bi-arrow-up-short"></i>
</button>
<!-- Custom Jquery for validation links -->
<script src="vendor/jquery.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/additional-methods.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
   <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script> -->
<!-- Bootstrap JS -->
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- WOW js -->
<script src="vendor/wow/wow.min.js"></script>
<!-- Slick Slider -->
<script src="vendor/slick/slick.min.js"></script>
<!-- Fancybox -->
<script src="vendor/fancybox/dist/jquery.fancybox.min.js"></script>
<!-- Lazy -->
<script src="vendor/jquery.lazy.min.js"></script>
<!-- js Counter -->
<script src="vendor/jquery.counterup.min.js"></script>
<script src="vendor/jquery.waypoints.min.js"></script>
<!-- validator js -->
<script src="vendor/validator.js"></script>
<!-- Theme js -->
<script src="js/theme.js"></script>
</div>

<script src="js/stepform.js"></script>
<script>
	$(document).ready(function(){
	    $('#existingrepotModal').modal('show');
	  });
	</script>
</body>
</html>