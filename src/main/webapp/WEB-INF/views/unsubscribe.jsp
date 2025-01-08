<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External style tags-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>Unsubscribe</title>
			<style>
				.btn-container{
					display : flex;
					justify-content : center;
				}
				
				</style>
    </head>

    <body>
        <!-- Include Header -->
        <%@ include file="/WEB-INF/views/header-login.jsp" %>
            <div class="main-page-wrapper footer-two">
                <!-- ===================================================
            Loading Transition
            ==================================================== -->
			<!-- Include loader -->
			 <%@ include file="/WEB-INF/views/loader.jsp" %>
				 <div class="cont-pages text-center bg-wrapper" style="margin:150px 30px 10px;">
					<%
						String btnClicked = (String)request.getAttribute("confirmBtnClicked");;
						if(btnClicked == null || !btnClicked.equalsIgnoreCase("true")){
					%>
				     <form action="/confirmUnsubscribe" method="POST">
				         <div>
				             <h4>
				                 Please click confirm button to Unsubscribe.
				             </h4>
				         </div>
						 <input type="hidden" name="userEmail" value="${userEmail}">
				         <!-- Corrected the usage of classes -->
                         <div class="mt-50 btn-container">					             
							<button type="submit" class="btn-four">Confirm</button>
				         </div>
				     </form>
					 <%
					 	}
					 %>
				   	 <div id="message">
					     <p class="${message.contains('successfully') ? 'unsubscribe-success-message' : 'unsubscribe-error-message'} mt-20">${message}</p>
					 </div>
				 </div>
                <!-- Include Footer -->
                <%@ include file="/WEB-INF/views/footer.jsp" %>
				<!---Include Model-->
				<%@ include file="/WEB-INF/views/log-reg.jsp" %>
				<%@ include file="/WEB-INF/views/right-click.jsp" %>
                    <button class="scroll-top">
                        <i class="bi bi-arrow-up-short"></i>
                    </button>
                    <!--external Java script-->
                    <%@ include file="/WEB-INF/views/js.jsp" %>
            </div>
            <!-- /.main-page-wrapper -->
    </body>

    </html>