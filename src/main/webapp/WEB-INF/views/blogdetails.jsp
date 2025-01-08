<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <!---External css-->
      <%@ include file="/WEB-INF/views/css.jsp" %>
      <title>CTAHarbor | Blog Details</title>
      <!-- Fix Internet Explorer ______________________________________-->
	  <style> 
	  						.contact-banner2{
	  							padding: 35px 3% 50px;
	  							    background: #003B6A;
	  							    border-radius: 20px;
	  						}
	  						.contact-banner2 h3 {
	  						    font-size: 32px;
	  						    line-height: 1.25em;
	  						    color: #fff;
	  							}
	  							
	  					   </style>
   </head>
   <body>
      <!-- Include External Header -->
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
         <!-- 
            =============================================
            	Inner Banner
            ============================================== 
            -->
			<!--<div class="inner-banner-two light-bg text-center pt-200 md-pt-150 pb-85 lg-pb-50 position-relative">
			   <div class="container position-relative">
			      <div class="row">
			         <div class="col-xl-6 m-auto">
			            <h1 class="hero-heading">Single Blog Details</h1>
			            <p class="text-md">Meet our experts, guiding you through financial intricacies with precision</p>
			         </div>
			      </div>
			   </div>
			</div>-->
			<img src="/images/lazy.svg" data-src="/images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_03">
			<img src="/images/lazy.svg" data-src="/images/shape/shape_06.svg" alt="" class="lazy-img shapes shape_04">
         <!-- /.inner-banner-one -->
         <!--
            =====================================================
            	Blog Details
            =====================================================
            -->
       <!-  <c:forEach var="blogDetailsObject" items="${blogDetailsObjectList}">
            <div class="blog-details position-relative pb-80 blog-wrapper">
               <div class="container" style="margin-top: 180px;">
                  <div class="row gx-xl-5">
                     <div class="col-lg-8">
                        <article class="blog-meta-two style-two">
                           <figure class="post-img position-relative d-flex align-items-end m0" style="background-image: url('<c:out value='${blogDetailsObject.c_image_url}' />');">
                              <div class="date">${blogDetailsObject.c_blog_date}</div>
                           </figure>
                           <div class="post-data">
                              <div class="post-info">${blogDetailsObject.c_metadata_line}</div>
                              <div class="blog-title">
                                 <h4>${blogDetailsObject.c_title}</h4>
                              </div>
                              <div class="post-details-meta">
                                 <p>${blogDetailsObject.c_content}</p>
                                 <!--<div class="quote-wrapper">
                                    <div class="wrapper">
                                       <div class="icon rounded-circle d-flex align-items-center justify-content-center m-auto"><img src="/images/lazy.svg" data-src="/images/icon/icon_93.svg" alt="" class="lazy-img"></div>
                                       <div class="row">
                                          <div class="col-xxl-9 col-xl-11 m-auto">
                                             <h3>Grow wealth like a tree, roots in savings, branches reaching toward diverse investments.</h3>
                                          </div>
                                       </div>
                                       <h6>James Bond. <span>Founder</span></h6>
                                    </div>
                                 </div>-->
<!--                                 <div class="row img-gallery">-->
<!--									<c:forEach var="blogDetailsContentImages" items="${blogDetailsContentImages}" varStatus="status">-->
<!--									    <div class="${status.index == 1 ? 'col-sm-4' : 'col-sm-8'}">-->
<!--									        <img src="/images/lazy.svg" data-src="<c:out value='${blogDetailsContentImages.Content_Images}' />" alt="" class="lazy-img w-100">-->
<!--									    </div>-->
<!--									</c:forEach>-->

<!--                                    <div class="col-sm-4">-->
<!--                                     <img src="images/lazy.svg" data-src="/images/blog/blog_img_17.jpg" alt="" class="lazy-img w-100">-->
<!--                                    </div>-->
<!--                                 </div>-->
<!--                                 <h3>Work Harder & Gain Success</h3>-->
<!--                                 <p>One touch of a red-hot stove is usually all we need to avoid that kind of discomfort in quis elit future. The same Duis aute irure dolor in reprehenderit.</p>-->
<!--                                 <ul class="style-none list-item">-->
<!--                                    <li>Find the problem first</li>-->
<!--                                    <li>Make research and find out the solution</li>-->
<!--                                    <li>Finalize the solution & apply.</li>-->
<!--                                 </ul>-->
<!--                                 <p>One touch of a red-hot stove is usually all we need to avoid that kind of discomfort in quis elit future. The same Duis aute irure dolor in reprehenderit. sunt in culpa qui official deserunt mollit anim id est laborum.</p>-->
<!--                              </div>-->
                              <!-- /.post-details-meta -->
                              <div class="bottom-widget d-sm-flex align-items-center justify-content-between">
<!--                                 <ul class="d-flex share-icon align-items-center style-none pt-20">-->
<!--                                    <li>Share:</li>-->
<!--									<li><a href="https://www.facebook.com/profile.php?id=61562918141574"><img src="/images/icon/Facebook.svg"></a></li>-->
<!--									<li><a href="https://www.linkedin.com/company/104102290/"><img src="/images/icon/linked-in.svg"></a></li>-->
                              </div>
                           </div>
                           <!-- /.post-data -->
                        </article>
                        <!-- /.blog-meta-two -->
<!--                        <div class="blog-comment-area grey-bg">-->
<!--                           <h3 class="blog-inner-title pb-15">Comments</h3>-->
<!--                           <c:forEach var="BlogDetailsComment" items="${BlogDetailsComment}">-->
<!--                              <div class="comment d-flex">-->
<!--                                 <img src="/images/lazy.svg" data-src="<c:out value='${BlogDetailsComment.Comment_Icon}' />" alt="" class="lazy-img user-avatar rounded-circle">-->
<!--                                 <div class="comment-text">-->
<!--                                    <div class="d-md-flex align-items-center justify-content-between">-->
<!--                                       <div class="name fw-500">${BlogDetailsComment.Comment_Name}</div>-->
<!--                                       <div class="date">13 June, 23, 7:30pm</div>-->
<!--                                    </div>-->
<!--                                    <p>${BlogDetailsComment.Comment_Description}</p>-->
<!--                                    <a href="#" class="reply-btn fw-500 tran3s">Reply</a>-->
<!--                                     /.comment -->
<!--                                 </div>-->
<!--                                  /.comment-text -->
<!--                              </div>-->
<!--                           </c:forEach>-->
<!--                            /.comment -->
<!--                            /.comment -->
<!--                        </div>-->
                        <!-- /.blog-comment-area -->
						<br>
                      <!--  <div class="blog-comment-form grey-bg">
                           <h3 class="blog-inner-title">Add Your Comments</h3> 
                           <p><a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="text-decoration-underline fw-500">Login</a> to post your comment or signup if you don't have any account.</p>
						   <form class="mt-30" action="/savecomments" id="blogdetailjq" method="post">
						       <input type="hidden" name="id" value="${comments.id}" />
							   <input type="hidden" name="blogId" value="${blogId}" />
						       <div class="input-wrapper mb-35">
						           <label for="bdname">Name*</label>
						           <input id="bdname" name="bdname" value="${comments.bdname}" type="text" placeholder="Your Name*">
						       </div>
						       <div class="input-wrapper mb-40">
						           <label for="bdemail">Email*</label>
						           <input id="bdemail" name="bdemail" value="${comments.bdemail}" type="email" placeholder="Email Address*">
						       </div>
						       <div class="input-wrapper mb-30">
						           <textarea id="bdmessage" name="bdmessage" value="${comments.bdmessage}" minlength="10" maxlength="500" placeholder="Your Comment"></textarea>
						       </div>
						       <c:choose>
						           <c:when test="${isAuthenticated}">
						               
						               <button class="btn-four tran3s rounded-2" type="button" onclick="submitForm()" >Post Comment</button>
						           </c:when>
						           <c:otherwise>
						            
						               <button class="btn-four tran3s rounded-2" type="submit" >Sign Up</button>
						           </c:otherwise>
						       </c:choose>
						   </form>
                        </div>-->
                     </div>
                     <div class="col-lg-4 col-md-8">
                        <div class="blog-sidebar md-mt-80 ps-xxl-4">
                           <!-- /.blog-category -->
                           <div class="blog-recent-news mt-60 lg-mt-40">
                              <h3 class="sidebar-title">Recent Blogs</h3>
                              <c:forEach var="blogDetailsRecentNews" items="${blogDetailsRecentNews}">
                                 <article class="recent-news">
                                    <figure class="post-img" style="background-image: url(<c:out value='${blogDetailsRecentNews.Image}' />);">
                                    </figure>
                                    <div class="post-data">
                                       <div class="date">${blogDetailsRecentNews.Date}</div>
                                       <a href="#" class="blog-title">
                                          <h3>${blogDetailsRecentNews.Title}</h3>
                                       </a>
                                    </div>
                                 </article>
                              </c:forEach>
                           </div>
                           <!-- /.blog-recent-news -->
                           
                           <!-- /.blog-keyword -->
						  
                           <div class="contact-banner2 text-center mt-50 lg-mt-30">
                              <h3 class="mb-20">Any Questions? <br>Let’s talk</h3>
                              <a href="/contactus" class="btn-four red-btn">Get in touch</a>
                           </div>
                           <!-- /.contact-banner -->
                        </div>
                        <!-- /.blog-sidebar -->
                     </div>
                  </div>
               </div>
            </div>
         </c:forEach>
         <!-- /.blog-details -->
		
         <!--
            =====================================================
            	Fancy Banner Three
            =====================================================
            -->
         <!-- /.fancy-banner-three -->
         <div class="fancy-banner-three position-relative wow fadeInUp">
            <!-- <div class="pricing-section light-bg border-top pt-120 lg-pt-80 pb-150 lg-pb-80"> -->
            <div class="container">
               <div class="contact-banner position-relative">
                  <!-- <img src="/images/assets/ils_04.svg" alt="" class="lazy-img shapes screen_01" style=""> -->
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
         <!--
            =====================================================
            	Newsletter Banner
            =====================================================
            -->
         <!--
            =====================================================
            	Footer Three
            =====================================================
            -->
         <!-- Include External Footer -->
         <%@ include file="/WEB-INF/views/footer.jsp" %>
         <!-- /.footer-three -->
         <!-- Modal -->
		 <!---Include Model-->
		   <%@ include file="/WEB-INF/views/log-reg.jsp" %>
		   <%@ include file="/WEB-INF/views/right-click.jsp" %>
         <button class="scroll-top">
         <i class="bi bi-arrow-up-short"></i>
         </button>
         <!-- External JavaScript _____________________________  -->
 	 	 <!-- <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
 	 	 <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script> -->
         <%@ include file="/WEB-INF/views/js.jsp" %>
		 <script>
			function submitForm(){
 			var form = document.getElementById('blogdetailjq');
	        form.submit();
		    }
	     </script>
      </div>
      <!-- /.main-page-wrapper -->
   </body>
</html>