<!DOCTYPE html>
<html lang="en">
   <head>
	  <%@ include file="/WEB-INF/views/css.jsp" %>
      <title>Error404</title>
      
   </head>
   <body>
	    <!-- Include Header -->
		<%@ include file="/WEB-INF/views/header-login.jsp" %>
      <div class="main-page-wrapper">
         <!-- ===================================================
            Loading Transition
            ==================================================== -->
			<!-- Include loader -->
			<%@ include file="/WEB-INF/views/loader.jsp" %>
         <!-- 
            =============================================
            		Theme Main Menu
            ============================================== 
            -->
	
         <!-- /.theme-main-menu -->
         <div class="error-page text-center d-flex align-items-center justify-content-center flex-column light-bg position-relative">
            <h1 class="font-magnita">404</h1>
            <h2 class="fw-bold">Page Not Found</h2>
            <p class="text-lg mb-45">Publishing industries for previewing layouts & visual mockups used.</p>
            <div><a href="home" class="btn-four">Go Back</a></div>
         </div>
         <!-- /.error-page -->
		 <!---Include Model-->
		 <%@ include file="/WEB-INF/views/log-reg.jsp" %>
         <button class="scroll-top">
         <i class="bi bi-arrow-up-short"></i>
         </button>
         <!-- External JavaScript _____________________________  -->
		 <%@ include file="/WEB-INF/views/js.jsp" %>
      </div>
      <!-- /.main-page-wrapper -->
   </body>
</html>