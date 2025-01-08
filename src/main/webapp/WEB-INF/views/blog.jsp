<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%@ include file="/WEB-INF/views/css.jsp" %>
      <title>CTAHarbor | Blog</title>
   </head>
   <body>
      <!-- Include External Header -->
      <%@ include file="/WEB-INF/views/header-login.jsp" %>
      <div class="main-page-wrapper">
	    <%@ include file="/WEB-INF/views/loader.jsp" %>
			<!--	Popup for successfull comment post	-->
			<div class="foreignvehicle-modal modal fade" id="successModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-fullscreen modal-dialog-centered">
										<div class="container">
											<div class="user-data-form step-form-modal modal-content">
											<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
												<div class="modal-cont">
													<h2>Attention</h2>
										            <p id="successMessage">${successMessage}</p>
										            <div class="modal-btns step-mod-btns"><button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok">Okay</button></div>
												</div>
											</div>	
										</div>
								</div>
						</div>

         <div class="blog-section-two position-relative blog-wrapper">
            <div class="container">
               <div class="position-relative">
                  <div class="row gx-xxl-5">
                     <c:forEach var="blogObject" items="${blogObjectList}">
                        <div class="col-md-6">
                           <article class="blog-meta-two mb-80 lg-mb-50 wow fadeInUp">
                              <figure class="post-img rounded-5 position-relative d-flex align-items-end m0" style="background-image: url('<c:out value='${blogObject.c_image_url}' />');">
                                 <a href="blogdetails/${blogObject.id}" class="stretched-link rounded-5 date tran3s">${blogObject.c_blog_date}</a>
                              </figure>
                              <div class="post-data">
                                 <div class="d-flex justify-content-between align-items-center flex-wrap">
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
                  <!-- /.pagination-one -->
               </div>
            </div>
         </div>
         <div class="fancy-banner-three position-relative wow fadeInUp">
            <div class="container">
               <div class="contact-banner position-relative">
                  <div class="row align-items-center">
                     <div class="col-lg-6">
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
         <!-- Include External Footer -->
         <%@ include file="/WEB-INF/views/footer.jsp" %>
		 <!---Include Model-->
		 <%@ include file="/WEB-INF/views/log-reg.jsp" %>
		 <%@ include file="/WEB-INF/views/right-click.jsp" %>
         <button class="scroll-top">
         <i class="bi bi-arrow-up-short"></i>
         </button>
         <!-- External JavaScript _____________________________  -->
         <%@ include file="/WEB-INF/views/js.jsp" %>
      </div>
      <!-- /.main-page-wrapper -->
	  <!-- JavaScript to trigger the modal -->
	  <script>
	      $(document).ready(function() {
	          //<%-- Check if there's a success message in the model --%>
	          <c:if test="${not empty successMessage}">
	              $('#successModal').modal('show');
	          </c:if>
	      });
	  </script>
   </body>
</html>