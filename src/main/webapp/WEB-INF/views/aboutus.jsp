<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External style tags-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>CTAHarbor | About Us</title>

			<style>
				.fancy-banner-five:before {
				    display: none;
				}
				
				.clickable {
				           cursor: pointer; /* Changes the cursor to a hand symbol */
				       }
           </style>
		
    </head>

    <body>
        <!-- Include Header -->
        <%@ include file="/WEB-INF/views/header-login.jsp" %>
            <div class="main-page-wrapper">
              
			 <%@ include file="/WEB-INF/views/loader.jsp" %>
                
                <div class="text-feature-one abt-top mt-150 lg-mt-80">
                    <div class="container">
                        <div class="position-relative">
                            <div class="row align-items-center">
                                <div class="col-lg-5 wow fadeInLeft">
                                    <div class="title-one">
                                        <div class="upper-title">About us</div>
                                        <h2>CTAHarbor: Simplifying CTA Compliance for US Businesses</h2>
                                    </div>
                                    <!-- /.title-one -->
                                    <p class="text-lg mt-45 lg-mt-30 mb-35 lg-mb-30">CTAHarbor, a d.b.a. of New York Business Advisory & Corporate Services Inc, from a legacy of trusted advisors. Established many years ago, NYBACS has served a global clientele of over 600 corporations,
                                        providing a comprehensive suite of services in incorporation, corporate services, business taxation, and business advisory.</p>
                                    <p class="text-lg mt-45 lg-mt-30 mb-35 lg-mb-30">Leveraging this experience and unwavering commitment to client success, CTAHarbor was born with a singular focus: empowering US businesses to navigate the complexities of the Corporate Transparency Act (CTA) of 2022.</p>
                                    <p class="text-lg mt-45 lg-mt-30 mb-35 lg-mb-30">We understand the challenges that the CTA presents for US entities. Our team of experts are dedicated to providing comprehensive solutions that streamline the Beneficial Ownership Information Reporting (BOIR) process.
                                        We are a FinCEN-approved API participant, ensuring secure and efficient data submissions.</p>
<!--                                    <a href="/contactus" class="btn-three icon-link mt-15 md-mb-40">-->
                                       <span onclick="reqCallback()"  class="clickable">Request a Callback</span>
                                        <img src="images/lazy.svg" data-src="images/icon/icon_09.svg" alt="" class="lazy-img icon ms-1">
<!--                                    </a>-->
                                </div>
                                <div class="col-lg-6 ms-auto wow fadeInRight">
                                    <div class="card-style-three d-flex pt-75 lg-pt-40 pb-45 lg-pb-20">
                                        <img src="images/lazy.svg" data-src="images/icon/Mission.svg" alt="" class="lazy-img icon">
                                        <div class="ps-4">
                                            <h4 class="fw-bold mb-20">Our Mission</h4>
                                            <p>Our mission is to simplify the CTA compliance for US entities, ensuring seamless compliance and peace of mind. We leverage our expertise and FinCEN-approved API participation advantage to streamline BOIR (Beneficial
                                                Ownership Information Reporting) submissions, empowering businesses to focus on their core operations.</p>
                                        </div>
                                    </div>
                                    <!-- /.card-style-three -->
                                    <div class="card-style-three d-flex pt-75 lg-pt-40 pb-45 lg-pb-20">
                                        <img src="images/lazy.svg" data-src="images/icon/Vision.svg" alt="" class="lazy-img icon">
                                        <div class="ps-4">
                                            <h4 class="fw-bold mb-20">Vision</h4>
                                            <p>We envision a future where US companies navigate the regulatory landscape with clarity and confidence. By providing exceptional service and fostering a culture of transparency, we aim to become the leading resource
                                                for CTA compliance, US business taxation, accounting & bookkeeping, and a comprehensive suite of business services. This integrated approach empowers businesses to focus on their growth strategies while
                                                ensuring long-term success.</p>
                                        </div>
                                    </div>
                                    <!-- /.card-style-three -->
                                </div>
                            </div>
                            <img src="images/lazy.svg" data-src="images/shape/shape_05.svg" alt="" class="lazy-img shapes shape_01">
                        </div>

                    </div>
                </div>
                <!-- /.text-feature-one -->
            
				<div id="redirectpage" class="fancy-banner-five text-center position-relative mt-150 lg-mt-80 pt-80 md-pt-60 pb-80 md-pb-60" onclick="window.open('https://www.nybacs.com', '_blank');">
				    <div class="container">
				        <h2 class="text-white fw-bold">Our Heritage <br>NYBACS Legacy</h2>
				        <p class="text-white text-xl pt-30 md-pt-10 lg-pb-30">CTAHarbor draws upon the extensive experience of NYBACS, a well-established firm with over 600 satisfied clients across the globe. NYBACS' proven track record in incorporation, corporate services, business taxation, and business advisory serves as a strong foundation for CTAHarbor's specialized compliance services.</p>
				        <p class="text-white text-xl pt-30 md-pt-10 lg-pb-30">Together, we offer an unparalleled combination of expertise and personalized support, ensuring your business remains compliant and thrives in the evolving regulatory landscape.</p>
				    </div>
				</div>

			
                <div class="block-feature-six bg-two position-relative pt-150 lg-pt-60 pb-120 lg-pb-40">
                    <div class="container">
                        <div class="row gx-lg-5">
                            <div class="col-lg-4 wow fadeInLef">
                                <div class="title-one">
                                    <h2>Why CTAHarbor is Your Trusted CTA Compliance Partner</h2>
                                </div>
                                <!-- /.title-one -->
                                <p class="text-lg text-dark mt-40 md-mt-20 mb-35 md-mb-30">The Corporate Transparency Act (CTA) of 2022 presents a new layer of complexity for US businesses. Meeting BOIR (Beneficial Ownership Information Reporting) requirements can be time-consuming and confusing. At CTAHarbor,
                                    we understand the challenges and are dedicated to simplifying the process for you. Here's why CTAHarbor is the perfect partner to ensure smooth and efficient CTA compliance</p>
                                <a href="contactus" class="btn-eleven d-inline-flex align-items-center md-mb-60">
                                    <span class="text">Contact Us</span>
                                    <div class="icon tran3s rounded-circle d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/icon_27.svg" alt="" class="lazy-img"></i>
                                    </div>
                                </a>
                            </div>
                            <div class="col-lg-8">
                                <div class="row">
                                    <div class="col-md-6 d-flex wow fadeInUp">
                                        <div class="card-style-eight rounded-5 vstack tran3s w-100 mb-30">
                                            <div class="icon d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/Free Service.svg" alt="" class="lazy-img"></div>
                                            <h4 class="fw-bold mt-30 mb-20">Understanding of the CTA</h4>
                                            <p>Our team stays abreast of the latest regulations and interpretations, providing you with clear and actionable guidance.</p>
                                            <a href="#" class="stretched-link"></a>
                                        </div>
                                        <!-- /.card-style-eight -->
                                    </div>
                                    <div class="col-md-6 d-flex wow fadeInUp" data-wow-delay="0.1s">
                                        <div class="card-style-eight rounded-5 vstack tran3s w-100 mb-30 active">
                                            <div class="icon d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/trust.svg" alt="" class="lazy-img"></div>
                                            <h4 class="fw-bold mt-30 mb-20">Expertise You Can Trust</h4>
                                            <p>Backed by NYBACS' years of expertise serving 600+ corporations, CTAHarbor is a US Dept of Treasury-approved API participant / solution with a proven track record of successful BOIR filings.</p>
                                            <a href="#" class="stretched-link"></a>
                                        </div>
                                        <!-- /.card-style-eight -->
                                    </div>
                                    <div class="col-md-6 d-flex wow fadeInUp" data-wow-delay="0.2s">
                                        <div class="card-style-eight rounded-5 vstack tran3s w-100 mb-30">
                                            <div class="icon d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/Streamlined Experience.svg" alt="" class="lazy-img"></div>
                                            <h4 class="fw-bold mt-30 mb-20">Streamlined Solutions</h4>
                                            <p>Our team of experts stays current on the latest CTA regulations and interpretations. We leverage technology and automation to create a streamlined BOIR filing process, minimizing your time and effort.
                                            </p>
                                            <a href="#" class="stretched-link"></a>
                                        </div>
                                        <!-- /.card-style-eight -->
                                    </div>
                                    <div class="col-md-6 d-flex wow fadeInUp" data-wow-delay="0.3s">
                                        <div class="card-style-eight rounded-5 vstack tran3s w-100 mb-30">
                                            <div class="icon d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/cooperation.svg" alt="" class="lazy-img"></div>
                                            <h4 class="fw-bold mt-30 mb-20">Focus on Your Business</h4>
                                            <p>By handling your CTA compliance needs, we allow you to focus on what matters most - running and growing your business.</p>
                                            <a href="#" class="stretched-link"></a>
                                        </div>
                                        <!-- /.card-style-eight -->
                                    </div>
                                    <div class="col-md-6 d-flex wow fadeInUp" data-wow-delay="0.2s">
                                        <div class="card-style-eight rounded-5 vstack tran3s w-100 mb-30">
                                            <div class="icon d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/security.svg" alt="" class="lazy-img"></div>
                                            <h4 class="fw-bold mt-30 mb-20">Advanced Data Protection</h4>
                                            <p>We understand the sensitivity of your BOIR data. Our world-class security measures ensure your information remains confidential and secure.</p>
                                            <a href="#" class="stretched-link"></a>
                                        </div>
                                        <!-- /.card-style-eight -->
                                    </div>
                                    <div class="col-md-6 d-flex wow fadeInUp" data-wow-delay="0.3s">
                                        <div class="card-style-eight rounded-5 vstack tran3s w-100 mb-30">
                                            <div class="icon d-flex align-items-center"><img src="images/lazy.svg" data-src="images/icon/briefcase.svg" alt="" class="lazy-img"></div>
                                            <h4 class="fw-bold mt-30 mb-20">Beyond CTA</h4>
                                            <p>We position ourselves as your long-term partner for navigating the evolving regulatory landscape. Our commitment to staying ahead of the curve ensures you're prepared for future regulatory changes.</p>
                                            <a href="#" class="stretched-link"></a>
                                        </div>
                                        <!-- /.card-style-eight -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <img src="images/lazy.svg" data-src="images/shape/shape_11.svg" alt="" class="lazy-img shapes shape_01">
                    <img src="images/lazy.svg" data-src="images/shape/shape_12.svg" alt="" class="lazy-img shapes shape_02">
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
			
			<script>
		        function reqCallback() {
		            // Redirect to the contact us page with a fragment identifier
		            window.location.href = 'contactus#help';
					
		        }
		    </script>
    </body>

  </html>