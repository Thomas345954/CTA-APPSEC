<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <!---External Styles-->
        <%@ include file="/WEB-INF/views/css.jsp" %>
            <title>CTAHarbor | FAQ</title>
    </head>

    <body>
        <!-- Include Header -->
        <%@ include file="/WEB-INF/views/header-login.jsp" %>
            <div class="main-page-wrapper">
			<%@ include file="/WEB-INF/views/loader.jsp" %>
              
			<br>
                <div class="faq-section-three border-top pt-180 sm-pt-120 pb-60">
                    <div class="container">
                        <nav>
                            <div class="nav nav-tabs justify-content-center" id="nav-tab" role="tablist">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#nav-general-questions" type="button" role="tab">A. General Questions </button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-marketing" type="button" role="tab">B. Reporting Process</button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-banking" type="button" role="tab">C. Reporting Company</button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-finance" type="button" role="tab">D. Beneficial Owner</button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-payment" type="button" role="tab">E. Company Applicant</button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-terms" type="button" role="tab">F. Reporting Requirements</button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-account" type="button" role="tab">G. Initial Report </button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-updated-&-corrected-report" type="button" role="tab">H. Updated & Corrected Report</button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-fincen-identifier" type="button" role="tab">I. FinCEN Identifier</button>
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-beneficial-ownership-information" type="button" role="tab">J. 
									Access to Beneficial Ownership Information</button>
                            </div>
                        </nav>
                        <div class="tab-content mt-60 lg-mt-40">
                            <div class="tab-pane fade show active" id="nav-general-questions" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionOne">
                                    <c:forEach var="faqObjectA" items="${faqObjectList}">
                                        <c:if test="${faqObjectA.c_feature_type  == 'A. General Questions'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectA.c_collapse}" aria-expanded="false" aria-controls="${faqObjectA.c_collapse}">
                                    ${faqObjectA.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectA.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionOne">
                                                    <div class="accordion-body">

														<c:choose>
														    <c:when test="${fn:contains(faqObjectA.c_answer, 'https://www.federalregister.gov')}">
														        <c:set var="processedContent">
														            ${fn:replace(faqObjectA.c_answer, 'https://www.federalregister.gov/documents/2024/01/08/2024-00109/indian-entities-recognized-by-and-eligible-to-receive-services-from-the-united-states-bureau-of', 
														            '<a href="https://www.federalregister.gov/documents/2024/01/08/2024-00109/indian-entities-recognized-by-and-eligible-to-receive-services-from-the-united-states-bureau-of" target="_blank">
														                https://www.federalregister.gov/documents/2024/01/08/2024-00109/indian-entities-recognized-by-and-eligible-to-receive-services-from-the-united-states-bureau-of
														            </a>')}
														        </c:set>
														    </c:when>
														    <c:otherwise>
														        <c:set var="processedContent">
														            ${fn:replace(faqObjectA.c_answer, 'www.fincen.gov/boi', '<a href="https://www.fincen.gov/boi" target="_blank">www.fincen.gov/boi</a>')}
														        </c:set>
														    </c:otherwise>
														</c:choose>

                                                        <p>${processedContent}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-marketing" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionTwo">
                                    <c:forEach var="faqObjectB" items="${faqObjectList}">
                                        <c:if test="${faqObjectB.c_feature_type  == 'B. Reporting Process'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectB.c_collapse}" aria-expanded="false" aria-controls="${faqObjectB.c_collapse}">
                                    ${faqObjectB.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectB.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionTwo">
                                                    <div class="accordion-body">
														        <c:set var="processedBContent">
														            ${fn:replace(faqObjectB.c_answer, 'https://boiefiling.fincen.gov', 
														            '<a href="https://boiefiling.fincen.gov" target="_blank">
														                https://boiefiling.fincen.gov
														            </a>')}
														        </c:set>
                                                        <p>${processedBContent}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-banking" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionThree">
                                    <c:forEach var="faqObjectC" items="${faqObjectList}">
                                        <c:if test="${faqObjectC.c_feature_type  == 'C. Reporting Company'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectC.c_collapse}" aria-expanded="false" aria-controls="${faqObjectC.c_collapse}">
                                    ${faqObjectC.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectC.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionThree">
                                                    <div class="accordion-body">
                                                        <p>${faqObjectC.c_answer}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-finance" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionFour">
                                    <c:forEach var="faqObjectD" items="${faqObjectList}">
                                        <c:if test="${faqObjectD.c_feature_type  == 'D. Beneficial Owner'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectD.c_collapse}" aria-expanded="false" aria-controls="${faqObjectD.c_collapse}">
                                    ${faqObjectD.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectD.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionFour">
                                                    <div class="accordion-body">
                                                        <p>${faqObjectD.c_answer}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-payment" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionFive">
                                    <c:forEach var="faqObjectE" items="${faqObjectList}">
                                        <c:if test="${faqObjectE.c_feature_type  == 'E. Company Applicant'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectE.c_collapse}" aria-expanded="false" aria-controls="${faqObjectE.c_collapse}">
                                    ${faqObjectE.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectE.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionFive">
                                                    <div class="accordion-body">
                                                        <p>${faqObjectE.c_answer}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-terms" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionSix">
                                    <c:forEach var="faqObjectF" items="${faqObjectList}">
                                        <c:if test="${faqObjectF.c_feature_type  == 'F. Reporting Requirements'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectF.c_collapse}" aria-expanded="false" aria-controls="${faqObjectF.c_collapse}">
                                    ${faqObjectF.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectF.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionSix">
                                                    <div class="accordion-body">
                                                        <p>${faqObjectF.c_answer}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-account" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionSeven">
                                    <c:forEach var="faqObjectG" items="${faqObjectList}">
                                        <c:if test="${faqObjectG.c_feature_type  == 'G. Initial Report'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectG.c_collapse}" aria-expanded="false" aria-controls="${faqObjectG.c_collapse}">
                                    ${faqObjectG.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectG.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionSeven">
                                                    <div class="accordion-body">
                                                        <p>${faqObjectG.c_answer}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-updated-&-corrected-report" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionEight">
                                    <c:forEach var="faqObjectH" items="${faqObjectList}">
                                        <c:if test="${faqObjectH.c_feature_type == 'H. Updated Report' or faqObjectH.c_feature_type == 'I. Corrected Report'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectH.c_collapse}" aria-expanded="false" aria-controls="${faqObjectH.c_collapse}">
                                    ${faqObjectH.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectH.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionSeven">
                                                    <div class="accordion-body">
                                                        <p>${faqObjectH.c_answer}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-fincen-identifier" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionEight">
                                    <c:forEach var="faqObjectI" items="${faqObjectList}">
                                        <c:if test="${faqObjectI.c_feature_type  == 'M. FinCEN Identifier'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectI.c_collapse}" aria-expanded="false" aria-controls="${faqObjectI.c_collapse}">
                                    ${faqObjectI.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectI.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionSeven">
                                                    <div class="accordion-body">
														<c:set var="processedIContent">
												            ${fn:replace(faqObjectI.c_answer, 'https://fincenid.fincen.gov', 
												            '<a href="https://fincenid.fincen.gov" target="_blank">
												                https://fincenid.fincen.gov
												            </a>')}
												        </c:set>
                                                        <p>${processedIContent}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-beneficial-ownership-information" role="tabpanel" tabindex="0">
                                <div class="accordion accordion-style-one" id="accordionEight">
                                    <c:forEach var="faqObjectJ" items="${faqObjectList}">
                                        <c:if test="${faqObjectJ.c_feature_type  == 'O. Access to Beneficial Ownership Information'}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${faqObjectJ.c_collapse}" aria-expanded="false" aria-controls="${faqObjectJ.c_collapse}">
                                    ${faqObjectJ.c_faq}
                                    </button>
                                 </h2>
                                                <div id="${faqObjectJ.c_collapse}" class="accordion-collapse collapse" data-bs-parent="#accordionSeven">
                                                    <div class="accordion-body">
                                                        <p>${faqObjectJ.c_answer}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
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
                </div>
                <!-- Include Footer -->
                <%@ include file="/WEB-INF/views/footer.jsp" %>
                    <!--footer end-->
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
			<script>
			$(document).ready(function() {	
			 $(".nav-link").on("shown.bs.tab", function (e) {
			   var href = $(this).attr("data-bs-target");
			   $("html, body").animate(
			    {
			      scrollTop: $(href).offset().top - 80
			    },
			    "slow"
			  );
			  });
			    });
			</script>
			
    </body>

    </html>