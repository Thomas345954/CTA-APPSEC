<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External style tags-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>Cookie Policy</title>
			
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
			 <div>
			 		<div class="cont-pages">
			 		 <h1 class="text-center pb-30">Cookie Policy</h1>
			 		         <p><strong>Effective Date:</strong> 08/20/2024</p>

			 		         <p>At CTAHarbor, we use cookies and similar tracking technologies to enhance your browsing experience, analyze website traffic, and understand the effectiveness of our marketing campaigns. This Cookie Policy explains what cookies are, how we use them, and your choices regarding their use.</p>
			                  <br>
			 		         <h5>1. What Are Cookies?</h5>
			 		         <p>Cookies are small text files that are stored on your device (computer, smartphone, or other internet-enabled devices) when you visit a website. They help the website recognize your device and remember certain information about your visit, such as your preferences and past actions.</p>
			 				 <br>
			 		         <h5>2. Types of Cookies We Use</h5>
			 		         <p>We use the following types of cookies on our website:</p>
			 		         <ul>
			 		             <li><strong>Strictly Necessary Cookies:</strong> These cookies are essential for the operation of our website. They allow you to navigate the site and use its features, such as accessing secure areas.</li>
			 		             <li><strong>Performance Cookies:</strong> These cookies collect information about how visitors use our website, such as which pages are visited most often. The data collected is used to improve the functionality of our website.</li>
			 		             <li><strong>Functional Cookies:</strong> These cookies allow our website to remember choices you make (such as your language or the region you are in) and provide enhanced, more personalized features.</li>
			 		             <li><strong>Targeting/Advertising Cookies:</strong> These cookies are used to deliver advertisements more relevant to you and your interests. They are also used to limit the number of times you see an advertisement and help measure the effectiveness of the advertising campaign.</li>
			 		         </ul>
			 				 <br>
			 		         <h5>3. How We Use Cookies</h5>
			 		         <p>We use cookies for various purposes, including:</p>
			 		         <ul>
			 		             <li>To ensure that our website functions properly.</li>
			 		             <li>To provide you with a more personalized experience.</li>
			 		             <li>To analyze and improve the performance of our website.</li>
			 		             <li>To deliver targeted advertisements.</li>
			 		         </ul>
			 				 <br>
			 		         <h5>4. What Other Cookies Might You Encounter on a CTAHarbor Website?</h5>
			 		         <p>We may also use third-party cookies on the site. In keeping with our policies, these session or persistent cookies are set only by trusted partners of CTAHarbor. These cookies may collect information about your online activities across websites and over time.</p>
			 		         <p>The third parties who set cookies through our site include LinkedIn, Maxmind, YouTube, Facebook, and DoubleClick.</p>
			 		         <p>The third-party cookies we may use on our website and apps may track site performance and usage, monitor chat sessions or a user's location, or compile reports that help us improve the site and apps. When you access our website, in certain jurisdictions, as required by law, you will receive a clear notice advising you that we intend to use cookies and that you must click an "I accept" box in order for cookies to be placed.</p>
			 		         <p>If you prefer not to receive cookies through our website, you can set your browser to either reject all cookies (see below), to allow only "trusted" websites to set them, or to accept only those cookies from those sites you currently use. If you access our website in Europe, you can refuse to click the "I accept" box or click the "I disagree" box when you are presented with a cookie notice on our homepage.</p>
			 		         <p>When you access our website outside of Europe, our system will automatically issue cookies when you log on to our website and apps (unless you have set your browser to reject them).</p>
			 				 <br>
			 		         <h5>5. Cookies We Do Not Use</h5>
			 		         <p>We do not use flash cookies (sometimes known as local shared objects or LSOs).</p>
			 				 <br>
			 		         <h5>6. Does CTAHarbor Use Cookies to Sell Customer Information?</h5>
			 		         <p>We do not use cookies to provide your data to third parties in exchange for monetary consideration, but we may receive other consideration for allowing third parties to access cookies.</p>
			 				 <br>
			 		         <h5>7. Your Choices Regarding Cookies</h5>
			 		         <p>You have several options for managing cookies on our website:</p>
			 		         <ul>
			 		             <li><strong>Browser Settings:</strong> You can set your browser to block or alert you about these cookies, but some parts of the site may not work as intended if you do so.</li>
			 		             <li><strong>Opt-Out Tools:</strong> You can also opt-out of targeted advertising by using opt-out tools provided by advertising networks.</li>
			 		         </ul>
			 				 <br>
			 		         <h5>8. Changes to This Cookie Policy</h5>
			 		         <p>We may update this Cookie Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. Any updates will be posted on this page with an updated effective date.</p>
			 				 <br>
			 		         <h5>9. Contact Us</h5>
			 		         <p>If you have any questions about our use of cookies, please contact us:</p>
			 		         <ul>
			 		             <li><strong>Email:</strong> <a href="mailto:service@ctaharbor.com">service@ctaharbor.com</a></li>
			 		             <li><strong>Phone:</strong><a href="tel:+1 (888) 203-2246">+1 (888) 203-2246</a></li>
			 		             <li><strong>Address:</strong>315 Madison Avenue Suite 4005, New York, NY 10017</li>
			 		         </ul>
			 		     </div>
			 			 <br>
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