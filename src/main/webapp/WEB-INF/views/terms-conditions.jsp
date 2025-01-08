<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External style tags-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>Terms & Conditions</title>
			
            <!-- Fix Internet Explorer ______________________________________-->
			      
			      
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
			 		<h1 class="text-center pb-30">CTAHarbor Terms & Conditions</h1> 
			          <h5>Welcome to CTAHarbor!</h5>
			          <p>
			             These Terms & Conditions ("Terms") govern your use of this website (the "Site") operated by 
			             CTAHarbor, a subsidiary of New York Business Advisory & Corporate Services Inc. 
			             ("NYBACS").
			          </p>
			          <p>
			             By accessing or using the Site, you agree to be bound by these Terms. If you disagree with 
			             any part of the Terms, you may not access or use the Site.
			          </p>
			          <h5>1. Use of the Site</h5>
			          <p>
			             The Site is provided for informational purposes only. You may not use the Site for any unlawful 
			             purpose or in any way that violates these Terms.
			          </p>
			          <h5>2. Content Ownership</h5>
			          <p>
			             The content on the Site, including text, graphics, logos, images, and software, is the property 
			             of CTAHarbor or its licensors and is protected by copyright and other intellectual property 
			             laws.
			          </p>
			          <h5>3. User Submissions</h5>
			          <p>
			             You may submit comments, questions, or other information to the Site (collectively, 
			             "Submissions"). By submitting content, you grant CTAHarbor a non-exclusive, royalty-free, 
			             worldwide license to use, reproduce, modify, publish, translate, distribute, and create derivative 
			             works of your Submissions.
			          </p>
			          <h5>4. Disclaimers</h5>
			          <p>
			             The information on the Site is provided "as is" without warranty of any kind, express or 
			             implied, including but not limited to the implied warranties of merchantability, fitness for a 
			             particular purpose, and non-infringement. <br>
			             CTAHarbor does not warrant the accuracy, completeness, or reliability of the information on 
			             the Site.
			          </p>
			          <h5>5. Limitation of Liability</h5>
			          <p>CTAHarbor will not be liable for any damages arising out of or related to your use of the Site.</p>
			          <h5>6. Indemnification</h5>
			          <p>
			             You agree to indemnify and hold harmless CTAHarbor and its affiliates, officers, directors, 
			             employees, agents, and licensors from and against any and all claims, demands, losses, 
			             liabilities, costs, or expenses (including attorney's fees) arising out of or related to your use of 
			             the Site.
			          </p>
			          <h5>7. Governing Law</h5>
			          <p>
			             These Terms will be governed by and construed in accordance with the laws of the State of New York, without regard to its conflict of law provisions.
			          </p>
			          <h5>8. Entire Agreement</h5>
			          <p>These Terms constitute the entire agreement between you and CTAHarbor regarding your use of the Site.</p>
			          <h5>9. Changes to the Terms</h5>
			          <p>CTAHarbor reserves the right to change these Terms at any time. Your continued use of the Site following any changes constitutes your acceptance of the revised Terms.</p>
			          <h5>10. Contact Us</h5>
			          <p>
			             If you have any questions about these Terms, please contact us at <a href="mailto:support@ctaharbor.com">support@ctaharbor.com</a>.
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