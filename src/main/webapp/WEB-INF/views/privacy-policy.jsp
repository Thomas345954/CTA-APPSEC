<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External style tags-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>Privacy Policy</title>
			      <style>
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
			 <div class="cont-pages">
			 			<h1 class="text-center pb-30">CTAHarbor Privacy Policy</h1>
			       <div>
			          <p>Protecting your privacy is important to CTAHarbor. This Privacy Policy describes how we collect, use, and disclose your personal information when you use the Site.</p>
			          <h5>1. Information We Collect</h5>
			          <p>We may collect the following information from you:</p>
			          <ul>
			             <li><strong>Personal Information:</strong> This includes information that can be used to identify you, such as your name, email address, phone number, and mailing address. We only collect this information when you voluntarily provide it to us, such as by contacting us through a form on the Site.</li>
			             <li><strong>Usage Data:</strong> We may collect information about your use of the Site, such as the pages you visit, the time you spend on the Site, and the links you click. This information is collected automatically through cookies and other tracking technologies.</li>
			          </ul>
			          <h5>2. How We Use Your Information</h5>
			          <p>We may use your personal information to:</p>
			          <ul>
			             <li>Respond to your inquiries and requests.</li>
			             <li>Send you information about our services.</li>
			             <li>Improve the Site.</li>
			             <li>Comply with legal requirements.</li>
			          </ul>
			          <p>We may use your usage data to:</p>
			          <ul>
			             <li>Analyse how users interact with the Site.</li>
			             <li>Improve the Site.</li>
			          </ul>
			          <h5>3. Sharing Your Information</h5>
			          <p>We may share your personal information with third-party service providers who help us operate the Site or provide services to you. These service providers are contractually obligated to keep your information confidential.</p>
			          <p>We will not share your personal information with any third party for marketing purposes without your consent.</p>
			          <h5>4. Data Retention</h5>
			          <p>We will retain your personal information for as long as necessary to fulfill the purposes for which it was collected, or as required by law.</p>
			          <h5>5. Your Choices</h5>
			          <p>You can opt out of receiving marketing emails from us by following the unsubscribe instructions in the emails we send you.</p>
			          <p>You can also control cookies by using the settings in your web browser. However, please note that disabling cookies may limit your ability to use certain features of the Site.</p>
			          <h5>6. Children's Privacy</h5>
			          <p>The Site is not directed to children under the age of 13. We do not knowingly collect personal information from children under 13.</p>
			          <h5>7. Security</h5>
			          <p>We take reasonable steps to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no website or internet transmission is completely secure. We cannot guarantee the security of your personal information.</p>
			          <h5>8. Cross-Border Transfer</h5>
			          <p>Your personal information may be transferred to and processed in countries other than your own. These countries may have different data protection laws than your own country.</p>
			          <h5>9. Changes to the Privacy Policy</h5>
			          <p>We may change this Privacy Policy at any time. Your continued use of the Site following any changes constitutes your acceptance of the revised Privacy Policy.</p>
			          <h5>10. Contact Us</h5>
			          <p>If you have any questions about this Privacy Policy, please contact us at <a href="mailto:support@ctaharbor.com">support@ctaharbor.com</a>.</p>
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