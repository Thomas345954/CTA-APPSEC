<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External style tags-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>Terms of Use</title>
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
			 		 <h1 class="text-center pb-30">Terms of Use</h1>

			 		         <h5>1. Introduction</h5>
			 		         <p>Welcome to CTAHarbor (“CTAHarbor, “we,” “us,” “our”). These Terms of Use (“Terms”) govern your use of our website www.ctaharbor.com and the services provided through the Website, including BOIR (Beneficial Ownership Information Report) filing services (collectively, the “Services”). By accessing or using our Website and Services, you agree to be bound by these Terms. If you do not agree with these Terms, please do not use our website or Services.</p>
			 				 <br>
			 		         <h5>2. Eligibility</h5>
			 		         <p>By using our Website and Services, you represent and warrant that you are at least 18 years old and have the legal capacity to enter into these Terms. If you are using the Website or Services on behalf of a company or other legal entity, you represent that you have the authority to bind that entity to these Terms.</p>
			 				 <br>
			 		         <h5>3. Use of the Website and Services</h5>
			 		         <ul>
			 		             <li><strong>Compliance:</strong> You agree to use our Website and Services only for lawful purposes and in accordance with these Terms.</li>
			 		             <li><strong>Account Registration:</strong> To access certain features of the Services, you may be required to create an account. You agree to provide accurate, current, and complete information during the registration process and to keep your account information updated.</li>
			 		             <li><strong>Security:</strong> You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.</li>
			 		             <li><strong>Prohibited Activities:</strong> You agree not to:
			 		                 <ul>
			 		                     <li>Use the Website or Services in any way that violates any applicable laws or regulations.</li>
			 		                     <li>Use the Website or Services to impersonate any person or entity or to falsely state or otherwise misrepresent your affiliation with a person or entity.</li>
			 		                     <li>Interfere with or disrupt the operation of the Website or Services or the servers or networks used to make the Website and Services available.</li>
			 		                 </ul>
			 		             </li>
			 		         </ul>
			 				 <br>
			 		         <h5>4. Intellectual Property Rights</h5>
			 		         <ul>
			 		             <li><strong>Ownership:</strong> All content, features, and functionality on the Website, including text, graphics, logos, images, and software, are the exclusive property of CTAHarbor or its licensors and are protected by intellectual property laws.</li>
			 		             <li><strong>License:</strong> Subject to your compliance with these Terms, we grant you a limited, non-exclusive, non-transferable, and revocable license to access and use the Website and Services for your personal or internal business purposes.</li>
			 		         </ul>
			 				 <br>
			 		         <h5>5. Third-Party Services</h5>
			 		         <p>Our website may include links to third-party websites or services that are not owned or controlled by CTAHarbor. We are not responsible for the content, privacy policies, or practices of any third-party websites or services. You access these third-party services at your own risk.</p>
			 				 <br>
			 		         <h5>6. Disclaimer of Warranties</h5>
			 		         <p>The Website and Services are provided “as is” and “as available” without any warranties of any kind, whether express or implied. We do not warrant that the Website or Services will be uninterrupted, error-free, or free of viruses or other harmful components. We disclaim all warranties, including, but not limited to, implied warranties of merchantability, fitness for a particular purpose, and non-infringement.</p>
			 				 <br>
			 		         <h5>7. Limitation of Liability</h5>
			 		         <p>To the fullest extent permitted by law, CTAHarbor and its affiliates, officers, directors, employees, and agents shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including loss of profits, data, use, goodwill, or other intangible losses, arising out of or in connection with your use of the Website or Services.</p>
			 				 <br>
			 		         <h5>8. Indemnification</h5>
			 		         <p>You agree to indemnify and hold harmless CTAHarbor, its affiliates, officers, directors, employees, and agents from and against any claims, liabilities, damages, judgments, awards, losses, costs, expenses, or fees (including reasonable attorneys' fees) arising out of or relating to your violation of these Terms or your use of the Website or Services.</p>

			 		         <h5>9. Termination</h5>
			 		         <p>We may terminate or suspend your access to the Website and Services, without prior notice or liability, for any reason whatsoever, including, but not limited to, a breach of these Terms. Upon termination, your right to use the Website and Services will immediately cease.</p>
			 				 <br>
			 		         <h5>10. Governing Law</h5>
			 		         <p>These Terms shall be governed by and construed in accordance with the laws of [Your State/Country], without regard to its conflict of law principles. Any legal action or proceeding arising under these Terms will be brought exclusively in the federal or state courts located in [Your State/Country], and you hereby consent to the personal jurisdiction and venue of such courts.</p>
			 				 <br>
			 		         <h5>11. Changes to These Terms</h5>
			 		         <p>We may update these Terms from time to time. Any changes will be effective immediately upon posting the revised Terms on the Website. Your continued use of the Website and Services following the posting of the revised Terms constitutes your acceptance of the changes.</p>
			 				<br>
			 		         <h5>12. Contact Us</h5>
			 		         <p>If you have any questions about these Terms, please contact us at:</p>
			 		         <p>
			 		             CTAHarbor<br>
			 		             315 Madison Avenue Suite 4005<br>
			 		             New York, NY 10017<br>
			 		             Email: <a href="mailto:service@ctaharbor.com">service@ctaharbor.com</a><br>
			 					 Toll-Free: <a href="tel:+1 (888) 203-2246">+1 (888) 203-2246</a>
			 		         </p>
			 		     </div>
                <!-- Include Footer -->
                <%@ include file="/WEB-INF/views/footer.jsp" %>
				<%@ include file="/WEB-INF/views/right-click.jsp" %>
				<!---Include Model-->
				<%@ include file="/WEB-INF/views/log-reg.jsp" %>
                    <button class="scroll-top">
                        <i class="bi bi-arrow-up-short"></i>
                    </button>
                    <!--external Java script-->
                    <%@ include file="/WEB-INF/views/js.jsp" %>
            </div>
            <!-- /.main-page-wrapper -->
    </body>

    </html>