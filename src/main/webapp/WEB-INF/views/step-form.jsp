<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <!--External Styles-->
      <%@ include file="/WEB-INF/views/css.jsp" %>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
      <title>CTAHarbor</title>
      <!--<script src="https://www.google.com/recaptcha/api.js"></script>-->
      <style>

         .step {
         display: none;
         }
         .step.active {
         display: block;
         }
         .form-field:disabled {
         background-color: #e9ecef;
         color: #6c757d;
         }
         #filingpre:disabled {
         background-color: #e9ecef;
         color: #6c757d;
         }
         .whsp {
         white-space: nowrap;
         }
         .loading-button {
         position: relative;
         padding: 12px 24px;
         font-size: 16px;
         font-weight: bold;
         color: white;
         background-color: #003B6A;
         border: none;
         border-radius: 30px;
         cursor: pointer;
         transition: background-color 0.3s ease;
         overflow: hidden;
         }
         .loading-button:hover {
         background-color: #B31942;
         }
         .loading-button:disabled {
         background-color: #003B6A;
         cursor: not-allowed;
         }
         .loading-button .spinner {
         position: absolute;
         top: 50%;
         left: 50%;
         width: 20px;
         height: 20px;
         margin-top: -10px;
         margin-left: -10px;
         border: 3px solid transparent;
         border-radius: 50%;
         border-top: 3px solid white;
         border-right: 3px solid white;
         animation: spin 1s linear infinite;
         }
         @keyframes spin {
         100% {
         transform: rotate(360deg);
         }
         }
         .loading-button .btn-text {
         transition: opacity 0.3s ease;
         }
         .loading-button.loading .btn-text {
         opacity: 0;
         }
         .loading-button.loading .spinner {
         display: block;
         }
         .loading-button .spinner {
         display: none;
         }
         #companyApplicantInfo\[0\]\.identificationDocuments\.document-error {
         color:#B31942;
         font-size: 14px;
         font-weight: 500;
         padding-left: 20px;
         }
         #subcheckbox1-error{
         color:#B31942;
         font-size: 14px;
         font-weight: 500;
         padding-left: 20px;
         }
         #beneficialOwner\[0\]\.identificationDocuments\.document-error {
         color:#B31942;
         font-size: 14px;
         font-weight: 500;
         padding-left: 20px;
         }
		  
		  #progressWrapper {
		   width: 100%;
		   margin-top: 10px;
		 }
		 #progressWrapperBen {
		 		   width: 100%;
		 		   margin-top: 10px;
		 		 }

		 progress {
		   width: 100%;
		 }
		 /** style for checkbar**/
		.custom-icon {color: #0EBD8A;padding: 10px;display: inline-flex;align-items: center;justify-content: center;width: 40px;height: 40px;font-size: 30px;margin: -6px 0px;float: inline-end;}
		/** style for progress bar**/
		.progress-container {position: relative;margin: 20px 0;width: 100%;}
		.progress-bar-wrapper {position: relative;background-color: #fff;height: 20px;border-radius: 10px;overflow: inherit;}
      .progress-bar {height: 100%;background-color: #B31942;width: 0%;transition: width 0.4s ease;border-radius: 10px;position: relative;}
		.progress-percentage {position: absolute;top: 50%;right: 10px;transform: translateY(-50%);font-size: 14px;font-weight: bold;color: white;transition: right 0.4s ease;}
		/** style for step-form automatic request for fincen id para**/
		.req-para{display:flex;align-items:left;}
		.req-p{margin-left:10px;}
		/** style for doc ai popup**/
		.spinner1 {width: 40px;height: 40px;animation: spin 4s linear infinite;}
		@keyframes spin {0% { transform: rotate(0deg); }100% { transform: rotate(360deg); }}
	 </style>
   </head>
   <body>
	
      <!--<div id="loader" class="loading"></div>-->
      <div class="main-page-wrapper">
         <%@ include file="/WEB-INF/views/loader.jsp" %>
         <%@ include file="/WEB-INF/views/right-click.jsp" %>
         <%@ include file="/WEB-INF/views/header-login.jsp" %>
         <section class="page-main">
            <input type="hidden" id="currentStep" value="<%=request.getAttribute("step")%>" />
            <div class="step active" id="step1">
               <div class="mid-content">
                  <div class="container">
                     <div class="cust-cf">
                        <!--<div class="notify-bar">
                           <p><img src="images/Bell.png"> Notification: Site Maintenance: BOI E-Filing System site will be unavailable for scheduled maintenance on June 21st, from 6:00 AM - 8:00 AM EST.</p>
                           </div>-->
                        <div class="breadcrumb-bar">
                           <div class="row">
                              <aside class="col-sm-6 col-8 bb-left">
                                 <a href="#">BOI E-Filing</a>
                                 <a href="#">File BOIR</a>
                              </aside>
                              <aside class="col-sm-6 col-4 bb-right">
                                 <a href="#"><img src="images/help.png" alt=""> Help</a>
                              </aside>
                           </div>
                        </div>
                     </div>
                     <h2>Beneficial Ownership Information Report (BOIR)</h2>
                     <p>Complete the report in its entirety with all required information. Fields marked with an asterisk (*) symbol are the fields that, at a minimum, must be completed by all companies to file the report. Reporting companies, however,
                        must include all information 31 CFR 1010.380(b) requires them to provide, regardless of whether a field is marked with an asterisk (*) symbol. These information requirements are summarized above under HELP.
                     </p>
                     <div class="step-form-main">
                        <div class="sf-top">
                            <h2> Step 1 of 7</h2>
                        </div>
						<div class="sf-form-top" style="margin-bottom: 30px;">
							<div class="progress-container">
								<div class="progress-bar-wrapper">
									<div class="progress-bar" id="progress1" style="width:4%; background-color:#B31942; padding-left: 40px;">
										<span class="progress-percentage" id="progress-percentage1">0%</span>
									</div>
								</div>
							</div>
						</div>
                        <div class="sf-main">
                           <div class="row">
                              <aside class="col-lg-3 sf-main-left">
                                 <ul>
                                    <li class="active"><a>Filing Information</a></li>
                                    <li><a>Reporting Company</a></li>
                                    <li><a>Company Applicant(s)</a></li>
                                    <li><a>Beneficial Owner(s)</a></li>
                                    <li><a>General Information</a></li>
                                    <li><a>Submitter Information</a></li>
                                    <li><a>Acknowledgement</a></li>
                                 </ul>
                              </aside>
                              <aside class="col-lg-9 sf-main-right">
                                 <h2>Filing Information</h2>
                                 <form action="#" id="FilingInfo" method="get">
                                    <div class="need-help-head row">
                                       <aside class="nh-left col-md-8">
                                        <h2>Choose Your Report Type</h2>
                                        <p>Please select the type of report you wish to file below.</p>
                                       </aside>
                                       <aside class="nh-right col-md-4">
                                        <div class="tool-tip-sec">
                                         <span><a class="hover-modal-btn" href="#boirNeedHelp0"><img src="/images/help-icon.svg" alt=""></a></span>
                                        </div>
                                       </aside>
                                      </div>
                                    <div class="sf-form-sec">
                                       
                                       <div class="sf-form-body">
                                          <input type="hidden" id="userId" name="userId" />
                                          <input type="hidden" id="filingInfoId" name="filingInfoId" />
                                         <input type="hidden" id="fincenId" name="fincenId" />
                                           
                                          <input type="hidden" id="currentStatus" name="currentStatus" />
                                           <input type="hidden" id="parentFilingInfoId" name="parentFilingInfoId" />
                                            <input type="hidden" id="prevSubmissionStatus" name="prevSubmissionStatus" />
                                          
                                          
                                            <div class="box-bg-sec br-btm-none">	
                                             <div class="form-rows no-margin pb-5">
                                                <label class="main-label" for="filingType">Report Type <em>*</em></label>
                                                <div class="form-fields">
                                                   <div class="row">
                                                      <div class="col-md-3 col-sm-6">
                                                         <label class="radio-box" title="">
                                                            <input type="radio" id="Initial" name="filingType" value="initial" 
                                                            <c:if test="${filingInfo.filingType == 'initial'}">checked</c:if>
                                                            /> Initial report
                                                         </label>
                                                      </div>
                                                      <div class="col-md-3 col-sm-6">
                                                         <label class="radio-box" title="">
                                                            <input type="radio" id="Correct" name="filingType" value="correct" 
                                                            <c:if test="${filingInfo.filingType == 'correct'}">checked</c:if>
                                                            /> Correct prior report
                                                         </label>
                                                      </div>
                                                      <div class="col-md-3 col-sm-6">
                                                         <label class="radio-box" title="">
                                                            <input type="radio" id="Update" name="filingType" value="update" 
                                                            <c:if test="${filingInfo.filingType == 'update'}">checked</c:if>
                                                            /> Update prior report
                                                         </label>
                                                      </div>
                                                      <div class="col-md-3 col-sm-6">
                                                         <label class="radio-box" title="">
                                                            <input type="radio" id="exemptRadio" name="filingType" value="newly" 
                                                            <c:if test="${filingInfo.filingType == 'newly'}">checked</c:if>
                                                            /> Newly exempt entity
                                                         </label>
                                                      </div>
                                                   </div>
                                                </div>
                                             </div>
                                             </div>
                                          <div class="exempt-modal modal fade" id="exemptModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
                                             <div class="modal-dialog modal-fullscreen modal-dialog-centered">
                                                <div class="container">
                                                   <div class="user-data-form step-form-modal modal-content">
                                                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                      <div class="modal-cont">
                                                         <h2>Confirm Exempt Status</h2>
                                                         <p>If your entity is exempt, you won't need to provide information for Reporting Company, Company Applicant, and Beneficial Owner. These fields will be cleared and disabled. Would you like to proceed?</p>
                                                         <div class="modal-btns step-mod-btns">
                                                            <button class="blue-btn" data-bs-dismiss="modal" id="exemptyes">Yes</button>
                                                            <button class="brdr-btn" data-bs-dismiss="modal" id="exemptno">No</button>
                                                         </div>
                                                      </div>
                                                   </div>
                                                </div>
                                             </div>
                                          </div>
                                          <div class="downcontent box-bg-sec br-top-none pb-15" style="display: none;">
                                             <div class="row two-fields pb-15">
                                                <div class="col-sm-6 mt-15" title="">
                                                   <label class="main-label" for="legalName" >Legal name <em>*</em></label>
                                                   <div class="form-fields">
                                                      <input type="text" id="legalName" name="legalName" value="" placeholder="Enter Reporting Company legal name" class="form-field" />
                                                   </div>
                                                </div>
                                                <div class="col-sm-6 mt-15" title="">
                                                   <label class="main-label" for="taxIdType"> Tax Identification type <em>*</em></label>
                                                   <div class="form-fields">
                                                      <select class="form-field" id="taxIdType" name="taxIdType">
                                                         <option value="">Select an ID type</option>
                                                         <option value="2">EIN</option>
                                                         <option value="1">SSN/ITIN</option>
                                                         <option value="9">Foreign</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div class="col-sm-6 mt-15" title="">
                                                   <label class="main-label" for="taxIdNum"> Tax Identification number <em>*</em></label>
                                                   <div class="form-fields">
                                                      <input type="text"  id="taxIdNum" name="taxIdNum" value="" placeholder="Enter Tax Identification number" class="form-field" />
                                                   </div>
                                                </div>
                                                <div class="col-sm-6 mt-15" title="">
                                                   <label class="main-label" for="countryOrJurisdiction"> Country/Jurisdiction (if foreign tax ID only)</label>
                                                   <div class="form-fields">
                                                      <select class="form-field" id="countryOrJurisdiction" name="countryOrJurisdiction">
                                                         <option value="">Select a country</option>
                                                         <option value="AF">Afghanistan</option>
                                                         <option value="AX">Åland Islands</option>
                                                         <option value="AL">Albania</option>
                                                         <option value="DZ">Algeria</option>
                                                         <option value="AD">Andorra</option>
                                                         <option value="AO">Angola</option>
                                                         <option value="AI">Anguilla</option>
                                                         <option value="AQ">Antarctica</option>
                                                         <option value="AG">Antigua And Barbuda</option>
                                                         <option value="AR">Argentina</option>
                                                         <option value="AM">Armenia</option>
                                                         <option value="AW">Aruba</option>
                                                         <option value="AU">Australia</option>
                                                         <option value="AT">Austria</option>
                                                         <option value="AZ">Azerbaijan</option>
                                                         <option value="BS">Bahamas</option>
                                                         <option value="BH">Bahrain</option>
                                                         <option value="BD">Bangladesh</option>
                                                         <option value="BB">Barbados</option>
                                                         <option value="BY">Belarus</option>
                                                         <option value="BE">Belgium</option>
                                                         <option value="BZ">Belize</option>
                                                         <option value="BJ">Benin</option>
                                                         <option value="BM">Bermuda</option>
                                                         <option value="BT">Bhutan</option>
                                                         <option value="BO">Bolivia, Plurinational State Of</option>
                                                         <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
                                                         <option value="BA">Bosnia And Herzegovina</option>
                                                         <option value="BW">Botswana</option>
                                                         <option value="BV">Bouvet Island</option>
                                                         <option value="BR">Brazil</option>
                                                         <option value="IO">British Indian Ocean Territory</option>
                                                         <option value="BN">Brunei Darussalam</option>
                                                         <option value="BG">Bulgaria</option>
                                                         <option value="BF">Burkina Faso</option>
                                                         <option value="BI">Burundi</option>
                                                         <option value="KH">Cambodia</option>
                                                         <option value="CM">Cameroon</option>
                                                         <option value="CA">Canada</option>
                                                         <option value="CV">Cape Verde</option>
                                                         <option value="KY">Cayman Islands</option>
                                                         <option value="CF">Central African Republic</option>
                                                         <option value="TD">Chad</option>
                                                         <option value="CL">Chile</option>
                                                         <option value="CN">China</option>
                                                         <option value="CX">Christmas Island</option>
                                                         <option value="CC">Cocos (Keeling) Islands</option>
                                                         <option value="CO">Colombia</option>
                                                         <option value="KM">Comoros</option>
                                                         <option value="CG">Congo</option>
                                                         <option value="CD">Congo, The Democratic Republic Of The</option>
                                                         <option value="CK">Cook Islands</option>
                                                         <option value="CR">Costa Rica</option>
                                                         <option value="CI">Côte D'ivoire</option>
                                                         <option value="HR">Croatia</option>
                                                         <option value="CU">Cuba</option>
                                                         <option value="CW">Curaçao</option>
                                                         <option value="CY">Cyprus</option>
                                                         <option value="CZ">Czech Republic</option>
                                                         <option value="DK">Denmark</option>
                                                         <option value="DJ">Djibouti</option>
                                                         <option value="DM">Dominica</option>
                                                         <option value="DO">Dominican Republic</option>
                                                         <option value="EC">Ecuador</option>
                                                         <option value="EG">Egypt</option>
                                                         <option value="SV">El Salvador</option>
                                                         <option value="GQ">Equatorial Guinea</option>
                                                         <option value="ER">Eritrea</option>
                                                         <option value="EE">Estonia</option>
                                                         <option value="ET">Ethiopia</option>
                                                         <option value="FK">Falkland Islands (Malvinas)</option>
                                                         <option value="FO">Faroe Islands</option>
                                                         <option value="FJ">Fiji</option>
                                                         <option value="FI">Finland</option>
                                                         <option value="FR">France</option>
                                                         <option value="GF">French Guiana</option>
                                                         <option value="PF">French Polynesia</option>
                                                         <option value="TF">French Southern Territories</option>
                                                         <option value="GA">Gabon</option>
                                                         <option value="GM">Gambia</option>
                                                         <option value="GE">Georgia</option>
                                                         <option value="DE">Germany</option>
                                                         <option value="GH">Ghana</option>
                                                         <option value="GI">Gibraltar</option>
                                                         <option value="GR">Greece</option>
                                                         <option value="GL">Greenland</option>
                                                         <option value="GD">Grenada</option>
                                                         <option value="GP">Guadeloupe</option>
                                                         <option value="GT">Guatemala</option>
                                                         <option value="GG">Guernsey</option>
                                                         <option value="GN">Guinea</option>
                                                         <option value="GW">Guinea-bissau</option>
                                                         <option value="GY">Guyana</option>
                                                         <option value="HT">Haiti</option>
                                                         <option value="HM">Heard Island And Mcdonald Islands</option>
                                                         <option value="VA">Holy See (Vatican City State)</option>
                                                         <option value="HN">Honduras</option>
                                                         <option value="HK">Hong Kong</option>
                                                         <option value="HU">Hungary</option>
                                                         <option value="IS">Iceland</option>
                                                         <option value="IN">India</option>
                                                         <option value="ID">Indonesia</option>
                                                         <option value="IR">Iran, Islamic Republic Of</option>
                                                         <option value="IQ">Iraq</option>
                                                         <option value="IE">Ireland</option>
                                                         <option value="IM">Isle Of Man</option>
                                                         <option value="IL">Israel</option>
                                                         <option value="IT">Italy</option>
                                                         <option value="JM">Jamaica</option>
                                                         <option value="JP">Japan</option>
                                                         <option value="JE">Jersey</option>
                                                         <option value="JO">Jordan</option>
                                                         <option value="KZ">Kazakhstan</option>
                                                         <option value="KE">Kenya</option>
                                                         <option value="KI">Kiribati</option>
                                                         <option value="KP">Korea, Democratic People's Republic Of</option>
                                                         <option value="KR">Korea, Republic Of</option>
                                                         <option value="KW">Kuwait</option>
                                                         <option value="KG">Kyrgyzstan</option>
                                                         <option value="LA">Lao People's Democratic Republic</option>
                                                         <option value="LV">Latvia</option>
                                                         <option value="LB">Lebanon</option>
                                                         <option value="LS">Lesotho</option>
                                                         <option value="LR">Liberia</option>
                                                         <option value="LY">Libya</option>
                                                         <option value="LI">Liechtenstein</option>
                                                         <option value="LT">Lithuania</option>
                                                         <option value="LU">Luxembourg</option>
                                                         <option value="MO">Macao</option>
                                                         <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
                                                         <option value="MG">Madagascar</option>
                                                         <option value="MW">Malawi</option>
                                                         <option value="MY">Malaysia</option>
                                                         <option value="MV">Maldives</option>
                                                         <option value="ML">Mali</option>
                                                         <option value="MT">Malta</option>
                                                         <option value="MQ">Martinique</option>
                                                         <option value="MR">Mauritania</option>
                                                         <option value="MU">Mauritius</option>
                                                         <option value="YT">Mayotte</option>
                                                         <option value="MX">Mexico</option>
                                                         <option value="MD">Moldova, Republic Of</option>
                                                         <option value="MC">Monaco</option>
                                                         <option value="MN">Mongolia</option>
                                                         <option value="ME">Montenegro</option>
                                                         <option value="MS">Montserrat</option>
                                                         <option value="MA">Morocco</option>
                                                         <option value="MZ">Mozambique</option>
                                                         <option value="MM">Myanmar</option>
                                                         <option value="NA">Namibia</option>
                                                         <option value="NR">Nauru</option>
                                                         <option value="NP">Nepal</option>
                                                         <option value="NL">Netherlands</option>
                                                         <option value="NC">New Caledonia</option>
                                                         <option value="NZ">New Zealand</option>
                                                         <option value="NI">Nicaragua</option>
                                                         <option value="NE">Niger</option>
                                                         <option value="NG">Nigeria</option>
                                                         <option value="NU">Niue</option>
                                                         <option value="NF">Norfolk Island</option>
                                                         <option value="NO">Norway</option>
                                                         <option value="OM">Oman</option>
                                                         <option value="PK">Pakistan</option>
                                                         <option value="PS">Palestinian Territory, Occupied</option>
                                                         <option value="PA">Panama</option>
                                                         <option value="PG">Papua New Guinea</option>
                                                         <option value="PY">Paraguay</option>
                                                         <option value="PE">Peru</option>
                                                         <option value="PH">Philippines</option>
                                                         <option value="PN">Pitcairn</option>
                                                         <option value="PL">Poland</option>
                                                         <option value="PT">Portugal</option>
                                                         <option value="QA">Qatar</option>
                                                         <option value="RE">Réunion</option>
                                                         <option value="RO">Romania</option>
                                                         <option value="RU">Russian Federation</option>
                                                         <option value="RW">Rwanda</option>
                                                         <option value="BL">Saint Barthélemy</option>
                                                         <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
                                                         <option value="KN">Saint Kitts And Nevis</option>
                                                         <option value="LC">Saint Lucia</option>
                                                         <option value="MF">Saint Martin (french Part)</option>
                                                         <option value="PM">Saint Pierre And Miquelon</option>
                                                         <option value="VC">Saint Vincent And The Grenadines</option>
                                                         <option value="WS">Samoa</option>
                                                         <option value="SM">San Marino</option>
                                                         <option value="ST">Sao Tome And Principe</option>
                                                         <option value="SA">Saudi Arabia</option>
                                                         <option value="SN">Senegal</option>
                                                         <option value="RS">Serbia</option>
                                                         <option value="SC">Seychelles</option>
                                                         <option value="SL">Sierra Leone</option>
                                                         <option value="SG">Singapore</option>
                                                         <option value="SX">Sint Maarten (dutch Part)</option>
                                                         <option value="SK">Slovakia</option>
                                                         <option value="SI">Slovenia</option>
                                                         <option value="SB">Solomon Islands</option>
                                                         <option value="SO">Somalia</option>
                                                         <option value="ZA">South Africa</option>
                                                         <option value="GS">South Georgia And The South Sandwich Islands</option>
                                                         <option value="SS">South Sudan</option>
                                                         <option value="ES">Spain</option>
                                                         <option value="LK">Sri Lanka</option>
                                                         <option value="SD">Sudan</option>
                                                         <option value="SR">Suriname</option>
                                                         <option value="SJ">Svalbard And Jan Mayen</option>
                                                         <option value="SZ">Swaziland</option>
                                                         <option value="SE">Sweden</option>
                                                         <option value="CH">Switzerland</option>
                                                         <option value="SY">Syrian Arab Republic</option>
                                                         <option value="TW">Taiwan</option>
                                                         <option value="TJ">Tajikistan</option>
                                                         <option value="TZ">Tanzania, United Republic Of</option>
                                                         <option value="TH">Thailand</option>
                                                         <option value="TL">Timor-leste</option>
                                                         <option value="TG">Togo</option>
                                                         <option value="TK">Tokelau</option>
                                                         <option value="TO">Tonga</option>
                                                         <option value="TT">Trinidad And Tobago</option>
                                                         <option value="TN">Tunisia</option>
                                                         <option value="TR">Turkey</option>
                                                         <option value="TM">Turkmenistan</option>
                                                         <option value="TC">Turks And Caicos Islands</option>
                                                         <option value="TV">Tuvalu</option>
                                                         <option value="UG">Uganda</option>
                                                         <option value="UA">Ukraine</option>
                                                         <option value="AE">United Arab Emirates</option>
                                                         <option value="GB">United Kingdom</option>
                                                         <option value="UY">Uruguay</option>
                                                         <option value="UZ">Uzbekistan</option>
                                                         <option value="VU">Vanuatu</option>
                                                         <option value="VE">Venezuela, Bolivarian Republic Of</option>
                                                         <option value="VN">Viet Nam</option>
                                                         <option value="VG">Virgin Islands, British</option>
                                                         <option value="WF">Wallis And Futuna</option>
                                                         <option value="EH">Western Sahara</option>
                                                         <option value="YE">Yemen</option>
                                                         <option value="ZM">Zambia</option>
                                                         <option value="ZW">Zimbabwe</option>
                                                      </select>
                                                   </div>
                                                </div>
                                             </div>
                                          </div>
                                          <div class="form-rows" title="">
                                             <!--    <label class="main-label" for="datePrepared">2. Date of Incorporation</label>-->
                                             <div class="form-fields">
                                                <div class="date-field col-sm-6">
                                                   <input type="hidden" id="datePrepared" name="datePrepared" value="" placeholder="06/20/2024" class="form-field"/>
                                                </div>
                                             </div>
                                          </div>

                                          
                                       </div>
                                       <div class="sf-form-footer">
                                          <div class="row">
                                             <aside class="col-sm-4 col-6 sf-foot-left">
                                                <button class="brdr-btn loading-button" id="filingpre">
                                                   Previous
                                                   <div class="spinner"></div>
                                                </button>
                                             </aside>
                                             <aside class="col-sm-8 col-6 sf-foot-right">
                                                <div class="sf-btns">
                                                   <button class="bg-btn loading-button" id="next1" type="submit" value="submit">
                                                      <span class="btn-text">Save & Proceed</span>
                                                      <div class="spinner"></div>
                                                   </button>
                                                </div>
                                             </aside>
                                          </div>
                                       </div>
                                    </div>
                                 </form>
                                 <div class="sf-btm-bar">
                                    <p><a class="hover-modal-btn" href="#boirNeedHelp19"><img src="images/Bell.png" alt="" /> PRIVACY ACT AND PAPERWORK REDUCTION ACT NOTICE</a></p>
                                 </div>
                              </aside>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="step" id="step2">
               <section class="page-cont">
                  <div class="mid-content">
                     <div class="container">
                        <div class="cust-cf">
                           <!--<div class="notify-bar">
                              <p><img src="images/Bell.png"> Notification: Site Maintenance: BOI E-Filing System site will be unavailable for scheduled maintenance on June 21st, from 6:00 AM - 8:00 AM EST.</p>
                              </div>-->
                           <div class="breadcrumb-bar">
                              <div class="row">
                                 <aside class="col-sm-6 col-8 bb-left">
                                    <a href="#">BOI E-Filing</a>
                                    <a href="#">File BOIR</a>
                                 </aside>
                                 <aside class="col-sm-6 col-4 bb-right">
                                    <a href="#"><img src="images/help.png" alt=""> Help</a>
                                 </aside>
                              </div>
                           </div>
                        </div>
                        <h2>Beneficial Ownership Information Report (BOIR)</h2>
                        <p>Complete the report in its entirety with all required information. Fields marked with an asterisk (*) symbol are the fields that, at a minimum, must be completed by all companies to file the report. Reporting companies, however,
                           must include all information 31 CFR 1010.380(b) requires them to provide, regardless of whether a field is marked with an asterisk (*) symbol. These information requirements are summarized above under HELP.
                        </p>
                        <div class="step-form-main">
                           <div class="sf-top">
                              <h2>Step 2 of 7</h2>
                           </div>
						   <div class="sf-form-top" style="margin-bottom: 30px;">
						   		<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress2" style="width:16.67%; background-color:#B31942;">
						   					<span class="progress-percentage" id="progress-percentage2">17%</span>
						   				</div>
						   			</div>
						   		</div>
						   	</div>   
                           <div class="sf-main">
                              <div class="row">
                                 <aside class="col-lg-3 sf-main-left">
                                    <ul>
                                       <li><a>Filing Information <i class="bi bi-check custom-icon"></i></a></li>
                                       <li class="active"><a>Reporting Company</a></li>
                                       <li><a>Company Applicant(s)</a></li>
                                       <li><a>Beneficial Owner(s)</a></li>
                                       <li><a>General Information</a></li>
                                       <li><a>Submitter Information</a></li>
                                       <li><a>Acknowledgement</a></li>
                                    </ul>
                                 </aside>
                                 <aside class="col-lg-9 sf-main-right">
                                    
                                    <form action="#" id="ReportingCom" method="get">

                                       <div class="need-help-head row">
                                          <aside class="nh-left col-md-8">
                                            <h2>Tell Us About Your Company</h2>
                                            <p>Please provide the following details about your company.</p>
                                           </aside>
                                           <aside class="nh-right col-md-4">	 									  
                                              <span><a class="hover-modal-btn" href="#boirNeedHelp1"><img src="/images/help-icon.svg" alt=""></a></span>
                                            </aside>
                                         </div>	   

                                       <div class="sf-form-sec">
                                <div class="sf-form-body">
											<div id="req-fincen-field-def">
											    <div class="form-rows">
											       <div class="row two-fields box-bg-sec no-margin">
											         <!-- lok start -->  
											                <div style="display: none;" class="col-md-6"  title="">
											                    <label class="main-label">Request to receive FinCEN ID</label>
											                    <div class="form-fields">
											                       <div class="row">
											                          <label class="col-sm-6">
											                          <input type="radio"  name="requestToReceiveFinCenId" value="true" id="request3yes" checked/> Yes</label>
											                          <label class="col-sm-6">
											                          <input type="radio" name="requestToReceiveFinCenId" value="false" id="request3no" /> No</label>
											                       </div>
											                    </div>
											                </div>
											                <div class="col-md-6" title="">
											                    <label class="main-label" for="foreignPooledInvestmentVehicle">Foreign pooled investment vehicle</label>
											                    <div class="form-fields">
											                       <div class="row">
											                          <label class="col-sm-6">
											                          <input type="radio" id="foreigninveyes" name="foreignPooledInvestmentVehicle" value="true" /> Yes</label>
											                          <label class="col-sm-6">
											                          <input type="radio" id="foreigninveno" name="foreignPooledInvestmentVehicle" value="false" checked /> No</label>
											                       </div>
											                    </div>
											                 </div>
											           
											               <div class="col-md-6 rbrdr-sec" id="reqFincenInitial">
                                                  <div class="req-para">
                                                    <p class="req-p para-in-input">Since you're filing an Initial Report, a company FinCEN ID will be automatically applied for when you submit this form.</br>No further action is required on your part.</p>
                                                   </div>
                                                </div>
											               <div  style="display: none;" id="reqFincenEdit" class="col-md-6" title="">
                                                   <label class="main-label">Your Company FinCEN ID</label>
                                                   <div class="form-fields">
                                                      <p class="text-muted mb-2" style="font-size: 0.8rem;">This ID was automatically generated when your initial report was filed.</p>
                                                   <div class="border rounded p-2">
                                                      <span id="fincenidspan" class="h5 text-dark"></span>
                                                   </div>
                                                   </div>
											               </div>
											           
											        </div> 
											    </div>
											</div>
											<!-- <div id="req-fincen-field" style="display:none;">
                                                  <div class="form-rows">
                                                      <div class="row two-fields">
                                                          <div class="col-md-6" title="">
                                                              <label class="main-label" for="foreignPooledInvestmentVehicle2">2. Foreign pooled investment vehicle</label>
                                                              <div class="form-fields">
                                                                  <div class="row">
                                                                      <label class="col-sm-6">
                                                                          <input type="radio" id="foreigninveyes2" name="foreignPooledInvestmentVehicle2" value="true" /> Yes</label>
                                                                      <label class="col-sm-6">
                                                                          <input type="radio" id="foreigninveno2" name="foreignPooledInvestmentVehicle2" value="false" checked  /> No</label>
                                                                  </div>
                                                              </div>
                                                          </div>
                                                          <div class="col-md-6 rbrdr-sec">
                                                              <div class="req-para">
 																 <label class="main-label"></label>
                                                                  <p class="req-p para-in-input">Since you're filing an Initial Report, a company FinCEN ID will be automatically applied for when you submit this form.</br>No further action is required on your part.
                                                                  </p>
                                                              </div>
                                                          </div>
                                                      </div>
                                                  </div>
                                             </div>
											 -->
											 <div class="accordion def-acc-sec" id="accordionDefault">
                                    <!-- Legal Name and DBAs Accordian Open -->
											  <div class="accordion-item box-bg-sec">
												<div class="accordion-header row">
										         <div class="dah-left col-md-8"><h2>Legal Name and DBAs</h2></div>
												 <div class="dah-right col-md-4">
												  <span><a class="hover-modal-btn" href="#boirNeedHelp2"><img src="/images/help-icon.svg" alt=""></a></span>
										          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne"></button>
                                             </div>
												</div>
												<div id="collapseOne" class="accordion-collapse collapse show">
												 <div class="accordion-body">
													<div class="ab-top-para"><p>Enter your company's official legal name and any other names it operates under.</p>
                                             <div class="form-rows pt-15">
	                                                <label class="main-label" for="reportingCompanyLegalName">Reporting Company legal name <em>*</em></label>
                                                <div class="form-fields">
                                                   <div class="normal-field col-md-6">
                                                      <input type="text" id="reportingCompanyLegalName" name="reportingCompanyLegalName" value="" placeholder="Enter Reporting Company legal name" class="form-field" title=""/>
                                                   </div>
                                                </div>
                                             </div>
                                             <div id="alternate-names-container" title="">
                                                <div class="form-rows" id="alternate-name-0">
	                                                   <label class="main-label" for="alternateName">Alternate name (e.g. trade name, DBA)</label>
                                                   <div class="form-fields d-flex">
                                                      <div class="normal-field col-sm-8" >
                                                         <input type="text" id="alternateName" name="alternateName[0].name" placeholder="Enter Alternate name" class="alternate-name form-field form-control" />
                                                      </div>
                                                      <div class="col-sm-4">
                                                         <button class="remove-alternate-name btn btn-primary d-none bg-btn" data-index="0">Remove</button>
                                                      </div>
                                                   </div>
                                                </div>
                                             </div>
                                             <div class="sf-btn-bar" title="">
                                                <button class="bg-btn" id="add-alternate-name">Add Alternate Name</button>
                                             </div>
                                             </div>
                                             </div>
											  </div>
											  </div>
                                   <!-- Legal Name and DBAs close -->
                                   <!-- Tax Identification Accordian Item Open -->
											  <div class="accordion-item box-bg-sec">
												<div class="accordion-header row">
												 <div class="dah-left col-md-8"><h2>Tax Identification</h2></div>
												<div class="dah-right col-md-4">
												 <span title=""><a class="hover-modal-btn" href="#boirNeedHelp3"><img src="/images/help-icon.svg" alt=""></a></span>
												 <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo"></button>
												</div>
												</div>
												<div id="collapseTwo" class="accordion-collapse collapse show">
												 <div class="accordion-body">
													<div class="ab-top-para"><p>Please provide your company's tax identification number. This can be your EIN, SSN, or ITIN.</p></div>
													<p>If your business is based overseas and is only registered in the US, and not required to file US tax returns, you may use your foreign tax identification number instead.</p>
                                             <div class="row two-fields">
                                                <div class="col-md-6 mt-15" title="">
													                                                   <label class="main-label" for="taxIdentificationType">Tax Identification type <em>*</em></label>
                                                   <div class="form-fields">
                                                      <select class="form-field" id="taxIdentificationType" name="taxIdentificationType">
                                                         <option value="">Select an ID type</option>
                                                         <option value="2">EIN</option>
                                                         <option value="1">SSN/ITIN</option>
                                                         <option value="9">Foreign</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div class="col-md-6 mt-15" title="">
                                                   <label class="main-label" for="taxIdentificationNumber">Tax Identification number <em>*</em></label>
                                                   <div class="form-fields">
                                                      <input type="text"  id="taxIdentificationNumber" name="taxIdentificationNumber" value="" placeholder="Enter Tax Identification number" class="form-field" disabled/>
                                                   </div>
                                                </div>
                                                <div class="col-md-6 mt-15" title="">
													                                                   <label class="main-label" for="countryOrJurisdictionRep">Country/Jurisdiction (if foreign tax ID only)</label>
                                                   <div class="form-fields">
                                                      <select class="form-field" id="countryOrJurisdictionRep" name="countryOrJurisdictionRep" disabled>
                                                         <option value="">Select a country</option>
                                                         <option value="AF">Afghanistan</option>
                                                         <option value="AX">Åland Islands</option>
                                                         <option value="AL">Albania</option>
                                                         <option value="DZ">Algeria</option>
                                                         <option value="AD">Andorra</option>
                                                         <option value="AO">Angola</option>
                                                         <option value="AI">Anguilla</option>
                                                         <option value="AQ">Antarctica</option>
                                                         <option value="AG">Antigua And Barbuda</option>
                                                         <option value="AR">Argentina</option>
                                                         <option value="AM">Armenia</option>
                                                         <option value="AW">Aruba</option>
                                                         <option value="AU">Australia</option>
                                                         <option value="AT">Austria</option>
                                                         <option value="AZ">Azerbaijan</option>
                                                         <option value="BS">Bahamas</option>
                                                         <option value="BH">Bahrain</option>
                                                         <option value="BD">Bangladesh</option>
                                                         <option value="BB">Barbados</option>
                                                         <option value="BY">Belarus</option>
                                                         <option value="BE">Belgium</option>
                                                         <option value="BZ">Belize</option>
                                                         <option value="BJ">Benin</option>
                                                         <option value="BM">Bermuda</option>
                                                         <option value="BT">Bhutan</option>
                                                         <option value="BO">Bolivia, Plurinational State Of</option>
                                                         <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
                                                         <option value="BA">Bosnia And Herzegovina</option>
                                                         <option value="BW">Botswana</option>
                                                         <option value="BV">Bouvet Island</option>
                                                         <option value="BR">Brazil</option>
                                                         <option value="IO">British Indian Ocean Territory</option>
                                                         <option value="BN">Brunei Darussalam</option>
                                                         <option value="BG">Bulgaria</option>
                                                         <option value="BF">Burkina Faso</option>
                                                         <option value="BI">Burundi</option>
                                                         <option value="KH">Cambodia</option>
                                                         <option value="CM">Cameroon</option>
                                                         <option value="CA">Canada</option>
                                                         <option value="CV">Cape Verde</option>
                                                         <option value="KY">Cayman Islands</option>
                                                         <option value="CF">Central African Republic</option>
                                                         <option value="TD">Chad</option>
                                                         <option value="CL">Chile</option>
                                                         <option value="CN">China</option>
                                                         <option value="CX">Christmas Island</option>
                                                         <option value="CC">Cocos (Keeling) Islands</option>
                                                         <option value="CO">Colombia</option>
                                                         <option value="KM">Comoros</option>
                                                         <option value="CG">Congo</option>
                                                         <option value="CD">Congo, The Democratic Republic Of The</option>
                                                         <option value="CK">Cook Islands</option>
                                                         <option value="CR">Costa Rica</option>
                                                         <option value="CI">Côte D'ivoire</option>
                                                         <option value="HR">Croatia</option>
                                                         <option value="CU">Cuba</option>
                                                         <option value="CW">Curaçao</option>
                                                         <option value="CY">Cyprus</option>
                                                         <option value="CZ">Czech Republic</option>
                                                         <option value="DK">Denmark</option>
                                                         <option value="DJ">Djibouti</option>
                                                         <option value="DM">Dominica</option>
                                                         <option value="DO">Dominican Republic</option>
                                                         <option value="EC">Ecuador</option>
                                                         <option value="EG">Egypt</option>
                                                         <option value="SV">El Salvador</option>
                                                         <option value="GQ">Equatorial Guinea</option>
                                                         <option value="ER">Eritrea</option>
                                                         <option value="EE">Estonia</option>
                                                         <option value="ET">Ethiopia</option>
                                                         <option value="FK">Falkland Islands (Malvinas)</option>
                                                         <option value="FO">Faroe Islands</option>
                                                         <option value="FJ">Fiji</option>
                                                         <option value="FI">Finland</option>
                                                         <option value="FR">France</option>
                                                         <option value="GF">French Guiana</option>
                                                         <option value="PF">French Polynesia</option>
                                                         <option value="TF">French Southern Territories</option>
                                                         <option value="GA">Gabon</option>
                                                         <option value="GM">Gambia</option>
                                                         <option value="GE">Georgia</option>
                                                         <option value="DE">Germany</option>
                                                         <option value="GH">Ghana</option>
                                                         <option value="GI">Gibraltar</option>
                                                         <option value="GR">Greece</option>
                                                         <option value="GL">Greenland</option>
                                                         <option value="GD">Grenada</option>
                                                         <option value="GP">Guadeloupe</option>
                                                         <option value="GT">Guatemala</option>
                                                         <option value="GG">Guernsey</option>
                                                         <option value="GN">Guinea</option>
                                                         <option value="GW">Guinea-bissau</option>
                                                         <option value="GY">Guyana</option>
                                                         <option value="HT">Haiti</option>
                                                         <option value="HM">Heard Island And Mcdonald Islands</option>
                                                         <option value="VA">Holy See (Vatican City State)</option>
                                                         <option value="HN">Honduras</option>
                                                         <option value="HK">Hong Kong</option>
                                                         <option value="HU">Hungary</option>
                                                         <option value="IS">Iceland</option>
                                                         <option value="IN">India</option>
                                                         <option value="ID">Indonesia</option>
                                                         <option value="IR">Iran, Islamic Republic Of</option>
                                                         <option value="IQ">Iraq</option>
                                                         <option value="IE">Ireland</option>
                                                         <option value="IM">Isle Of Man</option>
                                                         <option value="IL">Israel</option>
                                                         <option value="IT">Italy</option>
                                                         <option value="JM">Jamaica</option>
                                                         <option value="JP">Japan</option>
                                                         <option value="JE">Jersey</option>
                                                         <option value="JO">Jordan</option>
                                                         <option value="KZ">Kazakhstan</option>
                                                         <option value="KE">Kenya</option>
                                                         <option value="KI">Kiribati</option>
                                                         <option value="KP">Korea, Democratic People's Republic Of</option>
                                                         <option value="KR">Korea, Republic Of</option>
                                                         <option value="KW">Kuwait</option>
                                                         <option value="KG">Kyrgyzstan</option>
                                                         <option value="LA">Lao People's Democratic Republic</option>
                                                         <option value="LV">Latvia</option>
                                                         <option value="LB">Lebanon</option>
                                                         <option value="LS">Lesotho</option>
                                                         <option value="LR">Liberia</option>
                                                         <option value="LY">Libya</option>
                                                         <option value="LI">Liechtenstein</option>
                                                         <option value="LT">Lithuania</option>
                                                         <option value="LU">Luxembourg</option>
                                                         <option value="MO">Macao</option>
                                                         <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
                                                         <option value="MG">Madagascar</option>
                                                         <option value="MW">Malawi</option>
                                                         <option value="MY">Malaysia</option>
                                                         <option value="MV">Maldives</option>
                                                         <option value="ML">Mali</option>
                                                         <option value="MT">Malta</option>
                                                         <option value="MQ">Martinique</option>
                                                         <option value="MR">Mauritania</option>
                                                         <option value="MU">Mauritius</option>
                                                         <option value="YT">Mayotte</option>
                                                         <option value="MX">Mexico</option>
                                                         <option value="MD">Moldova, Republic Of</option>
                                                         <option value="MC">Monaco</option>
                                                         <option value="MN">Mongolia</option>
                                                         <option value="ME">Montenegro</option>
                                                         <option value="MS">Montserrat</option>
                                                         <option value="MA">Morocco</option>
                                                         <option value="MZ">Mozambique</option>
                                                         <option value="MM">Myanmar</option>
                                                         <option value="NA">Namibia</option>
                                                         <option value="NR">Nauru</option>
                                                         <option value="NP">Nepal</option>
                                                         <option value="NL">Netherlands</option>
                                                         <option value="NC">New Caledonia</option>
                                                         <option value="NZ">New Zealand</option>
                                                         <option value="NI">Nicaragua</option>
                                                         <option value="NE">Niger</option>
                                                         <option value="NG">Nigeria</option>
                                                         <option value="NU">Niue</option>
                                                         <option value="NF">Norfolk Island</option>
                                                         <option value="NO">Norway</option>
                                                         <option value="OM">Oman</option>
                                                         <option value="PK">Pakistan</option>
                                                         <option value="PS">Palestinian Territory, Occupied</option>
                                                         <option value="PA">Panama</option>
                                                         <option value="PG">Papua New Guinea</option>
                                                         <option value="PY">Paraguay</option>
                                                         <option value="PE">Peru</option>
                                                         <option value="PH">Philippines</option>
                                                         <option value="PN">Pitcairn</option>
                                                         <option value="PL">Poland</option>
                                                         <option value="PT">Portugal</option>
                                                         <option value="QA">Qatar</option>
                                                         <option value="RE">Réunion</option>
                                                         <option value="RO">Romania</option>
                                                         <option value="RU">Russian Federation</option>
                                                         <option value="RW">Rwanda</option>
                                                         <option value="BL">Saint Barthélemy</option>
                                                         <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
                                                         <option value="KN">Saint Kitts And Nevis</option>
                                                         <option value="LC">Saint Lucia</option>
                                                         <option value="MF">Saint Martin (french Part)</option>
                                                         <option value="PM">Saint Pierre And Miquelon</option>
                                                         <option value="VC">Saint Vincent And The Grenadines</option>
                                                         <option value="WS">Samoa</option>
                                                         <option value="SM">San Marino</option>
                                                         <option value="ST">Sao Tome And Principe</option>
                                                         <option value="SA">Saudi Arabia</option>
                                                         <option value="SN">Senegal</option>
                                                         <option value="RS">Serbia</option>
                                                         <option value="SC">Seychelles</option>
                                                         <option value="SL">Sierra Leone</option>
                                                         <option value="SG">Singapore</option>
                                                         <option value="SX">Sint Maarten (dutch Part)</option>
                                                         <option value="SK">Slovakia</option>
                                                         <option value="SI">Slovenia</option>
                                                         <option value="SB">Solomon Islands</option>
                                                         <option value="SO">Somalia</option>
                                                         <option value="ZA">South Africa</option>
                                                         <option value="GS">South Georgia And The South Sandwich Islands</option>
                                                         <option value="SS">South Sudan</option>
                                                         <option value="ES">Spain</option>
                                                         <option value="LK">Sri Lanka</option>
                                                         <option value="SD">Sudan</option>
                                                         <option value="SR">Suriname</option>
                                                         <option value="SJ">Svalbard And Jan Mayen</option>
                                                         <option value="SZ">Swaziland</option>
                                                         <option value="SE">Sweden</option>
                                                         <option value="CH">Switzerland</option>
                                                         <option value="SY">Syrian Arab Republic</option>
                                                         <option value="TW">Taiwan</option>
                                                         <option value="TJ">Tajikistan</option>
                                                         <option value="TZ">Tanzania, United Republic Of</option>
                                                         <option value="TH">Thailand</option>
                                                         <option value="TL">Timor-leste</option>
                                                         <option value="TG">Togo</option>
                                                         <option value="TK">Tokelau</option>
                                                         <option value="TO">Tonga</option>
                                                         <option value="TT">Trinidad And Tobago</option>
                                                         <option value="TN">Tunisia</option>
                                                         <option value="TR">Turkey</option>
                                                         <option value="TM">Turkmenistan</option>
                                                         <option value="TC">Turks And Caicos Islands</option>
                                                         <option value="TV">Tuvalu</option>
                                                         <option value="UG">Uganda</option>
                                                         <option value="UA">Ukraine</option>
                                                         <option value="AE">United Arab Emirates</option>
                                                         <option value="GB">United Kingdom</option>
                                                         <option value="UY">Uruguay</option>
                                                         <option value="UZ">Uzbekistan</option>
                                                         <option value="VU">Vanuatu</option>
                                                         <option value="VE">Venezuela, Bolivarian Republic Of</option>
                                                         <option value="VN">Viet Nam</option>
                                                         <option value="VG">Virgin Islands, British</option>
                                                         <option value="WF">Wallis And Futuna</option>
                                                         <option value="EH">Western Sahara</option>
                                                         <option value="YE">Yemen</option>
                                                         <option value="ZM">Zambia</option>
                                                         <option value="ZW">Zimbabwe</option>
                                                      </select>
                                                   </div>
                                                </div>
                                             </div>
                                             </div>
 </div>
											  </div>
											  <!-- Tax Identification Accordian Item Close -->
                                   <!-- Jurisdiction of Formation or First Registration Accordian Item Open -->
											  <div class="accordion-item box-bg-sec">
  												<div class="accordion-header row">
  												 <div class="dah-left col-md-8"><h2>Jurisdiction of Formation or First Registration</h2></div>
  												<div class="dah-right col-md-4">
  												 <span title=""><a class="hover-modal-btn" href="#boirNeedHelp4"><img src="/images/help-icon.svg" alt=""></a></span>
  												 <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree"></button>
  												</div>
  												</div>
  												<div id="collapseThree" class="accordion-collapse collapse show">
  												 <div class="accordion-body">
  													<div class="ab-top-para"><p>Please select the state (or tribal jurisdiction) where your company initially filed its formation or registration documents.</p></div>
                                             <div class="row two-fields">
                                                <div class="col-md-6 mt-15" title="">
													                                                   <label class="main-label" for="countryOrJurisdictionFormation">Country/Jurisdiction of formation <em>*</em></label>
                                                   <div class="form-fields">
                                                      <select class="form-field" id="countryOrJurisdictionFormation" name="countryOrJurisdictionFormation">
                                                         <option value="">Select Country</option>
                                                         <option value="US">United States of America</option>
                                                         <option value="AS">American Samoa</option>
                                                         <option value="GU">Guam</option>
                                                         <option value="MH">Marshall Islands</option>
                                                         <option value="FM">Micronesia, Federated States</option>
                                                         <option value="MP">Northern Mariana Islands</option>
                                                         <option value="PW">Palau</option>
                                                         <option value="PR">Puerto Rico</option>
                                                         <option value="VI">U.S. Virgin Islands</option>
                                                         <option value="AF">Afghanistan</option>
                                                         <option value="AX">Åland Islands</option>
                                                         <option value="AL">Albania</option>
                                                         <option value="DZ">Algeria</option>
                                                         <option value="AD">Andorra</option>
                                                         <option value="AO">Angola</option>
                                                         <option value="AI">Anguilla</option>
                                                         <option value="AQ">Antarctica</option>
                                                         <option value="AG">Antigua And Barbuda</option>
                                                         <option value="AR">Argentina</option>
                                                         <option value="AM">Armenia</option>
                                                         <option value="AW">Aruba</option>
                                                         <option value="AU">Australia</option>
                                                         <option value="AT">Austria</option>
                                                         <option value="AZ">Azerbaijan</option>
                                                         <option value="BS">Bahamas</option>
                                                         <option value="BH">Bahrain</option>
                                                         <option value="BD">Bangladesh</option>
                                                         <option value="BB">Barbados</option>
                                                         <option value="BY">Belarus</option>
                                                         <option value="BE">Belgium</option>
                                                         <option value="BZ">Belize</option>
                                                         <option value="BJ">Benin</option>
                                                         <option value="BM">Bermuda</option>
                                                         <option value="BT">Bhutan</option>
                                                         <option value="BO">Bolivia, Plurinational State Of</option>
                                                         <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
                                                         <option value="BA">Bosnia And Herzegovina</option>
                                                         <option value="BW">Botswana</option>
                                                         <option value="BV">Bouvet Island</option>
                                                         <option value="BR">Brazil</option>
                                                         <option value="IO">British Indian Ocean Territory</option>
                                                         <option value="BN">Brunei Darussalam</option>
                                                         <option value="BG">Bulgaria</option>
                                                         <option value="BF">Burkina Faso</option>
                                                         <option value="BI">Burundi</option>
                                                         <option value="KH">Cambodia</option>
                                                         <option value="CM">Cameroon</option>
                                                         <option value="CA">Canada</option>
                                                         <option value="CV">Cape Verde</option>
                                                         <option value="KY">Cayman Islands</option>
                                                         <option value="CF">Central African Republic</option>
                                                         <option value="TD">Chad</option>
                                                         <option value="CL">Chile</option>
                                                         <option value="CN">China</option>
                                                         <option value="CX">Christmas Island</option>
                                                         <option value="CC">Cocos (Keeling) Islands</option>
                                                         <option value="CO">Colombia</option>
                                                         <option value="KM">Comoros</option>
                                                         <option value="CG">Congo</option>
                                                         <option value="CD">Congo, The Democratic Republic Of The</option>
                                                         <option value="CK">Cook Islands</option>
                                                         <option value="CR">Costa Rica</option>
                                                         <option value="CI">Côte D'ivoire</option>
                                                         <option value="HR">Croatia</option>
                                                         <option value="CU">Cuba</option>
                                                         <option value="CW">Curaçao</option>
                                                         <option value="CY">Cyprus</option>
                                                         <option value="CZ">Czech Republic</option>
                                                         <option value="DK">Denmark</option>
                                                         <option value="DJ">Djibouti</option>
                                                         <option value="DM">Dominica</option>
                                                         <option value="DO">Dominican Republic</option>
                                                         <option value="EC">Ecuador</option>
                                                         <option value="EG">Egypt</option>
                                                         <option value="SV">El Salvador</option>
                                                         <option value="GQ">Equatorial Guinea</option>
                                                         <option value="ER">Eritrea</option>
                                                         <option value="EE">Estonia</option>
                                                         <option value="ET">Ethiopia</option>
                                                         <option value="FK">Falkland Islands (Malvinas)</option>
                                                         <option value="FO">Faroe Islands</option>
                                                         <option value="FJ">Fiji</option>
                                                         <option value="FI">Finland</option>
                                                         <option value="FR">France</option>
                                                         <option value="GF">French Guiana</option>
                                                         <option value="PF">French Polynesia</option>
                                                         <option value="TF">French Southern Territories</option>
                                                         <option value="GA">Gabon</option>
                                                         <option value="GM">Gambia</option>
                                                         <option value="GE">Georgia</option>
                                                         <option value="DE">Germany</option>
                                                         <option value="GH">Ghana</option>
                                                         <option value="GI">Gibraltar</option>
                                                         <option value="GR">Greece</option>
                                                         <option value="GL">Greenland</option>
                                                         <option value="GD">Grenada</option>
                                                         <option value="GP">Guadeloupe</option>
                                                         <option value="GT">Guatemala</option>
                                                         <option value="GG">Guernsey</option>
                                                         <option value="GN">Guinea</option>
                                                         <option value="GW">Guinea-bissau</option>
                                                         <option value="GY">Guyana</option>
                                                         <option value="HT">Haiti</option>
                                                         <option value="HM">Heard Island And Mcdonald Islands</option>
                                                         <option value="VA">Holy See (Vatican City State)</option>
                                                         <option value="HN">Honduras</option>
                                                         <option value="HK">Hong Kong</option>
                                                         <option value="HU">Hungary</option>
                                                         <option value="IS">Iceland</option>
                                                         <option value="IN">India</option>
                                                         <option value="ID">Indonesia</option>
                                                         <option value="IR">Iran, Islamic Republic Of</option>
                                                         <option value="IQ">Iraq</option>
                                                         <option value="IE">Ireland</option>
                                                         <option value="IM">Isle Of Man</option>
                                                         <option value="IL">Israel</option>
                                                         <option value="IT">Italy</option>
                                                         <option value="JM">Jamaica</option>
                                                         <option value="JP">Japan</option>
                                                         <option value="JE">Jersey</option>
                                                         <option value="JO">Jordan</option>
                                                         <option value="KZ">Kazakhstan</option>
                                                         <option value="KE">Kenya</option>
                                                         <option value="KI">Kiribati</option>
                                                         <option value="KP">Korea, Democratic People's Republic Of</option>
                                                         <option value="KR">Korea, Republic Of</option>
                                                         <option value="KW">Kuwait</option>
                                                         <option value="KG">Kyrgyzstan</option>
                                                         <option value="LA">Lao People's Democratic Republic</option>
                                                         <option value="LV">Latvia</option>
                                                         <option value="LB">Lebanon</option>
                                                         <option value="LS">Lesotho</option>
                                                         <option value="LR">Liberia</option>
                                                         <option value="LY">Libya</option>
                                                         <option value="LI">Liechtenstein</option>
                                                         <option value="LT">Lithuania</option>
                                                         <option value="LU">Luxembourg</option>
                                                         <option value="MO">Macao</option>
                                                         <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
                                                         <option value="MG">Madagascar</option>
                                                         <option value="MW">Malawi</option>
                                                         <option value="MY">Malaysia</option>
                                                         <option value="MV">Maldives</option>
                                                         <option value="ML">Mali</option>
                                                         <option value="MT">Malta</option>
                                                         <option value="MQ">Martinique</option>
                                                         <option value="MR">Mauritania</option>
                                                         <option value="MU">Mauritius</option>
                                                         <option value="YT">Mayotte</option>
                                                         <option value="MX">Mexico</option>
                                                         <option value="MD">Moldova, Republic Of</option>
                                                         <option value="MC">Monaco</option>
                                                         <option value="MN">Mongolia</option>
                                                         <option value="ME">Montenegro</option>
                                                         <option value="MS">Montserrat</option>
                                                         <option value="MA">Morocco</option>
                                                         <option value="MZ">Mozambique</option>
                                                         <option value="MM">Myanmar</option>
                                                         <option value="NA">Namibia</option>
                                                         <option value="NR">Nauru</option>
                                                         <option value="NP">Nepal</option>
                                                         <option value="NL">Netherlands</option>
                                                         <option value="NC">New Caledonia</option>
                                                         <option value="NZ">New Zealand</option>
                                                         <option value="NI">Nicaragua</option>
                                                         <option value="NE">Niger</option>
                                                         <option value="NG">Nigeria</option>
                                                         <option value="NU">Niue</option>
                                                         <option value="NF">Norfolk Island</option>
                                                         <option value="NO">Norway</option>
                                                         <option value="OM">Oman</option>
                                                         <option value="PK">Pakistan</option>
                                                         <option value="PS">Palestinian Territory, Occupied</option>
                                                         <option value="PA">Panama</option>
                                                         <option value="PG">Papua New Guinea</option>
                                                         <option value="PY">Paraguay</option>
                                                         <option value="PE">Peru</option>
                                                         <option value="PH">Philippines</option>
                                                         <option value="PN">Pitcairn</option>
                                                         <option value="PL">Poland</option>
                                                         <option value="PT">Portugal</option>
                                                         <option value="QA">Qatar</option>
                                                         <option value="RE">Réunion</option>
                                                         <option value="RO">Romania</option>
                                                         <option value="RU">Russian Federation</option>
                                                         <option value="RW">Rwanda</option>
                                                         <option value="BL">Saint Barthélemy</option>
                                                         <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
                                                         <option value="KN">Saint Kitts And Nevis</option>
                                                         <option value="LC">Saint Lucia</option>
                                                         <option value="MF">Saint Martin (french Part)</option>
                                                         <option value="PM">Saint Pierre And Miquelon</option>
                                                         <option value="VC">Saint Vincent And The Grenadines</option>
                                                         <option value="WS">Samoa</option>
                                                         <option value="SM">San Marino</option>
                                                         <option value="ST">Sao Tome And Principe</option>
                                                         <option value="SA">Saudi Arabia</option>
                                                         <option value="SN">Senegal</option>
                                                         <option value="RS">Serbia</option>
                                                         <option value="SC">Seychelles</option>
                                                         <option value="SL">Sierra Leone</option>
                                                         <option value="SG">Singapore</option>
                                                         <option value="SX">Sint Maarten (dutch Part)</option>
                                                         <option value="SK">Slovakia</option>
                                                         <option value="SI">Slovenia</option>
                                                         <option value="SB">Solomon Islands</option>
                                                         <option value="SO">Somalia</option>
                                                         <option value="ZA">South Africa</option>
                                                         <option value="GS">South Georgia And The South Sandwich Islands</option>
                                                         <option value="SS">South Sudan</option>
                                                         <option value="ES">Spain</option>
                                                         <option value="LK">Sri Lanka</option>
                                                         <option value="SD">Sudan</option>
                                                         <option value="SR">Suriname</option>
                                                         <option value="SJ">Svalbard And Jan Mayen</option>
                                                         <option value="SZ">Swaziland</option>
                                                         <option value="SE">Sweden</option>
                                                         <option value="CH">Switzerland</option>
                                                         <option value="SY">Syrian Arab Republic</option>
                                                         <option value="TW">Taiwan</option>
                                                         <option value="TJ">Tajikistan</option>
                                                         <option value="TZ">Tanzania, United Republic Of</option>
                                                         <option value="TH">Thailand</option>
                                                         <option value="TL">Timor-leste</option>
                                                         <option value="TG">Togo</option>
                                                         <option value="TK">Tokelau</option>
                                                         <option value="TO">Tonga</option>
                                                         <option value="TT">Trinidad And Tobago</option>
                                                         <option value="TN">Tunisia</option>
                                                         <option value="TR">Turkey</option>
                                                         <option value="TM">Turkmenistan</option>
                                                         <option value="TC">Turks And Caicos Islands</option>
                                                         <option value="TV">Tuvalu</option>
                                                         <option value="UG">Uganda</option>
                                                         <option value="UA">Ukraine</option>
                                                         <option value="AE">United Arab Emirates</option>
                                                         <option value="GB">United Kingdom</option>
                                                         <option value="UY">Uruguay</option>
                                                         <option value="UZ">Uzbekistan</option>
                                                         <option value="VU">Vanuatu</option>
                                                         <option value="VE">Venezuela, Bolivarian Republic Of</option>
                                                         <option value="VN">Viet Nam</option>
                                                         <option value="VG">Virgin Islands, British</option>
                                                         <option value="WF">Wallis And Futuna</option>
                                                         <option value="EH">Western Sahara</option>
                                                         <option value="YE">Yemen</option>
                                                         <option value="ZM">Zambia</option>
                                                         <option value="ZW">Zimbabwe</option>
                                                      </select>
                                                   </div>
                                                </div>
																									
                                                <div id="stateFormationDiv" class="col-sm-6 mt-15 hidden" title="">
                                                   <label for="stateFormation" class="main-label">b. State of formation</label>
                                                   <div class="form-fields">
                                                      <select id="stateFormation" name="stateFormation" class="form-field">
                                                         <option value="AL">Alabama</option>
                                                         <option value="AK">Alaska</option>
                                                         <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
                                                         <option value="AA">Armed Forces Americas (except Canada)</option>
                                                         <option value="AP">Armed Forces Pacific</option>
                                                         <option value="AZ">Arizona</option>
                                                         <option value="AR">Arkansas</option>
                                                         <option value="CA">California</option>
                                                         <option value="CO">Colorado</option>
                                                         <option value="CT">Connecticut</option>
                                                         <option value="DE">Delaware</option>
                                                         <option value="DC">District of Columbia</option>
                                                         <option value="FL">Florida</option>
                                                         <option value="GA">Georgia</option>
                                                         <option value="HI">Hawaii</option>
                                                         <option value="ID">Idaho</option>
                                                         <option value="IL">Illinois</option>
                                                         <option value="IN">Indiana</option>
                                                         <option value="IA">Iowa</option>
                                                         <option value="KS">Kansas</option>
                                                         <option value="KY">Kentucky</option>
                                                         <option value="LA">Louisiana</option>
                                                         <option value="ME">Maine</option>
                                                         <option value="MD">Maryland</option>
                                                         <option value="MA">Massachusetts</option>
                                                         <option value="MI">Michigan</option>
                                                         <option value="MN">Minnesota</option>
                                                         <option value="MS">Mississippi</option>
                                                         <option value="MO">Missouri</option>
                                                         <option value="MT">Montana</option>
                                                         <option value="NE">Nebraska</option>
                                                         <option value="NV">Nevada</option>
                                                         <option value="NH">New Hampshire</option>
                                                         <option value="NJ">New Jersey</option>
                                                         <option value="NM">New Mexico</option>
                                                         <option value="NY">New York</option>
                                                         <option value="NC">North Carolina</option>
                                                         <option value="ND">North Dakota</option>
                                                         <option value="OH">Ohio</option>
                                                         <option value="OK">Oklahoma</option>
                                                         <option value="OR">Oregon</option>
                                                         <option value="PA">Pennsylvania</option>
                                                         <option value="RI">Rhode Island</option>
                                                         <option value="SC">South Carolina</option>
                                                         <option value="SD">South Dakota</option>
                                                         <option value="TN">Tennessee</option>
                                                         <option value="TX">Texas</option>
                                                         <option value="UT">Utah</option>
                                                         <option value="VT">Vermont</option>
                                                         <option value="VA">Virginia</option>
                                                         <option value="WA">Washington</option>
                                                         <option value="WV">West Virginia</option>
                                                         <option value="WI">Wisconsin</option>
                                                         <option value="WY">Wyoming</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div id="tribalJurisdictionFormationDiv" class="col-sm-6 mt-15 hidden" title="">
                                                   <label for="tribalJurisdictionFormation" class="main-label">c. Tribal jurisdiction of formation</label>
                                                   <div class="form-fields">
                                                      <select id="tribalJurisdictionFormation" name="tribalJurisdictionFormation" class="form-field">
                                                         <option value="">Select a local/tribal</option>
                                                         <option value="Absentee-Shawnee">Absentee-Shawnee Tribe of Indians of Oklahoma</option>
                                                         <option value="Agdaagux">Agdaagux Tribe of King Cove</option>
                                                         <option value="Agua Caliente">Agua Caliente Band of Cahuilla Indians of the Agua Caliente Indian Reservation, California</option>
                                                         <option value="Ak Chin">Ak-Chin Indian Community</option>
                                                         <option value="Akiachak">Akiachak Native Community</option>
                                                         <option value="Akiak">Akiak Native Community</option>
                                                         <option value="Alabama-Coushatta">Alabama-Coushatta Tribe of Texas</option>
                                                         <option value="Alabama-Quassarte Tribal Town">Alabama-Quassarte Tribal Town</option>
                                                         <option value="Alatna">Alatna Village</option>
                                                         <option value="Algaaciq">Algaaciq Native Village (St. Mary's)</option>
                                                         <option value="Allakaket">Allakaket Village</option>
                                                         <option value="Alturas">Alturas Indian Rancheria, California</option>
                                                         <option value="Alutiiq Tribe of Old Harbor">Alutiiq Tribe of Old Harbor</option>
                                                         <option value="Angoon">Angoon Community Association</option>
                                                         <option value="Anvik">Anvik Village</option>
                                                         <option value="Apache">Apache Tribe of Oklahoma</option>
                                                         <option value="Arctic Village">Arctic Village (See Native Village of Venetie Tribal Government)</option>
                                                         <option value="Asa'carsarmiut">Asa'carsarmiut Tribe</option>
                                                         <option value="Assiniboine and Sioux">Assiniboine &amp; Sioux Tribes of the Fort Peck Indian Reservation, Montana</option>
                                                         <option value="Augustine">Augustine Band of Cahuilla Indians, California</option>
                                                         <option value="Bad River Band">Bad River Band of the Lake Superior Tribe of Chippewa Indians of the Bad River Reservation, Wisconsin</option>
                                                         <option value="Bay Mills">Bay Mills Indian Community, Michigan</option>
                                                         <option value="Bear River">Bear River Band of the Rohnerville Rancheria, California</option>
                                                         <option value="Beaver">Beaver Village</option>
                                                         <option value="Berry Creek">Berry Creek Rancheria of Maidu Indians of California</option>
                                                         <option value="Big Lagoon">Big Lagoon Rancheria, California</option>
                                                         <option value="Big Pine Reservation">Big Pine Paiute Tribe of the Owens Valley</option>
                                                         <option value="Big Sandy">Big Sandy Rancheria of Western Mono Indians of California</option>
                                                         <option value="Big Valley Rancheria">Big Valley Band of Pomo Indians of the Big Valley Rancheria, California</option>
                                                         <option value="Birch Creek">Birch Creek Tribe</option>
                                                         <option value="Bishop Paiute">Bishop Paiute Tribe</option>
                                                         <option value="Blackfeet">Blackfeet Tribe of the Blackfeet Indian Reservation of Montana</option>
                                                         <option value="Blue Lake">Blue Lake Rancheria, California</option>
                                                         <option value="Bridgeport Indian Colony">Bridgeport Indian Colony</option>
                                                         <option value="Buena Vista Rancheria">Buena Vista Rancheria of Me-Wuk Indians of California</option>
                                                         <option value="Burns Paiute">Burns Paiute Tribe</option>
                                                         <option value="Cabazon">Cabazon Band of Mission Indians, California</option>
                                                         <option value="Cachil DeHe">Cachil DeHe Band of Wintun Indians of the Colusa Indian Community of the Colusa Rancheria, California</option>
                                                         <option value="Caddo">Caddo Nation of Oklahoma</option>
                                                         <option value="Cahto">Cahto Tribe of the Laytonville Rancheria</option>
                                                         <option value="Cahuilla">Cahuilla Band of Indians</option>
                                                         <option value="California Valley">California Valley Miwok Tribe, California</option>
                                                         <option value="Campo">Campo Band of Diegueno Mission Indians of the Campo Indian Reservation, California</option>
                                                         <option value="Capitan Grande">Capitan Grande Band of Diegueno Mission Indians of California (Barona Group of Capitan Grande Band of Mission Indians of the Barona Reservation, California)</option>
                                                         <option value="Capitan Grande Band">Capitan Grande Band of Diegueno Mission Indians of California</option>
                                                         <option value="Viejas">Capitan Grande Band of Diegueno Mission Indians of California: Viejas (Baron Long) Group of Capitan Grande Band of Mission Indians of the Viejas Reservation, California</option>
                                                         <option value="Catawba">Catawba Indian Nation (aka Catawba Indian Tribe of South Carolina)</option>
                                                         <option value="Cayuga Nation of New York">Cayuga Nation</option>
                                                         <option value="Cedarville">Cedarville Rancheria, California</option>
                                                         <option value="Tlingit &amp; Haida">Central Council of the Tlingit &amp; Haida Indian Tribes</option>
                                                         <option value="Chalkyitsik">Chalkyitsik Village</option>
                                                         <option value="Cheesh-Na">Cheesh-Na Tribe</option>
                                                         <option value="Chemehuevi">Chemehuevi Indian Tribe of the Chemehuevi Reservation, California</option>
                                                         <option value="Cher-Ae Heights">Cher-Ae Heights Indian Community of the Trinidad Rancheria, California</option>
                                                         <option value="Cherokee Nation">Cherokee Nation</option>
                                                         <option value="Chevak">Chevak Native Village</option>
                                                         <option value="Cheyenne River">Cheyenne and Arapaho Tribes, Oklahoma</option>
                                                         <option value="Cheyenne River Sioux Tribe">Cheyenne River Sioux Tribe of the Cheyenne River Reservation, South Dakota</option>
                                                         <option value="Chickahominy Indians-Eastern Division">Chickahominy Indian Tribe - Eastern Division</option>
                                                         <option value="Chickahominy Indian Tribe, Inc.">Chickahominy Indian Tribe</option>
                                                         <option value="Chickaloon">Chickaloon Native Village</option>
                                                         <option value="Chicken Ranch">Chicken Ranch Rancheria of Me-Wuk Indians of California</option>
                                                         <option value="Chignik Bay">Chignik Bay Tribal Council</option>
                                                         <option value="Chignik Lake">Chignik Lake Village</option>
                                                         <option value="Chilkat">Chilkat Indian Village (Klukwan)</option>
                                                         <option value="Chilkoot">Chilkoot Indian Association (Haines)</option>
                                                         <option value="Chinik">Chinik Eskimo Community (Golovin)</option>
                                                         <option value="Chippewa-Cree">Chippewa Cree Indians of the Rocky Boy's Reservation, Montana</option>
                                                         <option value="Chitimacha">Chitimacha Tribe of Louisiana</option>
                                                         <option value="Chuloonawick">Chuloonawick Native Village</option>
                                                         <option value="Circle">Circle Native Community</option>
                                                         <option value="Citizen Potawatomi">Citizen Potawatomi Nation, Oklahoma</option>
                                                         <option value="Cloverdale">Cloverdale Rancheria of Pomo Indians of California</option>
                                                         <option value="Cocopah">Cocopah Tribe of Arizona</option>
                                                         <option value="Coeur D'Alene">Coeur D'Alene Tribe</option>
                                                         <option value="Cold Springs">Cold Springs Rancheria of Mono Indians of California</option>
                                                         <option value="Colorado River">Colorado River Indian Tribes of the Colorado River Indian Reservation, Arizona and California</option>
                                                         <option value="Comanche">Comanche Nation, Oklahoma</option>
                                                         <option value="Confederated Salish">Confederated Salish and Kootenai Tribes of the Flathead Reservation</option>
                                                         <option value="Confederated Yakama">Confederated Tribes and Bands of the Yakama Nation</option>
                                                         <option value="Siletz Tribe">Confederated Tribes of Siletz Indians of Oregon</option>
                                                         <option value="Chehalis">Confederated Tribes of the Chehalis Reservation</option>
                                                         <option value="Confederated Colville">Confederated Tribes of the Colville Reservation</option>
                                                         <option value="Confederated Coos">Confederated Tribes of the Coos, Lower Umpqua and Siuslaw Indians</option>
                                                         <option value="Confederated Goshute">Confederated Tribes of the Goshute Reservation, Nevada and Utah</option>
                                                         <option value="Grand Ronde Tribes">Confederated Tribes of the Grand Ronde Community of Oregon</option>
                                                         <option value="Umatilla Tribe">Confederated Tribes of the Umatilla Indian Reservation</option>
                                                         <option value="Warms Springs Tribe">Confederated Tribes of the Warm Springs Reservation of Oregon</option>
                                                         <option value="Coquille">Coquille Indian Tribe</option>
                                                         <option value="Coushatta">Coushatta Tribe of Louisiana</option>
                                                         <option value="Cow Creek">Cow Creek Band of Umpqua Tribe of Indians</option>
                                                         <option value="Cowlitz">Cowlitz Indian Tribe</option>
                                                         <option value="Coyote Valley">Coyote Valley Band of Pomo Indians of California</option>
                                                         <option value="Craig">Craig Tribal Association</option>
                                                         <option value="Crow Creek">Crow Creek Sioux Tribe of the Crow Creek Reservation, South Dakota</option>
                                                         <option value="Crow">Crow Tribe of Montana</option>
                                                         <option value="Curyung">Curyung Tribal Council</option>
                                                         <option value="Delaware Nation">Delaware Nation, Oklahoma</option>
                                                         <option value="Delaware Tribe of Indians">Delaware Tribe of Indians</option>
                                                         <option value="Douglas">Douglas Indian Association</option>
                                                         <option value="Dry Creek">Dry Creek Rancheria Band of Pomo Indians, California</option>
                                                         <option value="Duckwater">Duckwater Shoshone Tribe of the Duckwater Reservation, Nevada</option>
                                                         <option value="Eastern Cherokee">Eastern Band of Cherokee Indians</option>
                                                         <option value="Eastern Shawnee Tribe of Oklahoma">Eastern Shawnee Tribe of Oklahoma</option>
                                                         <option value="Eastern Shoshone">Eastern Shoshone Tribe of the Wind River Reservation, Wyoming</option>
                                                         <option value="Egegik">Egegik Village</option>
                                                         <option value="Eklutna">Eklutna Native Village</option>
                                                         <option value="Elem">Elem Indian Colony of Pomo Indians of the Sulphur Bank Rancheria, California</option>
                                                         <option value="Elk Valley">Elk Valley Rancheria, California</option>
                                                         <option value="Ely Shoshone">Ely Shoshone Tribe of Nevada</option>
                                                         <option value="Emmonak">Emmonak Village</option>
                                                         <option value="Enterprise">Enterprise Rancheria of Maidu Indians of California</option>
                                                         <option value="Evansville">Evansville Village (aka Bettles Field)</option>
                                                         <option value="Ewiiaapaayp">Ewiiaapaayp Band of Kumeyaay Indians, California</option>
                                                         <option value="Federated Indians of Graton">Federated Indians of Graton Rancheria, California</option>
                                                         <option value="Flandreau">Flandreau Santee Sioux Tribe of South Dakota</option>
                                                         <option value="Forest County">Forest County Potawatomi Community, Wisconsin</option>
                                                         <option value="Assiniboine and Gros Ventre Tribes">Fort Belknap Indian Community of the Fort Belknap Reservation of Montana</option>
                                                         <option value="Fort Bidwell">Fort Bidwell Indian Community of the Fort Bidwell Reservation of California</option>
                                                         <option value="Fort Independence">Fort Independence Indian Community of Paiute Indians of the Fort Independence Reservation, California</option>
                                                         <option value="Fort McDermitt">Fort McDermitt Paiute and Shoshone Tribes of the Fort McDermitt Indian Reservation, Nevada and Oregon</option>
                                                         <option value="Fort McDowell">Fort McDowell Yavapai Nation, Arizona</option>
                                                         <option value="Fort Mojave">Fort Mojave Indian Tribe of Arizona, California &amp; Nevada</option>
                                                         <option value="Fort Sill">Fort Sill Apache Tribe of Oklahoma</option>
                                                         <option value="Galena">Galena Village (aka Louden Village)</option>
                                                         <option value="Gila River">Gila River Indian Community of the Gila River Indian Reservation, Arizona</option>
                                                         <option value="Grand Traverse">Grand Traverse Band of Ottawa and Chippewa Indians, Michigan</option>
                                                         <option value="Greenville">Greenville Rancheria</option>
                                                         <option value="Grindstone">Grindstone Indian Rancheria of Wintun-Wailaki Indians of California</option>
                                                         <option value="Guidiville">Guidiville Rancheria of California</option>
                                                         <option value="Gulkana">Gulkana Village Council</option>
                                                         <option value="Habematolel">Habematolel Pomo of Upper Lake, California</option>
                                                         <option value="Hannahville">Hannahville Indian Community, Michigan</option>
                                                         <option value="Havasupai">Havasupai Tribe of the Havasupai Reservation, Arizona</option>
                                                         <option value="Healy Lake">Healy Lake Village</option>
                                                         <option value="Ho-Chunk">Ho-Chunk Nation of Wisconsin</option>
                                                         <option value="Hoh">Hoh Indian Tribe</option>
                                                         <option value="Holy Cross">Holy Cross Tribe</option>
                                                         <option value="Hoonah">Hoonah Indian Association</option>
                                                         <option value="Hoopa">Hoopa Valley Tribe, California</option>
                                                         <option value="Hopi">Hopi Tribe of Arizona</option>
                                                         <option value="Hopland">Hopland Band of Pomo Indians, California</option>
                                                         <option value="Houlton">Houlton Band of Maliseet Indians</option>
                                                         <option value="Hualapai">Hualapai Indian Tribe of the Hualapai Indian Reservation, Arizona</option>
                                                         <option value="Hughes">Hughes Village</option>
                                                         <option value="Huslia">Huslia Village</option>
                                                         <option value="Hydaburg">Hydaburg Cooperative Association</option>
                                                         <option value="Igiugig">Igiugig Village</option>
                                                         <option value="Iipay">Iipay Nation of Santa Ysabel, California</option>
                                                         <option value="Inaja">Inaja Band of Diegueno Mission Indians of the Inaja and Cosmit Reservation, California</option>
                                                         <option value="Inupiat Community of the Arctic Slope">Inupiat Community of the Arctic Slope</option>
                                                         <option value="Ione">Ione Band of Miwok Indians of California</option>
                                                         <option value="Iowa of Kansas">Iowa Tribe of Kansas and Nebraska</option>
                                                         <option value="Iowa of Oklahoma">Iowa Tribe of Oklahoma</option>
                                                         <option value="Iqugmiut">Iqugmiut Traditional Council</option>
                                                         <option value="Ivanof Bay Tribe">Ivanof Bay Tribe</option>
                                                         <option value="Jackson">Jackson Band of Miwuk Indians</option>
                                                         <option value="Jamestown">Jamestown S'Klallam Tribe</option>
                                                         <option value="Jamul">Jamul Indian Village of California</option>
                                                         <option value="Jena">Jena Band of Choctaw Indians</option>
                                                         <option value="Jicarilla">Jicarilla Apache Nation, New Mexico</option>
                                                         <option value="Kaguyuk">Kaguyak Village</option>
                                                         <option value="Kaibab">Kaibab Band of Paiute Indians of the Kaibab Indian Reservation, Arizona</option>
                                                         <option value="Kaktovik">Kaktovik Village (aka Barter Island)</option>
                                                         <option value="Kalispel">Kalispel Indian Community of the Kalispel Reservation</option>
                                                         <option value="Karuk">Karuk Tribe</option>
                                                         <option value="Kashia">Kashia Band of Pomo Indians of the Stewarts Point Rancheria, California</option>
                                                         <option value="Kasigluk">Kasigluk Traditional Elders Council</option>
                                                         <option value="Kaw">Kaw Nation, Oklahoma</option>
                                                         <option value="Kenaitze">Kenaitze Indian Tribe</option>
                                                         <option value="Ketchikan">Ketchikan Indian Community</option>
                                                         <option value="Keweenaw">Keweenaw Bay Indian Community, Michigan</option>
                                                         <option value="Kialegee Tribal Town">Kialegee Tribal Town</option>
                                                         <option value="Kickapoo of Texas">Kickapoo Traditional Tribe of Texas</option>
                                                         <option value="Kickapoo Tribe in Kansas">Kickapoo Tribe of Indians of the Kickapoo Reservation in Kansas</option>
                                                         <option value="Kickapoo of Oklahoma">Kickapoo Tribe of Oklahoma</option>
                                                         <option value="King Island">King Island Native Community</option>
                                                         <option value="King Salmon">King Salmon Tribe</option>
                                                         <option value="Kiowa Tribe">Kiowa  Indian Tribe of Oklahoma</option>
                                                         <option value="Klamath">Klamath Tribes</option>
                                                         <option value="Klawock">Klawock Cooperative Association</option>
                                                         <option value="Cortina">Kletsel Dehe Band of Wintun Indians</option>
                                                         <option value="Knik">Knik Tribe</option>
                                                         <option value="Koi">Koi Nation of Northern California</option>
                                                         <option value="Kokhanok">Kokhanok Village</option>
                                                         <option value="Kootenai">Kootenai Tribe of Idaho</option>
                                                         <option value="Koyukuk">Koyukuk Native Village</option>
                                                         <option value="La Jolla">La Jolla Band of Luiseno Indians, California</option>
                                                         <option value="La Posta">La Posta Band of Diegueno Mission Indians of the La Posta Indian Reservation, California</option>
                                                         <option value="Lac Courte Oreilles">Lac Courte Oreilles Band of Lake Superior Chippewa Indians of Wisconsin</option>
                                                         <option value="Lac du Flambeau">Lac du Flambeau Band of Lake Superior Chippewa Indians of the Lac du Flambeau Reservation of Wisconsin</option>
                                                         <option value="Lac Vieux">Lac Vieux Desert Band of Lake Superior Chippewa Indians of Michigan</option>
                                                         <option value="Las Vegas">Las Vegas Tribe of Paiute Indians of the Las Vegas Indian Colony, Nevada</option>
                                                         <option value="Levelock">Levelock Village</option>
                                                         <option value="Lime">Lime Village</option>
                                                         <option value="Little River">Little River Band of Ottawa Indians, Michigan</option>
                                                         <option value="Little Shell Tribe">Little Shell Tribe of Chippewa Indians of Montana</option>
                                                         <option value="Little Traverse">Little Traverse Bay Bands of Odawa Indians, Michigan</option>
                                                         <option value="Lone Pine">Lone Pine Paiute-Shoshone Tribe</option>
                                                         <option value="Los Coyotes">Los Coyotes Band of Cahuilla and Cupeno Indians, California</option>
                                                         <option value="Lovelock">Lovelock Paiute Tribe of the Lovelock Indian Colony, Nevada</option>
                                                         <option value="Lower Brule">Lower Brule Sioux Tribe of the Lower Brule Reservation, South Dakota</option>
                                                         <option value="Lower Elwha">Lower Elwha Tribal Community</option>
                                                         <option value="Lower Sioux">Lower Sioux Indian Community in the State of Minnesota</option>
                                                         <option value="Lummi">Lummi Tribe of the Lummi Reservation</option>
                                                         <option value="Lytton">Lytton Rancheria of California</option>
                                                         <option value="Makah">Makah Indian Tribe of the Makah Indian Reservation</option>
                                                         <option value="Manchester">Manchester Band of Pomo Indians of the Manchester Rancheria, California</option>
                                                         <option value="Manley Hot Springs">Manley Hot Springs Village</option>
                                                         <option value="Manokotak">Manokotak Village</option>
                                                         <option value="Manzanita">Manzanita Band of Diegueno Mission Indians of the Manzanita Reservation, California</option>
                                                         <option value="Mashantucket Pequot">Mashantucket Pequot Indian Tribe</option>
                                                         <option value="Mashpee">Mashpee Wampanoag Tribe</option>
                                                         <option value="Match-e-be-nash-she-wish Band">Match-e-be-nash-she-wish Band of Pottawatomi Indians of Michigan</option>
                                                         <option value="Mcgrath">McGrath Native Village</option>
                                                         <option value="Mechoopda">Mechoopda Indian Tribe of Chico Rancheria, California</option>
                                                         <option value="Menominee">Menominee Indian Tribe of Wisconsin</option>
                                                         <option value="Mentasta">Mentasta Traditional Council</option>
                                                         <option value="Mesa Grande">Mesa Grande Band of Diegueno Mission Indians of the Mesa Grande Reservation, California</option>
                                                         <option value="Mescalero Apache">Mescalero Apache Tribe of the Mescalero Reservation, New Mexico</option>
                                                         <option value="Metlakatla">Metlakatla Indian Community, Annette Island Reserve</option>
                                                         <option value="Miami Tribe of Oklahoma">Miami Tribe of Oklahoma</option>
                                                         <option value="Miccosukee">Miccosukee Tribe of Indians</option>
                                                         <option value="Middletown">Middletown Rancheria of Pomo Indians of California</option>
                                                         <option value="Mi'kmaq Nation">Mi'kmaq Nation</option>
                                                         <option value="Bois Forte">Minnesota Chippewa Tribe - Bois Forte Band (Nett Lake)</option>
                                                         <option value="Fond du Lac">Minnesota Chippewa Tribe - Fond du Lac Band</option>
                                                         <option value="Grand Portage">Minnesota Chippewa Tribe - Grand Portage Band</option>
                                                         <option value="Leech Lake">Minnesota Chippewa Tribe - Leech Lake Band</option>
                                                         <option value="Mille Lacs">Minnesota Chippewa Tribe - Mille Lacs Band</option>
                                                         <option value="White Earth">Minnesota Chippewa Tribe - White Earth Band</option>
                                                         <option value="Minnesota Chippewa">Minnesota Chippewa Tribe, Minnesota</option>
                                                         <option value="Mississippi Choctaw">Mississippi Band of Choctaw Indians</option>
                                                         <option value="Moapa">Moapa Band of Paiute Indians of the Moapa River Indian Reservation, Nevada</option>
                                                         <option value="Modoc Nation">Modoc Nation</option>
                                                         <option value="Mohegan">Mohegan Tribe of Indians of Connecticut</option>
                                                         <option value="Monacan Indian Nation">Monacan Indian Nation</option>
                                                         <option value="Mooretown">Mooretown Rancheria of Maidu Indians of California</option>
                                                         <option value="Morongo">Morongo Band of Mission Indians, California</option>
                                                         <option value="Muckleshoot">Muckleshoot Indian Tribe</option>
                                                         <option value="Naknek">Naknek Native Village</option>
                                                         <option value="Nansemond Indian Tribe">Nansemond Indian Nation</option>
                                                         <option value="Narragansett">Narragansett Indian Tribe</option>
                                                         <option value="Afognak">Native Village of Afognak</option>
                                                         <option value="Akhiok">Native Village of Akhiok</option>
                                                         <option value="Akutan">Native Village of Akutan</option>
                                                         <option value="Aleknagik">Native Village of Aleknagik</option>
                                                         <option value="Ambler">Native Village of Ambler</option>
                                                         <option value="Atka">Native Village of Atka</option>
                                                         <option value="Native Village of Atqasuk">Native Village of Atqasuk</option>
                                                         <option value="Barrow">Native Village of Barrow Inupiat Traditional Government</option>
                                                         <option value="Belkofski">Native Village of Belkofski</option>
                                                         <option value="Brevig Mission">Native Village of Brevig Mission</option>
                                                         <option value="Buckland">Native Village of Buckland</option>
                                                         <option value="Cantwell">Native Village of Cantwell</option>
                                                         <option value="Chenega">Native Village of Chenega (aka Chanega)</option>
                                                         <option value="Chignik Lagoon">Native Village of Chignik Lagoon</option>
                                                         <option value="Chitina">Native Village of Chitina</option>
                                                         <option value="Chuathbaluk">Native Village of Chuathbaluk (Russian Mission, Kuskokwim)</option>
                                                         <option value="Council">Native Village of Council</option>
                                                         <option value="Deering">Native Village of Deering</option>
                                                         <option value="Diomede">Native Village of Diomede (aka Inalik)</option>
                                                         <option value="Eagle">Native Village of Eagle</option>
                                                         <option value="Eek">Native Village of Eek</option>
                                                         <option value="Ekuk">Native Village of Ekuk</option>
                                                         <option value="Ekwok">Native Village of Ekwok</option>
                                                         <option value="Elim IRA">Native Village of Elim</option>
                                                         <option value="Eyak">Native Village of Eyak (Cordova)</option>
                                                         <option value="False Pass">Native Village of False Pass</option>
                                                         <option value="Fort Yukon">Native Village of Fort Yukon</option>
                                                         <option value="Gakona">Native Village of Gakona</option>
                                                         <option value="Gambell">Native Village of Gambell</option>
                                                         <option value="Georgetown">Native Village of Georgetown</option>
                                                         <option value="Goodnews Bay">Native Village of Goodnews Bay</option>
                                                         <option value="Hamilton">Native Village of Hamilton</option>
                                                         <option value="Hooper Bay">Native Village of Hooper Bay</option>
                                                         <option value="Kanatak">Native Village of Kanatak</option>
                                                         <option value="Karluk">Native Village of Karluk</option>
                                                         <option value="Kiana">Native Village of Kiana</option>
                                                         <option value="Kipnuk">Native Village of Kipnuk</option>
                                                         <option value="Kivalina">Native Village of Kivalina</option>
                                                         <option value="Kluti Kaah">Native Village of Kluti Kaah (aka Copper Center)</option>
                                                         <option value="Kobuk">Native Village of Kobuk</option>
                                                         <option value="Kongiganak">Native Village of Kongiganak</option>
                                                         <option value="Kotzebue">Native Village of Kotzebue</option>
                                                         <option value="Koyuk">Native Village of Koyuk</option>
                                                         <option value="Kwigillingok">Native Village of Kwigillingok</option>
                                                         <option value="Kwinhagak">Native Village of Kwinhagak (aka Quinhagak)</option>
                                                         <option value="Larsen Bay">Native Village of Larsen Bay</option>
                                                         <option value="Marshall">Native Village of Marshall (aka Fortuna Ledge)</option>
                                                         <option value="Mary's Igloo">Native Village of Mary's Igloo</option>
                                                         <option value="Mekoryuk">Native Village of Mekoryuk</option>
                                                         <option value="Minto">Native Village of Minto</option>
                                                         <option value="Nanwalek">Native Village of Nanwalek (aka English Bay)</option>
                                                         <option value="Napaimute">Native Village of Napaimute</option>
                                                         <option value="Napakiak">Native Village of Napakiak</option>
                                                         <option value="Napaskiak">Native Village of Napaskiak</option>
                                                         <option value="Nelson Lagoon">Native Village of Nelson Lagoon</option>
                                                         <option value="Nightmute">Native Village of Nightmute</option>
                                                         <option value="Nikolski">Native Village of Nikolski</option>
                                                         <option value="Noatak">Native Village of Noatak</option>
                                                         <option value="Nuiqsut">Native Village of Nuiqsut (aka Nooiksut)</option>
                                                         <option value="Nunam Iqua">Native Village of Nunam Iqua</option>
                                                         <option value="Nunapitchuk">Native Village of Nunapitchuk</option>
                                                         <option value="Ouzinkie">Native Village of Ouzinkie</option>
                                                         <option value="Paimiut">Native Village of Paimiut</option>
                                                         <option value="Perryville">Native Village of Perryville</option>
                                                         <option value="Pilot Point">Native Village of Pilot Point</option>
                                                         <option value="Point Hope IRA">Native Village of Point Hope</option>
                                                         <option value="Point Lay IRA">Native Village of Point Lay</option>
                                                         <option value="Port Graham">Native Village of Port Graham</option>
                                                         <option value="Port Heiden">Native Village of Port Heiden</option>
                                                         <option value="Port Lions">Native Village of Port Lions</option>
                                                         <option value="Ruby">Native Village of Ruby</option>
                                                         <option value="St. Michael IRA">Native Village of Saint Michael</option>
                                                         <option value="Savoonga">Native Village of Savoonga</option>
                                                         <option value="Scammon Bay">Native Village of Scammon Bay</option>
                                                         <option value="Selawik">Native Village of Selawik</option>
                                                         <option value="Shaktoolik">Native Village of Shaktoolik</option>
                                                         <option value="Shishmaref IRA">Native Village of Shishmaref</option>
                                                         <option value="Shungnak">Native Village of Shungnak</option>
                                                         <option value="Stevens Village">Native Village of Stevens</option>
                                                         <option value="Tanacross">Native Village of Tanacross</option>
                                                         <option value="Tanana">Native Village of Tanana</option>
                                                         <option value="Tatitlek">Native Village of Tatitlek</option>
                                                         <option value="Tazlina">Native Village of Tazlina</option>
                                                         <option value="Teller">Native Village of Teller</option>
                                                         <option value="Tetlin">Native Village of Tetlin</option>
                                                         <option value="Tuntutuliak">Native Village of Tuntutuliak</option>
                                                         <option value="Tununak">Native Village of Tununak</option>
                                                         <option value="Tyonek">Native Village of Tyonek</option>
                                                         <option value="Unalakleet">Native Village of Unalakleet</option>
                                                         <option value="Unga">Native Village of Unga</option>
                                                         <option value="Venetie IRA">Native Village of Venetie Tribal Government (Arctic Village and Village of Venetie)</option>
                                                         <option value="Wales">Native Village of Wales</option>
                                                         <option value="White Mountain AK">Native Village of White Mountain</option>
                                                         <option value="Navajo">Navajo Nation, Arizona, New Mexico &amp; Utah</option>
                                                         <option value="Nenana">Nenana Native Association</option>
                                                         <option value="New Koliganek">New Koliganek Village Council</option>
                                                         <option value="New Stuyahok">New Stuyahok Village</option>
                                                         <option value="Newhalen">Newhalen Village</option>
                                                         <option value="Newtok">Newtok Village</option>
                                                         <option value="Nez Perce">Nez Perce Tribe</option>
                                                         <option value="Nikolai">Nikolai Village</option>
                                                         <option value="Ninilchik">Ninilchik Village</option>
                                                         <option value="Nisqually">Nisqually Indian Tribe</option>
                                                         <option value="Nome">Nome Eskimo Community</option>
                                                         <option value="Nondalton">Nondalton Village</option>
                                                         <option value="Nooksack">Nooksack Indian Tribe</option>
                                                         <option value="Noorvik">Noorvik Native Community</option>
                                                         <option value="Northern Arapaho">Northern Arapaho Tribe of the Wind River Reservation, Wyoming</option>
                                                         <option value="Northern Cheyenne">Northern Cheyenne Tribe of the Northern Cheyenne Indian Reservation, Montana</option>
                                                         <option value="North Fork">Northfork Rancheria of Mono Indians of California</option>
                                                         <option value="Northway">Northway Village</option>
                                                         <option value="Northwestern Shoshone">Northwestern Band of the Shoshone Nation</option>
                                                         <option value="Nottawaseppi Potawatomi">Nottawaseppi Huron Band of the Potawatomi, Michigan</option>
                                                         <option value="Nulato">Nulato Village</option>
                                                         <option value="Nunakauyarmiut">Nunakauyarmiut Tribe</option>
                                                         <option value="Oglala Sioux">Oglala Sioux Tribe</option>
                                                         <option value="Ohkay Owingeh">Ohkay Owingeh, New Mexico</option>
                                                         <option value="Omaha">Omaha Tribe of Nebraska</option>
                                                         <option value="Oneida">Oneida Indian Nation</option>
                                                         <option value="Oneida Nation (Wisconsin)">Oneida Nation</option>
                                                         <option value="Onondaga">Onondaga Nation</option>
                                                         <option value="Grayling">Organized Village of Grayling (aka Holikachuk)</option>
                                                         <option value="Kake">Organized Village of Kake</option>
                                                         <option value="Kasaan">Organized Village of Kasaan</option>
                                                         <option value="Kwethluk">Organized Village of Kwethluk</option>
                                                         <option value="Saxman">Organized Village of Saxman</option>
                                                         <option value="Orutsararmiut">Orutsararmiut Traditional Native Council</option>
                                                         <option value="Oscarville">Oscarville Traditional Village</option>
                                                         <option value="Otoe-Missouria">Otoe-Missouria Tribe of Indians, Oklahoma</option>
                                                         <option value="Ottawa Tribe of Oklahoma">Ottawa Tribe of Oklahoma</option>
                                                         <option value="Paiute of Utah">Paiute Indian Tribe of Utah (Cedar Band of Paiutes, Kanosh Band of Paiutes, Koosharem Band of Paiutes, Indian Peaks Band of Paiutes, and Shivwits Band of Paiutes)</option>
                                                         <option value="Paiute-Shoshone">Paiute-Shoshone Tribe of the Fallon Reservation and Colony, Nevada</option>
                                                         <option value="Pala">Pala Band of Mission Indians</option>
                                                         <option value="Pamunkey Indian Tribe">Pamunkey Indian Tribe</option>
                                                         <option value="Pascua Yaqui">Pascua Yaqui Tribe of Arizona</option>
                                                         <option value="Paskenta">Paskenta Band of Nomlaki Indians of California</option>
                                                         <option value="Passamaquoddy Indian Township">Passamaquoddy Tribe - Indian Township</option>
                                                         <option value="Passamaquoddy Pleasant Point">Passamaquoddy Tribe - Pleasant Point</option>
                                                         <option value="Passamaquoddy Tribe">Passamaquoddy Tribe</option>
                                                         <option value="Pauloff Harbor">Pauloff Harbor Village</option>
                                                         <option value="Pauma">Pauma Band of Luiseno Mission Indians of the Pauma &amp; Yuima Reservation, California</option>
                                                         <option value="Pawnee">Pawnee Nation of Oklahoma</option>
                                                         <option value="Pechanga Band of Indians">Pechanga Band of Indians</option>
                                                         <option value="Pedro Bay">Pedro Bay Village</option>
                                                         <option value="Penobscot">Penobscot Nation</option>
                                                         <option value="Peoria Tribe of Indians of Oklahoma">Peoria Tribe of Indians of Oklahoma</option>
                                                         <option value="Petersburg">Petersburg Indian Association</option>
                                                         <option value="Picayune">Picayune Rancheria of Chukchansi Indians of California</option>
                                                         <option value="Pilot Station">Pilot Station Traditional Village</option>
                                                         <option value="Pinoleville">Pinoleville Pomo Nation, California</option>
                                                         <option value="Pit River">Pit River Tribe, California</option>
                                                         <option value="Pitka's Point">Pitka's Point Traditional Council</option>
                                                         <option value="Platinum">Platinum Traditional Village</option>
                                                         <option value="Poarch">Poarch Band of Creek Indians</option>
                                                         <option value="Pokagon">Pokagon Band of Potawatomi Indians, Michigan and Indiana</option>
                                                         <option value="Ponca of Oklahoma">Ponca Tribe of Indians of Oklahoma</option>
                                                         <option value="Ponca of Nebraska">Ponca Tribe of Nebraska</option>
                                                         <option value="Port Gamble">Port Gamble S'Klallam Tribe</option>
                                                         <option value="Portage Creek">Portage Creek Village (aka Ohgsenakale)</option>
                                                         <option value="Potter Valley">Potter Valley Tribe, California</option>
                                                         <option value="Prairie Band">Prairie Band Potawatomi Nation</option>
                                                         <option value="Prairie Island">Prairie Island Indian Community in the State of Minnesota</option>
                                                         <option value="Pribilof Islands Aleut Communities">Pribilof Islands Aleut Communities</option>
                                                         <option value="Pueblo of Acoma">Pueblo of Acoma, New Mexico</option>
                                                         <option value="Pueblo of Cochiti">Pueblo of Cochiti, New Mexico</option>
                                                         <option value="Pueblo of Isleta">Pueblo of Isleta, New Mexico</option>
                                                         <option value="Pueblo of Jemez">Pueblo of Jemez, New Mexico</option>
                                                         <option value="Pueblo of Laguna">Pueblo of Laguna, New Mexico</option>
                                                         <option value="Pueblo of Nambe">Pueblo of Nambe, New Mexico</option>
                                                         <option value="Pueblo of Picuris">Pueblo of Picuris, New Mexico</option>
                                                         <option value="Pueblo of Pojoaque">Pueblo of Pojoaque, New Mexico</option>
                                                         <option value="Pueblo of San Felipe">Pueblo of San Felipe, New Mexico</option>
                                                         <option value="Pueblo of San Ildefonso">Pueblo of San Ildefonso, New Mexico</option>
                                                         <option value="Pueblo of Sandia">Pueblo of Sandia, New Mexico</option>
                                                         <option value="Pueblo of Santa Ana">Pueblo of Santa Ana, New Mexico</option>
                                                         <option value="Pueblo of Santa Clara">Pueblo of Santa Clara, New Mexico</option>
                                                         <option value="Pueblo of Taos">Pueblo of Taos, New Mexico</option>
                                                         <option value="Pueblo of Tesuque">Pueblo of Tesuque, New Mexico</option>
                                                         <option value="Pueblo of Zia">Pueblo of Zia, New Mexico</option>
                                                         <option value="Puyallup">Puyallup Tribe of the Puyallup Reservation</option>
                                                         <option value="Pyramid Lake">Pyramid Lake Paiute Tribe of the Pyramid Lake Reservation, Nevada</option>
                                                         <option value="Qagan Tayagungin">Qagan Tayagungin Tribe of Sand Point</option>
                                                         <option value="Qawalangin">Qawalangin Tribe of Unalaska</option>
                                                         <option value="Quapaw Nation">Quapaw Nation</option>
                                                         <option value="Quartz Valley">Quartz Valley Indian Community of the Quartz Valley Reservation of California</option>
                                                         <option value="Quechan">Quechan Tribe of the Fort Yuma Indian Reservation, California &amp; Arizona</option>
                                                         <option value="Quileute">Quileute Tribe of the Quileute Reservation</option>
                                                         <option value="Quinault">Quinault Indian Nation</option>
                                                         <option value="Ramah Navajo Chapter">Ramah Navajo Chapter of the Navajo Nation</option>
                                                         <option value="Ramona">Ramona Band of Cahuilla, California</option>
                                                         <option value="Rampart">Rampart Village</option>
                                                         <option value="Rappahannock Tribe, Inc.">Rappahannock Tribe, Inc.</option>
                                                         <option value="Red Cliff">Red Cliff Band of Lake Superior Chippewa Indians of Wisconsin</option>
                                                         <option value="Red Lake">Red Lake Band of Chippewa Indians, Minnesota</option>
                                                         <option value="Redding">Redding Rancheria, California</option>
                                                         <option value="Redwood Valley">Redwood Valley or Little River Band of Pomo Indians of the Redwood Valley Rancheria California</option>
                                                         <option value="Reno-Sparks">Reno-Sparks Indian Colony, Nevada</option>
                                                         <option value="Resighini">Resighini Rancheria, California</option>
                                                         <option value="Rincon">Rincon Band of Luiseno Mission Indians of the Rincon Reservation, California</option>
                                                         <option value="Robinson">Robinson Rancheria</option>
                                                         <option value="Rosebud">Rosebud Sioux Tribe of the Rosebud Indian Reservation, South Dakota</option>
                                                         <option value="Round Valley">Round Valley Indian Tribes, Round Valley Reservation, California</option>
                                                         <option value="Sac &amp; Fox Nation of Missouri in Kansas and Nebraska">Sac &amp; Fox Nation of Missouri in Kansas and Nebraska</option>
                                                         <option value="Sac &amp; Fox Nation, Oklahoma">Sac &amp; Fox Nation, Oklahoma</option>
                                                         <option value="Sac &amp; Fox of Mississippi">Sac &amp; Fox Tribe of the Mississippi in Iowa</option>
                                                         <option value="Saginaw Chippewa">Saginaw Chippewa Indian Tribe of Michigan</option>
                                                         <option value="St. George">Saint George Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                                                         <option value="Saint Paul">Saint Paul Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                                                         <option value="Saint Regis">Saint Regis Mohawk Tribe</option>
                                                         <option value="Salamatof">Salamatof Tribe</option>
                                                         <option value="Salt River">Salt River Pima-Maricopa Indian Community of the Salt River Reservation, Arizona</option>
                                                         <option value="Samish">Samish Indian Nation</option>
                                                         <option value="San Carlos">San Carlos Apache Tribe of the San Carlos Reservation, Arizona</option>
                                                         <option value="San Juan">San Juan Southern Paiute Tribe of Arizona</option>
                                                         <option value="San Pasqual">San Pasqual Band of Diegueno Mission Indians of California</option>
                                                         <option value="Santa Rosa of Cahuilla">Santa Rosa Band of Cahuilla Indians, California</option>
                                                         <option value="Santa Rosa">Santa Rosa Indian Community of the Santa Rosa Rancheria, California</option>
                                                         <option value="Santa Ynez">Santa Ynez Band of Chumash Mission Indians of the Santa Ynez Reservation, California</option>
                                                         <option value="Santee Sioux">Santee Sioux Nation, Nebraska</option>
                                                         <option value="Santo Domingo">Santo Domingo Pueblo</option>
                                                         <option value="Sauk-Suiattle">Sauk-Suiattle Indian Tribe</option>
                                                         <option value="Sault Ste. Marie">Sault Ste. Marie Tribe of Chippewa Indians, Michigan</option>
                                                         <option value="Scotts Valley">Scotts Valley Band of Pomo Indians of California</option>
                                                         <option value="Seldovia">Seldovia Village Tribe</option>
                                                         <option value="Seminole">Seminole Tribe of Florida</option>
                                                         <option value="Seneca">Seneca Nation of Indians</option>
                                                         <option value="Seneca-Cayuga Nation">Seneca-Cayuga Nation</option>
                                                         <option value="Shageluk">Shageluk Native Village</option>
                                                         <option value="Shakopee">Shakopee Mdewakanton Sioux Community of Minnesota</option>
                                                         <option value="Shawnee Tribe">Shawnee Tribe</option>
                                                         <option value="Sherwood Valley">Sherwood Valley Rancheria of Pomo Indians of California</option>
                                                         <option value="Shingle Springs">Shingle Springs Band of Miwok Indians, Shingle Springs Rancheria (Verona Tract), California</option>
                                                         <option value="Shinnecock">Shinnecock Indian Nation</option>
                                                         <option value="Shoalwater">Shoalwater Bay Indian Tribe of the Shoalwater Bay Indian Reservation</option>
                                                         <option value="Shoshone-Bannock">Shoshone-Bannock Tribes of the Fort Hall Reservation</option>
                                                         <option value="Shoshone-Paiute">Shoshone-Paiute Tribes of the Duck Valley Reservation, Nevada</option>
                                                         <option value="Sisseton-Wahpeton">Sisseton-Wahpeton Oyate of the Lake Traverse Reservation, South Dakota</option>
                                                         <option value="Sitka">Sitka Tribe of Alaska</option>
                                                         <option value="Skagway">Skagway Village</option>
                                                         <option value="Skokomish">Skokomish Indian Tribe</option>
                                                         <option value="Skull Valley">Skull Valley Band of Goshute Indians of Utah</option>
                                                         <option value="Snoqualmie">Snoqualmie Indian Tribe</option>
                                                         <option value="Soboba">Soboba Band of Luiseno Indians, California</option>
                                                         <option value="Sokaogon">Sokaogon Chippewa  Community, Wisconsin</option>
                                                         <option value="South Naknek">South Naknek Village</option>
                                                         <option value="Southern Ute">Southern Ute Indian Tribe of the Southern Ute Reservation, Colorado</option>
                                                         <option value="Spirit Lake">Spirit Lake Tribe, North Dakota</option>
                                                         <option value="Spokane">Spokane Tribe of the Spokane Reservation</option>
                                                         <option value="Squaxin">Squaxin Island Tribe of the Squaxin Island Reservation</option>
                                                         <option value="St. Croix">St. Croix Chippewa Indians of Wisconsin</option>
                                                         <option value="Standing Rock">Standing Rock Sioux Tribe of North &amp; South Dakota</option>
                                                         <option value="Stebbins">Stebbins Community Association</option>
                                                         <option value="Stillaguamish">Stillaguamish Tribe of Indians of Washington</option>
                                                         <option value="Stockbridge">Stockbridge Munsee Community, Wisconsin</option>
                                                         <option value="Summit Lake">Summit Lake Paiute Tribe of Nevada</option>
                                                         <option value="Sun'aq">Sun'aq Tribe of Kodiak</option>
                                                         <option value="Suquamish">Suquamish Indian Tribe of the Port Madison Reservation</option>
                                                         <option value="Susanville">Susanville Indian Rancheria, California</option>
                                                         <option value="Swinomish">Swinomish Indian Tribal Community</option>
                                                         <option value="Sycuan">Sycuan Band of the Kumeyaay Nation</option>
                                                         <option value="Table Mountain">Table Mountain Rancheria</option>
                                                         <option value="Takotna">Takotna Village</option>
                                                         <option value="Tangirnaq">Tangirnaq Native Village</option>
                                                         <option value="Tejon">Tejon Indian Tribe</option>
                                                         <option value="Telida">Telida Village</option>
                                                         <option value="Te-Moak">Te-Moak Tribe of Western Shoshone Indians of Nevada (Four constituent bands: Battle Mountain Band; Elko Band; South Fork Band and Wells Band)</option>
                                                         <option value="Chickasaw Nation">The Chickasaw Nation</option>
                                                         <option value="The Choctaw Nation of Oklahoma">The Choctaw Nation of Oklahoma</option>
                                                         <option value="The Muscogee (Creek) Nation">The Muscogee (Creek) Nation</option>
                                                         <option value="The Osage Nation">The Osage Nation</option>
                                                         <option value="The Seminole Nation  of Oklahoma">The Seminole Nation of Oklahoma</option>
                                                         <option value="Thlopthlocco Tribal Town">Thlopthlocco Tribal Town</option>
                                                         <option value="Three Affiliated">Three Affiliated Tribes of the Fort Berthold Reservation, North Dakota</option>
                                                         <option value="Timbi-sha Shoshone">Timbisha Shoshone Tribe</option>
                                                         <option value="Tohono O'odham">Tohono O'odham Nation of Arizona</option>
                                                         <option value="Tolowa Dee-ni'">Tolowa Dee-ni' Nation</option>
                                                         <option value="Tonawanda">Tonawanda Band of Seneca</option>
                                                         <option value="Tonkawa">Tonkawa Tribe of Indians of Oklahoma</option>
                                                         <option value="Tonto Apache">Tonto Apache Tribe of Arizona</option>
                                                         <option value="Torres Martinez">Torres Martinez Desert Cahuilla Indians, California</option>
                                                         <option value="Togiak">Traditional Village of Togiak</option>
                                                         <option value="Tulalip">Tulalip Tribes of Washington</option>
                                                         <option value="Tule River">Tule River Indian Tribe of the Tule River Reservation, California</option>
                                                         <option value="Tuluksak">Tuluksak Native Community</option>
                                                         <option value="Tunica-Biloxi">Tunica-Biloxi Indian Tribe</option>
                                                         <option value="Tuolumne">Tuolumne Band of Me-Wuk Indians of the Tuolumne Rancheria of California</option>
                                                         <option value="Turtle Mountain">Turtle Mountain Band of Chippewa Indians of North Dakota</option>
                                                         <option value="Tuscarora">Tuscarora Nation</option>
                                                         <option value="Twenty-Nine Palms">Twenty-Nine Palms Band of Mission Indians of California</option>
                                                         <option value="Twin Hills">Twin Hills Village</option>
                                                         <option value="Ugashik">Ugashik Village</option>
                                                         <option value="Umkumiut">Umkumiut Native Village</option>
                                                         <option value="United Auburn">United Auburn Indian Community of the Auburn Rancheria of California</option>
                                                         <option value="United Keetoowah Band of Cherokee Indians in Oklahoma">United Keetoowah Band of Cherokee Indians in Oklahoma</option>
                                                         <option value="Upper Mattaponi Tribe">Upper Mattaponi Tribe</option>
                                                         <option value="Upper Sioux">Upper Sioux Community, Minnesota</option>
                                                         <option value="Upper Skagit">Upper Skagit Indian Tribe</option>
                                                         <option value="Ute">Ute Indian Tribe of the Uintah &amp; Ouray Reservation, Utah</option>
                                                         <option value="Ute Mountain Ute">Ute Mountain Ute Tribe</option>
                                                         <option value="Benton">Utu Utu Gwaitu Paiute Tribe of the Benton Paiute Reservation, California</option>
                                                         <option value="Alakanuk">Village of Alakanuk</option>
                                                         <option value="Anaktuvuk Pass">Village of Anaktuvuk Pass</option>
                                                         <option value="Aniak">Village of Aniak</option>
                                                         <option value="Atmautluak">Village of Atmautluak</option>
                                                         <option value="Bill Moore's Slough">Village of Bill Moore's Slough</option>
                                                         <option value="Chefornak">Village of Chefornak</option>
                                                         <option value="Clark's Point">Village of Clarks Point</option>
                                                         <option value="Crooked Creek">Village of Crooked Creek</option>
                                                         <option value="Dot Lake">Village of Dot Lake</option>
                                                         <option value="Iliamna">Village of Iliamna</option>
                                                         <option value="Kalskag">Village of Kalskag</option>
                                                         <option value="Kaltag">Village of Kaltag</option>
                                                         <option value="Kotlik">Village of Kotlik</option>
                                                         <option value="Lower Kalskag">Village of Lower Kalskag</option>
                                                         <option value="Ohogamiut">Village of Ohogamiut</option>
                                                         <option value="Red Devil">Village of Red Devil</option>
                                                         <option value="Sleetmute">Village of Sleetmute</option>
                                                         <option value="Solomon">Village of Solomon</option>
                                                         <option value="Stony River">Village of Stony River</option>
                                                         <option value="Venetie">Village of Venetie (See Native Village of Venetie Tribal Government)</option>
                                                         <option value="Wainwright">Village of Wainwright</option>
                                                         <option value="Walker River">Walker River Paiute Tribe of the Walker River Reservation, Nevada</option>
                                                         <option value="Wampanoag">Wampanoag Tribe of Gay Head (Aquinnah)</option>
                                                         <option value="Washoe">Washoe Tribe of Nevada &amp; California (Carson Colony, Dresslerville Colony, Woodfords Community, Stewart Community, &amp; Washoe Ranches)</option>
                                                         <option value="White Mountain">White Mountain Apache Tribe of the Fort Apache Reservation, Arizona</option>
                                                         <option value="Wichita">Wichita and Affiliated Tribes (Wichita, Keechi, Waco &amp; Tawakonie), Oklahoma</option>
                                                         <option value="Wilton">Wilton Rancheria, California</option>
                                                         <option value="Winnebago">Winnebago Tribe of Nebraska</option>
                                                         <option value="Winnemucca">Winnemucca Indian Colony of Nevada</option>
                                                         <option value="Wiyot">Wiyot Tribe, California</option>
                                                         <option value="Wrangell">Wrangell Cooperative Association</option>
                                                         <option value="Wyandotte Nation">Wyandotte Nation</option>
                                                         <option value="Yakutat">Yakutat Tlingit Tribe</option>
                                                         <option value="Yankton">Yankton Sioux Tribe of South Dakota</option>
                                                         <option value="Yavapai-Apache">Yavapai-Apache Nation of the Camp Verde Indian Reservation, Arizona</option>
                                                         <option value="Yavapai-Prescott">Yavapai-Prescott Indian Tribe</option>
                                                         <option value="Yerington">Yerington Paiute Tribe of the Yerington Colony and Campbell Ranch, Nevada</option>
                                                         <option value="Yocha Dehe">Yocha Dehe Wintun Nation, California</option>
                                                         <option value="Yomba Shoshone">Yomba Shoshone Tribe of the Yomba Reservation, Nevada</option>
                                                         <option value="Ysleta Del Sur">Ysleta del Sur Pueblo</option>
                                                         <option value="Yuhaaviatam of San Manuel Nation">Yuhaaviatam of San Manuel Nation</option>
                                                         <option value="Andreafski">Yupiit of Andreafski</option>
                                                         <option value="Yurok">Yurok Tribe of the Yurok Reservation, California</option>
                                                         <option value="Pueblo of Zuni">Zuni Tribe of the Zuni Reservation, New Mexico</option>
                                                         <option value="Other">Other</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div id="otherTribeFormationDiv" class="col-sm-6 mt-15 hidden" title="">
                                                   <label for="otherTribeFormation" class="main-label">d. Name of the other Tribe</label>
                                                   <div class="form-fields">
                                                      <input type="text" id="otherTribeFormation" name="otherTribeFormation" class="form-field">
                                                   </div>
                                                </div>
                                                <div id="stateFirstRegistrationDiv" class="col-sm-6 mt-15 hidden" title="">
                                                   <label for="stateFirstRegistration" class="main-label">e. State of first registration</label>
                                                   <div class="form-fields">
                                                      <select id="stateFirstRegistration" name="stateFirstRegistration" class="form-field">
                                                         <option value="">Select a state</option>
                                                         <option value="AS">American Samoa</option>
                                                         <option value="GU">Guam</option>
                                                         <option value="MH">Marshall Islands</option>
                                                         <option value="FM">Micronesia, Federated States</option>
                                                         <option value="MP">Northern Mariana Islands</option>
                                                         <option value="PW">Palau</option>
                                                         <option value="PR">Puerto Rico</option>
                                                         <option value="VI">U.S. Virgin Islands</option>
                                                         <option value="AL">Alabama</option>
                                                         <option value="AK">Alaska</option>
                                                         <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
                                                         <option value="AA">Armed Forces Americas (except Canada)</option>
                                                         <option value="AP">Armed Forces Pacific</option>
                                                         <option value="AZ">Arizona</option>
                                                         <option value="AR">Arkansas</option>
                                                         <option value="CA">California</option>
                                                         <option value="CO">Colorado</option>
                                                         <option value="CT">Connecticut</option>
                                                         <option value="DE">Delaware</option>
                                                         <option value="DC">District of Columbia</option>
                                                         <option value="FL">Florida</option>
                                                         <option value="GA">Georgia</option>
                                                         <option value="HI">Hawaii</option>
                                                         <option value="ID">Idaho</option>
                                                         <option value="IL">Illinois</option>
                                                         <option value="IN">Indiana</option>
                                                         <option value="IA">Iowa</option>
                                                         <option value="KS">Kansas</option>
                                                         <option value="KY">Kentucky</option>
                                                         <option value="LA">Louisiana</option>
                                                         <option value="ME">Maine</option>
                                                         <option value="MD">Maryland</option>
                                                         <option value="MA">Massachusetts</option>
                                                         <option value="MI">Michigan</option>
                                                         <option value="MN">Minnesota</option>
                                                         <option value="MS">Mississippi</option>
                                                         <option value="MO">Missouri</option>
                                                         <option value="MT">Montana</option>
                                                         <option value="NE">Nebraska</option>
                                                         <option value="NV">Nevada</option>
                                                         <option value="NH">New Hampshire</option>
                                                         <option value="NJ">New Jersey</option>
                                                         <option value="NM">New Mexico</option>
                                                         <option value="NY">New York</option>
                                                         <option value="NC">North Carolina</option>
                                                         <option value="ND">North Dakota</option>
                                                         <option value="OH">Ohio</option>
                                                         <option value="OK">Oklahoma</option>
                                                         <option value="OR">Oregon</option>
                                                         <option value="PA">Pennsylvania</option>
                                                         <option value="RI">Rhode Island</option>
                                                         <option value="SC">South Carolina</option>
                                                         <option value="SD">South Dakota</option>
                                                         <option value="TN">Tennessee</option>
                                                         <option value="TX">Texas</option>
                                                         <option value="UT">Utah</option>
                                                         <option value="VT">Vermont</option>
                                                         <option value="VA">Virginia</option>
                                                         <option value="WA">Washington</option>
                                                         <option value="WV">West Virginia</option>
                                                         <option value="WI">Wisconsin</option>
                                                         <option value="WY">Wyoming</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div id="tribalJurisdictionFirstRegistrationDiv" class="col-sm-6 mt-15 hidden" title="">
                                                   <label for="tribalJurisdictionFirstRegistration" class="main-label">f. Tribal jurisdiction of first registration</label>
                                                   <div class="form-fields">
                                                      <select id="tribalJurisdictionFirstRegistration" name="tribalJurisdictionFirstRegistration" class="form-field">
                                                         <option value="">Select a local/tribal</option>
                                                         <option value="Absentee-Shawnee">Absentee-Shawnee Tribe of Indians of Oklahoma</option>
                                                         <option value="Agdaagux">Agdaagux Tribe of King Cove</option>
                                                         <option value="Agua Caliente">Agua Caliente Band of Cahuilla Indians of the Agua Caliente Indian Reservation, California</option>
                                                         <option value="Ak Chin">Ak-Chin Indian Community</option>
                                                         <option value="Akiachak">Akiachak Native Community</option>
                                                         <option value="Akiak">Akiak Native Community</option>
                                                         <option value="Alabama-Coushatta">Alabama-Coushatta Tribe of Texas</option>
                                                         <option value="Alabama-Quassarte Tribal Town">Alabama-Quassarte Tribal Town</option>
                                                         <option value="Alatna">Alatna Village</option>
                                                         <option value="Algaaciq">Algaaciq Native Village (St. Mary's)</option>
                                                         <option value="Allakaket">Allakaket Village</option>
                                                         <option value="Alturas">Alturas Indian Rancheria, California</option>
                                                         <option value="Alutiiq Tribe of Old Harbor">Alutiiq Tribe of Old Harbor</option>
                                                         <option value="Angoon">Angoon Community Association</option>
                                                         <option value="Anvik">Anvik Village</option>
                                                         <option value="Apache">Apache Tribe of Oklahoma</option>
                                                         <option value="Arctic Village">Arctic Village (See Native Village of Venetie Tribal Government)</option>
                                                         <option value="Asa'carsarmiut">Asa'carsarmiut Tribe</option>
                                                         <option value="Assiniboine and Sioux">Assiniboine &amp; Sioux Tribes of the Fort Peck Indian Reservation, Montana</option>
                                                         <option value="Augustine">Augustine Band of Cahuilla Indians, California</option>
                                                         <option value="Bad River Band">Bad River Band of the Lake Superior Tribe of Chippewa Indians of the Bad River Reservation, Wisconsin</option>
                                                         <option value="Bay Mills">Bay Mills Indian Community, Michigan</option>
                                                         <option value="Bear River">Bear River Band of the Rohnerville Rancheria, California</option>
                                                         <option value="Beaver">Beaver Village</option>
                                                         <option value="Berry Creek">Berry Creek Rancheria of Maidu Indians of California</option>
                                                         <option value="Big Lagoon">Big Lagoon Rancheria, California</option>
                                                         <option value="Big Pine Reservation">Big Pine Paiute Tribe of the Owens Valley</option>
                                                         <option value="Big Sandy">Big Sandy Rancheria of Western Mono Indians of California</option>
                                                         <option value="Big Valley Rancheria">Big Valley Band of Pomo Indians of the Big Valley Rancheria, California</option>
                                                         <option value="Birch Creek">Birch Creek Tribe</option>
                                                         <option value="Bishop Paiute">Bishop Paiute Tribe</option>
                                                         <option value="Blackfeet">Blackfeet Tribe of the Blackfeet Indian Reservation of Montana</option>
                                                         <option value="Blue Lake">Blue Lake Rancheria, California</option>
                                                         <option value="Bridgeport Indian Colony">Bridgeport Indian Colony</option>
                                                         <option value="Buena Vista Rancheria">Buena Vista Rancheria of Me-Wuk Indians of California</option>
                                                         <option value="Burns Paiute">Burns Paiute Tribe</option>
                                                         <option value="Cabazon">Cabazon Band of Mission Indians, California</option>
                                                         <option value="Cachil DeHe">Cachil DeHe Band of Wintun Indians of the Colusa Indian Community of the Colusa Rancheria, California</option>
                                                         <option value="Caddo">Caddo Nation of Oklahoma</option>
                                                         <option value="Cahto">Cahto Tribe of the Laytonville Rancheria</option>
                                                         <option value="Cahuilla">Cahuilla Band of Indians</option>
                                                         <option value="California Valley">California Valley Miwok Tribe, California</option>
                                                         <option value="Campo">Campo Band of Diegueno Mission Indians of the Campo Indian Reservation, California</option>
                                                         <option value="Capitan Grande">Capitan Grande Band of Diegueno Mission Indians of California (Barona Group of Capitan Grande Band of Mission Indians of the Barona Reservation, California)</option>
                                                         <option value="Capitan Grande Band">Capitan Grande Band of Diegueno Mission Indians of California</option>
                                                         <option value="Viejas">Capitan Grande Band of Diegueno Mission Indians of California: Viejas (Baron Long) Group of Capitan Grande Band of Mission Indians of the Viejas Reservation, California</option>
                                                         <option value="Catawba">Catawba Indian Nation (aka Catawba Indian Tribe of South Carolina)</option>
                                                         <option value="Cayuga Nation of New York">Cayuga Nation</option>
                                                         <option value="Cedarville">Cedarville Rancheria, California</option>
                                                         <option value="Tlingit &amp; Haida">Central Council of the Tlingit &amp; Haida Indian Tribes</option>
                                                         <option value="Chalkyitsik">Chalkyitsik Village</option>
                                                         <option value="Cheesh-Na">Cheesh-Na Tribe</option>
                                                         <option value="Chemehuevi">Chemehuevi Indian Tribe of the Chemehuevi Reservation, California</option>
                                                         <option value="Cher-Ae Heights">Cher-Ae Heights Indian Community of the Trinidad Rancheria, California</option>
                                                         <option value="Cherokee Nation">Cherokee Nation</option>
                                                         <option value="Chevak">Chevak Native Village</option>
                                                         <option value="Cheyenne River">Cheyenne and Arapaho Tribes, Oklahoma</option>
                                                         <option value="Cheyenne River Sioux Tribe">Cheyenne River Sioux Tribe of the Cheyenne River Reservation, South Dakota</option>
                                                         <option value="Chickahominy Indians-Eastern Division">Chickahominy Indian Tribe - Eastern Division</option>
                                                         <option value="Chickahominy Indian Tribe, Inc.">Chickahominy Indian Tribe</option>
                                                         <option value="Chickaloon">Chickaloon Native Village</option>
                                                         <option value="Chicken Ranch">Chicken Ranch Rancheria of Me-Wuk Indians of California</option>
                                                         <option value="Chignik Bay">Chignik Bay Tribal Council</option>
                                                         <option value="Chignik Lake">Chignik Lake Village</option>
                                                         <option value="Chilkat">Chilkat Indian Village (Klukwan)</option>
                                                         <option value="Chilkoot">Chilkoot Indian Association (Haines)</option>
                                                         <option value="Chinik">Chinik Eskimo Community (Golovin)</option>
                                                         <option value="Chippewa-Cree">Chippewa Cree Indians of the Rocky Boy's Reservation, Montana</option>
                                                         <option value="Chitimacha">Chitimacha Tribe of Louisiana</option>
                                                         <option value="Chuloonawick">Chuloonawick Native Village</option>
                                                         <option value="Circle">Circle Native Community</option>
                                                         <option value="Citizen Potawatomi">Citizen Potawatomi Nation, Oklahoma</option>
                                                         <option value="Cloverdale">Cloverdale Rancheria of Pomo Indians of California</option>
                                                         <option value="Cocopah">Cocopah Tribe of Arizona</option>
                                                         <option value="Coeur D'Alene">Coeur D'Alene Tribe</option>
                                                         <option value="Cold Springs">Cold Springs Rancheria of Mono Indians of California</option>
                                                         <option value="Colorado River">Colorado River Indian Tribes of the Colorado River Indian Reservation, Arizona and California</option>
                                                         <option value="Comanche">Comanche Nation, Oklahoma</option>
                                                         <option value="Confederated Salish">Confederated Salish and Kootenai Tribes of the Flathead Reservation</option>
                                                         <option value="Confederated Yakama">Confederated Tribes and Bands of the Yakama Nation</option>
                                                         <option value="Siletz Tribe">Confederated Tribes of Siletz Indians of Oregon</option>
                                                         <option value="Chehalis">Confederated Tribes of the Chehalis Reservation</option>
                                                         <option value="Confederated Colville">Confederated Tribes of the Colville Reservation</option>
                                                         <option value="Confederated Coos">Confederated Tribes of the Coos, Lower Umpqua and Siuslaw Indians</option>
                                                         <option value="Confederated Goshute">Confederated Tribes of the Goshute Reservation, Nevada and Utah</option>
                                                         <option value="Grand Ronde Tribes">Confederated Tribes of the Grand Ronde Community of Oregon</option>
                                                         <option value="Umatilla Tribe">Confederated Tribes of the Umatilla Indian Reservation</option>
                                                         <option value="Warms Springs Tribe">Confederated Tribes of the Warm Springs Reservation of Oregon</option>
                                                         <option value="Coquille">Coquille Indian Tribe</option>
                                                         <option value="Coushatta">Coushatta Tribe of Louisiana</option>
                                                         <option value="Cow Creek">Cow Creek Band of Umpqua Tribe of Indians</option>
                                                         <option value="Cowlitz">Cowlitz Indian Tribe</option>
                                                         <option value="Coyote Valley">Coyote Valley Band of Pomo Indians of California</option>
                                                         <option value="Craig">Craig Tribal Association</option>
                                                         <option value="Crow Creek">Crow Creek Sioux Tribe of the Crow Creek Reservation, South Dakota</option>
                                                         <option value="Crow">Crow Tribe of Montana</option>
                                                         <option value="Curyung">Curyung Tribal Council</option>
                                                         <option value="Delaware Nation">Delaware Nation, Oklahoma</option>
                                                         <option value="Delaware Tribe of Indians">Delaware Tribe of Indians</option>
                                                         <option value="Douglas">Douglas Indian Association</option>
                                                         <option value="Dry Creek">Dry Creek Rancheria Band of Pomo Indians, California</option>
                                                         <option value="Duckwater">Duckwater Shoshone Tribe of the Duckwater Reservation, Nevada</option>
                                                         <option value="Eastern Cherokee">Eastern Band of Cherokee Indians</option>
                                                         <option value="Eastern Shawnee Tribe of Oklahoma">Eastern Shawnee Tribe of Oklahoma</option>
                                                         <option value="Eastern Shoshone">Eastern Shoshone Tribe of the Wind River Reservation, Wyoming</option>
                                                         <option value="Egegik">Egegik Village</option>
                                                         <option value="Eklutna">Eklutna Native Village</option>
                                                         <option value="Elem">Elem Indian Colony of Pomo Indians of the Sulphur Bank Rancheria, California</option>
                                                         <option value="Elk Valley">Elk Valley Rancheria, California</option>
                                                         <option value="Ely Shoshone">Ely Shoshone Tribe of Nevada</option>
                                                         <option value="Emmonak">Emmonak Village</option>
                                                         <option value="Enterprise">Enterprise Rancheria of Maidu Indians of California</option>
                                                         <option value="Evansville">Evansville Village (aka Bettles Field)</option>
                                                         <option value="Ewiiaapaayp">Ewiiaapaayp Band of Kumeyaay Indians, California</option>
                                                         <option value="Federated Indians of Graton">Federated Indians of Graton Rancheria, California</option>
                                                         <option value="Flandreau">Flandreau Santee Sioux Tribe of South Dakota</option>
                                                         <option value="Forest County">Forest County Potawatomi Community, Wisconsin</option>
                                                         <option value="Assiniboine and Gros Ventre Tribes">Fort Belknap Indian Community of the Fort Belknap Reservation of Montana</option>
                                                         <option value="Fort Bidwell">Fort Bidwell Indian Community of the Fort Bidwell Reservation of California</option>
                                                         <option value="Fort Independence">Fort Independence Indian Community of Paiute Indians of the Fort Independence Reservation, California</option>
                                                         <option value="Fort McDermitt">Fort McDermitt Paiute and Shoshone Tribes of the Fort McDermitt Indian Reservation, Nevada and Oregon</option>
                                                         <option value="Fort McDowell">Fort McDowell Yavapai Nation, Arizona</option>
                                                         <option value="Fort Mojave">Fort Mojave Indian Tribe of Arizona, California &amp; Nevada</option>
                                                         <option value="Fort Sill">Fort Sill Apache Tribe of Oklahoma</option>
                                                         <option value="Galena">Galena Village (aka Louden Village)</option>
                                                         <option value="Gila River">Gila River Indian Community of the Gila River Indian Reservation, Arizona</option>
                                                         <option value="Grand Traverse">Grand Traverse Band of Ottawa and Chippewa Indians, Michigan</option>
                                                         <option value="Greenville">Greenville Rancheria</option>
                                                         <option value="Grindstone">Grindstone Indian Rancheria of Wintun-Wailaki Indians of California</option>
                                                         <option value="Guidiville">Guidiville Rancheria of California</option>
                                                         <option value="Gulkana">Gulkana Village Council</option>
                                                         <option value="Habematolel">Habematolel Pomo of Upper Lake, California</option>
                                                         <option value="Hannahville">Hannahville Indian Community, Michigan</option>
                                                         <option value="Havasupai">Havasupai Tribe of the Havasupai Reservation, Arizona</option>
                                                         <option value="Healy Lake">Healy Lake Village</option>
                                                         <option value="Ho-Chunk">Ho-Chunk Nation of Wisconsin</option>
                                                         <option value="Hoh">Hoh Indian Tribe</option>
                                                         <option value="Holy Cross">Holy Cross Tribe</option>
                                                         <option value="Hoonah">Hoonah Indian Association</option>
                                                         <option value="Hoopa">Hoopa Valley Tribe, California</option>
                                                         <option value="Hopi">Hopi Tribe of Arizona</option>
                                                         <option value="Hopland">Hopland Band of Pomo Indians, California</option>
                                                         <option value="Houlton">Houlton Band of Maliseet Indians</option>
                                                         <option value="Hualapai">Hualapai Indian Tribe of the Hualapai Indian Reservation, Arizona</option>
                                                         <option value="Hughes">Hughes Village</option>
                                                         <option value="Huslia">Huslia Village</option>
                                                         <option value="Hydaburg">Hydaburg Cooperative Association</option>
                                                         <option value="Igiugig">Igiugig Village</option>
                                                         <option value="Iipay">Iipay Nation of Santa Ysabel, California</option>
                                                         <option value="Inaja">Inaja Band of Diegueno Mission Indians of the Inaja and Cosmit Reservation, California</option>
                                                         <option value="Inupiat Community of the Arctic Slope">Inupiat Community of the Arctic Slope</option>
                                                         <option value="Ione">Ione Band of Miwok Indians of California</option>
                                                         <option value="Iowa of Kansas">Iowa Tribe of Kansas and Nebraska</option>
                                                         <option value="Iowa of Oklahoma">Iowa Tribe of Oklahoma</option>
                                                         <option value="Iqugmiut">Iqugmiut Traditional Council</option>
                                                         <option value="Ivanof Bay Tribe">Ivanof Bay Tribe</option>
                                                         <option value="Jackson">Jackson Band of Miwuk Indians</option>
                                                         <option value="Jamestown">Jamestown S'Klallam Tribe</option>
                                                         <option value="Jamul">Jamul Indian Village of California</option>
                                                         <option value="Jena">Jena Band of Choctaw Indians</option>
                                                         <option value="Jicarilla">Jicarilla Apache Nation, New Mexico</option>
                                                         <option value="Kaguyuk">Kaguyak Village</option>
                                                         <option value="Kaibab">Kaibab Band of Paiute Indians of the Kaibab Indian Reservation, Arizona</option>
                                                         <option value="Kaktovik">Kaktovik Village (aka Barter Island)</option>
                                                         <option value="Kalispel">Kalispel Indian Community of the Kalispel Reservation</option>
                                                         <option value="Karuk">Karuk Tribe</option>
                                                         <option value="Kashia">Kashia Band of Pomo Indians of the Stewarts Point Rancheria, California</option>
                                                         <option value="Kasigluk">Kasigluk Traditional Elders Council</option>
                                                         <option value="Kaw">Kaw Nation, Oklahoma</option>
                                                         <option value="Kenaitze">Kenaitze Indian Tribe</option>
                                                         <option value="Ketchikan">Ketchikan Indian Community</option>
                                                         <option value="Keweenaw">Keweenaw Bay Indian Community, Michigan</option>
                                                         <option value="Kialegee Tribal Town">Kialegee Tribal Town</option>
                                                         <option value="Kickapoo of Texas">Kickapoo Traditional Tribe of Texas</option>
                                                         <option value="Kickapoo Tribe in Kansas">Kickapoo Tribe of Indians of the Kickapoo Reservation in Kansas</option>
                                                         <option value="Kickapoo of Oklahoma">Kickapoo Tribe of Oklahoma</option>
                                                         <option value="King Island">King Island Native Community</option>
                                                         <option value="King Salmon">King Salmon Tribe</option>
                                                         <option value="Kiowa Tribe">Kiowa  Indian Tribe of Oklahoma</option>
                                                         <option value="Klamath">Klamath Tribes</option>
                                                         <option value="Klawock">Klawock Cooperative Association</option>
                                                         <option value="Cortina">Kletsel Dehe Band of Wintun Indians</option>
                                                         <option value="Knik">Knik Tribe</option>
                                                         <option value="Koi">Koi Nation of Northern California</option>
                                                         <option value="Kokhanok">Kokhanok Village</option>
                                                         <option value="Kootenai">Kootenai Tribe of Idaho</option>
                                                         <option value="Koyukuk">Koyukuk Native Village</option>
                                                         <option value="La Jolla">La Jolla Band of Luiseno Indians, California</option>
                                                         <option value="La Posta">La Posta Band of Diegueno Mission Indians of the La Posta Indian Reservation, California</option>
                                                         <option value="Lac Courte Oreilles">Lac Courte Oreilles Band of Lake Superior Chippewa Indians of Wisconsin</option>
                                                         <option value="Lac du Flambeau">Lac du Flambeau Band of Lake Superior Chippewa Indians of the Lac du Flambeau Reservation of Wisconsin</option>
                                                         <option value="Lac Vieux">Lac Vieux Desert Band of Lake Superior Chippewa Indians of Michigan</option>
                                                         <option value="Las Vegas">Las Vegas Tribe of Paiute Indians of the Las Vegas Indian Colony, Nevada</option>
                                                         <option value="Levelock">Levelock Village</option>
                                                         <option value="Lime">Lime Village</option>
                                                         <option value="Little River">Little River Band of Ottawa Indians, Michigan</option>
                                                         <option value="Little Shell Tribe">Little Shell Tribe of Chippewa Indians of Montana</option>
                                                         <option value="Little Traverse">Little Traverse Bay Bands of Odawa Indians, Michigan</option>
                                                         <option value="Lone Pine">Lone Pine Paiute-Shoshone Tribe</option>
                                                         <option value="Los Coyotes">Los Coyotes Band of Cahuilla and Cupeno Indians, California</option>
                                                         <option value="Lovelock">Lovelock Paiute Tribe of the Lovelock Indian Colony, Nevada</option>
                                                         <option value="Lower Brule">Lower Brule Sioux Tribe of the Lower Brule Reservation, South Dakota</option>
                                                         <option value="Lower Elwha">Lower Elwha Tribal Community</option>
                                                         <option value="Lower Sioux">Lower Sioux Indian Community in the State of Minnesota</option>
                                                         <option value="Lummi">Lummi Tribe of the Lummi Reservation</option>
                                                         <option value="Lytton">Lytton Rancheria of California</option>
                                                         <option value="Makah">Makah Indian Tribe of the Makah Indian Reservation</option>
                                                         <option value="Manchester">Manchester Band of Pomo Indians of the Manchester Rancheria, California</option>
                                                         <option value="Manley Hot Springs">Manley Hot Springs Village</option>
                                                         <option value="Manokotak">Manokotak Village</option>
                                                         <option value="Manzanita">Manzanita Band of Diegueno Mission Indians of the Manzanita Reservation, California</option>
                                                         <option value="Mashantucket Pequot">Mashantucket Pequot Indian Tribe</option>
                                                         <option value="Mashpee">Mashpee Wampanoag Tribe</option>
                                                         <option value="Match-e-be-nash-she-wish Band">Match-e-be-nash-she-wish Band of Pottawatomi Indians of Michigan</option>
                                                         <option value="Mcgrath">McGrath Native Village</option>
                                                         <option value="Mechoopda">Mechoopda Indian Tribe of Chico Rancheria, California</option>
                                                         <option value="Menominee">Menominee Indian Tribe of Wisconsin</option>
                                                         <option value="Mentasta">Mentasta Traditional Council</option>
                                                         <option value="Mesa Grande">Mesa Grande Band of Diegueno Mission Indians of the Mesa Grande Reservation, California</option>
                                                         <option value="Mescalero Apache">Mescalero Apache Tribe of the Mescalero Reservation, New Mexico</option>
                                                         <option value="Metlakatla">Metlakatla Indian Community, Annette Island Reserve</option>
                                                         <option value="Miami Tribe of Oklahoma">Miami Tribe of Oklahoma</option>
                                                         <option value="Miccosukee">Miccosukee Tribe of Indians</option>
                                                         <option value="Middletown">Middletown Rancheria of Pomo Indians of California</option>
                                                         <option value="Mi'kmaq Nation">Mi'kmaq Nation</option>
                                                         <option value="Bois Forte">Minnesota Chippewa Tribe - Bois Forte Band (Nett Lake)</option>
                                                         <option value="Fond du Lac">Minnesota Chippewa Tribe - Fond du Lac Band</option>
                                                         <option value="Grand Portage">Minnesota Chippewa Tribe - Grand Portage Band</option>
                                                         <option value="Leech Lake">Minnesota Chippewa Tribe - Leech Lake Band</option>
                                                         <option value="Mille Lacs">Minnesota Chippewa Tribe - Mille Lacs Band</option>
                                                         <option value="White Earth">Minnesota Chippewa Tribe - White Earth Band</option>
                                                         <option value="Minnesota Chippewa">Minnesota Chippewa Tribe, Minnesota</option>
                                                         <option value="Mississippi Choctaw">Mississippi Band of Choctaw Indians</option>
                                                         <option value="Moapa">Moapa Band of Paiute Indians of the Moapa River Indian Reservation, Nevada</option>
                                                         <option value="Modoc Nation">Modoc Nation</option>
                                                         <option value="Mohegan">Mohegan Tribe of Indians of Connecticut</option>
                                                         <option value="Monacan Indian Nation">Monacan Indian Nation</option>
                                                         <option value="Mooretown">Mooretown Rancheria of Maidu Indians of California</option>
                                                         <option value="Morongo">Morongo Band of Mission Indians, California</option>
                                                         <option value="Muckleshoot">Muckleshoot Indian Tribe</option>
                                                         <option value="Naknek">Naknek Native Village</option>
                                                         <option value="Nansemond Indian Tribe">Nansemond Indian Nation</option>
                                                         <option value="Narragansett">Narragansett Indian Tribe</option>
                                                         <option value="Afognak">Native Village of Afognak</option>
                                                         <option value="Akhiok">Native Village of Akhiok</option>
                                                         <option value="Akutan">Native Village of Akutan</option>
                                                         <option value="Aleknagik">Native Village of Aleknagik</option>
                                                         <option value="Ambler">Native Village of Ambler</option>
                                                         <option value="Atka">Native Village of Atka</option>
                                                         <option value="Native Village of Atqasuk">Native Village of Atqasuk</option>
                                                         <option value="Barrow">Native Village of Barrow Inupiat Traditional Government</option>
                                                         <option value="Belkofski">Native Village of Belkofski</option>
                                                         <option value="Brevig Mission">Native Village of Brevig Mission</option>
                                                         <option value="Buckland">Native Village of Buckland</option>
                                                         <option value="Cantwell">Native Village of Cantwell</option>
                                                         <option value="Chenega">Native Village of Chenega (aka Chanega)</option>
                                                         <option value="Chignik Lagoon">Native Village of Chignik Lagoon</option>
                                                         <option value="Chitina">Native Village of Chitina</option>
                                                         <option value="Chuathbaluk">Native Village of Chuathbaluk (Russian Mission, Kuskokwim)</option>
                                                         <option value="Council">Native Village of Council</option>
                                                         <option value="Deering">Native Village of Deering</option>
                                                         <option value="Diomede">Native Village of Diomede (aka Inalik)</option>
                                                         <option value="Eagle">Native Village of Eagle</option>
                                                         <option value="Eek">Native Village of Eek</option>
                                                         <option value="Ekuk">Native Village of Ekuk</option>
                                                         <option value="Ekwok">Native Village of Ekwok</option>
                                                         <option value="Elim IRA">Native Village of Elim</option>
                                                         <option value="Eyak">Native Village of Eyak (Cordova)</option>
                                                         <option value="False Pass">Native Village of False Pass</option>
                                                         <option value="Fort Yukon">Native Village of Fort Yukon</option>
                                                         <option value="Gakona">Native Village of Gakona</option>
                                                         <option value="Gambell">Native Village of Gambell</option>
                                                         <option value="Georgetown">Native Village of Georgetown</option>
                                                         <option value="Goodnews Bay">Native Village of Goodnews Bay</option>
                                                         <option value="Hamilton">Native Village of Hamilton</option>
                                                         <option value="Hooper Bay">Native Village of Hooper Bay</option>
                                                         <option value="Kanatak">Native Village of Kanatak</option>
                                                         <option value="Karluk">Native Village of Karluk</option>
                                                         <option value="Kiana">Native Village of Kiana</option>
                                                         <option value="Kipnuk">Native Village of Kipnuk</option>
                                                         <option value="Kivalina">Native Village of Kivalina</option>
                                                         <option value="Kluti Kaah">Native Village of Kluti Kaah (aka Copper Center)</option>
                                                         <option value="Kobuk">Native Village of Kobuk</option>
                                                         <option value="Kongiganak">Native Village of Kongiganak</option>
                                                         <option value="Kotzebue">Native Village of Kotzebue</option>
                                                         <option value="Koyuk">Native Village of Koyuk</option>
                                                         <option value="Kwigillingok">Native Village of Kwigillingok</option>
                                                         <option value="Kwinhagak">Native Village of Kwinhagak (aka Quinhagak)</option>
                                                         <option value="Larsen Bay">Native Village of Larsen Bay</option>
                                                         <option value="Marshall">Native Village of Marshall (aka Fortuna Ledge)</option>
                                                         <option value="Mary's Igloo">Native Village of Mary's Igloo</option>
                                                         <option value="Mekoryuk">Native Village of Mekoryuk</option>
                                                         <option value="Minto">Native Village of Minto</option>
                                                         <option value="Nanwalek">Native Village of Nanwalek (aka English Bay)</option>
                                                         <option value="Napaimute">Native Village of Napaimute</option>
                                                         <option value="Napakiak">Native Village of Napakiak</option>
                                                         <option value="Napaskiak">Native Village of Napaskiak</option>
                                                         <option value="Nelson Lagoon">Native Village of Nelson Lagoon</option>
                                                         <option value="Nightmute">Native Village of Nightmute</option>
                                                         <option value="Nikolski">Native Village of Nikolski</option>
                                                         <option value="Noatak">Native Village of Noatak</option>
                                                         <option value="Nuiqsut">Native Village of Nuiqsut (aka Nooiksut)</option>
                                                         <option value="Nunam Iqua">Native Village of Nunam Iqua</option>
                                                         <option value="Nunapitchuk">Native Village of Nunapitchuk</option>
                                                         <option value="Ouzinkie">Native Village of Ouzinkie</option>
                                                         <option value="Paimiut">Native Village of Paimiut</option>
                                                         <option value="Perryville">Native Village of Perryville</option>
                                                         <option value="Pilot Point">Native Village of Pilot Point</option>
                                                         <option value="Point Hope IRA">Native Village of Point Hope</option>
                                                         <option value="Point Lay IRA">Native Village of Point Lay</option>
                                                         <option value="Port Graham">Native Village of Port Graham</option>
                                                         <option value="Port Heiden">Native Village of Port Heiden</option>
                                                         <option value="Port Lions">Native Village of Port Lions</option>
                                                         <option value="Ruby">Native Village of Ruby</option>
                                                         <option value="St. Michael IRA">Native Village of Saint Michael</option>
                                                         <option value="Savoonga">Native Village of Savoonga</option>
                                                         <option value="Scammon Bay">Native Village of Scammon Bay</option>
                                                         <option value="Selawik">Native Village of Selawik</option>
                                                         <option value="Shaktoolik">Native Village of Shaktoolik</option>
                                                         <option value="Shishmaref IRA">Native Village of Shishmaref</option>
                                                         <option value="Shungnak">Native Village of Shungnak</option>
                                                         <option value="Stevens Village">Native Village of Stevens</option>
                                                         <option value="Tanacross">Native Village of Tanacross</option>
                                                         <option value="Tanana">Native Village of Tanana</option>
                                                         <option value="Tatitlek">Native Village of Tatitlek</option>
                                                         <option value="Tazlina">Native Village of Tazlina</option>
                                                         <option value="Teller">Native Village of Teller</option>
                                                         <option value="Tetlin">Native Village of Tetlin</option>
                                                         <option value="Tuntutuliak">Native Village of Tuntutuliak</option>
                                                         <option value="Tununak">Native Village of Tununak</option>
                                                         <option value="Tyonek">Native Village of Tyonek</option>
                                                         <option value="Unalakleet">Native Village of Unalakleet</option>
                                                         <option value="Unga">Native Village of Unga</option>
                                                         <option value="Venetie IRA">Native Village of Venetie Tribal Government (Arctic Village and Village of Venetie)</option>
                                                         <option value="Wales">Native Village of Wales</option>
                                                         <option value="White Mountain AK">Native Village of White Mountain</option>
                                                         <option value="Navajo">Navajo Nation, Arizona, New Mexico &amp; Utah</option>
                                                         <option value="Nenana">Nenana Native Association</option>
                                                         <option value="New Koliganek">New Koliganek Village Council</option>
                                                         <option value="New Stuyahok">New Stuyahok Village</option>
                                                         <option value="Newhalen">Newhalen Village</option>
                                                         <option value="Newtok">Newtok Village</option>
                                                         <option value="Nez Perce">Nez Perce Tribe</option>
                                                         <option value="Nikolai">Nikolai Village</option>
                                                         <option value="Ninilchik">Ninilchik Village</option>
                                                         <option value="Nisqually">Nisqually Indian Tribe</option>
                                                         <option value="Nome">Nome Eskimo Community</option>
                                                         <option value="Nondalton">Nondalton Village</option>
                                                         <option value="Nooksack">Nooksack Indian Tribe</option>
                                                         <option value="Noorvik">Noorvik Native Community</option>
                                                         <option value="Northern Arapaho">Northern Arapaho Tribe of the Wind River Reservation, Wyoming</option>
                                                         <option value="Northern Cheyenne">Northern Cheyenne Tribe of the Northern Cheyenne Indian Reservation, Montana</option>
                                                         <option value="North Fork">Northfork Rancheria of Mono Indians of California</option>
                                                         <option value="Northway">Northway Village</option>
                                                         <option value="Northwestern Shoshone">Northwestern Band of the Shoshone Nation</option>
                                                         <option value="Nottawaseppi Potawatomi">Nottawaseppi Huron Band of the Potawatomi, Michigan</option>
                                                         <option value="Nulato">Nulato Village</option>
                                                         <option value="Nunakauyarmiut">Nunakauyarmiut Tribe</option>
                                                         <option value="Oglala Sioux">Oglala Sioux Tribe</option>
                                                         <option value="Ohkay Owingeh">Ohkay Owingeh, New Mexico</option>
                                                         <option value="Omaha">Omaha Tribe of Nebraska</option>
                                                         <option value="Oneida">Oneida Indian Nation</option>
                                                         <option value="Oneida Nation (Wisconsin)">Oneida Nation</option>
                                                         <option value="Onondaga">Onondaga Nation</option>
                                                         <option value="Grayling">Organized Village of Grayling (aka Holikachuk)</option>
                                                         <option value="Kake">Organized Village of Kake</option>
                                                         <option value="Kasaan">Organized Village of Kasaan</option>
                                                         <option value="Kwethluk">Organized Village of Kwethluk</option>
                                                         <option value="Saxman">Organized Village of Saxman</option>
                                                         <option value="Orutsararmiut">Orutsararmiut Traditional Native Council</option>
                                                         <option value="Oscarville">Oscarville Traditional Village</option>
                                                         <option value="Otoe-Missouria">Otoe-Missouria Tribe of Indians, Oklahoma</option>
                                                         <option value="Ottawa Tribe of Oklahoma">Ottawa Tribe of Oklahoma</option>
                                                         <option value="Paiute of Utah">Paiute Indian Tribe of Utah (Cedar Band of Paiutes, Kanosh Band of Paiutes, Koosharem Band of Paiutes, Indian Peaks Band of Paiutes, and Shivwits Band of Paiutes)</option>
                                                         <option value="Paiute-Shoshone">Paiute-Shoshone Tribe of the Fallon Reservation and Colony, Nevada</option>
                                                         <option value="Pala">Pala Band of Mission Indians</option>
                                                         <option value="Pamunkey Indian Tribe">Pamunkey Indian Tribe</option>
                                                         <option value="Pascua Yaqui">Pascua Yaqui Tribe of Arizona</option>
                                                         <option value="Paskenta">Paskenta Band of Nomlaki Indians of California</option>
                                                         <option value="Passamaquoddy Indian Township">Passamaquoddy Tribe - Indian Township</option>
                                                         <option value="Passamaquoddy Pleasant Point">Passamaquoddy Tribe - Pleasant Point</option>
                                                         <option value="Passamaquoddy Tribe">Passamaquoddy Tribe</option>
                                                         <option value="Pauloff Harbor">Pauloff Harbor Village</option>
                                                         <option value="Pauma">Pauma Band of Luiseno Mission Indians of the Pauma &amp; Yuima Reservation, California</option>
                                                         <option value="Pawnee">Pawnee Nation of Oklahoma</option>
                                                         <option value="Pechanga Band of Indians">Pechanga Band of Indians</option>
                                                         <option value="Pedro Bay">Pedro Bay Village</option>
                                                         <option value="Penobscot">Penobscot Nation</option>
                                                         <option value="Peoria Tribe of Indians of Oklahoma">Peoria Tribe of Indians of Oklahoma</option>
                                                         <option value="Petersburg">Petersburg Indian Association</option>
                                                         <option value="Picayune">Picayune Rancheria of Chukchansi Indians of California</option>
                                                         <option value="Pilot Station">Pilot Station Traditional Village</option>
                                                         <option value="Pinoleville">Pinoleville Pomo Nation, California</option>
                                                         <option value="Pit River">Pit River Tribe, California</option>
                                                         <option value="Pitka's Point">Pitka's Point Traditional Council</option>
                                                         <option value="Platinum">Platinum Traditional Village</option>
                                                         <option value="Poarch">Poarch Band of Creek Indians</option>
                                                         <option value="Pokagon">Pokagon Band of Potawatomi Indians, Michigan and Indiana</option>
                                                         <option value="Ponca of Oklahoma">Ponca Tribe of Indians of Oklahoma</option>
                                                         <option value="Ponca of Nebraska">Ponca Tribe of Nebraska</option>
                                                         <option value="Port Gamble">Port Gamble S'Klallam Tribe</option>
                                                         <option value="Portage Creek">Portage Creek Village (aka Ohgsenakale)</option>
                                                         <option value="Potter Valley">Potter Valley Tribe, California</option>
                                                         <option value="Prairie Band">Prairie Band Potawatomi Nation</option>
                                                         <option value="Prairie Island">Prairie Island Indian Community in the State of Minnesota</option>
                                                         <option value="Pribilof Islands Aleut Communities">Pribilof Islands Aleut Communities</option>
                                                         <option value="Pueblo of Acoma">Pueblo of Acoma, New Mexico</option>
                                                         <option value="Pueblo of Cochiti">Pueblo of Cochiti, New Mexico</option>
                                                         <option value="Pueblo of Isleta">Pueblo of Isleta, New Mexico</option>
                                                         <option value="Pueblo of Jemez">Pueblo of Jemez, New Mexico</option>
                                                         <option value="Pueblo of Laguna">Pueblo of Laguna, New Mexico</option>
                                                         <option value="Pueblo of Nambe">Pueblo of Nambe, New Mexico</option>
                                                         <option value="Pueblo of Picuris">Pueblo of Picuris, New Mexico</option>
                                                         <option value="Pueblo of Pojoaque">Pueblo of Pojoaque, New Mexico</option>
                                                         <option value="Pueblo of San Felipe">Pueblo of San Felipe, New Mexico</option>
                                                         <option value="Pueblo of San Ildefonso">Pueblo of San Ildefonso, New Mexico</option>
                                                         <option value="Pueblo of Sandia">Pueblo of Sandia, New Mexico</option>
                                                         <option value="Pueblo of Santa Ana">Pueblo of Santa Ana, New Mexico</option>
                                                         <option value="Pueblo of Santa Clara">Pueblo of Santa Clara, New Mexico</option>
                                                         <option value="Pueblo of Taos">Pueblo of Taos, New Mexico</option>
                                                         <option value="Pueblo of Tesuque">Pueblo of Tesuque, New Mexico</option>
                                                         <option value="Pueblo of Zia">Pueblo of Zia, New Mexico</option>
                                                         <option value="Puyallup">Puyallup Tribe of the Puyallup Reservation</option>
                                                         <option value="Pyramid Lake">Pyramid Lake Paiute Tribe of the Pyramid Lake Reservation, Nevada</option>
                                                         <option value="Qagan Tayagungin">Qagan Tayagungin Tribe of Sand Point</option>
                                                         <option value="Qawalangin">Qawalangin Tribe of Unalaska</option>
                                                         <option value="Quapaw Nation">Quapaw Nation</option>
                                                         <option value="Quartz Valley">Quartz Valley Indian Community of the Quartz Valley Reservation of California</option>
                                                         <option value="Quechan">Quechan Tribe of the Fort Yuma Indian Reservation, California &amp; Arizona</option>
                                                         <option value="Quileute">Quileute Tribe of the Quileute Reservation</option>
                                                         <option value="Quinault">Quinault Indian Nation</option>
                                                         <option value="Ramah Navajo Chapter">Ramah Navajo Chapter of the Navajo Nation</option>
                                                         <option value="Ramona">Ramona Band of Cahuilla, California</option>
                                                         <option value="Rampart">Rampart Village</option>
                                                         <option value="Rappahannock Tribe, Inc.">Rappahannock Tribe, Inc.</option>
                                                         <option value="Red Cliff">Red Cliff Band of Lake Superior Chippewa Indians of Wisconsin</option>
                                                         <option value="Red Lake">Red Lake Band of Chippewa Indians, Minnesota</option>
                                                         <option value="Redding">Redding Rancheria, California</option>
                                                         <option value="Redwood Valley">Redwood Valley or Little River Band of Pomo Indians of the Redwood Valley Rancheria California</option>
                                                         <option value="Reno-Sparks">Reno-Sparks Indian Colony, Nevada</option>
                                                         <option value="Resighini">Resighini Rancheria, California</option>
                                                         <option value="Rincon">Rincon Band of Luiseno Mission Indians of the Rincon Reservation, California</option>
                                                         <option value="Robinson">Robinson Rancheria</option>
                                                         <option value="Rosebud">Rosebud Sioux Tribe of the Rosebud Indian Reservation, South Dakota</option>
                                                         <option value="Round Valley">Round Valley Indian Tribes, Round Valley Reservation, California</option>
                                                         <option value="Sac &amp; Fox Nation of Missouri in Kansas and Nebraska">Sac &amp; Fox Nation of Missouri in Kansas and Nebraska</option>
                                                         <option value="Sac &amp; Fox Nation, Oklahoma">Sac &amp; Fox Nation, Oklahoma</option>
                                                         <option value="Sac &amp; Fox of Mississippi">Sac &amp; Fox Tribe of the Mississippi in Iowa</option>
                                                         <option value="Saginaw Chippewa">Saginaw Chippewa Indian Tribe of Michigan</option>
                                                         <option value="St. George">Saint George Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                                                         <option value="Saint Paul">Saint Paul Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                                                         <option value="Saint Regis">Saint Regis Mohawk Tribe</option>
                                                         <option value="Salamatof">Salamatof Tribe</option>
                                                         <option value="Salt River">Salt River Pima-Maricopa Indian Community of the Salt River Reservation, Arizona</option>
                                                         <option value="Samish">Samish Indian Nation</option>
                                                         <option value="San Carlos">San Carlos Apache Tribe of the San Carlos Reservation, Arizona</option>
                                                         <option value="San Juan">San Juan Southern Paiute Tribe of Arizona</option>
                                                         <option value="San Pasqual">San Pasqual Band of Diegueno Mission Indians of California</option>
                                                         <option value="Santa Rosa of Cahuilla">Santa Rosa Band of Cahuilla Indians, California</option>
                                                         <option value="Santa Rosa">Santa Rosa Indian Community of the Santa Rosa Rancheria, California</option>
                                                         <option value="Santa Ynez">Santa Ynez Band of Chumash Mission Indians of the Santa Ynez Reservation, California</option>
                                                         <option value="Santee Sioux">Santee Sioux Nation, Nebraska</option>
                                                         <option value="Santo Domingo">Santo Domingo Pueblo</option>
                                                         <option value="Sauk-Suiattle">Sauk-Suiattle Indian Tribe</option>
                                                         <option value="Sault Ste. Marie">Sault Ste. Marie Tribe of Chippewa Indians, Michigan</option>
                                                         <option value="Scotts Valley">Scotts Valley Band of Pomo Indians of California</option>
                                                         <option value="Seldovia">Seldovia Village Tribe</option>
                                                         <option value="Seminole">Seminole Tribe of Florida</option>
                                                         <option value="Seneca">Seneca Nation of Indians</option>
                                                         <option value="Seneca-Cayuga Nation">Seneca-Cayuga Nation</option>
                                                         <option value="Shageluk">Shageluk Native Village</option>
                                                         <option value="Shakopee">Shakopee Mdewakanton Sioux Community of Minnesota</option>
                                                         <option value="Shawnee Tribe">Shawnee Tribe</option>
                                                         <option value="Sherwood Valley">Sherwood Valley Rancheria of Pomo Indians of California</option>
                                                         <option value="Shingle Springs">Shingle Springs Band of Miwok Indians, Shingle Springs Rancheria (Verona Tract), California</option>
                                                         <option value="Shinnecock">Shinnecock Indian Nation</option>
                                                         <option value="Shoalwater">Shoalwater Bay Indian Tribe of the Shoalwater Bay Indian Reservation</option>
                                                         <option value="Shoshone-Bannock">Shoshone-Bannock Tribes of the Fort Hall Reservation</option>
                                                         <option value="Shoshone-Paiute">Shoshone-Paiute Tribes of the Duck Valley Reservation, Nevada</option>
                                                         <option value="Sisseton-Wahpeton">Sisseton-Wahpeton Oyate of the Lake Traverse Reservation, South Dakota</option>
                                                         <option value="Sitka">Sitka Tribe of Alaska</option>
                                                         <option value="Skagway">Skagway Village</option>
                                                         <option value="Skokomish">Skokomish Indian Tribe</option>
                                                         <option value="Skull Valley">Skull Valley Band of Goshute Indians of Utah</option>
                                                         <option value="Snoqualmie">Snoqualmie Indian Tribe</option>
                                                         <option value="Soboba">Soboba Band of Luiseno Indians, California</option>
                                                         <option value="Sokaogon">Sokaogon Chippewa  Community, Wisconsin</option>
                                                         <option value="South Naknek">South Naknek Village</option>
                                                         <option value="Southern Ute">Southern Ute Indian Tribe of the Southern Ute Reservation, Colorado</option>
                                                         <option value="Spirit Lake">Spirit Lake Tribe, North Dakota</option>
                                                         <option value="Spokane">Spokane Tribe of the Spokane Reservation</option>
                                                         <option value="Squaxin">Squaxin Island Tribe of the Squaxin Island Reservation</option>
                                                         <option value="St. Croix">St. Croix Chippewa Indians of Wisconsin</option>
                                                         <option value="Standing Rock">Standing Rock Sioux Tribe of North &amp; South Dakota</option>
                                                         <option value="Stebbins">Stebbins Community Association</option>
                                                         <option value="Stillaguamish">Stillaguamish Tribe of Indians of Washington</option>
                                                         <option value="Stockbridge">Stockbridge Munsee Community, Wisconsin</option>
                                                         <option value="Summit Lake">Summit Lake Paiute Tribe of Nevada</option>
                                                         <option value="Sun'aq">Sun'aq Tribe of Kodiak</option>
                                                         <option value="Suquamish">Suquamish Indian Tribe of the Port Madison Reservation</option>
                                                         <option value="Susanville">Susanville Indian Rancheria, California</option>
                                                         <option value="Swinomish">Swinomish Indian Tribal Community</option>
                                                         <option value="Sycuan">Sycuan Band of the Kumeyaay Nation</option>
                                                         <option value="Table Mountain">Table Mountain Rancheria</option>
                                                         <option value="Takotna">Takotna Village</option>
                                                         <option value="Tangirnaq">Tangirnaq Native Village</option>
                                                         <option value="Tejon">Tejon Indian Tribe</option>
                                                         <option value="Telida">Telida Village</option>
                                                         <option value="Te-Moak">Te-Moak Tribe of Western Shoshone Indians of Nevada (Four constituent bands: Battle Mountain Band; Elko Band; South Fork Band and Wells Band)</option>
                                                         <option value="Chickasaw Nation">The Chickasaw Nation</option>
                                                         <option value="The Choctaw Nation of Oklahoma">The Choctaw Nation of Oklahoma</option>
                                                         <option value="The Muscogee (Creek) Nation">The Muscogee (Creek) Nation</option>
                                                         <option value="The Osage Nation">The Osage Nation</option>
                                                         <option value="The Seminole Nation  of Oklahoma">The Seminole Nation of Oklahoma</option>
                                                         <option value="Thlopthlocco Tribal Town">Thlopthlocco Tribal Town</option>
                                                         <option value="Three Affiliated">Three Affiliated Tribes of the Fort Berthold Reservation, North Dakota</option>
                                                         <option value="Timbi-sha Shoshone">Timbisha Shoshone Tribe</option>
                                                         <option value="Tohono O'odham">Tohono O'odham Nation of Arizona</option>
                                                         <option value="Tolowa Dee-ni'">Tolowa Dee-ni' Nation</option>
                                                         <option value="Tonawanda">Tonawanda Band of Seneca</option>
                                                         <option value="Tonkawa">Tonkawa Tribe of Indians of Oklahoma</option>
                                                         <option value="Tonto Apache">Tonto Apache Tribe of Arizona</option>
                                                         <option value="Torres Martinez">Torres Martinez Desert Cahuilla Indians, California</option>
                                                         <option value="Togiak">Traditional Village of Togiak</option>
                                                         <option value="Tulalip">Tulalip Tribes of Washington</option>
                                                         <option value="Tule River">Tule River Indian Tribe of the Tule River Reservation, California</option>
                                                         <option value="Tuluksak">Tuluksak Native Community</option>
                                                         <option value="Tunica-Biloxi">Tunica-Biloxi Indian Tribe</option>
                                                         <option value="Tuolumne">Tuolumne Band of Me-Wuk Indians of the Tuolumne Rancheria of California</option>
                                                         <option value="Turtle Mountain">Turtle Mountain Band of Chippewa Indians of North Dakota</option>
                                                         <option value="Tuscarora">Tuscarora Nation</option>
                                                         <option value="Twenty-Nine Palms">Twenty-Nine Palms Band of Mission Indians of California</option>
                                                         <option value="Twin Hills">Twin Hills Village</option>
                                                         <option value="Ugashik">Ugashik Village</option>
                                                         <option value="Umkumiut">Umkumiut Native Village</option>
                                                         <option value="United Auburn">United Auburn Indian Community of the Auburn Rancheria of California</option>
                                                         <option value="United Keetoowah Band of Cherokee Indians in Oklahoma">United Keetoowah Band of Cherokee Indians in Oklahoma</option>
                                                         <option value="Upper Mattaponi Tribe">Upper Mattaponi Tribe</option>
                                                         <option value="Upper Sioux">Upper Sioux Community, Minnesota</option>
                                                         <option value="Upper Skagit">Upper Skagit Indian Tribe</option>
                                                         <option value="Ute">Ute Indian Tribe of the Uintah &amp; Ouray Reservation, Utah</option>
                                                         <option value="Ute Mountain Ute">Ute Mountain Ute Tribe</option>
                                                         <option value="Benton">Utu Utu Gwaitu Paiute Tribe of the Benton Paiute Reservation, California</option>
                                                         <option value="Alakanuk">Village of Alakanuk</option>
                                                         <option value="Anaktuvuk Pass">Village of Anaktuvuk Pass</option>
                                                         <option value="Aniak">Village of Aniak</option>
                                                         <option value="Atmautluak">Village of Atmautluak</option>
                                                         <option value="Bill Moore's Slough">Village of Bill Moore's Slough</option>
                                                         <option value="Chefornak">Village of Chefornak</option>
                                                         <option value="Clark's Point">Village of Clarks Point</option>
                                                         <option value="Crooked Creek">Village of Crooked Creek</option>
                                                         <option value="Dot Lake">Village of Dot Lake</option>
                                                         <option value="Iliamna">Village of Iliamna</option>
                                                         <option value="Kalskag">Village of Kalskag</option>
                                                         <option value="Kaltag">Village of Kaltag</option>
                                                         <option value="Kotlik">Village of Kotlik</option>
                                                         <option value="Lower Kalskag">Village of Lower Kalskag</option>
                                                         <option value="Ohogamiut">Village of Ohogamiut</option>
                                                         <option value="Red Devil">Village of Red Devil</option>
                                                         <option value="Sleetmute">Village of Sleetmute</option>
                                                         <option value="Solomon">Village of Solomon</option>
                                                         <option value="Stony River">Village of Stony River</option>
                                                         <option value="Venetie">Village of Venetie (See Native Village of Venetie Tribal Government)</option>
                                                         <option value="Wainwright">Village of Wainwright</option>
                                                         <option value="Walker River">Walker River Paiute Tribe of the Walker River Reservation, Nevada</option>
                                                         <option value="Wampanoag">Wampanoag Tribe of Gay Head (Aquinnah)</option>
                                                         <option value="Washoe">Washoe Tribe of Nevada &amp; California (Carson Colony, Dresslerville Colony, Woodfords Community, Stewart Community, &amp; Washoe Ranches)</option>
                                                         <option value="White Mountain">White Mountain Apache Tribe of the Fort Apache Reservation, Arizona</option>
                                                         <option value="Wichita">Wichita and Affiliated Tribes (Wichita, Keechi, Waco &amp; Tawakonie), Oklahoma</option>
                                                         <option value="Wilton">Wilton Rancheria, California</option>
                                                         <option value="Winnebago">Winnebago Tribe of Nebraska</option>
                                                         <option value="Winnemucca">Winnemucca Indian Colony of Nevada</option>
                                                         <option value="Wiyot">Wiyot Tribe, California</option>
                                                         <option value="Wrangell">Wrangell Cooperative Association</option>
                                                         <option value="Wyandotte Nation">Wyandotte Nation</option>
                                                         <option value="Yakutat">Yakutat Tlingit Tribe</option>
                                                         <option value="Yankton">Yankton Sioux Tribe of South Dakota</option>
                                                         <option value="Yavapai-Apache">Yavapai-Apache Nation of the Camp Verde Indian Reservation, Arizona</option>
                                                         <option value="Yavapai-Prescott">Yavapai-Prescott Indian Tribe</option>
                                                         <option value="Yerington">Yerington Paiute Tribe of the Yerington Colony and Campbell Ranch, Nevada</option>
                                                         <option value="Yocha Dehe">Yocha Dehe Wintun Nation, California</option>
                                                         <option value="Yomba Shoshone">Yomba Shoshone Tribe of the Yomba Reservation, Nevada</option>
                                                         <option value="Ysleta Del Sur">Ysleta del Sur Pueblo</option>
                                                         <option value="Yuhaaviatam of San Manuel Nation">Yuhaaviatam of San Manuel Nation</option>
                                                         <option value="Andreafski">Yupiit of Andreafski</option>
                                                         <option value="Yurok">Yurok Tribe of the Yurok Reservation, California</option>
                                                         <option value="Pueblo of Zuni">Zuni Tribe of the Zuni Reservation, New Mexico</option>
                                                         <option value="Other">Other</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div id="otherTribeFirstRegistrationDiv" class="col-sm-6 mt-15 hidden" title="">
                                                   <label for="otherTribeFirstRegistration" class="main-label">g. Name of the other Tribe</label>
                                                   <div class="form-fields">
                                                      <input type="text" id="otherTribeFirstRegistration" name="otherTribeFirstRegistration" class="form-field">
                                                   </div>
                                                </div>
													                                                <div class="col-sm-6 mt-15" title="">
													                                                   <label class="main-label" for="dateOfIncorporation">Date of Incorporation</label>
                                                   <div class="form-fields">
													                                                      <div class="date-field">
                                                         <input type="date" id="dateOfIncorporation" name="dateOfIncorporation" value="" placeholder="06/20/2024" class="form-field"/>
                                                      </div>
                                                   </div>
                                                </div>
                                             </div>
                                             </div>
 </div>
  											  </div> 
                                   <!-- Jurisdiction of Formation or First Registration Accordian Item Close -->
											  
                                   <!-- Current US Business Address Accordian Item Open -->
<div class="accordion-item box-bg-sec">
   <div class="accordion-header row">
    <div class="dah-left col-md-8"><h2>Current US Business Address</h2></div>
     <div class="dah-right col-md-4">
      <span title=""><a class="hover-modal-btn" href="#boirNeedHelp5"><img src="/images/help-icon.svg" alt=""></a></span>
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="true" aria-controls="collapseFour"></button>
    </div>	
   </div>
   <div id="collapseFour" class="accordion-collapse collapse show">
    <div class="accordion-body">
     <div class="ab-top-para atp-with-list"><p>Enter the main U.S. address where your business operates. If you conduct business from your home, feel free to use your home address.</p></div>
     <ul class="ab-top-list">
      <li>The address should be a physical location accessible for direct contact by FinCEN representatives.</li>
      <li>You cannot use a P.O. box or your registered agent's address.</li>
      <li>Foreign companies registered in the U.S. but operating abroad must also provide their most relevant U.S. address.</li>
     </ul>
                                             <div class="row two-fields">
                                                <div class="col-md-6 mt-15" title="">
         <label class="main-label whsp" for="repaddress">Address (number, street, and apt. or suite no.)  <em>*</em></label>
                                                   <div class="form-fields">
                                                      <input type="text" id="repaddress" name="reportingAddress.address" value="" placeholder="Enter Address" class="form-field" />
                                                   </div>
                                                </div>
                                                <div class="col-md-6 mt-15" title="">
         <label class="main-label" for="repcity">City <em>*</em></label>
                                                   <div class="form-fields">
                                                      <input type="text" id="repcity" name="reportingAddress.city" value="" placeholder="Enter City name" class="form-field" />
                                                   </div>
                                                </div>
                                                <div class="col-md-4 mt-15" title="">
         <label class="main-label" for="repusterritory">U.S. or U.S. Territory <em>*</em></label>
                                                   <div class="form-fields">
                                                      <select class="form-field" id="repusterritory" name="reportingAddress.country">
                                                         <option value="">Select a country</option>
                                                         <option value="US">United States of America</option>
                                                         <option value="AS">American Samoa</option>
                                                         <option value="GU">Guam</option>
                                                         <option value="MH">Marshall Islands</option>
                                                         <option value="FM">Micronesia, Federated States</option>
                                                         <option value="MP">Northern Mariana Islands</option>
                                                         <option value="PW">Palau</option>
                                                         <option value="PR">Puerto Rico</option>
                                                         <option value="VI">U.S. Virgin Islands</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div class="col-md-4 mt-15" title="">
         <label class="main-label" for="repstate">State <em id="repStateStar">*</em></label>
                                                   <div class="form-fields">
                                                      <select class="form-field" id="repstate" name="reportingAddress.state">
                                                         <option value="">Select a state</option>
                                                         <option value="AL">Alabama</option>
                                                         <option value="AK">Alaska</option>
                                                         <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
                                                         <option value="AA">Armed Forces Americas (except Canada)</option>
                                                         <option value="AP">Armed Forces Pacific</option>
                                                         <option value="AZ">Arizona</option>
                                                         <option value="AR">Arkansas</option>
                                                         <option value="CA">California</option>
                                                         <option value="CO">Colorado</option>
                                                         <option value="CT">Connecticut</option>
                                                         <option value="DE">Delaware</option>
                                                         <option value="DC">District of Columbia</option>
                                                         <option value="FL">Florida</option>
                                                         <option value="GA">Georgia</option>
                                                         <option value="HI">Hawaii</option>
                                                         <option value="ID">Idaho</option>
                                                         <option value="IL">Illinois</option>
                                                         <option value="IN">Indiana</option>
                                                         <option value="IA">Iowa</option>
                                                         <option value="KS">Kansas</option>
                                                         <option value="KY">Kentucky</option>
                                                         <option value="LA">Louisiana</option>
                                                         <option value="ME">Maine</option>
                                                         <option value="MD">Maryland</option>
                                                         <option value="MA">Massachusetts</option>
                                                         <option value="MI">Michigan</option>
                                                         <option value="MN">Minnesota</option>
                                                         <option value="MS">Mississippi</option>
                                                         <option value="MO">Missouri</option>
                                                         <option value="MT">Montana</option>
                                                         <option value="NE">Nebraska</option>
                                                         <option value="NV">Nevada</option>
                                                         <option value="NH">New Hampshire</option>
                                                         <option value="NJ">New Jersey</option>
                                                         <option value="NM">New Mexico</option>
                                                         <option value="NY">New York</option>
                                                         <option value="NC">North Carolina</option>
                                                         <option value="ND">North Dakota</option>
                                                         <option value="OH">Ohio</option>
                                                         <option value="OK">Oklahoma</option>
                                                         <option value="OR">Oregon</option>
                                                         <option value="PA">Pennsylvania</option>
                                                         <option value="RI">Rhode Island</option>
                                                         <option value="SC">South Carolina</option>
                                                         <option value="SD">South Dakota</option>
                                                         <option value="TN">Tennessee</option>
                                                         <option value="TX">Texas</option>
                                                         <option value="UT">Utah</option>
                                                         <option value="VT">Vermont</option>
                                                         <option value="VA">Virginia</option>
                                                         <option value="WA">Washington</option>
                                                         <option value="WV">West Virginia</option>
                                                         <option value="WI">Wisconsin</option>
                                                         <option value="WY">Wyoming</option>
                                                      </select>
                                                   </div>
                                                </div>
                                                <div class="col-md-4 mt-15" title="">
         <label class="main-label" for="repzipcode">Zip Code <em>*</em></label>
                                                   <div class="form-fields">
                                                      <input type="text" id="repzipcode" name="reportingAddress.postalCode" value="" placeholder="Enter Zip Code" class="form-field" />
                                                   </div>
                                                </div>
                                             </div>
                                          </div>
   </div>
  </div>
  <!-- Current US Business Address Accordian Item Close -->
														
											 </div>
											 <!-- Reporting Company Accordian Close -->
                                          </div>
										  <p class="text-danger" id="formRepoErrorText" style="display:none">Please complete all mandatory fields before submitting. These fields are essential to process your request accurately.</p>
                                          <div class="sf-form-footer">
                                             <div class="row">
                                                <aside class="col-sm-4 col-6 sf-foot-left">
                                                   <button id="prev1" class="brdr-btn">
                                                      Previous
                                                      <div class="spinner"></div>
                                                   </button>
                                                </aside>
                                                <aside class="col-sm-8 col-6 sf-foot-right">
                                                   <div class="sf-btns">
                                                      <button class="bg-btn loading-button" id="next2" type="submit" value="submit">
                                                         <span class="btn-text">Save & Proceed</span>
                                                         <div class="spinner"></div>
                                                      </button>
                                                   </div>
                                                </aside>
                                             </div>
                                          </div>
                                       </div>
                                    </form>
                                    <div class="sf-btm-bar">
                                       <p><a class="hover-modal-btn" href="#boirNeedHelp20"><img src="images/Bell.png" alt="" /> PRIVACY ACT AND PAPERWORK REDUCTION ACT NOTICE</a></p>
                                    </div>
                                 </aside>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </section>
            </div>
            <!--Step3-->
            <div class="step" id="step3">
               <section class="page-cont">
                  <div class="mid-content">
                     <div class="container">
                        <div class="cust-cf">
                           <!--<div class="notify-bar">
                              <p><img src="images/Bell.png"> Notification: Site Maintenance: BOI E-Filing System site will be unavailable for scheduled maintenance on June 21st, from 6:00 AM - 8:00 AM EST.</p>
                              </div>-->
                           <div class="breadcrumb-bar">
                              <div class="row">
                                 <aside class="col-sm-6 col-8 bb-left">
                                    <a href="#">BOI E-Filing</a>
                                    <a href="#">File BOIR</a>
                                 </aside>
                                 <aside class="col-sm-6 col-4 bb-right">
                                    <a href="#"><img src="images/help.png" alt=""> Help</a>
                                 </aside>
                              </div>
                           </div>
                        </div>
                        <h2>Beneficial Ownership Information Report (BOIR)</h2>
                        <p>Complete the report in its entirety with all required information. Fields marked with an asterisk (*) symbol are the fields that, at a minimum, must be completed by all companies to file the report. Reporting companies, however, must
                           include all information 31 CFR 1010.380(b) requires them to provide, regardless of whether a field is marked with an asterisk (*) symbol. These information requirements are summarized above under HELP.
                        </p>
                        <div class="step-form-main">
                           <div class="sf-top">
                               <h2> Step 3 of 7</h2>
                           </div>
						   <div class="sf-form-top" style="margin-bottom: 30px;">
						   		<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress3" style="width:33.33%; background-color:#B31942;">
						   					<span class="progress-percentage" id="progress-percentage3">33%</span>
						   				</div>
						   			</div>
						   		</div>
						   	</div>
                           <div class="sf-main">
                              <div class="row">
                                 <aside class="col-lg-3 sf-main-left">
                                    <ul>
                                       <li><a>Filing Information <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Reporting Company <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li class="active"><a>Company Applicant(s)</a></li>
                                       <li><a>Beneficial Owner(s)</a></li>
                                       <li><a>General Information</a></li>
                                       <li><a>Submitter Information</a></li>
                                       <li><a>Acknowledgement</a></li>
                                    </ul>
                                 </aside>
                                 <aside class="col-lg-9 sf-main-right">
                                    <!-- <h2>Part II. Company Applicant(s) Information</h2> -->
                                    <div class="need-help-head nhh-top-align row">
                                      <aside class="nh-left col-md-10">
                                       <h2>Company Applicant Details</h2>
                                       <p>If your company was formed in 2024 or later, please provide information for up to two company applicants. Company applicants are the individuals who filed or were primarily responsible for submitting your company's formation or registration documents.</p>
                                      </aside>
                                      <aside class="nh-right col-md-2">
                                       <span><a class="hover-modal-btn" href="#boirNeedHelp17"><img src="/images/help-icon.svg" alt=""></a></span>
                                      </aside>
                                    </div>
                                    <form action="#" id="CompanyAppinfo" method="get">
                                       <div class="sf-sub-head">
                                          <!-- <h3>Form of identification and issuing jurisdiction</h3> -->
                                       </div>
<div class="sf-form-sec">
                                          
                                          <div class="sf-form-body">
                                             <div class="row two-fields box-bg-sec radio-que-sec">
                                                <div class="col-md-8 rq-left">
                                                 <label class="main-label" for="existingRepoCompany">When was your company officially formed or registered in the US?</label>  
                                                 <div class="form-fields no-padding">
                                                   <div class="row">
                                                      <label class="col-sm-6">
                                                      <input type="radio" id="existyes" name="existingRepoCompany" value="true" /> Before 2024</label>
                                                      <label class="col-sm-6">
                                                      <input type="radio" id="existno" name="existingRepoCompany" value="false" checked/> On or after 01/01/2024</label>
                                                   </div>
                                                  </div>
                                                </div>
                                                <div class="col-md-4 rq-right">
                                                 <span title="">
<!--													<a class="hover-modal-btn" href="#boirNeedHelp6"><img src="/images/help-icon.svg" alt=""></a>-->
													</span>  
                                                </div>
                                              </div>
                                              <div class="radio-que-sec-para" style="display:none;"><p>Your company DOES NOT need to report a Company Applicant.<br/>Please proceed to the next step.</p></div>
                                             <!--
                                             <div class="form-rows">
                                                <div class="two-fields">
                                                   <div class="two-fields" title="">
                                                      <div class="mb-15">
                                                         <label class="main-label" for="existingRepoCompany">16. Existing reporting company (check if existing reporting company as of January 1, 2024)</label>
                                                         <div class="form-fields">
                                                            <div class="row">
                                                               <label class="col-sm-6">
                                                               <input type="radio" id="existyes" name="existingRepoCompany" value="true" /> Yes</label>
                                                               <label class="col-sm-6">
                                                               <input type="radio" id="existno" name="existingRepoCompany" value="false"checked /> No</label>
                                                            </div>
                                                         </div>
                                                      </div>
                                                      <div class="main-label">
                                                         <lable>Part II. Company Applicant Information <span> (This item is reserved for future use)</span></lable>
                                                         <div class="sf-btn-bar">
                                                            <button class="bg-btn" id="addcom">Add Company applicant</button>
                                                         </div>
                                                      </div>
                                                   </div>
                                                </div>
                                             </div>
                                             -->
                                             
                                             <!-- <div class="sf-form-top sf-form-top-in" title="Company applicant information is entered in fields 17 through 35 of the BOIR. Company applicants are individuals; no companies or legal entities may be reported as company applicants. Reporting companies may also provide FinCEN Identifiers for company applicants instead of this information. See detailed description below.
  Use the “Add Company Applicant” or “Remove Company Applicant” keys at the top of this section to add or remove additional company applicants. No more than two company applicants should be reported.
  If existing reporting company was checked in item 16, company applicant information is not required; proceed to Part III.">
  <h3><img src="images/help.png"> Need Help?</h3>
 </div> -->
                                             <div class="add-btn-sec"><button class="bg-btn" id="addcom">Add Company applicant</button></div>
                                             <div class="accordion step-acc-sec" id="accordionExample">
                                                <div class="accordion-item">
                                                   <h2 class="accordion-header no-margin">
                                                      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse0" aria-expanded="true" aria-controls="collapse0">Company Applicant</button>
                                                   </h2>
                                                   <div class="sf-btn-bar no-margin"><button type="button" class="remove-applicant bg-btn no-margin" data-applicant="${applicantCounter}" style="display: none;">Remove Applicant</button></div>
                                                   <div id="collapse0" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
                                                      <div class="accordion-body">
                                                         <!-- Company applicant Start -->
                                                         <div class="accordion def-acc-sec">
  
                                                            <!-- Company applicant FinCEN ID Start -->
                                                            <div class="accordion-item box-bg-sec">
                                                              <div class="accordion-header row">
                                                               <div class="dah-left col-md-8"><h2>Company applicant FinCEN ID</h2></div>
                                                               <div class="dah-right col-md-4">
                                                                <span title=""><a class="hover-modal-btn" href="#boirNeedHelp7"><img src="/images/help-icon.svg" alt=""></a></span>
                                                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCAone" aria-expanded="true" aria-controls="collapseCAone"></button>
                                                         </div>
 </div>
                                                              <div id="collapseCAone" class="accordion-collapse collapse show">
                                                                <div class="accordion-body">
                                                                 <div class="ab-top-para"><p>If the company applicant has a FinCEN ID, please enter it below to skip the remaining fields.</p>
                                                         <div class="col-sm-6 mt-15" title="">
                                                            <div class="form-fields">
                                                               <input type="text" data-index="0" id="companyApplicantInfo[0].finCenId" name="companyApplicantInfo[0].finCenId" value="" placeholder="Enter FinCEN ID" class="comfincin-id form-field" />
                                                            </div>
                                                         </div>
                                                                </div>
                                                              </div>
                                                            </div>
                                                          </div>
                                                          <!-- Company applicant FinCEN ID End -->
                                                          
                                                          </div>
                                                         <!-- Company applicant End -->
                                                         
                                                         <!-- Company applicant FinCEN ID Based Form Start -->
                                                         <div id="existrepotcom">
   <div class="accordion def-acc-sec">
   
      <!-- Form of identification and issuing jurisdiction Start -->
      <div class="accordion-item box-bg-sec">
        <div class="accordion-header row">
         <div class="dah-left col-md-8"><h2>Form of identification and issuing jurisdiction</h2></div>
         <div class="dah-right col-md-4">
          <span title=""><a class="hover-modal-btn" href="#boirNeedHelp8"><img src="/images/help-icon.svg" alt=""></a></span>
          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCATwo" aria-expanded="true" aria-controls="collapseCATwo"></button>
</div>
        </div>
        <div id="collapseCATwo" class="accordion-collapse collapse show">
          <div class="accordion-body">
           <div class="ab-top-para"><p>Please provide the company applicant's identification details and the jurisdiction that issued it. For a faster experience, you can use DocAI to quickly fill out your details by uploading your ID document.</p>
           
   
            <div class="row two-fields">
                                                            <div class="col-sm-6 mt-15" title="">
                                                               <label class="main-label" for="companyApplicantInfo[0].identificationDocuments.documentType">Identifying document type <em>*</em></label>
                                                               <div class="form-fields">
                                                                  <select class="com-idt form-field" id="companyApplicantInfo[0].identificationDocuments.documentType" name="companyApplicantInfo[0].identificationDocuments.documentType">
                                                                     <option value="">Select an ID type</option>
                                                                     <option value="37">State issued driver's license</option>
                                                                     <option value="38">State/local/tribe-issued ID</option>
                                                                     <option value="39">U.S. passport</option>
                                                                     <option value="40">Foreign passport</option>
                                                                  </select>
                                                               </div>
                                                            </div>
                                          <div class="col-sm-6 mt-15">
                                             <div class="fileinput">
                                                <label class="main-label" for="companyApplicantInfo[0].identificationDocuments.document">Identifying document image <em>*</em></label>
                                                <input type="file"  class="com-idi com-file-input fileInput"  id="companyApplicantInfo[0].identificationDocuments.document" name="companyApplicantInfo[0].identificationDocuments.document"/>
                                                <input type="hidden"  id="companyApplicantInfo[0].identificationDocuments.documentPath" name="companyApplicantInfo[0].identificationDocuments.documentPath"/>
                                                <input type="hidden"  id="companyApplicantInfo[0].identificationDocuments.documentName" name="companyApplicantInfo[0].identificationDocuments.documentName"/>
															   <span id="file-name-display" class="file-name-display comFileNameDisplay0" style="display:none;"></span>
        														<button class="blue-btn btn btn-four" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px; " type="button" id="edit-button">Edit</button>
                                             </div>
															   <div id="progressWrapper" style="display:none;">
														
															                 <progress id="progressBar" value="0" max="100"></progress>
															                 <span id="progressText">0%</span>
																		

															        </div>
																	<!-- File size too small modal -->
																	<div class="filelengthmodal modal fade" id="fileSizeTooLargeModal[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
																	   <div class="modal-dialog modal-fullscreen modal-dialog-centered">
																	      <div class="container">
																	         <div class="user-data-form step-form-modal modal-content">
																	            <div class="modal-cont">
																	               <h2>Oops! File Too Large</h2>
																	               <p>It looks like your file is too big. Please upload a file that's 4MB or less.</p>
																	               <div class="modal-btns step-mod-btns">
																	                  <button type="button" class="blue-btn" data-bs-dismiss="modal" id="fileSizeTooSmallOk">Okay</button>
																	               </div>
																	            </div>
																	         </div>
																	      </div>
																	   </div>
																	</div>
                                                </div>
																</div>
                                                            <!--</div>-->
                                                            <div class="row two-fields">
                                                               <div class="col-sm-6 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].identificationDocuments.documentNumber">Identifying document number <em>*</em></label>
                                                                  <div class="form-fields">
                                                                     <input type="text" id="companyApplicantInfo[0].identificationDocuments.documentNumber" name="companyApplicantInfo[0].identificationDocuments.documentNumber" value="" placeholder="Enter Identification number" class="com-idn form-field" />
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-6 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].identificationDocuments.issuerCountry">Country/Jurisdiction <em>*</em></label>
                                                                  <div class="form-fields">
                                                                     <select class="com-counjuri form-field" id="companyApplicantInfo[0].identificationDocuments.issuerCountry" name="companyApplicantInfo[0].identificationDocuments.issuerCountry">
                                                                        <option value="">Select a country/jurisdiction</option>
                                                                        <option value="US">United States of America</option>
                                                                        <option value="AS">American Samoa</option>
                                                                        <option value="GU">Guam</option>
                                                                        <option value="MH">Marshall Islands</option>
                                                                        <option value="FM">Micronesia, Federated States</option>
                                                                        <option value="MP">Northern Mariana Islands</option>
                                                                        <option value="PW">Palau</option>
                                                                        <option value="PR">Puerto Rico</option>
                                                                        <option value="VI">U.S. Virgin Islands</option>
                                                                        <option value="AF">Afghanistan</option>
                                                                        <option value="AX">Åland Islands</option>
                                                                        <option value="AL">Albania</option>
                                                                        <option value="DZ">Algeria</option>
                                                                        <option value="AD">Andorra</option>
                                                                        <option value="AO">Angola</option>
                                                                        <option value="AI">Anguilla</option>
                                                                        <option value="AQ">Antarctica</option>
                                                                        <option value="AG">Antigua And Barbuda</option>
                                                                        <option value="AR">Argentina</option>
                                                                        <option value="AM">Armenia</option>
                                                                        <option value="AW">Aruba</option>
                                                                        <option value="AU">Australia</option>
                                                                        <option value="AT">Austria</option>
                                                                        <option value="AZ">Azerbaijan</option>
                                                                        <option value="BS">Bahamas</option>
                                                                        <option value="BH">Bahrain</option>
                                                                        <option value="BD">Bangladesh</option>
                                                                        <option value="BB">Barbados</option>
                                                                        <option value="BY">Belarus</option>
                                                                        <option value="BE">Belgium</option>
                                                                        <option value="BZ">Belize</option>
                                                                        <option value="BJ">Benin</option>
                                                                        <option value="BM">Bermuda</option>
                                                                        <option value="BT">Bhutan</option>
                                                                        <option value="BO">Bolivia, Plurinational State Of</option>
                                                                        <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
                                                                        <option value="BA">Bosnia And Herzegovina</option>
                                                                        <option value="BW">Botswana</option>
                                                                        <option value="BV">Bouvet Island</option>
                                                                        <option value="BR">Brazil</option>
                                                                        <option value="IO">British Indian Ocean Territory</option>
                                                                        <option value="BN">Brunei Darussalam</option>
                                                                        <option value="BG">Bulgaria</option>
                                                                        <option value="BF">Burkina Faso</option>
                                                                        <option value="BI">Burundi</option>
                                                                        <option value="KH">Cambodia</option>
                                                                        <option value="CM">Cameroon</option>
                                                                        <option value="CA">Canada</option>
                                                                        <option value="CV">Cape Verde</option>
                                                                        <option value="KY">Cayman Islands</option>
                                                                        <option value="CF">Central African Republic</option>
                                                                        <option value="TD">Chad</option>
                                                                        <option value="CL">Chile</option>
                                                                        <option value="CN">China</option>
                                                                        <option value="CX">Christmas Island</option>
                                                                        <option value="CC">Cocos (Keeling) Islands</option>
                                                                        <option value="CO">Colombia</option>
                                                                        <option value="KM">Comoros</option>
                                                                        <option value="CG">Congo</option>
                                                                        <option value="CD">Congo, The Democratic Republic Of The</option>
                                                                        <option value="CK">Cook Islands</option>
                                                                        <option value="CR">Costa Rica</option>
                                                                        <option value="CI">Côte D'ivoire</option>
                                                                        <option value="HR">Croatia</option>
                                                                        <option value="CU">Cuba</option>
                                                                        <option value="CW">Curaçao</option>
                                                                        <option value="CY">Cyprus</option>
                                                                        <option value="CZ">Czech Republic</option>
                                                                        <option value="DK">Denmark</option>
                                                                        <option value="DJ">Djibouti</option>
                                                                        <option value="DM">Dominica</option>
                                                                        <option value="DO">Dominican Republic</option>
                                                                        <option value="EC">Ecuador</option>
                                                                        <option value="EG">Egypt</option>
                                                                        <option value="SV">El Salvador</option>
                                                                        <option value="GQ">Equatorial Guinea</option>
                                                                        <option value="ER">Eritrea</option>
                                                                        <option value="EE">Estonia</option>
                                                                        <option value="ET">Ethiopia</option>
                                                                        <option value="FK">Falkland Islands (Malvinas)</option>
                                                                        <option value="FO">Faroe Islands</option>
                                                                        <option value="FJ">Fiji</option>
                                                                        <option value="FI">Finland</option>
                                                                        <option value="FR">France</option>
                                                                        <option value="GF">French Guiana</option>
                                                                        <option value="PF">French Polynesia</option>
                                                                        <option value="TF">French Southern Territories</option>
                                                                        <option value="GA">Gabon</option>
                                                                        <option value="GM">Gambia</option>
                                                                        <option value="GE">Georgia</option>
                                                                        <option value="DE">Germany</option>
                                                                        <option value="GH">Ghana</option>
                                                                        <option value="GI">Gibraltar</option>
                                                                        <option value="GR">Greece</option>
                                                                        <option value="GL">Greenland</option>
                                                                        <option value="GD">Grenada</option>
                                                                        <option value="GP">Guadeloupe</option>
                                                                        <option value="GT">Guatemala</option>
                                                                        <option value="GG">Guernsey</option>
                                                                        <option value="GN">Guinea</option>
                                                                        <option value="GW">Guinea-bissau</option>
                                                                        <option value="GY">Guyana</option>
                                                                        <option value="HT">Haiti</option>
                                                                        <option value="HM">Heard Island And Mcdonald Islands</option>
                                                                        <option value="VA">Holy See (Vatican City State)</option>
                                                                        <option value="HN">Honduras</option>
                                                                        <option value="HK">Hong Kong</option>
                                                                        <option value="HU">Hungary</option>
                                                                        <option value="IS">Iceland</option>
                                                                        <option value="IN">India</option>
                                                                        <option value="ID">Indonesia</option>
                                                                        <option value="IR">Iran, Islamic Republic Of</option>
                                                                        <option value="IQ">Iraq</option>
                                                                        <option value="IE">Ireland</option>
                                                                        <option value="IM">Isle Of Man</option>
                                                                        <option value="IL">Israel</option>
                                                                        <option value="IT">Italy</option>
                                                                        <option value="JM">Jamaica</option>
                                                                        <option value="JP">Japan</option>
                                                                        <option value="JE">Jersey</option>
                                                                        <option value="JO">Jordan</option>
                                                                        <option value="KZ">Kazakhstan</option>
                                                                        <option value="KE">Kenya</option>
                                                                        <option value="KI">Kiribati</option>
                                                                        <option value="KP">Korea, Democratic People's Republic Of</option>
                                                                        <option value="KR">Korea, Republic Of</option>
                                                                        <option value="KW">Kuwait</option>
                                                                        <option value="KG">Kyrgyzstan</option>
                                                                        <option value="LA">Lao People's Democratic Republic</option>
                                                                        <option value="LV">Latvia</option>
                                                                        <option value="LB">Lebanon</option>
                                                                        <option value="LS">Lesotho</option>
                                                                        <option value="LR">Liberia</option>
                                                                        <option value="LY">Libya</option>
                                                                        <option value="LI">Liechtenstein</option>
                                                                        <option value="LT">Lithuania</option>
                                                                        <option value="LU">Luxembourg</option>
                                                                        <option value="MO">Macao</option>
                                                                        <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
                                                                        <option value="MG">Madagascar</option>
                                                                        <option value="MW">Malawi</option>
                                                                        <option value="MY">Malaysia</option>
                                                                        <option value="MV">Maldives</option>
                                                                        <option value="ML">Mali</option>
                                                                        <option value="MT">Malta</option>
                                                                        <option value="MQ">Martinique</option>
                                                                        <option value="MR">Mauritania</option>
                                                                        <option value="MU">Mauritius</option>
                                                                        <option value="YT">Mayotte</option>
                                                                        <option value="MX">Mexico</option>
                                                                        <option value="MD">Moldova, Republic Of</option>
                                                                        <option value="MC">Monaco</option>
                                                                        <option value="MN">Mongolia</option>
                                                                        <option value="ME">Montenegro</option>
                                                                        <option value="MS">Montserrat</option>
                                                                        <option value="MA">Morocco</option>
                                                                        <option value="MZ">Mozambique</option>
                                                                        <option value="MM">Myanmar</option>
                                                                        <option value="NA">Namibia</option>
                                                                        <option value="NR">Nauru</option>
                                                                        <option value="NP">Nepal</option>
                                                                        <option value="NL">Netherlands</option>
                                                                        <option value="NC">New Caledonia</option>
                                                                        <option value="NZ">New Zealand</option>
                                                                        <option value="NI">Nicaragua</option>
                                                                        <option value="NE">Niger</option>
                                                                        <option value="NG">Nigeria</option>
                                                                        <option value="NU">Niue</option>
                                                                        <option value="NF">Norfolk Island</option>
                                                                        <option value="NO">Norway</option>
                                                                        <option value="OM">Oman</option>
                                                                        <option value="PK">Pakistan</option>
                                                                        <option value="PS">Palestinian Territory, Occupied</option>
                                                                        <option value="PA">Panama</option>
                                                                        <option value="PG">Papua New Guinea</option>
                                                                        <option value="PY">Paraguay</option>
                                                                        <option value="PE">Peru</option>
                                                                        <option value="PH">Philippines</option>
                                                                        <option value="PN">Pitcairn</option>
                                                                        <option value="PL">Poland</option>
                                                                        <option value="PT">Portugal</option>
                                                                        <option value="QA">Qatar</option>
                                                                        <option value="RE">Réunion</option>
                                                                        <option value="RO">Romania</option>
                                                                        <option value="RU">Russian Federation</option>
                                                                        <option value="RW">Rwanda</option>
                                                                        <option value="BL">Saint Barthélemy</option>
                                                                        <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
                                                                        <option value="KN">Saint Kitts And Nevis</option>
                                                                        <option value="LC">Saint Lucia</option>
                                                                        <option value="MF">Saint Martin (french Part)</option>
                                                                        <option value="PM">Saint Pierre And Miquelon</option>
                                                                        <option value="VC">Saint Vincent And The Grenadines</option>
                                                                        <option value="WS">Samoa</option>
                                                                        <option value="SM">San Marino</option>
                                                                        <option value="ST">Sao Tome And Principe</option>
                                                                        <option value="SA">Saudi Arabia</option>
                                                                        <option value="SN">Senegal</option>
                                                                        <option value="RS">Serbia</option>
                                                                        <option value="SC">Seychelles</option>
                                                                        <option value="SL">Sierra Leone</option>
                                                                        <option value="SG">Singapore</option>
                                                                        <option value="SX">Sint Maarten (dutch Part)</option>
                                                                        <option value="SK">Slovakia</option>
                                                                        <option value="SI">Slovenia</option>
                                                                        <option value="SB">Solomon Islands</option>
                                                                        <option value="SO">Somalia</option>
                                                                        <option value="ZA">South Africa</option>
                                                                        <option value="GS">South Georgia And The South Sandwich Islands</option>
                                                                        <option value="SS">South Sudan</option>
                                                                        <option value="ES">Spain</option>
                                                                        <option value="LK">Sri Lanka</option>
                                                                        <option value="SD">Sudan</option>
                                                                        <option value="SR">Suriname</option>
                                                                        <option value="SJ">Svalbard And Jan Mayen</option>
                                                                        <option value="SZ">Swaziland</option>
                                                                        <option value="SE">Sweden</option>
                                                                        <option value="CH">Switzerland</option>
                                                                        <option value="SY">Syrian Arab Republic</option>
                                                                        <option value="TW">Taiwan</option>
                                                                        <option value="TJ">Tajikistan</option>
                                                                        <option value="TZ">Tanzania, United Republic Of</option>
                                                                        <option value="TH">Thailand</option>
                                                                        <option value="TL">Timor-leste</option>
                                                                        <option value="TG">Togo</option>
                                                                        <option value="TK">Tokelau</option>
                                                                        <option value="TO">Tonga</option>
                                                                        <option value="TT">Trinidad And Tobago</option>
                                                                        <option value="TN">Tunisia</option>
                                                                        <option value="TR">Turkey</option>
                                                                        <option value="TM">Turkmenistan</option>
                                                                        <option value="TC">Turks And Caicos Islands</option>
                                                                        <option value="TV">Tuvalu</option>
                                                                        <option value="UG">Uganda</option>
                                                                        <option value="UA">Ukraine</option>
                                                                        <option value="AE">United Arab Emirates</option>
                                                                        <option value="GB">United Kingdom</option>
                                                                        <option value="UY">Uruguay</option>
                                                                        <option value="UZ">Uzbekistan</option>
                                                                        <option value="VU">Vanuatu</option>
                                                                        <option value="VE">Venezuela, Bolivarian Republic Of</option>
                                                                        <option value="VN">Viet Nam</option>
                                                                        <option value="VG">Virgin Islands, British</option>
                                                                        <option value="WF">Wallis And Futuna</option>
                                                                        <option value="EH">Western Sahara</option>
                                                                        <option value="YE">Yemen</option>
                                                                        <option value="ZM">Zambia</option>
                                                                        <option value="ZW">Zimbabwe</option>
                                                                     </select>
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-6 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].identificationDocuments.issuerState">State </label>
                                                                  <div class="form-fields">
                                                                     <select class="com-state form-field" id="companyApplicantInfo[0].identificationDocuments.issuerState" name="companyApplicantInfo[0].identificationDocuments.issuerState">
                                                                        <option value="">Select a state</option>
                                                                        <option value="AL">Alabama</option>
                                                                        <option value="AK">Alaska</option>
                                                                        <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
                                                                        <option value="AA">Armed Forces Americas (except Canada)</option>
                                                                        <option value="AP">Armed Forces Pacific</option>
                                                                        <option value="AZ">Arizona</option>
                                                                        <option value="AR">Arkansas</option>
                                                                        <option value="CA">California</option>
                                                                        <option value="CO">Colorado</option>
                                                                        <option value="CT">Connecticut</option>
                                                                        <option value="DE">Delaware</option>
                                                                        <option value="DC">District of Columbia</option>
                                                                        <option value="FL">Florida</option>
                                                                        <option value="GA">Georgia</option>
                                                                        <option value="HI">Hawaii</option>
                                                                        <option value="ID">Idaho</option>
                                                                        <option value="IL">Illinois</option>
                                                                        <option value="IN">Indiana</option>
                                                                        <option value="IA">Iowa</option>
                                                                        <option value="KS">Kansas</option>
                                                                        <option value="KY">Kentucky</option>
                                                                        <option value="LA">Louisiana</option>
                                                                        <option value="ME">Maine</option>
                                                                        <option value="MD">Maryland</option>
                                                                        <option value="MA">Massachusetts</option>
                                                                        <option value="MI">Michigan</option>
                                                                        <option value="MN">Minnesota</option>
                                                                        <option value="MS">Mississippi</option>
                                                                        <option value="MO">Missouri</option>
                                                                        <option value="MT">Montana</option>
                                                                        <option value="NE">Nebraska</option>
                                                                        <option value="NV">Nevada</option>
                                                                        <option value="NH">New Hampshire</option>
                                                                        <option value="NJ">New Jersey</option>
                                                                        <option value="NM">New Mexico</option>
                                                                        <option value="NY">New York</option>
                                                                        <option value="NC">North Carolina</option>
                                                                        <option value="ND">North Dakota</option>
                                                                        <option value="OH">Ohio</option>
                                                                        <option value="OK">Oklahoma</option>
                                                                        <option value="OR">Oregon</option>
                                                                        <option value="PA">Pennsylvania</option>
                                                                        <option value="RI">Rhode Island</option>
                                                                        <option value="SC">South Carolina</option>
                                                                        <option value="SD">South Dakota</option>
                                                                        <option value="TN">Tennessee</option>
                                                                        <option value="TX">Texas</option>
                                                                        <option value="UT">Utah</option>
                                                                        <option value="VT">Vermont</option>
                                                                        <option value="VA">Virginia</option>
                                                                        <option value="WA">Washington</option>
                                                                        <option value="WV">West Virginia</option>
                                                                        <option value="WI">Wisconsin</option>
                                                                        <option value="WY">Wyoming</option>
                                                                     </select>
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-6 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].identificationDocuments.issuerLocalOrTribal">Local/Tribal </label>
                                                                  <div class="form-fields">
                                                                     <select class="com-localtrib form-field" id="companyApplicantInfo[0].identificationDocuments.issuerLocalOrTribal" name="companyApplicantInfo[0].identificationDocuments.issuerLocalOrTribal" disabled>
                                                                        <option value="">Select a local/tribal</option>
                                                                        <option value="Absentee-Shawnee">Absentee-Shawnee Tribe of Indians of Oklahoma</option>
                                                                        <option value="Agdaagux">Agdaagux Tribe of King Cove</option>
                                                                        <option value="Agua Caliente">Agua Caliente Band of Cahuilla Indians of the Agua Caliente Indian Reservation, California</option>
                                                                        <option value="Ak Chin">Ak-Chin Indian Community</option>
                                                                        <option value="Akiachak">Akiachak Native Community</option>
                                                                        <option value="Akiak">Akiak Native Community</option>
                                                                        <option value="Alabama-Coushatta">Alabama-Coushatta Tribe of Texas</option>
                                                                        <option value="Alabama-Quassarte Tribal Town">Alabama-Quassarte Tribal Town</option>
                                                                        <option value="Alatna">Alatna Village</option>
                                                                        <option value="Algaaciq">Algaaciq Native Village (St. Mary's)</option>
                                                                        <option value="Allakaket">Allakaket Village</option>
                                                                        <option value="Alturas">Alturas Indian Rancheria, California</option>
                                                                        <option value="Alutiiq Tribe of Old Harbor">Alutiiq Tribe of Old Harbor</option>
                                                                        <option value="Angoon">Angoon Community Association</option>
                                                                        <option value="Anvik">Anvik Village</option>
                                                                        <option value="Apache">Apache Tribe of Oklahoma</option>
                                                                        <option value="Arctic Village">Arctic Village (See Native Village of Venetie Tribal Government)</option>
                                                                        <option value="Asa'carsarmiut">Asa'carsarmiut Tribe</option>
                                                                        <option value="Assiniboine and Sioux">Assiniboine &amp; Sioux Tribes of the Fort Peck Indian Reservation, Montana</option>
                                                                        <option value="Augustine">Augustine Band of Cahuilla Indians, California</option>
                                                                        <option value="Bad River Band">Bad River Band of the Lake Superior Tribe of Chippewa Indians of the Bad River Reservation, Wisconsin</option>
                                                                        <option value="Bay Mills">Bay Mills Indian Community, Michigan</option>
                                                                        <option value="Bear River">Bear River Band of the Rohnerville Rancheria, California</option>
                                                                        <option value="Beaver">Beaver Village</option>
                                                                        <option value="Berry Creek">Berry Creek Rancheria of Maidu Indians of California</option>
                                                                        <option value="Big Lagoon">Big Lagoon Rancheria, California</option>
                                                                        <option value="Big Pine Reservation">Big Pine Paiute Tribe of the Owens Valley</option>
                                                                        <option value="Big Sandy">Big Sandy Rancheria of Western Mono Indians of California</option>
                                                                        <option value="Big Valley Rancheria">Big Valley Band of Pomo Indians of the Big Valley Rancheria, California</option>
                                                                        <option value="Birch Creek">Birch Creek Tribe</option>
                                                                        <option value="Bishop Paiute">Bishop Paiute Tribe</option>
                                                                        <option value="Blackfeet">Blackfeet Tribe of the Blackfeet Indian Reservation of Montana</option>
                                                                        <option value="Blue Lake">Blue Lake Rancheria, California</option>
                                                                        <option value="Bridgeport Indian Colony">Bridgeport Indian Colony</option>
                                                                        <option value="Buena Vista Rancheria">Buena Vista Rancheria of Me-Wuk Indians of California</option>
                                                                        <option value="Burns Paiute">Burns Paiute Tribe</option>
                                                                        <option value="Cabazon">Cabazon Band of Mission Indians, California</option>
                                                                        <option value="Cachil DeHe">Cachil DeHe Band of Wintun Indians of the Colusa Indian Community of the Colusa Rancheria, California</option>
                                                                        <option value="Caddo">Caddo Nation of Oklahoma</option>
                                                                        <option value="Cahto">Cahto Tribe of the Laytonville Rancheria</option>
                                                                        <option value="Cahuilla">Cahuilla Band of Indians</option>
                                                                        <option value="California Valley">California Valley Miwok Tribe, California</option>
                                                                        <option value="Campo">Campo Band of Diegueno Mission Indians of the Campo Indian Reservation, California</option>
                                                                        <option value="Capitan Grande">Capitan Grande Band of Diegueno Mission Indians of California (Barona Group of Capitan Grande Band of Mission Indians of the Barona Reservation, California)</option>
                                                                        <option value="Capitan Grande Band">Capitan Grande Band of Diegueno Mission Indians of California</option>
                                                                        <option value="Viejas">Capitan Grande Band of Diegueno Mission Indians of California: Viejas (Baron Long) Group of Capitan Grande Band of Mission Indians of the Viejas Reservation, California</option>
                                                                        <option value="Catawba">Catawba Indian Nation (aka Catawba Indian Tribe of South Carolina)</option>
                                                                        <option value="Cayuga Nation of New York">Cayuga Nation</option>
                                                                        <option value="Cedarville">Cedarville Rancheria, California</option>
                                                                        <option value="Tlingit &amp; Haida">Central Council of the Tlingit &amp; Haida Indian Tribes</option>
                                                                        <option value="Chalkyitsik">Chalkyitsik Village</option>
                                                                        <option value="Cheesh-Na">Cheesh-Na Tribe</option>
                                                                        <option value="Chemehuevi">Chemehuevi Indian Tribe of the Chemehuevi Reservation, California</option>
                                                                        <option value="Cher-Ae Heights">Cher-Ae Heights Indian Community of the Trinidad Rancheria, California</option>
                                                                        <option value="Cherokee Nation">Cherokee Nation</option>
                                                                        <option value="Chevak">Chevak Native Village</option>
                                                                        <option value="Cheyenne River">Cheyenne and Arapaho Tribes, Oklahoma</option>
                                                                        <option value="Cheyenne River Sioux Tribe">Cheyenne River Sioux Tribe of the Cheyenne River Reservation, South Dakota</option>
                                                                        <option value="Chickahominy Indians-Eastern Division">Chickahominy Indian Tribe - Eastern Division</option>
                                                                        <option value="Chickahominy Indian Tribe, Inc.">Chickahominy Indian Tribe</option>
                                                                        <option value="Chickaloon">Chickaloon Native Village</option>
                                                                        <option value="Chicken Ranch">Chicken Ranch Rancheria of Me-Wuk Indians of California</option>
                                                                        <option value="Chignik Bay">Chignik Bay Tribal Council</option>
                                                                        <option value="Chignik Lake">Chignik Lake Village</option>
                                                                        <option value="Chilkat">Chilkat Indian Village (Klukwan)</option>
                                                                        <option value="Chilkoot">Chilkoot Indian Association (Haines)</option>
                                                                        <option value="Chinik">Chinik Eskimo Community (Golovin)</option>
                                                                        <option value="Chippewa-Cree">Chippewa Cree Indians of the Rocky Boy's Reservation, Montana</option>
                                                                        <option value="Chitimacha">Chitimacha Tribe of Louisiana</option>
                                                                        <option value="Chuloonawick">Chuloonawick Native Village</option>
                                                                        <option value="Circle">Circle Native Community</option>
                                                                        <option value="Citizen Potawatomi">Citizen Potawatomi Nation, Oklahoma</option>
                                                                        <option value="Cloverdale">Cloverdale Rancheria of Pomo Indians of California</option>
                                                                        <option value="Cocopah">Cocopah Tribe of Arizona</option>
                                                                        <option value="Coeur D'Alene">Coeur D'Alene Tribe</option>
                                                                        <option value="Cold Springs">Cold Springs Rancheria of Mono Indians of California</option>
                                                                        <option value="Colorado River">Colorado River Indian Tribes of the Colorado River Indian Reservation, Arizona and California</option>
                                                                        <option value="Comanche">Comanche Nation, Oklahoma</option>
                                                                        <option value="Confederated Salish">Confederated Salish and Kootenai Tribes of the Flathead Reservation</option>
                                                                        <option value="Confederated Yakama">Confederated Tribes and Bands of the Yakama Nation</option>
                                                                        <option value="Siletz Tribe">Confederated Tribes of Siletz Indians of Oregon</option>
                                                                        <option value="Chehalis">Confederated Tribes of the Chehalis Reservation</option>
                                                                        <option value="Confederated Colville">Confederated Tribes of the Colville Reservation</option>
                                                                        <option value="Confederated Coos">Confederated Tribes of the Coos, Lower Umpqua and Siuslaw Indians</option>
                                                                        <option value="Confederated Goshute">Confederated Tribes of the Goshute Reservation, Nevada and Utah</option>
                                                                        <option value="Grand Ronde Tribes">Confederated Tribes of the Grand Ronde Community of Oregon</option>
                                                                        <option value="Umatilla Tribe">Confederated Tribes of the Umatilla Indian Reservation</option>
                                                                        <option value="Warms Springs Tribe">Confederated Tribes of the Warm Springs Reservation of Oregon</option>
                                                                        <option value="Coquille">Coquille Indian Tribe</option>
                                                                        <option value="Coushatta">Coushatta Tribe of Louisiana</option>
                                                                        <option value="Cow Creek">Cow Creek Band of Umpqua Tribe of Indians</option>
                                                                        <option value="Cowlitz">Cowlitz Indian Tribe</option>
                                                                        <option value="Coyote Valley">Coyote Valley Band of Pomo Indians of California</option>
                                                                        <option value="Craig">Craig Tribal Association</option>
                                                                        <option value="Crow Creek">Crow Creek Sioux Tribe of the Crow Creek Reservation, South Dakota</option>
                                                                        <option value="Crow">Crow Tribe of Montana</option>
                                                                        <option value="Curyung">Curyung Tribal Council</option>
                                                                        <option value="Delaware Nation">Delaware Nation, Oklahoma</option>
                                                                        <option value="Delaware Tribe of Indians">Delaware Tribe of Indians</option>
                                                                        <option value="Douglas">Douglas Indian Association</option>
                                                                        <option value="Dry Creek">Dry Creek Rancheria Band of Pomo Indians, California</option>
                                                                        <option value="Duckwater">Duckwater Shoshone Tribe of the Duckwater Reservation, Nevada</option>
                                                                        <option value="Eastern Cherokee">Eastern Band of Cherokee Indians</option>
                                                                        <option value="Eastern Shawnee Tribe of Oklahoma">Eastern Shawnee Tribe of Oklahoma</option>
                                                                        <option value="Eastern Shoshone">Eastern Shoshone Tribe of the Wind River Reservation, Wyoming</option>
                                                                        <option value="Egegik">Egegik Village</option>
                                                                        <option value="Eklutna">Eklutna Native Village</option>
                                                                        <option value="Elem">Elem Indian Colony of Pomo Indians of the Sulphur Bank Rancheria, California</option>
                                                                        <option value="Elk Valley">Elk Valley Rancheria, California</option>
                                                                        <option value="Ely Shoshone">Ely Shoshone Tribe of Nevada</option>
                                                                        <option value="Emmonak">Emmonak Village</option>
                                                                        <option value="Enterprise">Enterprise Rancheria of Maidu Indians of California</option>
                                                                        <option value="Evansville">Evansville Village (aka Bettles Field)</option>
                                                                        <option value="Ewiiaapaayp">Ewiiaapaayp Band of Kumeyaay Indians, California</option>
                                                                        <option value="Federated Indians of Graton">Federated Indians of Graton Rancheria, California</option>
                                                                        <option value="Flandreau">Flandreau Santee Sioux Tribe of South Dakota</option>
                                                                        <option value="Forest County">Forest County Potawatomi Community, Wisconsin</option>
                                                                        <option value="Assiniboine and Gros Ventre Tribes">Fort Belknap Indian Community of the Fort Belknap Reservation of Montana</option>
                                                                        <option value="Fort Bidwell">Fort Bidwell Indian Community of the Fort Bidwell Reservation of California</option>
                                                                        <option value="Fort Independence">Fort Independence Indian Community of Paiute Indians of the Fort Independence Reservation, California</option>
                                                                        <option value="Fort McDermitt">Fort McDermitt Paiute and Shoshone Tribes of the Fort McDermitt Indian Reservation, Nevada and Oregon</option>
                                                                        <option value="Fort McDowell">Fort McDowell Yavapai Nation, Arizona</option>
                                                                        <option value="Fort Mojave">Fort Mojave Indian Tribe of Arizona, California &amp; Nevada</option>
                                                                        <option value="Fort Sill">Fort Sill Apache Tribe of Oklahoma</option>
                                                                        <option value="Galena">Galena Village (aka Louden Village)</option>
                                                                        <option value="Gila River">Gila River Indian Community of the Gila River Indian Reservation, Arizona</option>
                                                                        <option value="Grand Traverse">Grand Traverse Band of Ottawa and Chippewa Indians, Michigan</option>
                                                                        <option value="Greenville">Greenville Rancheria</option>
                                                                        <option value="Grindstone">Grindstone Indian Rancheria of Wintun-Wailaki Indians of California</option>
                                                                        <option value="Guidiville">Guidiville Rancheria of California</option>
                                                                        <option value="Gulkana">Gulkana Village Council</option>
                                                                        <option value="Habematolel">Habematolel Pomo of Upper Lake, California</option>
                                                                        <option value="Hannahville">Hannahville Indian Community, Michigan</option>
                                                                        <option value="Havasupai">Havasupai Tribe of the Havasupai Reservation, Arizona</option>
                                                                        <option value="Healy Lake">Healy Lake Village</option>
                                                                        <option value="Ho-Chunk">Ho-Chunk Nation of Wisconsin</option>
                                                                        <option value="Hoh">Hoh Indian Tribe</option>
                                                                        <option value="Holy Cross">Holy Cross Tribe</option>
                                                                        <option value="Hoonah">Hoonah Indian Association</option>
                                                                        <option value="Hoopa">Hoopa Valley Tribe, California</option>
                                                                        <option value="Hopi">Hopi Tribe of Arizona</option>
                                                                        <option value="Hopland">Hopland Band of Pomo Indians, California</option>
                                                                        <option value="Houlton">Houlton Band of Maliseet Indians</option>
                                                                        <option value="Hualapai">Hualapai Indian Tribe of the Hualapai Indian Reservation, Arizona</option>
                                                                        <option value="Hughes">Hughes Village</option>
                                                                        <option value="Huslia">Huslia Village</option>
                                                                        <option value="Hydaburg">Hydaburg Cooperative Association</option>
                                                                        <option value="Igiugig">Igiugig Village</option>
                                                                        <option value="Iipay">Iipay Nation of Santa Ysabel, California</option>
                                                                        <option value="Inaja">Inaja Band of Diegueno Mission Indians of the Inaja and Cosmit Reservation, California</option>
                                                                        <option value="Inupiat Community of the Arctic Slope">Inupiat Community of the Arctic Slope</option>
                                                                        <option value="Ione">Ione Band of Miwok Indians of California</option>
                                                                        <option value="Iowa of Kansas">Iowa Tribe of Kansas and Nebraska</option>
                                                                        <option value="Iowa of Oklahoma">Iowa Tribe of Oklahoma</option>
                                                                        <option value="Iqugmiut">Iqugmiut Traditional Council</option>
                                                                        <option value="Ivanof Bay Tribe">Ivanof Bay Tribe</option>
                                                                        <option value="Jackson">Jackson Band of Miwuk Indians</option>
                                                                        <option value="Jamestown">Jamestown S'Klallam Tribe</option>
                                                                        <option value="Jamul">Jamul Indian Village of California</option>
                                                                        <option value="Jena">Jena Band of Choctaw Indians</option>
                                                                        <option value="Jicarilla">Jicarilla Apache Nation, New Mexico</option>
                                                                        <option value="Kaguyuk">Kaguyak Village</option>
                                                                        <option value="Kaibab">Kaibab Band of Paiute Indians of the Kaibab Indian Reservation, Arizona</option>
                                                                        <option value="Kaktovik">Kaktovik Village (aka Barter Island)</option>
                                                                        <option value="Kalispel">Kalispel Indian Community of the Kalispel Reservation</option>
                                                                        <option value="Karuk">Karuk Tribe</option>
                                                                        <option value="Kashia">Kashia Band of Pomo Indians of the Stewarts Point Rancheria, California</option>
                                                                        <option value="Kasigluk">Kasigluk Traditional Elders Council</option>
                                                                        <option value="Kaw">Kaw Nation, Oklahoma</option>
                                                                        <option value="Kenaitze">Kenaitze Indian Tribe</option>
                                                                        <option value="Ketchikan">Ketchikan Indian Community</option>
                                                                        <option value="Keweenaw">Keweenaw Bay Indian Community, Michigan</option>
                                                                        <option value="Kialegee Tribal Town">Kialegee Tribal Town</option>
                                                                        <option value="Kickapoo of Texas">Kickapoo Traditional Tribe of Texas</option>
                                                                        <option value="Kickapoo Tribe in Kansas">Kickapoo Tribe of Indians of the Kickapoo Reservation in Kansas</option>
                                                                        <option value="Kickapoo of Oklahoma">Kickapoo Tribe of Oklahoma</option>
                                                                        <option value="King Island">King Island Native Community</option>
                                                                        <option value="King Salmon">King Salmon Tribe</option>
                                                                        <option value="Kiowa Tribe">Kiowa  Indian Tribe of Oklahoma</option>
                                                                        <option value="Klamath">Klamath Tribes</option>
                                                                        <option value="Klawock">Klawock Cooperative Association</option>
                                                                        <option value="Cortina">Kletsel Dehe Band of Wintun Indians</option>
                                                                        <option value="Knik">Knik Tribe</option>
                                                                        <option value="Koi">Koi Nation of Northern California</option>
                                                                        <option value="Kokhanok">Kokhanok Village</option>
                                                                        <option value="Kootenai">Kootenai Tribe of Idaho</option>
                                                                        <option value="Koyukuk">Koyukuk Native Village</option>
                                                                        <option value="La Jolla">La Jolla Band of Luiseno Indians, California</option>
                                                                        <option value="La Posta">La Posta Band of Diegueno Mission Indians of the La Posta Indian Reservation, California</option>
                                                                        <option value="Lac Courte Oreilles">Lac Courte Oreilles Band of Lake Superior Chippewa Indians of Wisconsin</option>
                                                                        <option value="Lac du Flambeau">Lac du Flambeau Band of Lake Superior Chippewa Indians of the Lac du Flambeau Reservation of Wisconsin</option>
                                                                        <option value="Lac Vieux">Lac Vieux Desert Band of Lake Superior Chippewa Indians of Michigan</option>
                                                                        <option value="Las Vegas">Las Vegas Tribe of Paiute Indians of the Las Vegas Indian Colony, Nevada</option>
                                                                        <option value="Levelock">Levelock Village</option>
                                                                        <option value="Lime">Lime Village</option>
                                                                        <option value="Little River">Little River Band of Ottawa Indians, Michigan</option>
                                                                        <option value="Little Shell Tribe">Little Shell Tribe of Chippewa Indians of Montana</option>
                                                                        <option value="Little Traverse">Little Traverse Bay Bands of Odawa Indians, Michigan</option>
                                                                        <option value="Lone Pine">Lone Pine Paiute-Shoshone Tribe</option>
                                                                        <option value="Los Coyotes">Los Coyotes Band of Cahuilla and Cupeno Indians, California</option>
                                                                        <option value="Lovelock">Lovelock Paiute Tribe of the Lovelock Indian Colony, Nevada</option>
                                                                        <option value="Lower Brule">Lower Brule Sioux Tribe of the Lower Brule Reservation, South Dakota</option>
                                                                        <option value="Lower Elwha">Lower Elwha Tribal Community</option>
                                                                        <option value="Lower Sioux">Lower Sioux Indian Community in the State of Minnesota</option>
                                                                        <option value="Lummi">Lummi Tribe of the Lummi Reservation</option>
                                                                        <option value="Lytton">Lytton Rancheria of California</option>
                                                                        <option value="Makah">Makah Indian Tribe of the Makah Indian Reservation</option>
                                                                        <option value="Manchester">Manchester Band of Pomo Indians of the Manchester Rancheria, California</option>
                                                                        <option value="Manley Hot Springs">Manley Hot Springs Village</option>
                                                                        <option value="Manokotak">Manokotak Village</option>
                                                                        <option value="Manzanita">Manzanita Band of Diegueno Mission Indians of the Manzanita Reservation, California</option>
                                                                        <option value="Mashantucket Pequot">Mashantucket Pequot Indian Tribe</option>
                                                                        <option value="Mashpee">Mashpee Wampanoag Tribe</option>
                                                                        <option value="Match-e-be-nash-she-wish Band">Match-e-be-nash-she-wish Band of Pottawatomi Indians of Michigan</option>
                                                                        <option value="Mcgrath">McGrath Native Village</option>
                                                                        <option value="Mechoopda">Mechoopda Indian Tribe of Chico Rancheria, California</option>
                                                                        <option value="Menominee">Menominee Indian Tribe of Wisconsin</option>
                                                                        <option value="Mentasta">Mentasta Traditional Council</option>
                                                                        <option value="Mesa Grande">Mesa Grande Band of Diegueno Mission Indians of the Mesa Grande Reservation, California</option>
                                                                        <option value="Mescalero Apache">Mescalero Apache Tribe of the Mescalero Reservation, New Mexico</option>
                                                                        <option value="Metlakatla">Metlakatla Indian Community, Annette Island Reserve</option>
                                                                        <option value="Miami Tribe of Oklahoma">Miami Tribe of Oklahoma</option>
                                                                        <option value="Miccosukee">Miccosukee Tribe of Indians</option>
                                                                        <option value="Middletown">Middletown Rancheria of Pomo Indians of California</option>
                                                                        <option value="Mi'kmaq Nation">Mi'kmaq Nation</option>
                                                                        <option value="Bois Forte">Minnesota Chippewa Tribe - Bois Forte Band (Nett Lake)</option>
                                                                        <option value="Fond du Lac">Minnesota Chippewa Tribe - Fond du Lac Band</option>
                                                                        <option value="Grand Portage">Minnesota Chippewa Tribe - Grand Portage Band</option>
                                                                        <option value="Leech Lake">Minnesota Chippewa Tribe - Leech Lake Band</option>
                                                                        <option value="Mille Lacs">Minnesota Chippewa Tribe - Mille Lacs Band</option>
                                                                        <option value="White Earth">Minnesota Chippewa Tribe - White Earth Band</option>
                                                                        <option value="Minnesota Chippewa">Minnesota Chippewa Tribe, Minnesota</option>
                                                                        <option value="Mississippi Choctaw">Mississippi Band of Choctaw Indians</option>
                                                                        <option value="Moapa">Moapa Band of Paiute Indians of the Moapa River Indian Reservation, Nevada</option>
                                                                        <option value="Modoc Nation">Modoc Nation</option>
                                                                        <option value="Mohegan">Mohegan Tribe of Indians of Connecticut</option>
                                                                        <option value="Monacan Indian Nation">Monacan Indian Nation</option>
                                                                        <option value="Mooretown">Mooretown Rancheria of Maidu Indians of California</option>
                                                                        <option value="Morongo">Morongo Band of Mission Indians, California</option>
                                                                        <option value="Muckleshoot">Muckleshoot Indian Tribe</option>
                                                                        <option value="Naknek">Naknek Native Village</option>
                                                                        <option value="Nansemond Indian Tribe">Nansemond Indian Nation</option>
                                                                        <option value="Narragansett">Narragansett Indian Tribe</option>
                                                                        <option value="Afognak">Native Village of Afognak</option>
                                                                        <option value="Akhiok">Native Village of Akhiok</option>
                                                                        <option value="Akutan">Native Village of Akutan</option>
                                                                        <option value="Aleknagik">Native Village of Aleknagik</option>
                                                                        <option value="Ambler">Native Village of Ambler</option>
                                                                        <option value="Atka">Native Village of Atka</option>
                                                                        <option value="Native Village of Atqasuk">Native Village of Atqasuk</option>
                                                                        <option value="Barrow">Native Village of Barrow Inupiat Traditional Government</option>
                                                                        <option value="Belkofski">Native Village of Belkofski</option>
                                                                        <option value="Brevig Mission">Native Village of Brevig Mission</option>
                                                                        <option value="Buckland">Native Village of Buckland</option>
                                                                        <option value="Cantwell">Native Village of Cantwell</option>
                                                                        <option value="Chenega">Native Village of Chenega (aka Chanega)</option>
                                                                        <option value="Chignik Lagoon">Native Village of Chignik Lagoon</option>
                                                                        <option value="Chitina">Native Village of Chitina</option>
                                                                        <option value="Chuathbaluk">Native Village of Chuathbaluk (Russian Mission, Kuskokwim)</option>
                                                                        <option value="Council">Native Village of Council</option>
                                                                        <option value="Deering">Native Village of Deering</option>
                                                                        <option value="Diomede">Native Village of Diomede (aka Inalik)</option>
                                                                        <option value="Eagle">Native Village of Eagle</option>
                                                                        <option value="Eek">Native Village of Eek</option>
                                                                        <option value="Ekuk">Native Village of Ekuk</option>
                                                                        <option value="Ekwok">Native Village of Ekwok</option>
                                                                        <option value="Elim IRA">Native Village of Elim</option>
                                                                        <option value="Eyak">Native Village of Eyak (Cordova)</option>
                                                                        <option value="False Pass">Native Village of False Pass</option>
                                                                        <option value="Fort Yukon">Native Village of Fort Yukon</option>
                                                                        <option value="Gakona">Native Village of Gakona</option>
                                                                        <option value="Gambell">Native Village of Gambell</option>
                                                                        <option value="Georgetown">Native Village of Georgetown</option>
                                                                        <option value="Goodnews Bay">Native Village of Goodnews Bay</option>
                                                                        <option value="Hamilton">Native Village of Hamilton</option>
                                                                        <option value="Hooper Bay">Native Village of Hooper Bay</option>
                                                                        <option value="Kanatak">Native Village of Kanatak</option>
                                                                        <option value="Karluk">Native Village of Karluk</option>
                                                                        <option value="Kiana">Native Village of Kiana</option>
                                                                        <option value="Kipnuk">Native Village of Kipnuk</option>
                                                                        <option value="Kivalina">Native Village of Kivalina</option>
                                                                        <option value="Kluti Kaah">Native Village of Kluti Kaah (aka Copper Center)</option>
                                                                        <option value="Kobuk">Native Village of Kobuk</option>
                                                                        <option value="Kongiganak">Native Village of Kongiganak</option>
                                                                        <option value="Kotzebue">Native Village of Kotzebue</option>
                                                                        <option value="Koyuk">Native Village of Koyuk</option>
                                                                        <option value="Kwigillingok">Native Village of Kwigillingok</option>
                                                                        <option value="Kwinhagak">Native Village of Kwinhagak (aka Quinhagak)</option>
                                                                        <option value="Larsen Bay">Native Village of Larsen Bay</option>
                                                                        <option value="Marshall">Native Village of Marshall (aka Fortuna Ledge)</option>
                                                                        <option value="Mary's Igloo">Native Village of Mary's Igloo</option>
                                                                        <option value="Mekoryuk">Native Village of Mekoryuk</option>
                                                                        <option value="Minto">Native Village of Minto</option>
                                                                        <option value="Nanwalek">Native Village of Nanwalek (aka English Bay)</option>
                                                                        <option value="Napaimute">Native Village of Napaimute</option>
                                                                        <option value="Napakiak">Native Village of Napakiak</option>
                                                                        <option value="Napaskiak">Native Village of Napaskiak</option>
                                                                        <option value="Nelson Lagoon">Native Village of Nelson Lagoon</option>
                                                                        <option value="Nightmute">Native Village of Nightmute</option>
                                                                        <option value="Nikolski">Native Village of Nikolski</option>
                                                                        <option value="Noatak">Native Village of Noatak</option>
                                                                        <option value="Nuiqsut">Native Village of Nuiqsut (aka Nooiksut)</option>
                                                                        <option value="Nunam Iqua">Native Village of Nunam Iqua</option>
                                                                        <option value="Nunapitchuk">Native Village of Nunapitchuk</option>
                                                                        <option value="Ouzinkie">Native Village of Ouzinkie</option>
                                                                        <option value="Paimiut">Native Village of Paimiut</option>
                                                                        <option value="Perryville">Native Village of Perryville</option>
                                                                        <option value="Pilot Point">Native Village of Pilot Point</option>
                                                                        <option value="Point Hope IRA">Native Village of Point Hope</option>
                                                                        <option value="Point Lay IRA">Native Village of Point Lay</option>
                                                                        <option value="Port Graham">Native Village of Port Graham</option>
                                                                        <option value="Port Heiden">Native Village of Port Heiden</option>
                                                                        <option value="Port Lions">Native Village of Port Lions</option>
                                                                        <option value="Ruby">Native Village of Ruby</option>
                                                                        <option value="St. Michael IRA">Native Village of Saint Michael</option>
                                                                        <option value="Savoonga">Native Village of Savoonga</option>
                                                                        <option value="Scammon Bay">Native Village of Scammon Bay</option>
                                                                        <option value="Selawik">Native Village of Selawik</option>
                                                                        <option value="Shaktoolik">Native Village of Shaktoolik</option>
                                                                        <option value="Shishmaref IRA">Native Village of Shishmaref</option>
                                                                        <option value="Shungnak">Native Village of Shungnak</option>
                                                                        <option value="Stevens Village">Native Village of Stevens</option>
                                                                        <option value="Tanacross">Native Village of Tanacross</option>
                                                                        <option value="Tanana">Native Village of Tanana</option>
                                                                        <option value="Tatitlek">Native Village of Tatitlek</option>
                                                                        <option value="Tazlina">Native Village of Tazlina</option>
                                                                        <option value="Teller">Native Village of Teller</option>
                                                                        <option value="Tetlin">Native Village of Tetlin</option>
                                                                        <option value="Tuntutuliak">Native Village of Tuntutuliak</option>
                                                                        <option value="Tununak">Native Village of Tununak</option>
                                                                        <option value="Tyonek">Native Village of Tyonek</option>
                                                                        <option value="Unalakleet">Native Village of Unalakleet</option>
                                                                        <option value="Unga">Native Village of Unga</option>
                                                                        <option value="Venetie IRA">Native Village of Venetie Tribal Government (Arctic Village and Village of Venetie)</option>
                                                                        <option value="Wales">Native Village of Wales</option>
                                                                        <option value="White Mountain AK">Native Village of White Mountain</option>
                                                                        <option value="Navajo">Navajo Nation, Arizona, New Mexico &amp; Utah</option>
                                                                        <option value="Nenana">Nenana Native Association</option>
                                                                        <option value="New Koliganek">New Koliganek Village Council</option>
                                                                        <option value="New Stuyahok">New Stuyahok Village</option>
                                                                        <option value="Newhalen">Newhalen Village</option>
                                                                        <option value="Newtok">Newtok Village</option>
                                                                        <option value="Nez Perce">Nez Perce Tribe</option>
                                                                        <option value="Nikolai">Nikolai Village</option>
                                                                        <option value="Ninilchik">Ninilchik Village</option>
                                                                        <option value="Nisqually">Nisqually Indian Tribe</option>
                                                                        <option value="Nome">Nome Eskimo Community</option>
                                                                        <option value="Nondalton">Nondalton Village</option>
                                                                        <option value="Nooksack">Nooksack Indian Tribe</option>
                                                                        <option value="Noorvik">Noorvik Native Community</option>
                                                                        <option value="Northern Arapaho">Northern Arapaho Tribe of the Wind River Reservation, Wyoming</option>
                                                                        <option value="Northern Cheyenne">Northern Cheyenne Tribe of the Northern Cheyenne Indian Reservation, Montana</option>
                                                                        <option value="North Fork">Northfork Rancheria of Mono Indians of California</option>
                                                                        <option value="Northway">Northway Village</option>
                                                                        <option value="Northwestern Shoshone">Northwestern Band of the Shoshone Nation</option>
                                                                        <option value="Nottawaseppi Potawatomi">Nottawaseppi Huron Band of the Potawatomi, Michigan</option>
                                                                        <option value="Nulato">Nulato Village</option>
                                                                        <option value="Nunakauyarmiut">Nunakauyarmiut Tribe</option>
                                                                        <option value="Oglala Sioux">Oglala Sioux Tribe</option>
                                                                        <option value="Ohkay Owingeh">Ohkay Owingeh, New Mexico</option>
                                                                        <option value="Omaha">Omaha Tribe of Nebraska</option>
                                                                        <option value="Oneida">Oneida Indian Nation</option>
                                                                        <option value="Oneida Nation (Wisconsin)">Oneida Nation</option>
                                                                        <option value="Onondaga">Onondaga Nation</option>
                                                                        <option value="Grayling">Organized Village of Grayling (aka Holikachuk)</option>
                                                                        <option value="Kake">Organized Village of Kake</option>
                                                                        <option value="Kasaan">Organized Village of Kasaan</option>
                                                                        <option value="Kwethluk">Organized Village of Kwethluk</option>
                                                                        <option value="Saxman">Organized Village of Saxman</option>
                                                                        <option value="Orutsararmiut">Orutsararmiut Traditional Native Council</option>
                                                                        <option value="Oscarville">Oscarville Traditional Village</option>
                                                                        <option value="Otoe-Missouria">Otoe-Missouria Tribe of Indians, Oklahoma</option>
                                                                        <option value="Ottawa Tribe of Oklahoma">Ottawa Tribe of Oklahoma</option>
                                                                        <option value="Paiute of Utah">Paiute Indian Tribe of Utah (Cedar Band of Paiutes, Kanosh Band of Paiutes, Koosharem Band of Paiutes, Indian Peaks Band of Paiutes, and Shivwits Band of Paiutes)</option>
                                                                        <option value="Paiute-Shoshone">Paiute-Shoshone Tribe of the Fallon Reservation and Colony, Nevada</option>
                                                                        <option value="Pala">Pala Band of Mission Indians</option>
                                                                        <option value="Pamunkey Indian Tribe">Pamunkey Indian Tribe</option>
                                                                        <option value="Pascua Yaqui">Pascua Yaqui Tribe of Arizona</option>
                                                                        <option value="Paskenta">Paskenta Band of Nomlaki Indians of California</option>
                                                                        <option value="Passamaquoddy Indian Township">Passamaquoddy Tribe - Indian Township</option>
                                                                        <option value="Passamaquoddy Pleasant Point">Passamaquoddy Tribe - Pleasant Point</option>
                                                                        <option value="Passamaquoddy Tribe">Passamaquoddy Tribe</option>
                                                                        <option value="Pauloff Harbor">Pauloff Harbor Village</option>
                                                                        <option value="Pauma">Pauma Band of Luiseno Mission Indians of the Pauma &amp; Yuima Reservation, California</option>
                                                                        <option value="Pawnee">Pawnee Nation of Oklahoma</option>
                                                                        <option value="Pechanga Band of Indians">Pechanga Band of Indians</option>
                                                                        <option value="Pedro Bay">Pedro Bay Village</option>
                                                                        <option value="Penobscot">Penobscot Nation</option>
                                                                        <option value="Peoria Tribe of Indians of Oklahoma">Peoria Tribe of Indians of Oklahoma</option>
                                                                        <option value="Petersburg">Petersburg Indian Association</option>
                                                                        <option value="Picayune">Picayune Rancheria of Chukchansi Indians of California</option>
                                                                        <option value="Pilot Station">Pilot Station Traditional Village</option>
                                                                        <option value="Pinoleville">Pinoleville Pomo Nation, California</option>
                                                                        <option value="Pit River">Pit River Tribe, California</option>
                                                                        <option value="Pitka's Point">Pitka's Point Traditional Council</option>
                                                                        <option value="Platinum">Platinum Traditional Village</option>
                                                                        <option value="Poarch">Poarch Band of Creek Indians</option>
                                                                        <option value="Pokagon">Pokagon Band of Potawatomi Indians, Michigan and Indiana</option>
                                                                        <option value="Ponca of Oklahoma">Ponca Tribe of Indians of Oklahoma</option>
                                                                        <option value="Ponca of Nebraska">Ponca Tribe of Nebraska</option>
                                                                        <option value="Port Gamble">Port Gamble S'Klallam Tribe</option>
                                                                        <option value="Portage Creek">Portage Creek Village (aka Ohgsenakale)</option>
                                                                        <option value="Potter Valley">Potter Valley Tribe, California</option>
                                                                        <option value="Prairie Band">Prairie Band Potawatomi Nation</option>
                                                                        <option value="Prairie Island">Prairie Island Indian Community in the State of Minnesota</option>
                                                                        <option value="Pribilof Islands Aleut Communities">Pribilof Islands Aleut Communities</option>
                                                                        <option value="Pueblo of Acoma">Pueblo of Acoma, New Mexico</option>
                                                                        <option value="Pueblo of Cochiti">Pueblo of Cochiti, New Mexico</option>
                                                                        <option value="Pueblo of Isleta">Pueblo of Isleta, New Mexico</option>
                                                                        <option value="Pueblo of Jemez">Pueblo of Jemez, New Mexico</option>
                                                                        <option value="Pueblo of Laguna">Pueblo of Laguna, New Mexico</option>
                                                                        <option value="Pueblo of Nambe">Pueblo of Nambe, New Mexico</option>
                                                                        <option value="Pueblo of Picuris">Pueblo of Picuris, New Mexico</option>
                                                                        <option value="Pueblo of Pojoaque">Pueblo of Pojoaque, New Mexico</option>
                                                                        <option value="Pueblo of San Felipe">Pueblo of San Felipe, New Mexico</option>
                                                                        <option value="Pueblo of San Ildefonso">Pueblo of San Ildefonso, New Mexico</option>
                                                                        <option value="Pueblo of Sandia">Pueblo of Sandia, New Mexico</option>
                                                                        <option value="Pueblo of Santa Ana">Pueblo of Santa Ana, New Mexico</option>
                                                                        <option value="Pueblo of Santa Clara">Pueblo of Santa Clara, New Mexico</option>
                                                                        <option value="Pueblo of Taos">Pueblo of Taos, New Mexico</option>
                                                                        <option value="Pueblo of Tesuque">Pueblo of Tesuque, New Mexico</option>
                                                                        <option value="Pueblo of Zia">Pueblo of Zia, New Mexico</option>
                                                                        <option value="Puyallup">Puyallup Tribe of the Puyallup Reservation</option>
                                                                        <option value="Pyramid Lake">Pyramid Lake Paiute Tribe of the Pyramid Lake Reservation, Nevada</option>
                                                                        <option value="Qagan Tayagungin">Qagan Tayagungin Tribe of Sand Point</option>
                                                                        <option value="Qawalangin">Qawalangin Tribe of Unalaska</option>
                                                                        <option value="Quapaw Nation">Quapaw Nation</option>
                                                                        <option value="Quartz Valley">Quartz Valley Indian Community of the Quartz Valley Reservation of California</option>
                                                                        <option value="Quechan">Quechan Tribe of the Fort Yuma Indian Reservation, California &amp; Arizona</option>
                                                                        <option value="Quileute">Quileute Tribe of the Quileute Reservation</option>
                                                                        <option value="Quinault">Quinault Indian Nation</option>
                                                                        <option value="Ramah Navajo Chapter">Ramah Navajo Chapter of the Navajo Nation</option>
                                                                        <option value="Ramona">Ramona Band of Cahuilla, California</option>
                                                                        <option value="Rampart">Rampart Village</option>
                                                                        <option value="Rappahannock Tribe, Inc.">Rappahannock Tribe, Inc.</option>
                                                                        <option value="Red Cliff">Red Cliff Band of Lake Superior Chippewa Indians of Wisconsin</option>
                                                                        <option value="Red Lake">Red Lake Band of Chippewa Indians, Minnesota</option>
                                                                        <option value="Redding">Redding Rancheria, California</option>
                                                                        <option value="Redwood Valley">Redwood Valley or Little River Band of Pomo Indians of the Redwood Valley Rancheria California</option>
                                                                        <option value="Reno-Sparks">Reno-Sparks Indian Colony, Nevada</option>
                                                                        <option value="Resighini">Resighini Rancheria, California</option>
                                                                        <option value="Rincon">Rincon Band of Luiseno Mission Indians of the Rincon Reservation, California</option>
                                                                        <option value="Robinson">Robinson Rancheria</option>
                                                                        <option value="Rosebud">Rosebud Sioux Tribe of the Rosebud Indian Reservation, South Dakota</option>
                                                                        <option value="Round Valley">Round Valley Indian Tribes, Round Valley Reservation, California</option>
                                                                        <option value="Sac &amp; Fox Nation of Missouri in Kansas and Nebraska">Sac &amp; Fox Nation of Missouri in Kansas and Nebraska</option>
                                                                        <option value="Sac &amp; Fox Nation, Oklahoma">Sac &amp; Fox Nation, Oklahoma</option>
                                                                        <option value="Sac &amp; Fox of Mississippi">Sac &amp; Fox Tribe of the Mississippi in Iowa</option>
                                                                        <option value="Saginaw Chippewa">Saginaw Chippewa Indian Tribe of Michigan</option>
                                                                        <option value="St. George">Saint George Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                                                                        <option value="Saint Paul">Saint Paul Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                                                                        <option value="Saint Regis">Saint Regis Mohawk Tribe</option>
                                                                        <option value="Salamatof">Salamatof Tribe</option>
                                                                        <option value="Salt River">Salt River Pima-Maricopa Indian Community of the Salt River Reservation, Arizona</option>
                                                                        <option value="Samish">Samish Indian Nation</option>
                                                                        <option value="San Carlos">San Carlos Apache Tribe of the San Carlos Reservation, Arizona</option>
                                                                        <option value="San Juan">San Juan Southern Paiute Tribe of Arizona</option>
                                                                        <option value="San Pasqual">San Pasqual Band of Diegueno Mission Indians of California</option>
                                                                        <option value="Santa Rosa of Cahuilla">Santa Rosa Band of Cahuilla Indians, California</option>
                                                                        <option value="Santa Rosa">Santa Rosa Indian Community of the Santa Rosa Rancheria, California</option>
                                                                        <option value="Santa Ynez">Santa Ynez Band of Chumash Mission Indians of the Santa Ynez Reservation, California</option>
                                                                        <option value="Santee Sioux">Santee Sioux Nation, Nebraska</option>
                                                                        <option value="Santo Domingo">Santo Domingo Pueblo</option>
                                                                        <option value="Sauk-Suiattle">Sauk-Suiattle Indian Tribe</option>
                                                                        <option value="Sault Ste. Marie">Sault Ste. Marie Tribe of Chippewa Indians, Michigan</option>
                                                                        <option value="Scotts Valley">Scotts Valley Band of Pomo Indians of California</option>
                                                                        <option value="Seldovia">Seldovia Village Tribe</option>
                                                                        <option value="Seminole">Seminole Tribe of Florida</option>
                                                                        <option value="Seneca">Seneca Nation of Indians</option>
                                                                        <option value="Seneca-Cayuga Nation">Seneca-Cayuga Nation</option>
                                                                        <option value="Shageluk">Shageluk Native Village</option>
                                                                        <option value="Shakopee">Shakopee Mdewakanton Sioux Community of Minnesota</option>
                                                                        <option value="Shawnee Tribe">Shawnee Tribe</option>
                                                                        <option value="Sherwood Valley">Sherwood Valley Rancheria of Pomo Indians of California</option>
                                                                        <option value="Shingle Springs">Shingle Springs Band of Miwok Indians, Shingle Springs Rancheria (Verona Tract), California</option>
                                                                        <option value="Shinnecock">Shinnecock Indian Nation</option>
                                                                        <option value="Shoalwater">Shoalwater Bay Indian Tribe of the Shoalwater Bay Indian Reservation</option>
                                                                        <option value="Shoshone-Bannock">Shoshone-Bannock Tribes of the Fort Hall Reservation</option>
                                                                        <option value="Shoshone-Paiute">Shoshone-Paiute Tribes of the Duck Valley Reservation, Nevada</option>
                                                                        <option value="Sisseton-Wahpeton">Sisseton-Wahpeton Oyate of the Lake Traverse Reservation, South Dakota</option>
                                                                        <option value="Sitka">Sitka Tribe of Alaska</option>
                                                                        <option value="Skagway">Skagway Village</option>
                                                                        <option value="Skokomish">Skokomish Indian Tribe</option>
                                                                        <option value="Skull Valley">Skull Valley Band of Goshute Indians of Utah</option>
                                                                        <option value="Snoqualmie">Snoqualmie Indian Tribe</option>
                                                                        <option value="Soboba">Soboba Band of Luiseno Indians, California</option>
                                                                        <option value="Sokaogon">Sokaogon Chippewa  Community, Wisconsin</option>
                                                                        <option value="South Naknek">South Naknek Village</option>
                                                                        <option value="Southern Ute">Southern Ute Indian Tribe of the Southern Ute Reservation, Colorado</option>
                                                                        <option value="Spirit Lake">Spirit Lake Tribe, North Dakota</option>
                                                                        <option value="Spokane">Spokane Tribe of the Spokane Reservation</option>
                                                                        <option value="Squaxin">Squaxin Island Tribe of the Squaxin Island Reservation</option>
                                                                        <option value="St. Croix">St. Croix Chippewa Indians of Wisconsin</option>
                                                                        <option value="Standing Rock">Standing Rock Sioux Tribe of North &amp; South Dakota</option>
                                                                        <option value="Stebbins">Stebbins Community Association</option>
                                                                        <option value="Stillaguamish">Stillaguamish Tribe of Indians of Washington</option>
                                                                        <option value="Stockbridge">Stockbridge Munsee Community, Wisconsin</option>
                                                                        <option value="Summit Lake">Summit Lake Paiute Tribe of Nevada</option>
                                                                        <option value="Sun'aq">Sun'aq Tribe of Kodiak</option>
                                                                        <option value="Suquamish">Suquamish Indian Tribe of the Port Madison Reservation</option>
                                                                        <option value="Susanville">Susanville Indian Rancheria, California</option>
                                                                        <option value="Swinomish">Swinomish Indian Tribal Community</option>
                                                                        <option value="Sycuan">Sycuan Band of the Kumeyaay Nation</option>
                                                                        <option value="Table Mountain">Table Mountain Rancheria</option>
                                                                        <option value="Takotna">Takotna Village</option>
                                                                        <option value="Tangirnaq">Tangirnaq Native Village</option>
                                                                        <option value="Tejon">Tejon Indian Tribe</option>
                                                                        <option value="Telida">Telida Village</option>
                                                                        <option value="Te-Moak">Te-Moak Tribe of Western Shoshone Indians of Nevada (Four constituent bands: Battle Mountain Band; Elko Band; South Fork Band and Wells Band)</option>
                                                                        <option value="Chickasaw Nation">The Chickasaw Nation</option>
                                                                        <option value="The Choctaw Nation of Oklahoma">The Choctaw Nation of Oklahoma</option>
                                                                        <option value="The Muscogee (Creek) Nation">The Muscogee (Creek) Nation</option>
                                                                        <option value="The Osage Nation">The Osage Nation</option>
                                                                        <option value="The Seminole Nation  of Oklahoma">The Seminole Nation of Oklahoma</option>
                                                                        <option value="Thlopthlocco Tribal Town">Thlopthlocco Tribal Town</option>
                                                                        <option value="Three Affiliated">Three Affiliated Tribes of the Fort Berthold Reservation, North Dakota</option>
                                                                        <option value="Timbi-sha Shoshone">Timbisha Shoshone Tribe</option>
                                                                        <option value="Tohono O'odham">Tohono O'odham Nation of Arizona</option>
                                                                        <option value="Tolowa Dee-ni'">Tolowa Dee-ni' Nation</option>
                                                                        <option value="Tonawanda">Tonawanda Band of Seneca</option>
                                                                        <option value="Tonkawa">Tonkawa Tribe of Indians of Oklahoma</option>
                                                                        <option value="Tonto Apache">Tonto Apache Tribe of Arizona</option>
                                                                        <option value="Torres Martinez">Torres Martinez Desert Cahuilla Indians, California</option>
                                                                        <option value="Togiak">Traditional Village of Togiak</option>
                                                                        <option value="Tulalip">Tulalip Tribes of Washington</option>
                                                                        <option value="Tule River">Tule River Indian Tribe of the Tule River Reservation, California</option>
                                                                        <option value="Tuluksak">Tuluksak Native Community</option>
                                                                        <option value="Tunica-Biloxi">Tunica-Biloxi Indian Tribe</option>
                                                                        <option value="Tuolumne">Tuolumne Band of Me-Wuk Indians of the Tuolumne Rancheria of California</option>
                                                                        <option value="Turtle Mountain">Turtle Mountain Band of Chippewa Indians of North Dakota</option>
                                                                        <option value="Tuscarora">Tuscarora Nation</option>
                                                                        <option value="Twenty-Nine Palms">Twenty-Nine Palms Band of Mission Indians of California</option>
                                                                        <option value="Twin Hills">Twin Hills Village</option>
                                                                        <option value="Ugashik">Ugashik Village</option>
                                                                        <option value="Umkumiut">Umkumiut Native Village</option>
                                                                        <option value="United Auburn">United Auburn Indian Community of the Auburn Rancheria of California</option>
                                                                        <option value="United Keetoowah Band of Cherokee Indians in Oklahoma">United Keetoowah Band of Cherokee Indians in Oklahoma</option>
                                                                        <option value="Upper Mattaponi Tribe">Upper Mattaponi Tribe</option>
                                                                        <option value="Upper Sioux">Upper Sioux Community, Minnesota</option>
                                                                        <option value="Upper Skagit">Upper Skagit Indian Tribe</option>
                                                                        <option value="Ute">Ute Indian Tribe of the Uintah &amp; Ouray Reservation, Utah</option>
                                                                        <option value="Ute Mountain Ute">Ute Mountain Ute Tribe</option>
                                                                        <option value="Benton">Utu Utu Gwaitu Paiute Tribe of the Benton Paiute Reservation, California</option>
                                                                        <option value="Alakanuk">Village of Alakanuk</option>
                                                                        <option value="Anaktuvuk Pass">Village of Anaktuvuk Pass</option>
                                                                        <option value="Aniak">Village of Aniak</option>
                                                                        <option value="Atmautluak">Village of Atmautluak</option>
                                                                        <option value="Bill Moore's Slough">Village of Bill Moore's Slough</option>
                                                                        <option value="Chefornak">Village of Chefornak</option>
                                                                        <option value="Clark's Point">Village of Clarks Point</option>
                                                                        <option value="Crooked Creek">Village of Crooked Creek</option>
                                                                        <option value="Dot Lake">Village of Dot Lake</option>
                                                                        <option value="Iliamna">Village of Iliamna</option>
                                                                        <option value="Kalskag">Village of Kalskag</option>
                                                                        <option value="Kaltag">Village of Kaltag</option>
                                                                        <option value="Kotlik">Village of Kotlik</option>
                                                                        <option value="Lower Kalskag">Village of Lower Kalskag</option>
                                                                        <option value="Ohogamiut">Village of Ohogamiut</option>
                                                                        <option value="Red Devil">Village of Red Devil</option>
                                                                        <option value="Sleetmute">Village of Sleetmute</option>
                                                                        <option value="Solomon">Village of Solomon</option>
                                                                        <option value="Stony River">Village of Stony River</option>
                                                                        <option value="Venetie">Village of Venetie (See Native Village of Venetie Tribal Government)</option>
                                                                        <option value="Wainwright">Village of Wainwright</option>
                                                                        <option value="Walker River">Walker River Paiute Tribe of the Walker River Reservation, Nevada</option>
                                                                        <option value="Wampanoag">Wampanoag Tribe of Gay Head (Aquinnah)</option>
                                                                        <option value="Washoe">Washoe Tribe of Nevada &amp; California (Carson Colony, Dresslerville Colony, Woodfords Community, Stewart Community, &amp; Washoe Ranches)</option>
                                                                        <option value="White Mountain">White Mountain Apache Tribe of the Fort Apache Reservation, Arizona</option>
                                                                        <option value="Wichita">Wichita and Affiliated Tribes (Wichita, Keechi, Waco &amp; Tawakonie), Oklahoma</option>
                                                                        <option value="Wilton">Wilton Rancheria, California</option>
                                                                        <option value="Winnebago">Winnebago Tribe of Nebraska</option>
                                                                        <option value="Winnemucca">Winnemucca Indian Colony of Nevada</option>
                                                                        <option value="Wiyot">Wiyot Tribe, California</option>
                                                                        <option value="Wrangell">Wrangell Cooperative Association</option>
                                                                        <option value="Wyandotte Nation">Wyandotte Nation</option>
                                                                        <option value="Yakutat">Yakutat Tlingit Tribe</option>
                                                                        <option value="Yankton">Yankton Sioux Tribe of South Dakota</option>
                                                                        <option value="Yavapai-Apache">Yavapai-Apache Nation of the Camp Verde Indian Reservation, Arizona</option>
                                                                        <option value="Yavapai-Prescott">Yavapai-Prescott Indian Tribe</option>
                                                                        <option value="Yerington">Yerington Paiute Tribe of the Yerington Colony and Campbell Ranch, Nevada</option>
                                                                        <option value="Yocha Dehe">Yocha Dehe Wintun Nation, California</option>
                                                                        <option value="Yomba Shoshone">Yomba Shoshone Tribe of the Yomba Reservation, Nevada</option>
                                                                        <option value="Ysleta Del Sur">Ysleta del Sur Pueblo</option>
                                                                        <option value="Yuhaaviatam of San Manuel Nation">Yuhaaviatam of San Manuel Nation</option>
                                                                        <option value="Andreafski">Yupiit of Andreafski</option>
                                                                        <option value="Yurok">Yurok Tribe of the Yurok Reservation, California</option>
                                                                        <option value="Pueblo of Zuni">Zuni Tribe of the Zuni Reservation, New Mexico</option>
                                                                        <option value="Other">Other</option>
                                                                     </select>
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-6 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].identificationDocuments.otherLocalDesc">Other local/Tribal description </label>
                                                                  <div class="form-fields">
                                                                     <input type="text" id="companyApplicantInfo[0].identificationDocuments.otherLocalDesc" name="companyApplicantInfo[0].identificationDocuments.otherLocalDesc" value="" placeholder="Enter local/tribal description" class="com-otherlt form-field" disabled/>
                                                                  </div>
                                                               </div>
                                                            </div>
   
                                                            </div>
        </div>
      </div>
    </div>
   
    <!-- Form of identification and issuing jurisdiction End -->
   <!-- Legal name and date of birth Start -->
   <div class="accordion-item box-bg-sec">
     <div class="accordion-header row">
      <div class="dah-left col-md-8"><h2>Legal Name &amp; Date of Birth</h2></div>
      <div class="dah-right col-md-4">
       <span title=""><a class="hover-modal-btn" href="#boirNeedHelp9"><img src="/images/help-icon.svg" alt=""></a></span>
       <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCAThree" aria-expanded="true" aria-controls="collapseCAThree"></button>
      </div>
     </div>
     <div id="collapseCAThree" class="accordion-collapse collapse show">
       <div class="accordion-body">
         <div class="ab-top-para">
           <p>Enter your legal name and birthdate exactly as they appear on your identification documents.</p>
</div>
                                                            <div>
                                                               <div class="col-sm-6 mt-15" title="">
                                                                  <label class="main-label whsp" for="companyApplicantInfo[0].individualsLastName">Individual's last name or entity's legal name <em>*</em></label>
                                                                  <div class="form-fields">
                                                                     <input type="text" id="companyApplicantInfo[0].individualsLastName"  name="companyApplicantInfo[0].individualsLastName" value="" placeholder="Enter last name" class="com-lname form-field" />
                                                                  </div>
                                                               </div>
                                                               <div class="row two-fields">
                                                                  <div class="col-sm-4 mt-15" title="">
                                                                     <label class="main-label" for="companyApplicantInfo[0].firstName">First name <em>*</em></label>
                                                                     <div class="form-fields">
                                                                        <input type="text" id="companyApplicantInfo[0].firstName" name="companyApplicantInfo[0].firstName" value="" placeholder="Enter First name" class="com-fn form-field" />
                                                                     </div>
                                                                  </div>
                                                                  <div class="col-sm-4 mt-15" title="">
                                                                     <label class="main-label" for="companyApplicantInfo[0].middleName">Middle name </label>
                                                                     <div class="form-fields">
                                                                        <input type="text" id="companyApplicantInfo[0].middleName" name="companyApplicantInfo[0].middleName" value="" placeholder="Enter Middle name" class="com-midname form-field" />
                                                                     </div>
                                                                  </div>
                                                                  <div class="col-sm-4 mt-15" title="">
                                                                     <label class="main-label" for="companyApplicantInfo[0].suffix">Suffix </label>
                                                                     <div class="form-fields">
                                                                        <input type="text" id="companyApplicantInfo[0].suffix" name="companyApplicantInfo[0].suffix" value="" placeholder="Suffix" class="com-suffix form-field" />
                                                                     </div>
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-6 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].dateOfBirth">Date of birth <em>*</em> </label>
                                                                  <div class="form-fields">
                                                                     <div class="date-field"><input type="date" id="companyApplicantInfo[0].dateOfBirth" name="companyApplicantInfo[0].dateOfBirth" value="" placeholder="06/20/2024" class="com-dob form-field" /></div>
                                                                  </div>
                                                               </div>
                                                            </div>
   
                                                            </div>
    </div>
   </div>
   <!-- Legal name and date of birth End -->
   <!-- Current Address Start -->
   <div class="accordion-item box-bg-sec">
     <div class="accordion-header row">
      <div class="dah-left col-md-8"><h2>Current Address</h2></div>
      <div class="dah-right col-md-4">
       <span title=""><a class="hover-modal-btn" href="#boirNeedHelp10"><img src="/images/help-icon.svg" alt=""></a></span>
       <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCAFour" aria-expanded="true" aria-controls="collapseCAFour"></button>
      </div>
     </div>
     <div id="collapseCAFour" class="accordion-collapse collapse show">
       <div class="accordion-body">
         <div class="ab-top-para">
           <p>Please enter your current address—home or work.</p>
</div>
                                                            <div class="col-lg-6 col-md-10 mt-15">
                                                               <label class="main-label">Address type <em>*</em></label>
                                                               <div class="form-fields">
                                                                  <div class="row">
                                                                     <label class="col-sm-6" title="">
                                                                     <input type="radio" id="Residential" name="companyApplicantInfo[0].address.addressType" value="Residential" class="com-addtype"/> Residential</label>
                                                                     <label class="col-sm-6" title="">
                                                                     <input type="radio" id="Business" name="companyApplicantInfo[0].address.addressType" value="Business" class="com-addtype"/> Business</label>
                                                                  </div>
                                                               </div>
                                                            </div>
                                                            <div class="row two-fields">
                                                               <div class="col-sm-7 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].address.address">Address (number, street, apt. or suite no.) <em>*</em></label>
                                                                  <div class="form-fields">
                                                                     <input type="text" id="companyApplicantInfo[0].address.address" name="companyApplicantInfo[0].address.address" value="" placeholder="Enter Address" class="com-address form-field" />
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-5 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].address.city">City <em>*</em></label>
                                                                  <div class="form-fields">
                                                                     <input type="text" id="companyApplicantInfo[0].address.city" name="companyApplicantInfo[0].address.city" value="" placeholder="Enter City name" class="com-city form-field" />
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-4 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].address.country">Country/Jurisdiction <em>*</em></label>
                                                                  <div class="form-fields">
                                                                     <select class="com-countryjuri form-field" id="companyApplicantInfo[0].address.country" name="companyApplicantInfo[0].address.country">
                                                                        <option value="">Select a Country/Jurisdiction</option>
                                                                        <option value="US">United States of America</option>
                                                                        <option value="AS">American Samoa</option>
                                                                        <option value="GU">Guam</option>
                                                                        <option value="MH">Marshall Islands</option>
                                                                        <option value="FM">Micronesia, Federated States</option>
                                                                        <option value="MP">Northern Mariana Islands</option>
                                                                        <option value="PW">Palau</option>
                                                                        <option value="PR">Puerto Rico</option>
                                                                        <option value="VI">U.S. Virgin Islands</option>
                                                                        <option value="AF">Afghanistan</option>
                                                                        <option value="AX">Åland Islands</option>
                                                                        <option value="AL">Albania</option>
                                                                        <option value="DZ">Algeria</option>
                                                                        <option value="AD">Andorra</option>
                                                                        <option value="AO">Angola</option>
                                                                        <option value="AI">Anguilla</option>
                                                                        <option value="AQ">Antarctica</option>
                                                                        <option value="AG">Antigua And Barbuda</option>
                                                                        <option value="AR">Argentina</option>
                                                                        <option value="AM">Armenia</option>
                                                                        <option value="AW">Aruba</option>
                                                                        <option value="AU">Australia</option>
                                                                        <option value="AT">Austria</option>
                                                                        <option value="AZ">Azerbaijan</option>
                                                                        <option value="BS">Bahamas</option>
                                                                        <option value="BH">Bahrain</option>
                                                                        <option value="BD">Bangladesh</option>
                                                                        <option value="BB">Barbados</option>
                                                                        <option value="BY">Belarus</option>
                                                                        <option value="BE">Belgium</option>
                                                                        <option value="BZ">Belize</option>
                                                                        <option value="BJ">Benin</option>
                                                                        <option value="BM">Bermuda</option>
                                                                        <option value="BT">Bhutan</option>
                                                                        <option value="BO">Bolivia, Plurinational State Of</option>
                                                                        <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
                                                                        <option value="BA">Bosnia And Herzegovina</option>
                                                                        <option value="BW">Botswana</option>
                                                                        <option value="BV">Bouvet Island</option>
                                                                        <option value="BR">Brazil</option>
                                                                        <option value="IO">British Indian Ocean Territory</option>
                                                                        <option value="BN">Brunei Darussalam</option>
                                                                        <option value="BG">Bulgaria</option>
                                                                        <option value="BF">Burkina Faso</option>
                                                                        <option value="BI">Burundi</option>
                                                                        <option value="KH">Cambodia</option>
                                                                        <option value="CM">Cameroon</option>
                                                                        <option value="CA">Canada</option>
                                                                        <option value="CV">Cape Verde</option>
                                                                        <option value="KY">Cayman Islands</option>
                                                                        <option value="CF">Central African Republic</option>
                                                                        <option value="TD">Chad</option>
                                                                        <option value="CL">Chile</option>
                                                                        <option value="CN">China</option>
                                                                        <option value="CX">Christmas Island</option>
                                                                        <option value="CC">Cocos (Keeling) Islands</option>
                                                                        <option value="CO">Colombia</option>
                                                                        <option value="KM">Comoros</option>
                                                                        <option value="CG">Congo</option>
                                                                        <option value="CD">Congo, The Democratic Republic Of The</option>
                                                                        <option value="CK">Cook Islands</option>
                                                                        <option value="CR">Costa Rica</option>
                                                                        <option value="CI">Côte D'ivoire</option>
                                                                        <option value="HR">Croatia</option>
                                                                        <option value="CU">Cuba</option>
                                                                        <option value="CW">Curaçao</option>
                                                                        <option value="CY">Cyprus</option>
                                                                        <option value="CZ">Czech Republic</option>
                                                                        <option value="DK">Denmark</option>
                                                                        <option value="DJ">Djibouti</option>
                                                                        <option value="DM">Dominica</option>
                                                                        <option value="DO">Dominican Republic</option>
                                                                        <option value="EC">Ecuador</option>
                                                                        <option value="EG">Egypt</option>
                                                                        <option value="SV">El Salvador</option>
                                                                        <option value="GQ">Equatorial Guinea</option>
                                                                        <option value="ER">Eritrea</option>
                                                                        <option value="EE">Estonia</option>
                                                                        <option value="ET">Ethiopia</option>
                                                                        <option value="FK">Falkland Islands (Malvinas)</option>
                                                                        <option value="FO">Faroe Islands</option>
                                                                        <option value="FJ">Fiji</option>
                                                                        <option value="FI">Finland</option>
                                                                        <option value="FR">France</option>
                                                                        <option value="GF">French Guiana</option>
                                                                        <option value="PF">French Polynesia</option>
                                                                        <option value="TF">French Southern Territories</option>
                                                                        <option value="GA">Gabon</option>
                                                                        <option value="GM">Gambia</option>
                                                                        <option value="GE">Georgia</option>
                                                                        <option value="DE">Germany</option>
                                                                        <option value="GH">Ghana</option>
                                                                        <option value="GI">Gibraltar</option>
                                                                        <option value="GR">Greece</option>
                                                                        <option value="GL">Greenland</option>
                                                                        <option value="GD">Grenada</option>
                                                                        <option value="GP">Guadeloupe</option>
                                                                        <option value="GT">Guatemala</option>
                                                                        <option value="GG">Guernsey</option>
                                                                        <option value="GN">Guinea</option>
                                                                        <option value="GW">Guinea-bissau</option>
                                                                        <option value="GY">Guyana</option>
                                                                        <option value="HT">Haiti</option>
                                                                        <option value="HM">Heard Island And Mcdonald Islands</option>
                                                                        <option value="VA">Holy See (Vatican City State)</option>
                                                                        <option value="HN">Honduras</option>
                                                                        <option value="HK">Hong Kong</option>
                                                                        <option value="HU">Hungary</option>
                                                                        <option value="IS">Iceland</option>
                                                                        <option value="IN">India</option>
                                                                        <option value="ID">Indonesia</option>
                                                                        <option value="IR">Iran, Islamic Republic Of</option>
                                                                        <option value="IQ">Iraq</option>
                                                                        <option value="IE">Ireland</option>
                                                                        <option value="IM">Isle Of Man</option>
                                                                        <option value="IL">Israel</option>
                                                                        <option value="IT">Italy</option>
                                                                        <option value="JM">Jamaica</option>
                                                                        <option value="JP">Japan</option>
                                                                        <option value="JE">Jersey</option>
                                                                        <option value="JO">Jordan</option>
                                                                        <option value="KZ">Kazakhstan</option>
                                                                        <option value="KE">Kenya</option>
                                                                        <option value="KI">Kiribati</option>
                                                                        <option value="KP">Korea, Democratic People's Republic Of</option>
                                                                        <option value="KR">Korea, Republic Of</option>
                                                                        <option value="KW">Kuwait</option>
                                                                        <option value="KG">Kyrgyzstan</option>
                                                                        <option value="LA">Lao People's Democratic Republic</option>
                                                                        <option value="LV">Latvia</option>
                                                                        <option value="LB">Lebanon</option>
                                                                        <option value="LS">Lesotho</option>
                                                                        <option value="LR">Liberia</option>
                                                                        <option value="LY">Libya</option>
                                                                        <option value="LI">Liechtenstein</option>
                                                                        <option value="LT">Lithuania</option>
                                                                        <option value="LU">Luxembourg</option>
                                                                        <option value="MO">Macao</option>
                                                                        <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
                                                                        <option value="MG">Madagascar</option>
                                                                        <option value="MW">Malawi</option>
                                                                        <option value="MY">Malaysia</option>
                                                                        <option value="MV">Maldives</option>
                                                                        <option value="ML">Mali</option>
                                                                        <option value="MT">Malta</option>
                                                                        <option value="MQ">Martinique</option>
                                                                        <option value="MR">Mauritania</option>
                                                                        <option value="MU">Mauritius</option>
                                                                        <option value="YT">Mayotte</option>
                                                                        <option value="MX">Mexico</option>
                                                                        <option value="MD">Moldova, Republic Of</option>
                                                                        <option value="MC">Monaco</option>
                                                                        <option value="MN">Mongolia</option>
                                                                        <option value="ME">Montenegro</option>
                                                                        <option value="MS">Montserrat</option>
                                                                        <option value="MA">Morocco</option>
                                                                        <option value="MZ">Mozambique</option>
                                                                        <option value="MM">Myanmar</option>
                                                                        <option value="NA">Namibia</option>
                                                                        <option value="NR">Nauru</option>
                                                                        <option value="NP">Nepal</option>
                                                                        <option value="NL">Netherlands</option>
                                                                        <option value="NC">New Caledonia</option>
                                                                        <option value="NZ">New Zealand</option>
                                                                        <option value="NI">Nicaragua</option>
                                                                        <option value="NE">Niger</option>
                                                                        <option value="NG">Nigeria</option>
                                                                        <option value="NU">Niue</option>
                                                                        <option value="NF">Norfolk Island</option>
                                                                        <option value="NO">Norway</option>
                                                                        <option value="OM">Oman</option>
                                                                        <option value="PK">Pakistan</option>
                                                                        <option value="PS">Palestinian Territory, Occupied</option>
                                                                        <option value="PA">Panama</option>
                                                                        <option value="PG">Papua New Guinea</option>
                                                                        <option value="PY">Paraguay</option>
                                                                        <option value="PE">Peru</option>
                                                                        <option value="PH">Philippines</option>
                                                                        <option value="PN">Pitcairn</option>
                                                                        <option value="PL">Poland</option>
                                                                        <option value="PT">Portugal</option>
                                                                        <option value="QA">Qatar</option>
                                                                        <option value="RE">Réunion</option>
                                                                        <option value="RO">Romania</option>
                                                                        <option value="RU">Russian Federation</option>
                                                                        <option value="RW">Rwanda</option>
                                                                        <option value="BL">Saint Barthélemy</option>
                                                                        <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
                                                                        <option value="KN">Saint Kitts And Nevis</option>
                                                                        <option value="LC">Saint Lucia</option>
                                                                        <option value="MF">Saint Martin (french Part)</option>
                                                                        <option value="PM">Saint Pierre And Miquelon</option>
                                                                        <option value="VC">Saint Vincent And The Grenadines</option>
                                                                        <option value="WS">Samoa</option>
                                                                        <option value="SM">San Marino</option>
                                                                        <option value="ST">Sao Tome And Principe</option>
                                                                        <option value="SA">Saudi Arabia</option>
                                                                        <option value="SN">Senegal</option>
                                                                        <option value="RS">Serbia</option>
                                                                        <option value="SC">Seychelles</option>
                                                                        <option value="SL">Sierra Leone</option>
                                                                        <option value="SG">Singapore</option>
                                                                        <option value="SX">Sint Maarten (dutch Part)</option>
                                                                        <option value="SK">Slovakia</option>
                                                                        <option value="SI">Slovenia</option>
                                                                        <option value="SB">Solomon Islands</option>
                                                                        <option value="SO">Somalia</option>
                                                                        <option value="ZA">South Africa</option>
                                                                        <option value="GS">South Georgia And The South Sandwich Islands</option>
                                                                        <option value="SS">South Sudan</option>
                                                                        <option value="ES">Spain</option>
                                                                        <option value="LK">Sri Lanka</option>
                                                                        <option value="SD">Sudan</option>
                                                                        <option value="SR">Suriname</option>
                                                                        <option value="SJ">Svalbard And Jan Mayen</option>
                                                                        <option value="SZ">Swaziland</option>
                                                                        <option value="SE">Sweden</option>
                                                                        <option value="CH">Switzerland</option>
                                                                        <option value="SY">Syrian Arab Republic</option>
                                                                        <option value="TW">Taiwan</option>
                                                                        <option value="TJ">Tajikistan</option>
                                                                        <option value="TZ">Tanzania, United Republic Of</option>
                                                                        <option value="TH">Thailand</option>
                                                                        <option value="TL">Timor-leste</option>
                                                                        <option value="TG">Togo</option>
                                                                        <option value="TK">Tokelau</option>
                                                                        <option value="TO">Tonga</option>
                                                                        <option value="TT">Trinidad And Tobago</option>
                                                                        <option value="TN">Tunisia</option>
                                                                        <option value="TR">Turkey</option>
                                                                        <option value="TM">Turkmenistan</option>
                                                                        <option value="TC">Turks And Caicos Islands</option>
                                                                        <option value="TV">Tuvalu</option>
                                                                        <option value="UG">Uganda</option>
                                                                        <option value="UA">Ukraine</option>
                                                                        <option value="AE">United Arab Emirates</option>
                                                                        <option value="GB">United Kingdom</option>
                                                                        <option value="UY">Uruguay</option>
                                                                        <option value="UZ">Uzbekistan</option>
                                                                        <option value="VU">Vanuatu</option>
                                                                        <option value="VE">Venezuela, Bolivarian Republic Of</option>
                                                                        <option value="VN">Viet Nam</option>
                                                                        <option value="VG">Virgin Islands, British</option>
                                                                        <option value="WF">Wallis And Futuna</option>
                                                                        <option value="EH">Western Sahara</option>
                                                                        <option value="YE">Yemen</option>
                                                                        <option value="ZM">Zambia</option>
                                                                        <option value="ZW">Zimbabwe</option>
                                                                     </select>
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-4 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].address.state">State <em id="comStateStar">*</em></label>
                                                                  <div class="form-fields">
                                                                     <select class="company-state form-field" id="companyApplicantInfo[0].address.state" name="companyApplicantInfo[0].address.state">
                                                                        <option value="">Select a state</option>
                                                                        <option value="AL">Alabama</option>
                                                                        <option value="AK">Alaska</option>
                                                                        <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
                                                                        <option value="AA">Armed Forces Americas (except Canada)</option>
                                                                        <option value="AP">Armed Forces Pacific</option>
                                                                        <option value="AZ">Arizona</option>
                                                                        <option value="AR">Arkansas</option>
                                                                        <option value="CA">California</option>
                                                                        <option value="CO">Colorado</option>
                                                                        <option value="CT">Connecticut</option>
                                                                        <option value="DE">Delaware</option>
                                                                        <option value="DC">District of Columbia</option>
                                                                        <option value="FL">Florida</option>
                                                                        <option value="GA">Georgia</option>
                                                                        <option value="HI">Hawaii</option>
                                                                        <option value="ID">Idaho</option>
                                                                        <option value="IL">Illinois</option>
                                                                        <option value="IN">Indiana</option>
                                                                        <option value="IA">Iowa</option>
                                                                        <option value="KS">Kansas</option>
                                                                        <option value="KY">Kentucky</option>
                                                                        <option value="LA">Louisiana</option>
                                                                        <option value="ME">Maine</option>
                                                                        <option value="MD">Maryland</option>
                                                                        <option value="MA">Massachusetts</option>
                                                                        <option value="MI">Michigan</option>
                                                                        <option value="MN">Minnesota</option>
                                                                        <option value="MS">Mississippi</option>
                                                                        <option value="MO">Missouri</option>
                                                                        <option value="MT">Montana</option>
                                                                        <option value="NE">Nebraska</option>
                                                                        <option value="NV">Nevada</option>
                                                                        <option value="NH">New Hampshire</option>
                                                                        <option value="NJ">New Jersey</option>
                                                                        <option value="NM">New Mexico</option>
                                                                        <option value="NY">New York</option>
                                                                        <option value="NC">North Carolina</option>
                                                                        <option value="ND">North Dakota</option>
                                                                        <option value="OH">Ohio</option>
                                                                        <option value="OK">Oklahoma</option>
                                                                        <option value="OR">Oregon</option>
                                                                        <option value="PA">Pennsylvania</option>
                                                                        <option value="RI">Rhode Island</option>
                                                                        <option value="SC">South Carolina</option>
                                                                        <option value="SD">South Dakota</option>
                                                                        <option value="TN">Tennessee</option>
                                                                        <option value="TX">Texas</option>
                                                                        <option value="UT">Utah</option>
                                                                        <option value="VT">Vermont</option>
                                                                        <option value="VA">Virginia</option>
                                                                        <option value="WA">Washington</option>
                                                                        <option value="WV">West Virginia</option>
                                                                        <option value="WI">Wisconsin</option>
                                                                        <option value="WY">Wyoming</option>
                                                                     </select>
                                                                  </div>
                                                               </div>
                                                               <div class="col-sm-4 mt-15" title="">
                                                                  <label class="main-label" for="companyApplicantInfo[0].address.postalCode">Zip Code <em>*</em></label>
                                                                  <div class="form-fields">
                                                                     <input type="text" id="companyApplicantInfo[0].address.postalCode" name="companyApplicantInfo[0].address.postalCode" value="" placeholder="Enter Zip Code" class="com-zipcode form-field" />
                                                                  </div>
                                                               </div>
                                                            </div>
                                                         </div>
                                                      </div>
                                                   </div>
   <!-- Current Address End -->
    
                                                </div>
                                             </div>
   <!-- Company applicant FinCEN ID Based Form End -->
                                                         
                                                      </div>
                                                   </div>
                                                </div>
                                             </div>
											 <p class="text-danger"id="formComErrorText" style="display:none">Please complete all mandatory fields before submitting. These fields are essential to process your request accurately.</p>
                                             <div class="sf-form-footer">
                                                <div class="row">
                                                   <aside class="col-sm-4 col-6 sf-foot-left">
                                                      <button class="brdr-btn" id="prev2">Previous</button>
                                                   </aside>
                                                   <aside class="col-sm-8 col-6 sf-foot-right">
                                                      <div class="sf-btns">
                                                         <button class="bg-btn loading-button" id="next3" type="submit" value="submit">
                                                            <span class="btn-text">Save & Proceed</span>
                                                            <div class="spinner"></div>
                                                         </button>
                                                      </div>
                                                   </aside>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </form>
                                    <div class="sf-btm-bar">
                                       <p><a class="hover-modal-btn" href="#boirNeedHelp21"><img src="images/Bell.png" alt="" /> PRIVACY ACT AND PAPERWORK REDUCTION ACT NOTICE</a></p>
                                    </div>
                                 </aside>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </section>
            </div>
            <!--step4-->
            <section class="page-cont">
               <div class="step" id="step4">
                  <div class="mid-content">
                     <div class="container">
                        <div class="cust-cf">
                           <!--<div class="notify-bar">
                              <p><img src="images/Bell.png"> Notification: Site Maintenance: BOI E-Filing System site will be unavailable for scheduled maintenance on June 21st, from 6:00 AM - 8:00 AM EST.</p>
                              </div>-->
                           <div class="breadcrumb-bar">
                              <div class="row">
                                 <aside class="col-sm-6 col-8 bb-left">
                                    <a href="#">BOI E-Filing</a>
                                    <a href="#">File BOIR</a>
                                 </aside>
                                 <aside class="col-sm-6 col-4 bb-right">
                                    <a href="#"><img src="images/help.png" alt=""> Help</a>
                                 </aside>
                              </div>
                           </div>
                        </div>
                        <h2>Beneficial Ownership Information Report (BOIR)</h2>
                        <p>Complete the report in its entirety with all required information. Fields marked with an asterisk (*) symbol are the fields that, at a minimum, must be completed by all companies to file the report. Reporting companies,
                           however, must include all information 31 CFR 1010.380(b) requires them to provide, regardless of whether a field is marked with an asterisk (*) symbol. These information requirements are summarized above under HELP.
                        </p>
                        <div class="step-form-main">
                           <div class="sf-top">
                              <h2>Step 4 of 7</h2>
                           </div>
						   <div class="sf-form-top" style="margin-bottom: 30px;">
						   		<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress4" style="width:50%; background-color:#B31942;">
						   					<span class="progress-percentage" id="progress-percentage4">50%</span>
						   				</div>
						   			</div>
						   		</div>
						   	</div>
							<!-- File size too small modal -->
							<div class="filelengthmodal modal fade" id="fileSizeTooLargeModal2[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
							   <div class="modal-dialog modal-fullscreen modal-dialog-centered">
							      <div class="container">
							         <div class="user-data-form step-form-modal modal-content">
							            <div class="modal-cont">
							               <h2>Oops! File Too Large</h2>
							               <p>It looks like your file is too big. Please upload a file that's 4MB or less.</p>
							               <div class="modal-btns step-mod-btns">
							                  <button type="button" class="blue-btn" data-bs-dismiss="modal" id="fileSizeTooSmallOk">Okay</button>
							               </div>
							            </div>
							         </div>
							      </div>
							   </div>
							</div>
                           <div class="sf-main">
                              <div class="row">
                                 <aside class="col-lg-3 sf-main-left">
                                    <ul>
                                       <li><a>Filing Information <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Reporting Company <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Company Applicant(s) <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li class="active"><a>Beneficial Owner(s)</a></li>
                                       <li><a>General Information</a></li>
                                       <li><a>Submitter Information</a></li>
                                       <li><a>Acknowledgement</a></li>
                                    </ul>
                                 </aside>
                                 <aside class="col-lg-9 sf-main-right">
                                    
                                    <form id="BeneficialForm" method="get" action="#">
                                       <div class="sf-form-sec">
                                          <div class="need-help-head nhh-top-align row">
                                            <aside class="nh-left col-md-10">
                                             <h2>Beneficial Owner Information</h2>
                                             <p>A Beneficial Owner is any person who <strong>owns 25% or more of the company, OR has substantial decision-making control on behalf of the company.</strong></p>
                                             <p>Please fill out the information for each individual who has such significant ownership or control.</p>
                                            </aside>
                                            <aside class="nh-right col-md-2">
                                             <span><a class="hover-modal-btn" href="#boirNeedHelp18"><img src="/images/help-icon.svg" alt=""></a></span>
                                            </aside>
                                            
                                          </div>
                                          <div>
                                             <div class="sf-btn-bar no-margin">
                                                <div class="row">
                                                   <aside class="col-sm-4 sf-foot-left">
                                                   </aside>
                                                   <aside class="col-sm-8 sf-foot-right">
                                                      <div class="sf-btns">
                                                         <button class="bg-btn" id="addBeneficial">Add Beneficial Owner</button>
                                                      </div>
                                                   </aside>
                                                </div>
                                             </div>
                                             <!-- <div class="sf-form-top"  title="">
 <h3><img src="images/help.png"> Need Help?</h3>
 </div>
                                             <br> -->
                                             <!--<div class="sf-btm-bar">
                                                <p> Beneficial Owner #1</p>
                                                <span><img src="images/arrow-down-white.png"></span>
                                                </div>-->
                                             <div class="accordion step-acc-sec" id="accordionExample1">
                                                <div class="accordion-item">
                                                   <h2 class="accordion-header no-margin">
                                                      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBeneficial0" aria-expanded="true" aria-controls="collapseBeneficial0">Beneficial Owner</button>
                                                   </h2>
                                                   <div class="sf-btn-bar no-margin"><button type="button" class="remove-beneficial bg-btn" data-beneficial="${beneficialCounter}" style="display: none;">Remove Beneficial Owner</button></div>
                                                   <div id="collapseBeneficial0" class="accordion-collapse collapse show" data-bs-parent="#accordionExample1">
                                                      <div class="accordion-body">
                                                         <p>Would you like to invite this beneficial owner to complete their information? 
                                                            <!--<button class="link-btn">Send them a link instead.</button>--></p>
                                                            <!-- Beneficial Owner Accordian Start -->
                                                            <div class="accordion def-acc-sec">
                                                               <!-- Send Form to Beneficial Owner Start -->
                                                               <div class="accordion-item box-bg-sec">  
                                                                  <div class="sf-form-body no-padding">
                                                                  <div id="benOwnerEmailField" class="form-rows pt-15" title="">
                                                                     <label class="main-label" for="beneficialOwner[0].benficialEmail">Send Form to Beneficial Owner</label>
                                                                     <div class="form-fields">
                                                                      <div class="normal-field col-sm-6">
                                                                        <input id="beneficialOwner[0].benficialEmail" data-index="0" name="beneficialOwner[0].benficialEmail" type="email" placeholder="Enter Beneficial Owner's Email" class="form-field ben-email" autocomplete="new-password">
                                                                        <input id="beneficialOwner[0].benficialEmailSentDate" name="beneficialOwner[0].benficialEmailSentDate" type="hidden" />
                                                                        <input id="beneficialOwner[0].beneficialTrackId" name="beneficialOwner[0].beneficialTrackId" type="hidden" />
                                                                        <input id="beneficialOwner[0].beneficialStatus" name="beneficialOwner[0].beneficialStatus" type="hidden" />
                                                                        <div class="check-field mt-15 mb-10">
                                                                      <label class="check-ben-lab">
                                                                       <input class="checkBeneficialEmail" type="checkbox" data-index="0" id="checkBenEmail0" value="beneficialEmailChecked" name="checkBenEmail0" style="margin-right:10px;" disabled>By checking on this below all fields will be disabled
                                                                      </label>
                                                                  </div>   
                                                                 </div>
                                                               </div>
                                                                 </div>
                                                                 </div>    
                                                               </div>  
                                                               <!-- Send Form to Beneficial Owner End -->
                                                             <div id="parentfinceid">
                                                               <!-- Send Form to Beneficial Owner Start -->
                                                               
                                                               <!-- Send Form to Beneficial Owner End -->
                                                               <!-- Provide Parent/Guardian Start -->
                                                            <div class="accordion-item box-bg-sec">
                                                              <div class="accordion-header row">
                                                               <div class="dah-left col-md-8"><h2>Beneficial Owner is a Minor – Provide Parent/Guardian Information Instead</h2></div>
                                                               <div class="dah-right col-md-4">
                                                                <span title=""><a class="hover-modal-btn" href="#boirNeedHelp11"><img src="/images/help-icon.svg" alt=""></a></span>
                                                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoOne" aria-expanded="true" aria-controls="collapseBoOne"></button>
                                                               </div>
                                                              </div>
                                                              <div id="collapseBoOne" class="accordion-collapse collapse show">
                                                                <div class="accordion-body">
                                                                  <div class="ab-top-para">
                                                                    <p>Select this option if the beneficial owner is a minor and you will be entering parent or guardian details instead.</p>
                                                                 </div>
                                                                 <div class="sf-form-body">
                                                                 <div class="form-rows mt-15 mb-0" title="">
                                                                 <input type="hidden" id="beneficialOwner[0].filingInfoId" name="beneficialOwner[0].filingInfoId" value="${filingInfoId}"/>
                                                                 <div class="form-fields">
                                                                   <div class="row">
                                                                      <label class="col-sm-3">
                                                                      <input type="radio" id="parentyes" name="beneficialOwner[0].isMinorChild" value="true" /> Yes
                                                                      </label>
                                                                      <label class="col-sm-3">
                                                                      <input type="radio" id="parentno" name="beneficialOwner[0].isMinorChild" value="false" checked/> No
                                                                      </label>
                                                                   </div>
                                                                 </div>
                                                                </div>
                                                               </div>
                                                               </div>
                                                             </div>
                                                            </div>
                                                            <!-- Provide Parent/Guardian End -->
                                                            
                                                            <!-- Beneficial Owner FinCEN ID Start -->
                                                            <div class="accordion-item box-bg-sec">
                                                              <div class="accordion-header row">
                                                               <div class="dah-left col-md-8"><h2>Beneficial Owner FinCEN ID</h2></div>
                                                               <div class="dah-right col-md-4">
                                                                <span title=""><a class="hover-modal-btn" href="#boirNeedHelp12"><img src="/images/help-icon.svg" alt=""></a></span>
                                                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoTwo" aria-expanded="true" aria-controls="collapseBoTwo"></button>
                                                               </div>
                                                              </div>
                                                              <div id="collapseBoTwo" class="accordion-collapse collapse show">
                                                                <div class="accordion-body">
                                                                  <div class="ab-top-para">
                                                                    <p>If the beneficial owner has a FinCEN ID, please enter it below to skip the remaining fields.</p>
                                                                 </div>
                                                                 <div class="sf-form-body">
                                                                  <div class="form-rows no-margin" title="">
                                                                    <label class="main-label" for="beneficialOwner[0].finCenId">FinCEN ID</label>
                                                                    <div class="form-fields">
                                                                      <div class="normal-field col-sm-6">
                                                                       <input id="beneficialOwner[0].finCenId" name="beneficialOwner[0].finCenId" type="text" placeholder="Enter FinCEN ID" class="ben-fincenid form-field" />
                                                                      </div>
                                                                    </div>
                                                                  </div>
                                                                  <div id="benficialnamefieldp2" style="display: none;"> 
                                                                     <div class="row">
                                                                        <div class="col-sm-6 mt-15" title="">
                                                                           <label class="main-label whsp" for="beneficialOwner[0].flegalName">Last name <em>*</em></label>
                                                                           <div class="form-fields">
                                                                              <input id="beneficialOwner[0].flegalName" name="beneficialOwner[0].flegalName" type="text" placeholder="Enter Last Name" class="ben-fincen-lname form-field" />
                                                                           </div>
                                                                        </div>
                                                                        <div class="col-sm-6 mt-15" title="">
                                                                          <label class="main-label" for="beneficialOwner[0].ffirstName">First name <em>*</em></label>
                                                                          <div class="form-fields">
                                                                           <input id="beneficialOwner[0].ffirstName" name="beneficialOwner[0].ffirstName" type="text" placeholder="Enter First Name" class="ben-fincen-fn form-field" />
                                                                          </div>
                                                                        </div>
                                                                        <div class="col-sm-12 mt-15">
                                                                          <p>Based on your FinCEN ID, all fields have been disabled. You are not required to fill them out here. However, please ensure to enter your First Name and Last Name for certificate generation.</p>
                                                                        </div>
                                                                     </div>
                                                                  </div>
                                                                 </div>
                                                                 
                                                               </div>
                                                             </div>
                                                            </div>
                                                            <!-- Beneficial Owner FinCEN ID End -->
                                                         </div>
                                                            <!-- Benificial Remaining Fields Start -->
<div id="benificialfinid">
   <!-- Benificial Remaining Fields Accordian Start -->
  <div class="accordion def-acc-sec">
   <!-- Exempt entity Start -->
  <div class="accordion-item box-bg-sec">
    <div class="accordion-header row">
     <div class="dah-left col-md-8"><h2>Exempt entity</h2></div>
     <div class="dah-right col-md-4">
      <span><a class="hover-modal-btn" href="#boirNeedHelp13"><img src="/images/help-icon.svg" alt=""></a></span>
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoThree" aria-expanded="true" aria-controls="collapseBoThree"></button>
     </div>
    </div>
    <div id="collapseBoThree" class="accordion-collapse collapse show">
      <div class="accordion-body">
        <div class="ab-top-para">
          <p>Exempt entity: Check this box if the beneficial owner holds its ownership interest in the reporting company exclusively through one or more exempt entities, and the name of that exempt entity or entities are being reported in lieu of the beneficial owner’s information.
			 </p>
       </div>
       <div class="sf-form-body">
         <div class="form-rows no-margin" title="">
           <label class="main-label">Exempt entity</label>
           <div class="form-fields">
              <div class="row">
                 <label class="col-sm-3">
                 <input type="radio" id="beneficialOwner[0].exemptEntity" name="beneficialOwner[0].exemptEntity" value="true" data-index="0" class="ben-exemptentity ben-exemptYes"/> Yes</label>
                 <label class="col-sm-3">
                 <input type="radio" id="beneficialOwner[0].exemptEntity" name="beneficialOwner[0].exemptEntity" value="false" class="ben-exemptentity" checked/> No</label>
              </div>
           </div>
         </div>
        </div>
     </div>
   </div>
  </div>
  <!-- Exempt entity End -->
   <!-- Form of identification and issuing jurisdiction Start -->
   <div class="benexemptidi">
   <div class="accordion-item box-bg-sec">
    <div class="accordion-header row">
     <div class="dah-left col-md-8"><h2>Form of identification and issuing jurisdiction</h2></div>
     <div class="dah-right col-md-4">
      <span title=""><a class="hover-modal-btn" href="#boirNeedHelp14"><img src="/images/help-icon.svg" alt=""></a></span>
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoFour" aria-expanded="true" aria-controls="collapseBoFour"></button>
     </div>
    </div>
    <div id="collapseBoFour" class="accordion-collapse collapse show">
      <div class="accordion-body">
         <div class="ab-top-para">
          <p>Please provide the company applicant's identification details and the jurisdiction that issued it. For a faster experience, you can use DocAI to quickly fill out your details by uploading your ID document.</p>
         </div>
           <div class="sf-form-body">
              
              <div class="row two-fields">
               <div class="col-sm-6 mt-15" title="">
                  <label for="beneficialOwner[0].identificationDocuments.documentType" class="main-label">Identifying document type <em>*</em></label>
                  <div class="form-fields">
                     <select class="ben-idt form-field" id="beneficialOwner[0].identificationDocuments.documentType" name="beneficialOwner[0].identificationDocuments.documentType">
                        <option value="">Select an ID type</option>
                        <option value="37">State issued driver's license</option>
                        <option value="38">State/local/tribe-issued ID</option>
                        <option value="39">U.S. passport</option>
                        <option value="40">Foreign passport</option>
                     </select>
                  </div>
               </div>
              <div class="col-sm-6 mt-15" title="">
               
               <div class="fileinput" >
                  <label class="main-label" for="beneficialOwner[0].identificationDocuments.document">Identifying document image <em>*</em></label>
                  <div class="form-fields">
                   <input type="file" class="ben-idi ben-file-input fileInput" id="beneficialOwner[0].identificationDocuments.document" name="beneficialOwner[0].identificationDocuments.document"/>
                   <input type="hidden"  id="beneficialOwner[0].identificationDocuments.documentPath" name="beneficialOwner[0].identificationDocuments.documentPath"/>
                   <input type="hidden"  id="beneficialOwner[0].identificationDocuments.documentName" name="beneficialOwner[0].identificationDocuments.documentName"/>
                   <span id="file-name-display" class="file-name-display benFileNameDisplay0" style="display:none;"></span>
                   <button class="blue-btn btn btn-four" style="font-size: 16px;line-height: normal;padding: 4px 10px;border-radius: 4px;" type="button" id="edit-button">Edit</button>
                  </div>
                 </div>

              </div>

              <div id="progressWrapperBen" style="display:none;">
                 <progress id="progressBarBen" value="0" max="100"></progress>
                 <span id="progressTextBen">0%</span>
              </div> 
                 <div class="col-sm-6 mt-15" title="">
                    <label class="main-label" for="beneficialOwner[0].identificationDocuments.documentNumber">Identifying document number <em>*</em></label>
                    <div class="form-fields">
                       <input type="text" name="beneficialOwner[0].identificationDocuments.documentNumber" id="beneficialOwner[0].identificationDocuments.documentNumber" placeholder="Enter Tax Identification number" class="ben-idn form-field" />
                    </div>
                 </div>
                 <div class="col-sm-6 mt-15" title="">
                    <label class="main-label" for="beneficialOwner[0].identificationDocuments.issuerCountry">Country/Jurisdiction <em>*</em></label>
                    <div class="form-fields">
                       <select class="ben-counjuri form-field" id="beneficialOwner[0].identificationDocuments.issuerCountry" name="beneficialOwner[0].identificationDocuments.issuerCountry">
                          <option value="">Select a country/jurisdiction</option>
                          <option value="US">United States of America</option>
                          <option value="AS">American Samoa</option>
                          <option value="GU">Guam</option>
                          <option value="MH">Marshall Islands</option>
                          <option value="FM">Micronesia, Federated States</option>
                          <option value="MP">Northern Mariana Islands</option>
                          <option value="PW">Palau</option>
                          <option value="PR">Puerto Rico</option>
                          <option value="VI">U.S. Virgin Islands</option>
                          <option value="AF">Afghanistan</option>
                          <option value="AX">Åland Islands</option>
                          <option value="AL">Albania</option>
                          <option value="DZ">Algeria</option>
                          <option value="AD">Andorra</option>
                          <option value="AO">Angola</option>
                          <option value="AI">Anguilla</option>
                          <option value="AQ">Antarctica</option>
                          <option value="AG">Antigua And Barbuda</option>
                          <option value="AR">Argentina</option>
                          <option value="AM">Armenia</option>
                          <option value="AW">Aruba</option>
                          <option value="AU">Australia</option>
                          <option value="AT">Austria</option>
                          <option value="AZ">Azerbaijan</option>
                          <option value="BS">Bahamas</option>
                          <option value="BH">Bahrain</option>
                          <option value="BD">Bangladesh</option>
                          <option value="BB">Barbados</option>
                          <option value="BY">Belarus</option>
                          <option value="BE">Belgium</option>
                          <option value="BZ">Belize</option>
                          <option value="BJ">Benin</option>
                          <option value="BM">Bermuda</option>
                          <option value="BT">Bhutan</option>
                          <option value="BO">Bolivia, Plurinational State Of</option>
                          <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
                          <option value="BA">Bosnia And Herzegovina</option>
                          <option value="BW">Botswana</option>
                          <option value="BV">Bouvet Island</option>
                          <option value="BR">Brazil</option>
                          <option value="IO">British Indian Ocean Territory</option>
                          <option value="BN">Brunei Darussalam</option>
                          <option value="BG">Bulgaria</option>
                          <option value="BF">Burkina Faso</option>
                          <option value="BI">Burundi</option>
                          <option value="KH">Cambodia</option>
                          <option value="CM">Cameroon</option>
                          <option value="CA">Canada</option>
                          <option value="CV">Cape Verde</option>
                          <option value="KY">Cayman Islands</option>
                          <option value="CF">Central African Republic</option>
                          <option value="TD">Chad</option>
                          <option value="CL">Chile</option>
                          <option value="CN">China</option>
                          <option value="CX">Christmas Island</option>
                          <option value="CC">Cocos (Keeling) Islands</option>
                          <option value="CO">Colombia</option>
                          <option value="KM">Comoros</option>
                          <option value="CG">Congo</option>
                          <option value="CD">Congo, The Democratic Republic Of The</option>
                          <option value="CK">Cook Islands</option>
                          <option value="CR">Costa Rica</option>
                          <option value="CI">Côte D'ivoire</option>
                          <option value="HR">Croatia</option>
                          <option value="CU">Cuba</option>
                          <option value="CW">Curaçao</option>
                          <option value="CY">Cyprus</option>
                          <option value="CZ">Czech Republic</option>
                          <option value="DK">Denmark</option>
                          <option value="DJ">Djibouti</option>
                          <option value="DM">Dominica</option>
                          <option value="DO">Dominican Republic</option>
                          <option value="EC">Ecuador</option>
                          <option value="EG">Egypt</option>
                          <option value="SV">El Salvador</option>
                          <option value="GQ">Equatorial Guinea</option>
                          <option value="ER">Eritrea</option>
                          <option value="EE">Estonia</option>
                          <option value="ET">Ethiopia</option>
                          <option value="FK">Falkland Islands (Malvinas)</option>
                          <option value="FO">Faroe Islands</option>
                          <option value="FJ">Fiji</option>
                          <option value="FI">Finland</option>
                          <option value="FR">France</option>
                          <option value="GF">French Guiana</option>
                          <option value="PF">French Polynesia</option>
                          <option value="TF">French Southern Territories</option>
                          <option value="GA">Gabon</option>
                          <option value="GM">Gambia</option>
                          <option value="GE">Georgia</option>
                          <option value="DE">Germany</option>
                          <option value="GH">Ghana</option>
                          <option value="GI">Gibraltar</option>
                          <option value="GR">Greece</option>
                          <option value="GL">Greenland</option>
                          <option value="GD">Grenada</option>
                          <option value="GP">Guadeloupe</option>
                          <option value="GT">Guatemala</option>
                          <option value="GG">Guernsey</option>
                          <option value="GN">Guinea</option>
                          <option value="GW">Guinea-bissau</option>
                          <option value="GY">Guyana</option>
                          <option value="HT">Haiti</option>
                          <option value="HM">Heard Island And Mcdonald Islands</option>
                          <option value="VA">Holy See (Vatican City State)</option>
                          <option value="HN">Honduras</option>
                          <option value="HK">Hong Kong</option>
                          <option value="HU">Hungary</option>
                          <option value="IS">Iceland</option>
                          <option value="IN">India</option>
                          <option value="ID">Indonesia</option>
                          <option value="IR">Iran, Islamic Republic Of</option>
                          <option value="IQ">Iraq</option>
                          <option value="IE">Ireland</option>
                          <option value="IM">Isle Of Man</option>
                          <option value="IL">Israel</option>
                          <option value="IT">Italy</option>
                          <option value="JM">Jamaica</option>
                          <option value="JP">Japan</option>
                          <option value="JE">Jersey</option>
                          <option value="JO">Jordan</option>
                          <option value="KZ">Kazakhstan</option>
                          <option value="KE">Kenya</option>
                          <option value="KI">Kiribati</option>
                          <option value="KP">Korea, Democratic People's Republic Of</option>
                          <option value="KR">Korea, Republic Of</option>
                          <option value="KW">Kuwait</option>
                          <option value="KG">Kyrgyzstan</option>
                          <option value="LA">Lao People's Democratic Republic</option>
                          <option value="LV">Latvia</option>
                          <option value="LB">Lebanon</option>
                          <option value="LS">Lesotho</option>
                          <option value="LR">Liberia</option>
                          <option value="LY">Libya</option>
                          <option value="LI">Liechtenstein</option>
                          <option value="LT">Lithuania</option>
                          <option value="LU">Luxembourg</option>
                          <option value="MO">Macao</option>
                          <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
                          <option value="MG">Madagascar</option>
                          <option value="MW">Malawi</option>
                          <option value="MY">Malaysia</option>
                          <option value="MV">Maldives</option>
                          <option value="ML">Mali</option>
                          <option value="MT">Malta</option>
                          <option value="MQ">Martinique</option>
                          <option value="MR">Mauritania</option>
                          <option value="MU">Mauritius</option>
                          <option value="YT">Mayotte</option>
                          <option value="MX">Mexico</option>
                          <option value="MD">Moldova, Republic Of</option>
                          <option value="MC">Monaco</option>
                          <option value="MN">Mongolia</option>
                          <option value="ME">Montenegro</option>
                          <option value="MS">Montserrat</option>
                          <option value="MA">Morocco</option>
                          <option value="MZ">Mozambique</option>
                          <option value="MM">Myanmar</option>
                          <option value="NA">Namibia</option>
                          <option value="NR">Nauru</option>
                          <option value="NP">Nepal</option>
                          <option value="NL">Netherlands</option>
                          <option value="NC">New Caledonia</option>
                          <option value="NZ">New Zealand</option>
                          <option value="NI">Nicaragua</option>
                          <option value="NE">Niger</option>
                          <option value="NG">Nigeria</option>
                          <option value="NU">Niue</option>
                          <option value="NF">Norfolk Island</option>
                          <option value="NO">Norway</option>
                          <option value="OM">Oman</option>
                          <option value="PK">Pakistan</option>
                          <option value="PS">Palestinian Territory, Occupied</option>
                          <option value="PA">Panama</option>
                          <option value="PG">Papua New Guinea</option>
                          <option value="PY">Paraguay</option>
                          <option value="PE">Peru</option>
                          <option value="PH">Philippines</option>
                          <option value="PN">Pitcairn</option>
                          <option value="PL">Poland</option>
                          <option value="PT">Portugal</option>
                          <option value="QA">Qatar</option>
                          <option value="RE">Réunion</option>
                          <option value="RO">Romania</option>
                          <option value="RU">Russian Federation</option>
                          <option value="RW">Rwanda</option>
                          <option value="BL">Saint Barthélemy</option>
                          <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
                          <option value="KN">Saint Kitts And Nevis</option>
                          <option value="LC">Saint Lucia</option>
                          <option value="MF">Saint Martin (french Part)</option>
                          <option value="PM">Saint Pierre And Miquelon</option>
                          <option value="VC">Saint Vincent And The Grenadines</option>
                          <option value="WS">Samoa</option>
                          <option value="SM">San Marino</option>
                          <option value="ST">Sao Tome And Principe</option>
                          <option value="SA">Saudi Arabia</option>
                          <option value="SN">Senegal</option>
                          <option value="RS">Serbia</option>
                          <option value="SC">Seychelles</option>
                          <option value="SL">Sierra Leone</option>
                          <option value="SG">Singapore</option>
                          <option value="SX">Sint Maarten (dutch Part)</option>
                          <option value="SK">Slovakia</option>
                          <option value="SI">Slovenia</option>
                          <option value="SB">Solomon Islands</option>
                          <option value="SO">Somalia</option>
                          <option value="ZA">South Africa</option>
                          <option value="GS">South Georgia And The South Sandwich Islands</option>
                          <option value="SS">South Sudan</option>
                          <option value="ES">Spain</option>
                          <option value="LK">Sri Lanka</option>
                          <option value="SD">Sudan</option>
                          <option value="SR">Suriname</option>
                          <option value="SJ">Svalbard And Jan Mayen</option>
                          <option value="SZ">Swaziland</option>
                          <option value="SE">Sweden</option>
                          <option value="CH">Switzerland</option>
                          <option value="SY">Syrian Arab Republic</option>
                          <option value="TW">Taiwan</option>
                          <option value="TJ">Tajikistan</option>
                          <option value="TZ">Tanzania, United Republic Of</option>
                          <option value="TH">Thailand</option>
                          <option value="TL">Timor-leste</option>
                          <option value="TG">Togo</option>
                          <option value="TK">Tokelau</option>
                          <option value="TO">Tonga</option>
                          <option value="TT">Trinidad And Tobago</option>
                          <option value="TN">Tunisia</option>
                          <option value="TR">Turkey</option>
                          <option value="TM">Turkmenistan</option>
                          <option value="TC">Turks And Caicos Islands</option>
                          <option value="TV">Tuvalu</option>
                          <option value="UG">Uganda</option>
                          <option value="UA">Ukraine</option>
                          <option value="AE">United Arab Emirates</option>
                          <option value="GB">United Kingdom</option>
                          <option value="UY">Uruguay</option>
                          <option value="UZ">Uzbekistan</option>
                          <option value="VU">Vanuatu</option>
                          <option value="VE">Venezuela, Bolivarian Republic Of</option>
                          <option value="VN">Viet Nam</option>
                          <option value="VG">Virgin Islands, British</option>
                          <option value="WF">Wallis And Futuna</option>
                          <option value="EH">Western Sahara</option>
                          <option value="YE">Yemen</option>
                          <option value="ZM">Zambia</option>
                          <option value="ZW">Zimbabwe</option>
                       </select>
                    </div>
                 </div>
                 
                    <div class="col-sm-6 mt-15" title="">
                       <label class="main-label" for="beneficialOwner[0].identificationDocuments.issuerState">State <em>*</em></label>
                       <div class="form-fields">
                          <select class="ben-state form-field" id="beneficialOwner[0].identificationDocuments.issuerState" name="beneficialOwner[0].identificationDocuments.issuerState">
                             <option value="">Select a State </option>
                             <option value="AL">Alabama</option>
                             <option value="AK">Alaska</option>
                             <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
                             <option value="AA">Armed Forces Americas (except Canada)</option>
                             <option value="AP">Armed Forces Pacific</option>
                             <option value="AZ">Arizona</option>
                             <option value="AR">Arkansas</option>
                             <option value="CA">California</option>
                             <option value="CO">Colorado</option>
                             <option value="CT">Connecticut</option>
                             <option value="DE">Delaware</option>
                             <option value="DC">District of Columbia</option>
                             <option value="FL">Florida</option>
                             <option value="GA">Georgia</option>
                             <option value="HI">Hawaii</option>
                             <option value="ID">Idaho</option>
                             <option value="IL">Illinois</option>
                             <option value="IN">Indiana</option>
                             <option value="IA">Iowa</option>
                             <option value="KS">Kansas</option>
                             <option value="KY">Kentucky</option>
                             <option value="LA">Louisiana</option>
                             <option value="ME">Maine</option>
                             <option value="MD">Maryland</option>
                             <option value="MA">Massachusetts</option>
                             <option value="MI">Michigan</option>
                             <option value="MN">Minnesota</option>
                             <option value="MS">Mississippi</option>
                             <option value="MO">Missouri</option>
                             <option value="MT">Montana</option>
                             <option value="NE">Nebraska</option>
                             <option value="NV">Nevada</option>
                             <option value="NH">New Hampshire</option>
                             <option value="NJ">New Jersey</option>
                             <option value="NM">New Mexico</option>
                             <option value="NY">New York</option>
                             <option value="NC">North Carolina</option>
                             <option value="ND">North Dakota</option>
                             <option value="OH">Ohio</option>
                             <option value="OK">Oklahoma</option>
                             <option value="OR">Oregon</option>
                             <option value="PA">Pennsylvania</option>
                             <option value="RI">Rhode Island</option>
                             <option value="SC">South Carolina</option>
                             <option value="SD">South Dakota</option>
                             <option value="TN">Tennessee</option>
                             <option value="TX">Texas</option>
                             <option value="UT">Utah</option>
                             <option value="VT">Vermont</option>
                             <option value="VA">Virginia</option>
                             <option value="WA">Washington</option>
                             <option value="WV">West Virginia</option>
                             <option value="WI">Wisconsin</option>
                             <option value="WY">Wyoming</option>
                          </select>
                       </div>
                    </div>
                    <div class="col-sm-6 mt-15" title="">
                       <label class="main-label" for="beneficialOwner[0].identificationDocuments.issuerLocalOrTribal">Local/Tribal <em>*</em></label>
                       <div class="form-fields">
                          <select class="ben-localtrib form-field" id="beneficialOwner[0].identificationDocuments.issuerLocalOrTribal" name="beneficialOwner[0].identificationDocuments.issuerLocalOrTribal" disabled>
                             <option value="">Select a local/tribal</option>
                             <option value="Absentee-Shawnee">Absentee-Shawnee Tribe of Indians of Oklahoma</option>
                             <option value="Agdaagux">Agdaagux Tribe of King Cove</option>
                             <option value="Agua Caliente">Agua Caliente Band of Cahuilla Indians of the Agua Caliente Indian Reservation, California</option>
                             <option value="Ak Chin">Ak-Chin Indian Community</option>
                             <option value="Akiachak">Akiachak Native Community</option>
                             <option value="Akiak">Akiak Native Community</option>
                             <option value="Alabama-Coushatta">Alabama-Coushatta Tribe of Texas</option>
                             <option value="Alabama-Quassarte Tribal Town">Alabama-Quassarte Tribal Town</option>
                             <option value="Alatna">Alatna Village</option>
                             <option value="Algaaciq">Algaaciq Native Village (St. Mary's)</option>
                             <option value="Allakaket">Allakaket Village</option>
                             <option value="Alturas">Alturas Indian Rancheria, California</option>
                             <option value="Alutiiq Tribe of Old Harbor">Alutiiq Tribe of Old Harbor</option>
                             <option value="Angoon">Angoon Community Association</option>
                             <option value="Anvik">Anvik Village</option>
                             <option value="Apache">Apache Tribe of Oklahoma</option>
                             <option value="Arctic Village">Arctic Village (See Native Village of Venetie Tribal Government)</option>
                             <option value="Asa'carsarmiut">Asa'carsarmiut Tribe</option>
                             <option value="Assiniboine and Sioux">Assiniboine &amp; Sioux Tribes of the Fort Peck Indian Reservation, Montana</option>
                             <option value="Augustine">Augustine Band of Cahuilla Indians, California</option>
                             <option value="Bad River Band">Bad River Band of the Lake Superior Tribe of Chippewa Indians of the Bad River Reservation, Wisconsin</option>
                             <option value="Bay Mills">Bay Mills Indian Community, Michigan</option>
                             <option value="Bear River">Bear River Band of the Rohnerville Rancheria, California</option>
                             <option value="Beaver">Beaver Village</option>
                             <option value="Berry Creek">Berry Creek Rancheria of Maidu Indians of California</option>
                             <option value="Big Lagoon">Big Lagoon Rancheria, California</option>
                             <option value="Big Pine Reservation">Big Pine Paiute Tribe of the Owens Valley</option>
                             <option value="Big Sandy">Big Sandy Rancheria of Western Mono Indians of California</option>
                             <option value="Big Valley Rancheria">Big Valley Band of Pomo Indians of the Big Valley Rancheria, California</option>
                             <option value="Birch Creek">Birch Creek Tribe</option>
                             <option value="Bishop Paiute">Bishop Paiute Tribe</option>
                             <option value="Blackfeet">Blackfeet Tribe of the Blackfeet Indian Reservation of Montana</option>
                             <option value="Blue Lake">Blue Lake Rancheria, California</option>
                             <option value="Bridgeport Indian Colony">Bridgeport Indian Colony</option>
                             <option value="Buena Vista Rancheria">Buena Vista Rancheria of Me-Wuk Indians of California</option>
                             <option value="Burns Paiute">Burns Paiute Tribe</option>
                             <option value="Cabazon">Cabazon Band of Mission Indians, California</option>
                             <option value="Cachil DeHe">Cachil DeHe Band of Wintun Indians of the Colusa Indian Community of the Colusa Rancheria, California</option>
                             <option value="Caddo">Caddo Nation of Oklahoma</option>
                             <option value="Cahto">Cahto Tribe of the Laytonville Rancheria</option>
                             <option value="Cahuilla">Cahuilla Band of Indians</option>
                             <option value="California Valley">California Valley Miwok Tribe, California</option>
                             <option value="Campo">Campo Band of Diegueno Mission Indians of the Campo Indian Reservation, California</option>
                             <option value="Capitan Grande">Capitan Grande Band of Diegueno Mission Indians of California (Barona Group of Capitan Grande Band of Mission Indians of the Barona Reservation, California)</option>
                             <option value="Capitan Grande Band">Capitan Grande Band of Diegueno Mission Indians of California</option>
                             <option value="Viejas">Capitan Grande Band of Diegueno Mission Indians of California: Viejas (Baron Long) Group of Capitan Grande Band of Mission Indians of the Viejas Reservation, California</option>
                             <option value="Catawba">Catawba Indian Nation (aka Catawba Indian Tribe of South Carolina)</option>
                             <option value="Cayuga Nation of New York">Cayuga Nation</option>
                             <option value="Cedarville">Cedarville Rancheria, California</option>
                             <option value="Tlingit &amp; Haida">Central Council of the Tlingit &amp; Haida Indian Tribes</option>
                             <option value="Chalkyitsik">Chalkyitsik Village</option>
                             <option value="Cheesh-Na">Cheesh-Na Tribe</option>
                             <option value="Chemehuevi">Chemehuevi Indian Tribe of the Chemehuevi Reservation, California</option>
                             <option value="Cher-Ae Heights">Cher-Ae Heights Indian Community of the Trinidad Rancheria, California</option>
                             <option value="Cherokee Nation">Cherokee Nation</option>
                             <option value="Chevak">Chevak Native Village</option>
                             <option value="Cheyenne River">Cheyenne and Arapaho Tribes, Oklahoma</option>
                             <option value="Cheyenne River Sioux Tribe">Cheyenne River Sioux Tribe of the Cheyenne River Reservation, South Dakota</option>
                             <option value="Chickahominy Indians-Eastern Division">Chickahominy Indian Tribe - Eastern Division</option>
                             <option value="Chickahominy Indian Tribe, Inc.">Chickahominy Indian Tribe</option>
                             <option value="Chickaloon">Chickaloon Native Village</option>
                             <option value="Chicken Ranch">Chicken Ranch Rancheria of Me-Wuk Indians of California</option>
                             <option value="Chignik Bay">Chignik Bay Tribal Council</option>
                             <option value="Chignik Lake">Chignik Lake Village</option>
                             <option value="Chilkat">Chilkat Indian Village (Klukwan)</option>
                             <option value="Chilkoot">Chilkoot Indian Association (Haines)</option>
                             <option value="Chinik">Chinik Eskimo Community (Golovin)</option>
                             <option value="Chippewa-Cree">Chippewa Cree Indians of the Rocky Boy's Reservation, Montana</option>
                             <option value="Chitimacha">Chitimacha Tribe of Louisiana</option>
                             <option value="Chuloonawick">Chuloonawick Native Village</option>
                             <option value="Circle">Circle Native Community</option>
                             <option value="Citizen Potawatomi">Citizen Potawatomi Nation, Oklahoma</option>
                             <option value="Cloverdale">Cloverdale Rancheria of Pomo Indians of California</option>
                             <option value="Cocopah">Cocopah Tribe of Arizona</option>
                             <option value="Coeur D'Alene">Coeur D'Alene Tribe</option>
                             <option value="Cold Springs">Cold Springs Rancheria of Mono Indians of California</option>
                             <option value="Colorado River">Colorado River Indian Tribes of the Colorado River Indian Reservation, Arizona and California</option>
                             <option value="Comanche">Comanche Nation, Oklahoma</option>
                             <option value="Confederated Salish">Confederated Salish and Kootenai Tribes of the Flathead Reservation</option>
                             <option value="Confederated Yakama">Confederated Tribes and Bands of the Yakama Nation</option>
                             <option value="Siletz Tribe">Confederated Tribes of Siletz Indians of Oregon</option>
                             <option value="Chehalis">Confederated Tribes of the Chehalis Reservation</option>
                             <option value="Confederated Colville">Confederated Tribes of the Colville Reservation</option>
                             <option value="Confederated Coos">Confederated Tribes of the Coos, Lower Umpqua and Siuslaw Indians</option>
                             <option value="Confederated Goshute">Confederated Tribes of the Goshute Reservation, Nevada and Utah</option>
                             <option value="Grand Ronde Tribes">Confederated Tribes of the Grand Ronde Community of Oregon</option>
                             <option value="Umatilla Tribe">Confederated Tribes of the Umatilla Indian Reservation</option>
                             <option value="Warms Springs Tribe">Confederated Tribes of the Warm Springs Reservation of Oregon</option>
                             <option value="Coquille">Coquille Indian Tribe</option>
                             <option value="Coushatta">Coushatta Tribe of Louisiana</option>
                             <option value="Cow Creek">Cow Creek Band of Umpqua Tribe of Indians</option>
                             <option value="Cowlitz">Cowlitz Indian Tribe</option>
                             <option value="Coyote Valley">Coyote Valley Band of Pomo Indians of California</option>
                             <option value="Craig">Craig Tribal Association</option>
                             <option value="Crow Creek">Crow Creek Sioux Tribe of the Crow Creek Reservation, South Dakota</option>
                             <option value="Crow">Crow Tribe of Montana</option>
                             <option value="Curyung">Curyung Tribal Council</option>
                             <option value="Delaware Nation">Delaware Nation, Oklahoma</option>
                             <option value="Delaware Tribe of Indians">Delaware Tribe of Indians</option>
                             <option value="Douglas">Douglas Indian Association</option>
                             <option value="Dry Creek">Dry Creek Rancheria Band of Pomo Indians, California</option>
                             <option value="Duckwater">Duckwater Shoshone Tribe of the Duckwater Reservation, Nevada</option>
                             <option value="Eastern Cherokee">Eastern Band of Cherokee Indians</option>
                             <option value="Eastern Shawnee Tribe of Oklahoma">Eastern Shawnee Tribe of Oklahoma</option>
                             <option value="Eastern Shoshone">Eastern Shoshone Tribe of the Wind River Reservation, Wyoming</option>
                             <option value="Egegik">Egegik Village</option>
                             <option value="Eklutna">Eklutna Native Village</option>
                             <option value="Elem">Elem Indian Colony of Pomo Indians of the Sulphur Bank Rancheria, California</option>
                             <option value="Elk Valley">Elk Valley Rancheria, California</option>
                             <option value="Ely Shoshone">Ely Shoshone Tribe of Nevada</option>
                             <option value="Emmonak">Emmonak Village</option>
                             <option value="Enterprise">Enterprise Rancheria of Maidu Indians of California</option>
                             <option value="Evansville">Evansville Village (aka Bettles Field)</option>
                             <option value="Ewiiaapaayp">Ewiiaapaayp Band of Kumeyaay Indians, California</option>
                             <option value="Federated Indians of Graton">Federated Indians of Graton Rancheria, California</option>
                             <option value="Flandreau">Flandreau Santee Sioux Tribe of South Dakota</option>
                             <option value="Forest County">Forest County Potawatomi Community, Wisconsin</option>
                             <option value="Assiniboine and Gros Ventre Tribes">Fort Belknap Indian Community of the Fort Belknap Reservation of Montana</option>
                             <option value="Fort Bidwell">Fort Bidwell Indian Community of the Fort Bidwell Reservation of California</option>
                             <option value="Fort Independence">Fort Independence Indian Community of Paiute Indians of the Fort Independence Reservation, California</option>
                             <option value="Fort McDermitt">Fort McDermitt Paiute and Shoshone Tribes of the Fort McDermitt Indian Reservation, Nevada and Oregon</option>
                             <option value="Fort McDowell">Fort McDowell Yavapai Nation, Arizona</option>
                             <option value="Fort Mojave">Fort Mojave Indian Tribe of Arizona, California &amp; Nevada</option>
                             <option value="Fort Sill">Fort Sill Apache Tribe of Oklahoma</option>
                             <option value="Galena">Galena Village (aka Louden Village)</option>
                             <option value="Gila River">Gila River Indian Community of the Gila River Indian Reservation, Arizona</option>
                             <option value="Grand Traverse">Grand Traverse Band of Ottawa and Chippewa Indians, Michigan</option>
                             <option value="Greenville">Greenville Rancheria</option>
                             <option value="Grindstone">Grindstone Indian Rancheria of Wintun-Wailaki Indians of California</option>
                             <option value="Guidiville">Guidiville Rancheria of California</option>
                             <option value="Gulkana">Gulkana Village Council</option>
                             <option value="Habematolel">Habematolel Pomo of Upper Lake, California</option>
                             <option value="Hannahville">Hannahville Indian Community, Michigan</option>
                             <option value="Havasupai">Havasupai Tribe of the Havasupai Reservation, Arizona</option>
                             <option value="Healy Lake">Healy Lake Village</option>
                             <option value="Ho-Chunk">Ho-Chunk Nation of Wisconsin</option>
                             <option value="Hoh">Hoh Indian Tribe</option>
                             <option value="Holy Cross">Holy Cross Tribe</option>
                             <option value="Hoonah">Hoonah Indian Association</option>
                             <option value="Hoopa">Hoopa Valley Tribe, California</option>
                             <option value="Hopi">Hopi Tribe of Arizona</option>
                             <option value="Hopland">Hopland Band of Pomo Indians, California</option>
                             <option value="Houlton">Houlton Band of Maliseet Indians</option>
                             <option value="Hualapai">Hualapai Indian Tribe of the Hualapai Indian Reservation, Arizona</option>
                             <option value="Hughes">Hughes Village</option>
                             <option value="Huslia">Huslia Village</option>
                             <option value="Hydaburg">Hydaburg Cooperative Association</option>
                             <option value="Igiugig">Igiugig Village</option>
                             <option value="Iipay">Iipay Nation of Santa Ysabel, California</option>
                             <option value="Inaja">Inaja Band of Diegueno Mission Indians of the Inaja and Cosmit Reservation, California</option>
                             <option value="Inupiat Community of the Arctic Slope">Inupiat Community of the Arctic Slope</option>
                             <option value="Ione">Ione Band of Miwok Indians of California</option>
                             <option value="Iowa of Kansas">Iowa Tribe of Kansas and Nebraska</option>
                             <option value="Iowa of Oklahoma">Iowa Tribe of Oklahoma</option>
                             <option value="Iqugmiut">Iqugmiut Traditional Council</option>
                             <option value="Ivanof Bay Tribe">Ivanof Bay Tribe</option>
                             <option value="Jackson">Jackson Band of Miwuk Indians</option>
                             <option value="Jamestown">Jamestown S'Klallam Tribe</option>
                             <option value="Jamul">Jamul Indian Village of California</option>
                             <option value="Jena">Jena Band of Choctaw Indians</option>
                             <option value="Jicarilla">Jicarilla Apache Nation, New Mexico</option>
                             <option value="Kaguyuk">Kaguyak Village</option>
                             <option value="Kaibab">Kaibab Band of Paiute Indians of the Kaibab Indian Reservation, Arizona</option>
                             <option value="Kaktovik">Kaktovik Village (aka Barter Island)</option>
                             <option value="Kalispel">Kalispel Indian Community of the Kalispel Reservation</option>
                             <option value="Karuk">Karuk Tribe</option>
                             <option value="Kashia">Kashia Band of Pomo Indians of the Stewarts Point Rancheria, California</option>
                             <option value="Kasigluk">Kasigluk Traditional Elders Council</option>
                             <option value="Kaw">Kaw Nation, Oklahoma</option>
                             <option value="Kenaitze">Kenaitze Indian Tribe</option>
                             <option value="Ketchikan">Ketchikan Indian Community</option>
                             <option value="Keweenaw">Keweenaw Bay Indian Community, Michigan</option>
                             <option value="Kialegee Tribal Town">Kialegee Tribal Town</option>
                             <option value="Kickapoo of Texas">Kickapoo Traditional Tribe of Texas</option>
                             <option value="Kickapoo Tribe in Kansas">Kickapoo Tribe of Indians of the Kickapoo Reservation in Kansas</option>
                             <option value="Kickapoo of Oklahoma">Kickapoo Tribe of Oklahoma</option>
                             <option value="King Island">King Island Native Community</option>
                             <option value="King Salmon">King Salmon Tribe</option>
                             <option value="Kiowa Tribe">Kiowa  Indian Tribe of Oklahoma</option>
                             <option value="Klamath">Klamath Tribes</option>
                             <option value="Klawock">Klawock Cooperative Association</option>
                             <option value="Cortina">Kletsel Dehe Band of Wintun Indians</option>
                             <option value="Knik">Knik Tribe</option>
                             <option value="Koi">Koi Nation of Northern California</option>
                             <option value="Kokhanok">Kokhanok Village</option>
                             <option value="Kootenai">Kootenai Tribe of Idaho</option>
                             <option value="Koyukuk">Koyukuk Native Village</option>
                             <option value="La Jolla">La Jolla Band of Luiseno Indians, California</option>
                             <option value="La Posta">La Posta Band of Diegueno Mission Indians of the La Posta Indian Reservation, California</option>
                             <option value="Lac Courte Oreilles">Lac Courte Oreilles Band of Lake Superior Chippewa Indians of Wisconsin</option>
                             <option value="Lac du Flambeau">Lac du Flambeau Band of Lake Superior Chippewa Indians of the Lac du Flambeau Reservation of Wisconsin</option>
                             <option value="Lac Vieux">Lac Vieux Desert Band of Lake Superior Chippewa Indians of Michigan</option>
                             <option value="Las Vegas">Las Vegas Tribe of Paiute Indians of the Las Vegas Indian Colony, Nevada</option>
                             <option value="Levelock">Levelock Village</option>
                             <option value="Lime">Lime Village</option>
                             <option value="Little River">Little River Band of Ottawa Indians, Michigan</option>
                             <option value="Little Shell Tribe">Little Shell Tribe of Chippewa Indians of Montana</option>
                             <option value="Little Traverse">Little Traverse Bay Bands of Odawa Indians, Michigan</option>
                             <option value="Lone Pine">Lone Pine Paiute-Shoshone Tribe</option>
                             <option value="Los Coyotes">Los Coyotes Band of Cahuilla and Cupeno Indians, California</option>
                             <option value="Lovelock">Lovelock Paiute Tribe of the Lovelock Indian Colony, Nevada</option>
                             <option value="Lower Brule">Lower Brule Sioux Tribe of the Lower Brule Reservation, South Dakota</option>
                             <option value="Lower Elwha">Lower Elwha Tribal Community</option>
                             <option value="Lower Sioux">Lower Sioux Indian Community in the State of Minnesota</option>
                             <option value="Lummi">Lummi Tribe of the Lummi Reservation</option>
                             <option value="Lytton">Lytton Rancheria of California</option>
                             <option value="Makah">Makah Indian Tribe of the Makah Indian Reservation</option>
                             <option value="Manchester">Manchester Band of Pomo Indians of the Manchester Rancheria, California</option>
                             <option value="Manley Hot Springs">Manley Hot Springs Village</option>
                             <option value="Manokotak">Manokotak Village</option>
                             <option value="Manzanita">Manzanita Band of Diegueno Mission Indians of the Manzanita Reservation, California</option>
                             <option value="Mashantucket Pequot">Mashantucket Pequot Indian Tribe</option>
                             <option value="Mashpee">Mashpee Wampanoag Tribe</option>
                             <option value="Match-e-be-nash-she-wish Band">Match-e-be-nash-she-wish Band of Pottawatomi Indians of Michigan</option>
                             <option value="Mcgrath">McGrath Native Village</option>
                             <option value="Mechoopda">Mechoopda Indian Tribe of Chico Rancheria, California</option>
                             <option value="Menominee">Menominee Indian Tribe of Wisconsin</option>
                             <option value="Mentasta">Mentasta Traditional Council</option>
                             <option value="Mesa Grande">Mesa Grande Band of Diegueno Mission Indians of the Mesa Grande Reservation, California</option>
                             <option value="Mescalero Apache">Mescalero Apache Tribe of the Mescalero Reservation, New Mexico</option>
                             <option value="Metlakatla">Metlakatla Indian Community, Annette Island Reserve</option>
                             <option value="Miami Tribe of Oklahoma">Miami Tribe of Oklahoma</option>
                             <option value="Miccosukee">Miccosukee Tribe of Indians</option>
                             <option value="Middletown">Middletown Rancheria of Pomo Indians of California</option>
                             <option value="Mi'kmaq Nation">Mi'kmaq Nation</option>
                             <option value="Bois Forte">Minnesota Chippewa Tribe - Bois Forte Band (Nett Lake)</option>
                             <option value="Fond du Lac">Minnesota Chippewa Tribe - Fond du Lac Band</option>
                             <option value="Grand Portage">Minnesota Chippewa Tribe - Grand Portage Band</option>
                             <option value="Leech Lake">Minnesota Chippewa Tribe - Leech Lake Band</option>
                             <option value="Mille Lacs">Minnesota Chippewa Tribe - Mille Lacs Band</option>
                             <option value="White Earth">Minnesota Chippewa Tribe - White Earth Band</option>
                             <option value="Minnesota Chippewa">Minnesota Chippewa Tribe, Minnesota</option>
                             <option value="Mississippi Choctaw">Mississippi Band of Choctaw Indians</option>
                             <option value="Moapa">Moapa Band of Paiute Indians of the Moapa River Indian Reservation, Nevada</option>
                             <option value="Modoc Nation">Modoc Nation</option>
                             <option value="Mohegan">Mohegan Tribe of Indians of Connecticut</option>
                             <option value="Monacan Indian Nation">Monacan Indian Nation</option>
                             <option value="Mooretown">Mooretown Rancheria of Maidu Indians of California</option>
                             <option value="Morongo">Morongo Band of Mission Indians, California</option>
                             <option value="Muckleshoot">Muckleshoot Indian Tribe</option>
                             <option value="Naknek">Naknek Native Village</option>
                             <option value="Nansemond Indian Tribe">Nansemond Indian Nation</option>
                             <option value="Narragansett">Narragansett Indian Tribe</option>
                             <option value="Afognak">Native Village of Afognak</option>
                             <option value="Akhiok">Native Village of Akhiok</option>
                             <option value="Akutan">Native Village of Akutan</option>
                             <option value="Aleknagik">Native Village of Aleknagik</option>
                             <option value="Ambler">Native Village of Ambler</option>
                             <option value="Atka">Native Village of Atka</option>
                             <option value="Native Village of Atqasuk">Native Village of Atqasuk</option>
                             <option value="Barrow">Native Village of Barrow Inupiat Traditional Government</option>
                             <option value="Belkofski">Native Village of Belkofski</option>
                             <option value="Brevig Mission">Native Village of Brevig Mission</option>
                             <option value="Buckland">Native Village of Buckland</option>
                             <option value="Cantwell">Native Village of Cantwell</option>
                             <option value="Chenega">Native Village of Chenega (aka Chanega)</option>
                             <option value="Chignik Lagoon">Native Village of Chignik Lagoon</option>
                             <option value="Chitina">Native Village of Chitina</option>
                             <option value="Chuathbaluk">Native Village of Chuathbaluk (Russian Mission, Kuskokwim)</option>
                             <option value="Council">Native Village of Council</option>
                             <option value="Deering">Native Village of Deering</option>
                             <option value="Diomede">Native Village of Diomede (aka Inalik)</option>
                             <option value="Eagle">Native Village of Eagle</option>
                             <option value="Eek">Native Village of Eek</option>
                             <option value="Ekuk">Native Village of Ekuk</option>
                             <option value="Ekwok">Native Village of Ekwok</option>
                             <option value="Elim IRA">Native Village of Elim</option>
                             <option value="Eyak">Native Village of Eyak (Cordova)</option>
                             <option value="False Pass">Native Village of False Pass</option>
                             <option value="Fort Yukon">Native Village of Fort Yukon</option>
                             <option value="Gakona">Native Village of Gakona</option>
                             <option value="Gambell">Native Village of Gambell</option>
                             <option value="Georgetown">Native Village of Georgetown</option>
                             <option value="Goodnews Bay">Native Village of Goodnews Bay</option>
                             <option value="Hamilton">Native Village of Hamilton</option>
                             <option value="Hooper Bay">Native Village of Hooper Bay</option>
                             <option value="Kanatak">Native Village of Kanatak</option>
                             <option value="Karluk">Native Village of Karluk</option>
                             <option value="Kiana">Native Village of Kiana</option>
                             <option value="Kipnuk">Native Village of Kipnuk</option>
                             <option value="Kivalina">Native Village of Kivalina</option>
                             <option value="Kluti Kaah">Native Village of Kluti Kaah (aka Copper Center)</option>
                             <option value="Kobuk">Native Village of Kobuk</option>
                             <option value="Kongiganak">Native Village of Kongiganak</option>
                             <option value="Kotzebue">Native Village of Kotzebue</option>
                             <option value="Koyuk">Native Village of Koyuk</option>
                             <option value="Kwigillingok">Native Village of Kwigillingok</option>
                             <option value="Kwinhagak">Native Village of Kwinhagak (aka Quinhagak)</option>
                             <option value="Larsen Bay">Native Village of Larsen Bay</option>
                             <option value="Marshall">Native Village of Marshall (aka Fortuna Ledge)</option>
                             <option value="Mary's Igloo">Native Village of Mary's Igloo</option>
                             <option value="Mekoryuk">Native Village of Mekoryuk</option>
                             <option value="Minto">Native Village of Minto</option>
                             <option value="Nanwalek">Native Village of Nanwalek (aka English Bay)</option>
                             <option value="Napaimute">Native Village of Napaimute</option>
                             <option value="Napakiak">Native Village of Napakiak</option>
                             <option value="Napaskiak">Native Village of Napaskiak</option>
                             <option value="Nelson Lagoon">Native Village of Nelson Lagoon</option>
                             <option value="Nightmute">Native Village of Nightmute</option>
                             <option value="Nikolski">Native Village of Nikolski</option>
                             <option value="Noatak">Native Village of Noatak</option>
                             <option value="Nuiqsut">Native Village of Nuiqsut (aka Nooiksut)</option>
                             <option value="Nunam Iqua">Native Village of Nunam Iqua</option>
                             <option value="Nunapitchuk">Native Village of Nunapitchuk</option>
                             <option value="Ouzinkie">Native Village of Ouzinkie</option>
                             <option value="Paimiut">Native Village of Paimiut</option>
                             <option value="Perryville">Native Village of Perryville</option>
                             <option value="Pilot Point">Native Village of Pilot Point</option>
                             <option value="Point Hope IRA">Native Village of Point Hope</option>
                             <option value="Point Lay IRA">Native Village of Point Lay</option>
                             <option value="Port Graham">Native Village of Port Graham</option>
                             <option value="Port Heiden">Native Village of Port Heiden</option>
                             <option value="Port Lions">Native Village of Port Lions</option>
                             <option value="Ruby">Native Village of Ruby</option>
                             <option value="St. Michael IRA">Native Village of Saint Michael</option>
                             <option value="Savoonga">Native Village of Savoonga</option>
                             <option value="Scammon Bay">Native Village of Scammon Bay</option>
                             <option value="Selawik">Native Village of Selawik</option>
                             <option value="Shaktoolik">Native Village of Shaktoolik</option>
                             <option value="Shishmaref IRA">Native Village of Shishmaref</option>
                             <option value="Shungnak">Native Village of Shungnak</option>
                             <option value="Stevens Village">Native Village of Stevens</option>
                             <option value="Tanacross">Native Village of Tanacross</option>
                             <option value="Tanana">Native Village of Tanana</option>
                             <option value="Tatitlek">Native Village of Tatitlek</option>
                             <option value="Tazlina">Native Village of Tazlina</option>
                             <option value="Teller">Native Village of Teller</option>
                             <option value="Tetlin">Native Village of Tetlin</option>
                             <option value="Tuntutuliak">Native Village of Tuntutuliak</option>
                             <option value="Tununak">Native Village of Tununak</option>
                             <option value="Tyonek">Native Village of Tyonek</option>
                             <option value="Unalakleet">Native Village of Unalakleet</option>
                             <option value="Unga">Native Village of Unga</option>
                             <option value="Venetie IRA">Native Village of Venetie Tribal Government (Arctic Village and Village of Venetie)</option>
                             <option value="Wales">Native Village of Wales</option>
                             <option value="White Mountain AK">Native Village of White Mountain</option>
                             <option value="Navajo">Navajo Nation, Arizona, New Mexico &amp; Utah</option>
                             <option value="Nenana">Nenana Native Association</option>
                             <option value="New Koliganek">New Koliganek Village Council</option>
                             <option value="New Stuyahok">New Stuyahok Village</option>
                             <option value="Newhalen">Newhalen Village</option>
                             <option value="Newtok">Newtok Village</option>
                             <option value="Nez Perce">Nez Perce Tribe</option>
                             <option value="Nikolai">Nikolai Village</option>
                             <option value="Ninilchik">Ninilchik Village</option>
                             <option value="Nisqually">Nisqually Indian Tribe</option>
                             <option value="Nome">Nome Eskimo Community</option>
                             <option value="Nondalton">Nondalton Village</option>
                             <option value="Nooksack">Nooksack Indian Tribe</option>
                             <option value="Noorvik">Noorvik Native Community</option>
                             <option value="Northern Arapaho">Northern Arapaho Tribe of the Wind River Reservation, Wyoming</option>
                             <option value="Northern Cheyenne">Northern Cheyenne Tribe of the Northern Cheyenne Indian Reservation, Montana</option>
                             <option value="North Fork">Northfork Rancheria of Mono Indians of California</option>
                             <option value="Northway">Northway Village</option>
                             <option value="Northwestern Shoshone">Northwestern Band of the Shoshone Nation</option>
                             <option value="Nottawaseppi Potawatomi">Nottawaseppi Huron Band of the Potawatomi, Michigan</option>
                             <option value="Nulato">Nulato Village</option>
                             <option value="Nunakauyarmiut">Nunakauyarmiut Tribe</option>
                             <option value="Oglala Sioux">Oglala Sioux Tribe</option>
                             <option value="Ohkay Owingeh">Ohkay Owingeh, New Mexico</option>
                             <option value="Omaha">Omaha Tribe of Nebraska</option>
                             <option value="Oneida">Oneida Indian Nation</option>
                             <option value="Oneida Nation (Wisconsin)">Oneida Nation</option>
                             <option value="Onondaga">Onondaga Nation</option>
                             <option value="Grayling">Organized Village of Grayling (aka Holikachuk)</option>
                             <option value="Kake">Organized Village of Kake</option>
                             <option value="Kasaan">Organized Village of Kasaan</option>
                             <option value="Kwethluk">Organized Village of Kwethluk</option>
                             <option value="Saxman">Organized Village of Saxman</option>
                             <option value="Orutsararmiut">Orutsararmiut Traditional Native Council</option>
                             <option value="Oscarville">Oscarville Traditional Village</option>
                             <option value="Otoe-Missouria">Otoe-Missouria Tribe of Indians, Oklahoma</option>
                             <option value="Ottawa Tribe of Oklahoma">Ottawa Tribe of Oklahoma</option>
                             <option value="Paiute of Utah">Paiute Indian Tribe of Utah (Cedar Band of Paiutes, Kanosh Band of Paiutes, Koosharem Band of Paiutes, Indian Peaks Band of Paiutes, and Shivwits Band of Paiutes)</option>
                             <option value="Paiute-Shoshone">Paiute-Shoshone Tribe of the Fallon Reservation and Colony, Nevada</option>
                             <option value="Pala">Pala Band of Mission Indians</option>
                             <option value="Pamunkey Indian Tribe">Pamunkey Indian Tribe</option>
                             <option value="Pascua Yaqui">Pascua Yaqui Tribe of Arizona</option>
                             <option value="Paskenta">Paskenta Band of Nomlaki Indians of California</option>
                             <option value="Passamaquoddy Indian Township">Passamaquoddy Tribe - Indian Township</option>
                             <option value="Passamaquoddy Pleasant Point">Passamaquoddy Tribe - Pleasant Point</option>
                             <option value="Passamaquoddy Tribe">Passamaquoddy Tribe</option>
                             <option value="Pauloff Harbor">Pauloff Harbor Village</option>
                             <option value="Pauma">Pauma Band of Luiseno Mission Indians of the Pauma &amp; Yuima Reservation, California</option>
                             <option value="Pawnee">Pawnee Nation of Oklahoma</option>
                             <option value="Pechanga Band of Indians">Pechanga Band of Indians</option>
                             <option value="Pedro Bay">Pedro Bay Village</option>
                             <option value="Penobscot">Penobscot Nation</option>
                             <option value="Peoria Tribe of Indians of Oklahoma">Peoria Tribe of Indians of Oklahoma</option>
                             <option value="Petersburg">Petersburg Indian Association</option>
                             <option value="Picayune">Picayune Rancheria of Chukchansi Indians of California</option>
                             <option value="Pilot Station">Pilot Station Traditional Village</option>
                             <option value="Pinoleville">Pinoleville Pomo Nation, California</option>
                             <option value="Pit River">Pit River Tribe, California</option>
                             <option value="Pitka's Point">Pitka's Point Traditional Council</option>
                             <option value="Platinum">Platinum Traditional Village</option>
                             <option value="Poarch">Poarch Band of Creek Indians</option>
                             <option value="Pokagon">Pokagon Band of Potawatomi Indians, Michigan and Indiana</option>
                             <option value="Ponca of Oklahoma">Ponca Tribe of Indians of Oklahoma</option>
                             <option value="Ponca of Nebraska">Ponca Tribe of Nebraska</option>
                             <option value="Port Gamble">Port Gamble S'Klallam Tribe</option>
                             <option value="Portage Creek">Portage Creek Village (aka Ohgsenakale)</option>
                             <option value="Potter Valley">Potter Valley Tribe, California</option>
                             <option value="Prairie Band">Prairie Band Potawatomi Nation</option>
                             <option value="Prairie Island">Prairie Island Indian Community in the State of Minnesota</option>
                             <option value="Pribilof Islands Aleut Communities">Pribilof Islands Aleut Communities</option>
                             <option value="Pueblo of Acoma">Pueblo of Acoma, New Mexico</option>
                             <option value="Pueblo of Cochiti">Pueblo of Cochiti, New Mexico</option>
                             <option value="Pueblo of Isleta">Pueblo of Isleta, New Mexico</option>
                             <option value="Pueblo of Jemez">Pueblo of Jemez, New Mexico</option>
                             <option value="Pueblo of Laguna">Pueblo of Laguna, New Mexico</option>
                             <option value="Pueblo of Nambe">Pueblo of Nambe, New Mexico</option>
                             <option value="Pueblo of Picuris">Pueblo of Picuris, New Mexico</option>
                             <option value="Pueblo of Pojoaque">Pueblo of Pojoaque, New Mexico</option>
                             <option value="Pueblo of San Felipe">Pueblo of San Felipe, New Mexico</option>
                             <option value="Pueblo of San Ildefonso">Pueblo of San Ildefonso, New Mexico</option>
                             <option value="Pueblo of Sandia">Pueblo of Sandia, New Mexico</option>
                             <option value="Pueblo of Santa Ana">Pueblo of Santa Ana, New Mexico</option>
                             <option value="Pueblo of Santa Clara">Pueblo of Santa Clara, New Mexico</option>
                             <option value="Pueblo of Taos">Pueblo of Taos, New Mexico</option>
                             <option value="Pueblo of Tesuque">Pueblo of Tesuque, New Mexico</option>
                             <option value="Pueblo of Zia">Pueblo of Zia, New Mexico</option>
                             <option value="Puyallup">Puyallup Tribe of the Puyallup Reservation</option>
                             <option value="Pyramid Lake">Pyramid Lake Paiute Tribe of the Pyramid Lake Reservation, Nevada</option>
                             <option value="Qagan Tayagungin">Qagan Tayagungin Tribe of Sand Point</option>
                             <option value="Qawalangin">Qawalangin Tribe of Unalaska</option>
                             <option value="Quapaw Nation">Quapaw Nation</option>
                             <option value="Quartz Valley">Quartz Valley Indian Community of the Quartz Valley Reservation of California</option>
                             <option value="Quechan">Quechan Tribe of the Fort Yuma Indian Reservation, California &amp; Arizona</option>
                             <option value="Quileute">Quileute Tribe of the Quileute Reservation</option>
                             <option value="Quinault">Quinault Indian Nation</option>
                             <option value="Ramah Navajo Chapter">Ramah Navajo Chapter of the Navajo Nation</option>
                             <option value="Ramona">Ramona Band of Cahuilla, California</option>
                             <option value="Rampart">Rampart Village</option>
                             <option value="Rappahannock Tribe, Inc.">Rappahannock Tribe, Inc.</option>
                             <option value="Red Cliff">Red Cliff Band of Lake Superior Chippewa Indians of Wisconsin</option>
                             <option value="Red Lake">Red Lake Band of Chippewa Indians, Minnesota</option>
                             <option value="Redding">Redding Rancheria, California</option>
                             <option value="Redwood Valley">Redwood Valley or Little River Band of Pomo Indians of the Redwood Valley Rancheria California</option>
                             <option value="Reno-Sparks">Reno-Sparks Indian Colony, Nevada</option>
                             <option value="Resighini">Resighini Rancheria, California</option>
                             <option value="Rincon">Rincon Band of Luiseno Mission Indians of the Rincon Reservation, California</option>
                             <option value="Robinson">Robinson Rancheria</option>
                             <option value="Rosebud">Rosebud Sioux Tribe of the Rosebud Indian Reservation, South Dakota</option>
                             <option value="Round Valley">Round Valley Indian Tribes, Round Valley Reservation, California</option>
                             <option value="Sac &amp; Fox Nation of Missouri in Kansas and Nebraska">Sac &amp; Fox Nation of Missouri in Kansas and Nebraska</option>
                             <option value="Sac &amp; Fox Nation, Oklahoma">Sac &amp; Fox Nation, Oklahoma</option>
                             <option value="Sac &amp; Fox of Mississippi">Sac &amp; Fox Tribe of the Mississippi in Iowa</option>
                             <option value="Saginaw Chippewa">Saginaw Chippewa Indian Tribe of Michigan</option>
                             <option value="St. George">Saint George Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                             <option value="Saint Paul">Saint Paul Island (See Pribilof Islands Aleut Communities of St. Paul &amp; St. George Islands)</option>
                             <option value="Saint Regis">Saint Regis Mohawk Tribe</option>
                             <option value="Salamatof">Salamatof Tribe</option>
                             <option value="Salt River">Salt River Pima-Maricopa Indian Community of the Salt River Reservation, Arizona</option>
                             <option value="Samish">Samish Indian Nation</option>
                             <option value="San Carlos">San Carlos Apache Tribe of the San Carlos Reservation, Arizona</option>
                             <option value="San Juan">San Juan Southern Paiute Tribe of Arizona</option>
                             <option value="San Pasqual">San Pasqual Band of Diegueno Mission Indians of California</option>
                             <option value="Santa Rosa of Cahuilla">Santa Rosa Band of Cahuilla Indians, California</option>
                             <option value="Santa Rosa">Santa Rosa Indian Community of the Santa Rosa Rancheria, California</option>
                             <option value="Santa Ynez">Santa Ynez Band of Chumash Mission Indians of the Santa Ynez Reservation, California</option>
                             <option value="Santee Sioux">Santee Sioux Nation, Nebraska</option>
                             <option value="Santo Domingo">Santo Domingo Pueblo</option>
                             <option value="Sauk-Suiattle">Sauk-Suiattle Indian Tribe</option>
                             <option value="Sault Ste. Marie">Sault Ste. Marie Tribe of Chippewa Indians, Michigan</option>
                             <option value="Scotts Valley">Scotts Valley Band of Pomo Indians of California</option>
                             <option value="Seldovia">Seldovia Village Tribe</option>
                             <option value="Seminole">Seminole Tribe of Florida</option>
                             <option value="Seneca">Seneca Nation of Indians</option>
                             <option value="Seneca-Cayuga Nation">Seneca-Cayuga Nation</option>
                             <option value="Shageluk">Shageluk Native Village</option>
                             <option value="Shakopee">Shakopee Mdewakanton Sioux Community of Minnesota</option>
                             <option value="Shawnee Tribe">Shawnee Tribe</option>
                             <option value="Sherwood Valley">Sherwood Valley Rancheria of Pomo Indians of California</option>
                             <option value="Shingle Springs">Shingle Springs Band of Miwok Indians, Shingle Springs Rancheria (Verona Tract), California</option>
                             <option value="Shinnecock">Shinnecock Indian Nation</option>
                             <option value="Shoalwater">Shoalwater Bay Indian Tribe of the Shoalwater Bay Indian Reservation</option>
                             <option value="Shoshone-Bannock">Shoshone-Bannock Tribes of the Fort Hall Reservation</option>
                             <option value="Shoshone-Paiute">Shoshone-Paiute Tribes of the Duck Valley Reservation, Nevada</option>
                             <option value="Sisseton-Wahpeton">Sisseton-Wahpeton Oyate of the Lake Traverse Reservation, South Dakota</option>
                             <option value="Sitka">Sitka Tribe of Alaska</option>
                             <option value="Skagway">Skagway Village</option>
                             <option value="Skokomish">Skokomish Indian Tribe</option>
                             <option value="Skull Valley">Skull Valley Band of Goshute Indians of Utah</option>
                             <option value="Snoqualmie">Snoqualmie Indian Tribe</option>
                             <option value="Soboba">Soboba Band of Luiseno Indians, California</option>
                             <option value="Sokaogon">Sokaogon Chippewa  Community, Wisconsin</option>
                             <option value="South Naknek">South Naknek Village</option>
                             <option value="Southern Ute">Southern Ute Indian Tribe of the Southern Ute Reservation, Colorado</option>
                             <option value="Spirit Lake">Spirit Lake Tribe, North Dakota</option>
                             <option value="Spokane">Spokane Tribe of the Spokane Reservation</option>
                             <option value="Squaxin">Squaxin Island Tribe of the Squaxin Island Reservation</option>
                             <option value="St. Croix">St. Croix Chippewa Indians of Wisconsin</option>
                             <option value="Standing Rock">Standing Rock Sioux Tribe of North &amp; South Dakota</option>
                             <option value="Stebbins">Stebbins Community Association</option>
                             <option value="Stillaguamish">Stillaguamish Tribe of Indians of Washington</option>
                             <option value="Stockbridge">Stockbridge Munsee Community, Wisconsin</option>
                             <option value="Summit Lake">Summit Lake Paiute Tribe of Nevada</option>
                             <option value="Sun'aq">Sun'aq Tribe of Kodiak</option>
                             <option value="Suquamish">Suquamish Indian Tribe of the Port Madison Reservation</option>
                             <option value="Susanville">Susanville Indian Rancheria, California</option>
                             <option value="Swinomish">Swinomish Indian Tribal Community</option>
                             <option value="Sycuan">Sycuan Band of the Kumeyaay Nation</option>
                             <option value="Table Mountain">Table Mountain Rancheria</option>
                             <option value="Takotna">Takotna Village</option>
                             <option value="Tangirnaq">Tangirnaq Native Village</option>
                             <option value="Tejon">Tejon Indian Tribe</option>
                             <option value="Telida">Telida Village</option>
                             <option value="Te-Moak">Te-Moak Tribe of Western Shoshone Indians of Nevada (Four constituent bands: Battle Mountain Band; Elko Band; South Fork Band and Wells Band)</option>
                             <option value="Chickasaw Nation">The Chickasaw Nation</option>
                             <option value="The Choctaw Nation of Oklahoma">The Choctaw Nation of Oklahoma</option>
                             <option value="The Muscogee (Creek) Nation">The Muscogee (Creek) Nation</option>
                             <option value="The Osage Nation">The Osage Nation</option>
                             <option value="The Seminole Nation  of Oklahoma">The Seminole Nation of Oklahoma</option>
                             <option value="Thlopthlocco Tribal Town">Thlopthlocco Tribal Town</option>
                             <option value="Three Affiliated">Three Affiliated Tribes of the Fort Berthold Reservation, North Dakota</option>
                             <option value="Timbi-sha Shoshone">Timbisha Shoshone Tribe</option>
                             <option value="Tohono O'odham">Tohono O'odham Nation of Arizona</option>
                             <option value="Tolowa Dee-ni'">Tolowa Dee-ni' Nation</option>
                             <option value="Tonawanda">Tonawanda Band of Seneca</option>
                             <option value="Tonkawa">Tonkawa Tribe of Indians of Oklahoma</option>
                             <option value="Tonto Apache">Tonto Apache Tribe of Arizona</option>
                             <option value="Torres Martinez">Torres Martinez Desert Cahuilla Indians, California</option>
                             <option value="Togiak">Traditional Village of Togiak</option>
                             <option value="Tulalip">Tulalip Tribes of Washington</option>
                             <option value="Tule River">Tule River Indian Tribe of the Tule River Reservation, California</option>
                             <option value="Tuluksak">Tuluksak Native Community</option>
                             <option value="Tunica-Biloxi">Tunica-Biloxi Indian Tribe</option>
                             <option value="Tuolumne">Tuolumne Band of Me-Wuk Indians of the Tuolumne Rancheria of California</option>
                             <option value="Turtle Mountain">Turtle Mountain Band of Chippewa Indians of North Dakota</option>
                             <option value="Tuscarora">Tuscarora Nation</option>
                             <option value="Twenty-Nine Palms">Twenty-Nine Palms Band of Mission Indians of California</option>
                             <option value="Twin Hills">Twin Hills Village</option>
                             <option value="Ugashik">Ugashik Village</option>
                             <option value="Umkumiut">Umkumiut Native Village</option>
                             <option value="United Auburn">United Auburn Indian Community of the Auburn Rancheria of California</option>
                             <option value="United Keetoowah Band of Cherokee Indians in Oklahoma">United Keetoowah Band of Cherokee Indians in Oklahoma</option>
                             <option value="Upper Mattaponi Tribe">Upper Mattaponi Tribe</option>
                             <option value="Upper Sioux">Upper Sioux Community, Minnesota</option>
                             <option value="Upper Skagit">Upper Skagit Indian Tribe</option>
                             <option value="Ute">Ute Indian Tribe of the Uintah &amp; Ouray Reservation, Utah</option>
                             <option value="Ute Mountain Ute">Ute Mountain Ute Tribe</option>
                             <option value="Benton">Utu Utu Gwaitu Paiute Tribe of the Benton Paiute Reservation, California</option>
                             <option value="Alakanuk">Village of Alakanuk</option>
                             <option value="Anaktuvuk Pass">Village of Anaktuvuk Pass</option>
                             <option value="Aniak">Village of Aniak</option>
                             <option value="Atmautluak">Village of Atmautluak</option>
                             <option value="Bill Moore's Slough">Village of Bill Moore's Slough</option>
                             <option value="Chefornak">Village of Chefornak</option>
                             <option value="Clark's Point">Village of Clarks Point</option>
                             <option value="Crooked Creek">Village of Crooked Creek</option>
                             <option value="Dot Lake">Village of Dot Lake</option>
                             <option value="Iliamna">Village of Iliamna</option>
                             <option value="Kalskag">Village of Kalskag</option>
                             <option value="Kaltag">Village of Kaltag</option>
                             <option value="Kotlik">Village of Kotlik</option>
                             <option value="Lower Kalskag">Village of Lower Kalskag</option>
                             <option value="Ohogamiut">Village of Ohogamiut</option>
                             <option value="Red Devil">Village of Red Devil</option>
                             <option value="Sleetmute">Village of Sleetmute</option>
                             <option value="Solomon">Village of Solomon</option>
                             <option value="Stony River">Village of Stony River</option>
                             <option value="Venetie">Village of Venetie (See Native Village of Venetie Tribal Government)</option>
                             <option value="Wainwright">Village of Wainwright</option>
                             <option value="Walker River">Walker River Paiute Tribe of the Walker River Reservation, Nevada</option>
                             <option value="Wampanoag">Wampanoag Tribe of Gay Head (Aquinnah)</option>
                             <option value="Washoe">Washoe Tribe of Nevada &amp; California (Carson Colony, Dresslerville Colony, Woodfords Community, Stewart Community, &amp; Washoe Ranches)</option>
                             <option value="White Mountain">White Mountain Apache Tribe of the Fort Apache Reservation, Arizona</option>
                             <option value="Wichita">Wichita and Affiliated Tribes (Wichita, Keechi, Waco &amp; Tawakonie), Oklahoma</option>
                             <option value="Wilton">Wilton Rancheria, California</option>
                             <option value="Winnebago">Winnebago Tribe of Nebraska</option>
                             <option value="Winnemucca">Winnemucca Indian Colony of Nevada</option>
                             <option value="Wiyot">Wiyot Tribe, California</option>
                             <option value="Wrangell">Wrangell Cooperative Association</option>
                             <option value="Wyandotte Nation">Wyandotte Nation</option>
                             <option value="Yakutat">Yakutat Tlingit Tribe</option>
                             <option value="Yankton">Yankton Sioux Tribe of South Dakota</option>
                             <option value="Yavapai-Apache">Yavapai-Apache Nation of the Camp Verde Indian Reservation, Arizona</option>
                             <option value="Yavapai-Prescott">Yavapai-Prescott Indian Tribe</option>
                             <option value="Yerington">Yerington Paiute Tribe of the Yerington Colony and Campbell Ranch, Nevada</option>
                             <option value="Yocha Dehe">Yocha Dehe Wintun Nation, California</option>
                             <option value="Yomba Shoshone">Yomba Shoshone Tribe of the Yomba Reservation, Nevada</option>
                             <option value="Ysleta Del Sur">Ysleta del Sur Pueblo</option>
                             <option value="Yuhaaviatam of San Manuel Nation">Yuhaaviatam of San Manuel Nation</option>
                             <option value="Andreafski">Yupiit of Andreafski</option>
                             <option value="Yurok">Yurok Tribe of the Yurok Reservation, California</option>
                             <option value="Pueblo of Zuni">Zuni Tribe of the Zuni Reservation, New Mexico</option>
                             <option value="Other">Other</option>
                          </select>
                       </div>
                    </div>
                 
                 <div class="col-sm-6 mt-15" title="">
                    <label class="main-label" for="beneficialOwner[0].identificationDocuments.otherLocalDesc">Other local/Tribal description <em>*</em></label>
                    <div class="form-fields">
                       <input id="beneficialOwner[0].identificationDocuments.otherLocalDesc" name="beneficialOwner[0].identificationDocuments.otherLocalDesc" type="text" placeholder="Enter local/tribal description" class="ben-otherlt form-field" disabled/>
                    </div>
                 </div>
              </div>
           </div>
        </div>
       
     </div>
   </div>
  </div>
  
  <!-- Form of identification and issuing jurisdiction End -->
  
  <!-- Legal Name &amp; Date of Birth Start -->
  
  <div class="accordion-item box-bg-sec">
    <div class="accordion-header row">
     <div class="dah-left col-md-8"><h2>Legal Name & Date of Birth</h2></div>
     <div class="dah-right col-md-4">
      <span title=""><a class="hover-modal-btn" href="#boirNeedHelp15"><img src="/images/help-icon.svg" alt=""></a></span>
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoFive" aria-expanded="true" aria-controls="collapseBoFive"></button>
     </div>
    </div>
    <div id="collapseBoFive" class="accordion-collapse collapse show">
      <div class="accordion-body">
        <div class="ab-top-para">
          <p>Enter your legal name and birthdate exactly as they appear on your identification documents.</p>
       </div>
       <div class="sf-form-body">
       <div class="col-sm-6 mt-15" title="">
         <label class="main-label whsp" for="beneficialOwner[0].legalName">Individual's last name or entity's legal name <em>*</em></label>
         <div class="form-fields">
            <input id="beneficialOwner[0].legalName" name="beneficialOwner[0].legalName" type="text" placeholder="Enter Last Name" class="ben-lname form-field" />
         </div>
       </div>
  
       <div id="benficialexempt">
        <div class="row two-fields">
              <div class="col-sm-4 mt-15" title="">
                 <label class="main-label" for="beneficialOwner[0].firstName">First name <em>*</em></label>
                 <div class="form-fields">
                    <input id="beneficialOwner[0].firstName" name="beneficialOwner[0].firstName" type="text" placeholder="Enter First Name" class="ben-fn form-field" />
                 </div>
              </div>
              <div class="col-sm-4 mt-15" title="">
                 <label class="main-label" for="beneficialOwner[0].middleName">Middle name</label>
                 <div class="form-fields">
                    <input id="beneficialOwner[0].middleName" name="beneficialOwner[0].middleName" type="text" placeholder="Enter Middle name" class="ben-midname form-field" />
                 </div>
              </div>
              <div class="col-sm-4 mt-15" title="">
                 <label class="main-label" for="beneficialOwner[0].suffix">Suffix </label>
                 <div class="form-fields">
                    <input id="beneficialOwner[0].suffix" name="beneficialOwner[0].suffix" type="text" placeholder="Enter Suffix" class="ben-suffix form-field" />
                 </div>
              </div>
           </div>
           <div class="form-rows mt-15 mb-0" title="">
              <label class="main-label" for="beneficialOwner[0].dateOfBirth">Date of birth <em>*</em></label>
              <div class="form-fields">
                 <div class="date-field col-sm-6">
                    <input id="beneficialOwner[0].dateOfBirth" name="beneficialOwner[0].dateOfBirth" type="date" placeholder="06/20/2024" class="ben-dob form-field" />
                 </div>
              </div>
           </div>
  
       </div>
      </div>
       
     </div>
   </div>
  </div>
  <!-- Legal Name &amp; Date of Birth End -->
  <div class="benexemptidi">
  <!-- Current Residential Address Start -->
  <div class="accordion-item box-bg-sec">
    <div class="accordion-header row">
     <div class="dah-left col-md-8"><h2>Current Residential Address</h2></div>
     <div class="dah-right col-md-4">
      <span title=""><a class="hover-modal-btn" href="#boirNeedHelp16"><img src="/images/help-icon.svg" alt=""></a></span>
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBoSix" aria-expanded="true" aria-controls="collapseBoSix"></button>
     </div>
    </div>
    <div id="collapseBoSix" class="accordion-collapse collapse show">
      <div class="accordion-body">
        <div class="ab-top-para">
          <p>Please enter your current residential address.<br/>FinCEN requires the beneficial owner’s primary residential address, not a PO box or business address. </p>
       </div>
      <div class="sf-form-body">
       <div class="form-rows">
              <label class="main-label" for="beneficialOwner[0].address.addressType">Address type <em>*</em></label>
              <div class="form-fields">
                 <div class="row">
                    <label class="col-sm-3">
                    <input id="beneficialOwner[0].address.addressType" name="beneficialOwner[0].address.addressType" type="radio" value="Business" class="ben-addtype"/> Business</label>
                    <label class="col-sm-3">
                    <input type="radio" name="beneficialOwner[0].address.addressType" value="Residential" class="ben-addtype"/> Residential</label>
                 </div>
              </div>
           </div>
           <div class="row two-fields">
              <div class="col-sm-7 mt-15" title="">
                 <label class="main-label whsp" for="beneficialOwner[0].address.address">Address (number, street, and apt. or suite no.) <em>*</em></label>
                 <div class="form-fields">
                    <input id="beneficialOwner[0].address.address" name="beneficialOwner[0].address.address" type="text" placeholder="Enter Address" class="ben-address form-field" />
                 </div>
              </div>
              <div class="col-sm-5 mt-15" title="">
                 <label class="main-label" for="beneficialOwner[0].address.city">City <em>*</em></label>
                 <div class="form-fields">
                    <input id="beneficialOwner[0].address.city" name="beneficialOwner[0].address.city" type="text" placeholder="Enter City" class="ben-city form-field" />
                 </div>
              </div>
              <div class="col-sm-4 mt-15" title="">
                 <label class="main-label" for="beneficialOwner[0].address.country">Country/Jurisdiction <em>*</em></label>
                 <div class="form-fields">
                    <select class="ben-countryjuri form-field" id="beneficialOwner[0].address.country" name="beneficialOwner[0].address.country">
                       <option value="">Select Country</option>
                       <option value="US">United States of America</option>
                       <option value="AS">American Samoa</option>
                       <option value="GU">Guam</option>
                       <option value="MH">Marshall Islands</option>
                       <option value="FM">Micronesia, Federated States</option>
                       <option value="MP">Northern Mariana Islands</option>
                       <option value="PW">Palau</option>
                       <option value="PR">Puerto Rico</option>
                       <option value="VI">U.S. Virgin Islands</option>
                       <option value="AF">Afghanistan</option>
                       <option value="AX">Åland Islands</option>
                       <option value="AL">Albania</option>
                       <option value="DZ">Algeria</option>
                       <option value="AD">Andorra</option>
                       <option value="AO">Angola</option>
                       <option value="AI">Anguilla</option>
                       <option value="AQ">Antarctica</option>
                       <option value="AG">Antigua And Barbuda</option>
                       <option value="AR">Argentina</option>
                       <option value="AM">Armenia</option>
                       <option value="AW">Aruba</option>
                       <option value="AU">Australia</option>
                       <option value="AT">Austria</option>
                       <option value="AZ">Azerbaijan</option>
                       <option value="BS">Bahamas</option>
                       <option value="BH">Bahrain</option>
                       <option value="BD">Bangladesh</option>
                       <option value="BB">Barbados</option>
                       <option value="BY">Belarus</option>
                       <option value="BE">Belgium</option>
                       <option value="BZ">Belize</option>
                       <option value="BJ">Benin</option>
                       <option value="BM">Bermuda</option>
                       <option value="BT">Bhutan</option>
                       <option value="BO">Bolivia, Plurinational State Of</option>
                       <option value="BQ">Bonaire, Sint Eustatius And Saba</option>
                       <option value="BA">Bosnia And Herzegovina</option>
                       <option value="BW">Botswana</option>
                       <option value="BV">Bouvet Island</option>
                       <option value="BR">Brazil</option>
                       <option value="IO">British Indian Ocean Territory</option>
                       <option value="BN">Brunei Darussalam</option>
                       <option value="BG">Bulgaria</option>
                       <option value="BF">Burkina Faso</option>
                       <option value="BI">Burundi</option>
                       <option value="KH">Cambodia</option>
                       <option value="CM">Cameroon</option>
                       <option value="CA">Canada</option>
                       <option value="CV">Cape Verde</option>
                       <option value="KY">Cayman Islands</option>
                       <option value="CF">Central African Republic</option>
                       <option value="TD">Chad</option>
                       <option value="CL">Chile</option>
                       <option value="CN">China</option>
                       <option value="CX">Christmas Island</option>
                       <option value="CC">Cocos (Keeling) Islands</option>
                       <option value="CO">Colombia</option>
                       <option value="KM">Comoros</option>
                       <option value="CG">Congo</option>
                       <option value="CD">Congo, The Democratic Republic Of The</option>
                       <option value="CK">Cook Islands</option>
                       <option value="CR">Costa Rica</option>
                       <option value="CI">Côte D'ivoire</option>
                       <option value="HR">Croatia</option>
                       <option value="CU">Cuba</option>
                       <option value="CW">Curaçao</option>
                       <option value="CY">Cyprus</option>
                       <option value="CZ">Czech Republic</option>
                       <option value="DK">Denmark</option>
                       <option value="DJ">Djibouti</option>
                       <option value="DM">Dominica</option>
                       <option value="DO">Dominican Republic</option>
                       <option value="EC">Ecuador</option>
                       <option value="EG">Egypt</option>
                       <option value="SV">El Salvador</option>
                       <option value="GQ">Equatorial Guinea</option>
                       <option value="ER">Eritrea</option>
                       <option value="EE">Estonia</option>
                       <option value="ET">Ethiopia</option>
                       <option value="FK">Falkland Islands (Malvinas)</option>
                       <option value="FO">Faroe Islands</option>
                       <option value="FJ">Fiji</option>
                       <option value="FI">Finland</option>
                       <option value="FR">France</option>
                       <option value="GF">French Guiana</option>
                       <option value="PF">French Polynesia</option>
                       <option value="TF">French Southern Territories</option>
                       <option value="GA">Gabon</option>
                       <option value="GM">Gambia</option>
                       <option value="GE">Georgia</option>
                       <option value="DE">Germany</option>
                       <option value="GH">Ghana</option>
                       <option value="GI">Gibraltar</option>
                       <option value="GR">Greece</option>
                       <option value="GL">Greenland</option>
                       <option value="GD">Grenada</option>
                       <option value="GP">Guadeloupe</option>
                       <option value="GT">Guatemala</option>
                       <option value="GG">Guernsey</option>
                       <option value="GN">Guinea</option>
                       <option value="GW">Guinea-bissau</option>
                       <option value="GY">Guyana</option>
                       <option value="HT">Haiti</option>
                       <option value="HM">Heard Island And Mcdonald Islands</option>
                       <option value="VA">Holy See (Vatican City State)</option>
                       <option value="HN">Honduras</option>
                       <option value="HK">Hong Kong</option>
                       <option value="HU">Hungary</option>
                       <option value="IS">Iceland</option>
                       <option value="IN">India</option>
                       <option value="ID">Indonesia</option>
                       <option value="IR">Iran, Islamic Republic Of</option>
                       <option value="IQ">Iraq</option>
                       <option value="IE">Ireland</option>
                       <option value="IM">Isle Of Man</option>
                       <option value="IL">Israel</option>
                       <option value="IT">Italy</option>
                       <option value="JM">Jamaica</option>
                       <option value="JP">Japan</option>
                       <option value="JE">Jersey</option>
                       <option value="JO">Jordan</option>
                       <option value="KZ">Kazakhstan</option>
                       <option value="KE">Kenya</option>
                       <option value="KI">Kiribati</option>
                       <option value="KP">Korea, Democratic People's Republic Of</option>
                       <option value="KR">Korea, Republic Of</option>
                       <option value="KW">Kuwait</option>
                       <option value="KG">Kyrgyzstan</option>
                       <option value="LA">Lao People's Democratic Republic</option>
                       <option value="LV">Latvia</option>
                       <option value="LB">Lebanon</option>
                       <option value="LS">Lesotho</option>
                       <option value="LR">Liberia</option>
                       <option value="LY">Libya</option>
                       <option value="LI">Liechtenstein</option>
                       <option value="LT">Lithuania</option>
                       <option value="LU">Luxembourg</option>
                       <option value="MO">Macao</option>
                       <option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
                       <option value="MG">Madagascar</option>
                       <option value="MW">Malawi</option>
                       <option value="MY">Malaysia</option>
                       <option value="MV">Maldives</option>
                       <option value="ML">Mali</option>
                       <option value="MT">Malta</option>
                       <option value="MQ">Martinique</option>
                       <option value="MR">Mauritania</option>
                       <option value="MU">Mauritius</option>
                       <option value="YT">Mayotte</option>
                       <option value="MX">Mexico</option>
                       <option value="MD">Moldova, Republic Of</option>
                       <option value="MC">Monaco</option>
                       <option value="MN">Mongolia</option>
                       <option value="ME">Montenegro</option>
                       <option value="MS">Montserrat</option>
                       <option value="MA">Morocco</option>
                       <option value="MZ">Mozambique</option>
                       <option value="MM">Myanmar</option>
                       <option value="NA">Namibia</option>
                       <option value="NR">Nauru</option>
                       <option value="NP">Nepal</option>
                       <option value="NL">Netherlands</option>
                       <option value="NC">New Caledonia</option>
                       <option value="NZ">New Zealand</option>
                       <option value="NI">Nicaragua</option>
                       <option value="NE">Niger</option>
                       <option value="NG">Nigeria</option>
                       <option value="NU">Niue</option>
                       <option value="NF">Norfolk Island</option>
                       <option value="NO">Norway</option>
                       <option value="OM">Oman</option>
                       <option value="PK">Pakistan</option>
                       <option value="PS">Palestinian Territory, Occupied</option>
                       <option value="PA">Panama</option>
                       <option value="PG">Papua New Guinea</option>
                       <option value="PY">Paraguay</option>
                       <option value="PE">Peru</option>
                       <option value="PH">Philippines</option>
                       <option value="PN">Pitcairn</option>
                       <option value="PL">Poland</option>
                       <option value="PT">Portugal</option>
                       <option value="QA">Qatar</option>
                       <option value="RE">Réunion</option>
                       <option value="RO">Romania</option>
                       <option value="RU">Russian Federation</option>
                       <option value="RW">Rwanda</option>
                       <option value="BL">Saint Barthélemy</option>
                       <option value="SH">Saint Helena, Ascension And Tristan Da Cunha</option>
                       <option value="KN">Saint Kitts And Nevis</option>
                       <option value="LC">Saint Lucia</option>
                       <option value="MF">Saint Martin (french Part)</option>
                       <option value="PM">Saint Pierre And Miquelon</option>
                       <option value="VC">Saint Vincent And The Grenadines</option>
                       <option value="WS">Samoa</option>
                       <option value="SM">San Marino</option>
                       <option value="ST">Sao Tome And Principe</option>
                       <option value="SA">Saudi Arabia</option>
                       <option value="SN">Senegal</option>
                       <option value="RS">Serbia</option>
                       <option value="SC">Seychelles</option>
                       <option value="SL">Sierra Leone</option>
                       <option value="SG">Singapore</option>
                       <option value="SX">Sint Maarten (dutch Part)</option>
                       <option value="SK">Slovakia</option>
                       <option value="SI">Slovenia</option>
                       <option value="SB">Solomon Islands</option>
                       <option value="SO">Somalia</option>
                       <option value="ZA">South Africa</option>
                       <option value="GS">South Georgia And The South Sandwich Islands</option>
                       <option value="SS">South Sudan</option>
                       <option value="ES">Spain</option>
                       <option value="LK">Sri Lanka</option>
                       <option value="SD">Sudan</option>
                       <option value="SR">Suriname</option>
                       <option value="SJ">Svalbard And Jan Mayen</option>
                       <option value="SZ">Swaziland</option>
                       <option value="SE">Sweden</option>
                       <option value="CH">Switzerland</option>
                       <option value="SY">Syrian Arab Republic</option>
                       <option value="TW">Taiwan</option>
                       <option value="TJ">Tajikistan</option>
                       <option value="TZ">Tanzania, United Republic Of</option>
                       <option value="TH">Thailand</option>
                       <option value="TL">Timor-leste</option>
                       <option value="TG">Togo</option>
                       <option value="TK">Tokelau</option>
                       <option value="TO">Tonga</option>
                       <option value="TT">Trinidad And Tobago</option>
                       <option value="TN">Tunisia</option>
                       <option value="TR">Turkey</option>
                       <option value="TM">Turkmenistan</option>
                       <option value="TC">Turks And Caicos Islands</option>
                       <option value="TV">Tuvalu</option>
                       <option value="UG">Uganda</option>
                       <option value="UA">Ukraine</option>
                       <option value="AE">United Arab Emirates</option>
                       <option value="GB">United Kingdom</option>
                       <option value="UY">Uruguay</option>
                       <option value="UZ">Uzbekistan</option>
                       <option value="VU">Vanuatu</option>
                       <option value="VE">Venezuela, Bolivarian Republic Of</option>
                       <option value="VN">Viet Nam</option>
                       <option value="VG">Virgin Islands, British</option>
                       <option value="WF">Wallis And Futuna</option>
                       <option value="EH">Western Sahara</option>
                       <option value="YE">Yemen</option>
                       <option value="ZM">Zambia</option>
                       <option value="ZW">Zimbabwe</option>
                    </select>
                 </div>
              </div>
              <div class="col-sm-4 mt-15" title="">
                 <label class="main-label" for="beneficialOwner[0].address.state">State <em id="benStateStar">*</em></label>
                 <div class="form-fields">
                    <select class="benstate form-field" id="beneficialOwner[0].address.state" name="beneficialOwner[0].address.state">
                       <option value="">Select a State </option>
                       <option value="AL">Alabama</option>
                       <option value="AK">Alaska</option>
                       <option value="AE">Armed Forces Europe/Middle-East/Canada</option>
                       <option value="AA">Armed Forces Americas (except Canada)</option>
                       <option value="AP">Armed Forces Pacific</option>
                       <option value="AZ">Arizona</option>
                       <option value="AR">Arkansas</option>
                       <option value="CA">California</option>
                       <option value="CO">Colorado</option>
                       <option value="CT">Connecticut</option>
                       <option value="DE">Delaware</option>
                       <option value="DC">District of Columbia</option>
                       <option value="FL">Florida</option>
                       <option value="GA">Georgia</option>
                       <option value="HI">Hawaii</option>
                       <option value="ID">Idaho</option>
                       <option value="IL">Illinois</option>
                       <option value="IN">Indiana</option>
                       <option value="IA">Iowa</option>
                       <option value="KS">Kansas</option>
                       <option value="KY">Kentucky</option>
                       <option value="LA">Louisiana</option>
                       <option value="ME">Maine</option>
                       <option value="MD">Maryland</option>
                       <option value="MA">Massachusetts</option>
                       <option value="MI">Michigan</option>
                       <option value="MN">Minnesota</option>
                       <option value="MS">Mississippi</option>
                       <option value="MO">Missouri</option>
                       <option value="MT">Montana</option>
                       <option value="NE">Nebraska</option>
                       <option value="NV">Nevada</option>
                       <option value="NH">New Hampshire</option>
                       <option value="NJ">New Jersey</option>
                       <option value="NM">New Mexico</option>
                       <option value="NY">New York</option>
                       <option value="NC">North Carolina</option>
                       <option value="ND">North Dakota</option>
                       <option value="OH">Ohio</option>
                       <option value="OK">Oklahoma</option>
                       <option value="OR">Oregon</option>
                       <option value="PA">Pennsylvania</option>
                       <option value="RI">Rhode Island</option>
                       <option value="SC">South Carolina</option>
                       <option value="SD">South Dakota</option>
                       <option value="TN">Tennessee</option>
                       <option value="TX">Texas</option>
                       <option value="UT">Utah</option>
                       <option value="VT">Vermont</option>
                       <option value="VA">Virginia</option>
                       <option value="WA">Washington</option>
                       <option value="WV">West Virginia</option>
                       <option value="WI">Wisconsin</option>
                       <option value="WY">Wyoming</option>
                    </select>
                 </div>
              </div>
              <div class="col-sm-4 mt-15" title="">
                 <label class="main-label" for="beneficialOwner[0].address.postalCode">Zip Code <em>*</em></label>
                 <div class="form-fields">
                    <input id="beneficialOwner[0].address.postalCode" name="beneficialOwner[0].address.postalCode" type="text" placeholder="Enter Zip Code" class="ben-zipcode form-field" />
                 </div>
              </div>
           </div>
       </div>
     </div>
   </div>
  </div>
</div>
  <!-- Current Residential Address End -->
  
  </div>
  <!-- Benificial Remaining Fields Accordian Start -->
  </div>
  <!-- Benificial Remaining Fields End -->

                                                            </div>
                                                            
                                                            </div>
                                                            <!-- Beneficial Owner Accordian End -->
                                                         

                                                      </div>
                                                   </div>
                                                   <!-- asdfasdfsadf -->
                                                   <!-- </div>
                                                      </div> -->
                                                   <!-- here hre hre her  -->
                                                </div>
                                             </div>
                                          </div>
										  <p class="text-danger" id="formBenErrorText" style="display:none">Please complete all mandatory fields before submitting. These fields are essential to process your request accurately.</p>
                                          <div class="sf-form-footer">
                                             <div class="row">
                                                <aside class="col-sm-4 sf-foot-left">
                                                   <button class="brdr-btn" id="prev3">Previous</button>
                                                </aside>
                                                <aside class="col-sm-8 sf-foot-right">
                                                   <div class="sf-btns">
                                                      <button class="bg-btn loading-button" id="next4" type="submit" value="submit">
                                                         <span class="btn-text" id="beneficialProceed">Save & Proceed</span>
														 <span class="btn-text" id="beneficialDraft" style="display:none;">Save as Draft</span>
                                                         <div class="spinner"></div>
                                                      </button>
                                                   </div>
                                                </aside>
                                             </div>
                                          </div>
                                    </form>
                                    <div class="sf-btm-bar">
                                    <p><a class="hover-modal-btn" href="#boirNeedHelp22"><img src="images/Bell.png" alt="" /> PRIVACY ACT AND PAPERWORK REDUCTION ACT NOTICE</a></p>
                                    </div>
                                 </aside>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
            </section>
            <!--step5-->
			<section class="page-cont">
			   <div class="step" id="step5">
			      <div class="cust-cf">
			         <!--<div class="notify-bar">
			            <p><img src="images/Bell.png"> Notification: Site Maintenance: BOI E-Filing System site will be unavailable for scheduled maintenance on June 21st, from 6:00 AM - 8:00 AM EST.</p>
			            </div>-->
			         <div class="breadcrumb-bar">
			            <div class="row">
			               <aside class="col-sm-6 bb-left">
			                  <a href="#">BOI E-Filing</a>
			                  <a href="#">File BOIR</a>
			               </aside>
			               <aside class="col-sm-6 bb-right">
			                  <a href="#"><img src="images/help.png" alt=""> Help</a>
			               </aside>
			            </div>
			         </div>
			      </div>
			      <br/>  
			      <div class="mid-content">
			         <div class="container">
			            <h2>Beneficial Ownership Information Report (BOIR)</h2>
			            <p>Complete the report in its entirety with all required information. Fields marked with an asterisk (*) symbol are the fields that, at a minimum, must be completed by all companies to file the report. Reporting companies, however, must include all information 31 CFR 1010.380(b) requires them to provide, regardless of whether a field is marked with an asterisk (*) symbol. These information requirements are summarized above under HELP.</p>
			            <div class="step-form-main">
			               <div class="sf-top">
			                  <h2>Step 5 of 7</h2>
			               </div>
						   <div class="sf-form-top" style="margin-bottom: 30px;">
						   		<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress5" style="width:66.67%; background-color:#B31942;">
						   					<span class="progress-percentage" id="progress-percentage5">67%</span>
						   				</div>
						   			</div>
						   		</div>
						   	</div>
			               <div class="sf-main">
			                  <div class="row">
			                     <aside class="col-lg-3 sf-main-left">
			                        <ul>
			                           <li><a>Filing Information <i class="bi bi-check custom-icon"></i></a></a></li>
			                           <li><a>Reporting Company <i class="bi bi-check custom-icon"></i></a></a></li>
			                           <li><a>Company Applicant(s) <i class="bi bi-check custom-icon"></i></a></a></li>
			                           <li><a>Beneficial Owner(s) <i class="bi bi-check custom-icon"></i></a></a></li>
			                           <li class="active"><a>General Information</a></li>
			                           <li><a>Submitter Information</a></li>
			                           <li><a>Acknowledgement</a></li>
			                        </ul>
			                     </aside>
			                     <aside class="col-lg-9 sf-main-right">
                                 <div class="sub-info">
			                         <h2 class="no-margin">Submitter’s Information</h2>
                                  <p>Complete all fields below before submitting. Directly after submission, a processing page will be displayed, followed by a page confirming the status of your report. This confirmation page will also give you an opportunity to download a transcript of your report.</p>
			                        </div>
			                        <form id="SubmitForm" method="get" action="#">
			                           <div class="sf-form-sec gi-form-sec">
			                              <div class="sf-form-body sub-check">
                                          <div class="box-bg-sec">
			                                 <div class="row two-fields">
			                                    <div class="col-sm-6 mt-15" title="Enter your email address">
			                                       <label class="main-label" for="subemail">Your Email <em>*</em></label>
			                                       <div class="form-fields">
			                                          <input id="subemail" name="email" type="email"  autocomplete="new_password" class="sub-email form-field" />
			                                       </div>
			                                    </div>
			                                    <div class="col-sm-6 mt-15" title="Enter your email address">
			                                       <label class="main-label" for="subconemail">Confirm Email <em>*</em></label>
			                                       <div class="form-fields">
			                                          <input id="subconemail" name="subconemail" type="email" autocomplete="new_password" class="sub-confimemail form-field" />
			                                       </div>
			                                    </div>
			                                    <div class="col-sm-6 mt-15" title="Enter your first name">
			                                       <label class="main-label" for="subfirstname">First Name <em>*</em></label>
			                                       <div class="form-fields">
			                                          <input id="subfirstname" name="firstName" type="text" autocomplete="new_password" class="subfname form-field" />
			                                       </div>
			                                    </div>
			                                    <div class="col-sm-6 mt-15" title="Enter your last name">
			                                       <label class="main-label" for="sublastname">Last Name <em>*</em></label>
			                                       <div class="form-fields">
			                                          <input id="sublastname" name="lastName" type="text" autocomplete="new_password" class="sublname form-field" />
			                                       </div>
			                                    </div>
			                                 </div>
                                       </div>
                                       <div class="form-rows no-margin">
                                          <div class="check-field mt-15 mb-10">
			                                          <input class="main-label" type="checkbox" id="subcheckbox1" name="subcheckbox1">
			                                          <label class="main-label" for="subcheckbox1">  I certify that I am authorized to file this BOIR on behalf of the reporting company. I further certify, on behalf of the reporting company, that the information contained in this BOIR is true, correct, and complete.</label>
			                                       </div>
			                                    </div>
			                                 </div>
			                              <div class="sf-form-footer">
			                                 <div class="row">
			                                    <aside class="col-sm-4 sf-foot-left">
			                                    </aside>
			                                    <aside class="col-sm-8 sf-foot-right">
			                                       <div class="sf-btns">
			                                          <!--<button class="brdr-btn">Review</button>-->
			                                          <button class="brdr-btn" id="prev4">Previous</button>
			                                          <button class="bg-btn loading-button" id="next5" type="submit" value="submit">
			                                             <span class="btn-text">Review & Submit BOIR</span>
			                                             <div class="spinner"></div>
			                                          </button>
			                                       </div>
			                                    </aside>
			                                 </div>
			                              </div>
			                              <br/>
			                              <div class="sf-form-top com-data">
			                                 <h3><strong>COMPLIANCE REMINDER:</strong> The willful failure to report complete beneficial ownership information to FinCEN, the willful failure to update beneficial ownership information provided to FinCEN when previously reported information changes, or the willful provision of false or fraudulent beneficial ownership information to FinCEN, may result in civil or criminal penalties. A person may also be subject to civil or criminal penalties for willfully causing a reporting company to report incomplete or false beneficial ownership information to FinCEN.</h3>
			                              </div>
			                           </div>
			                        </form>
			                        <div class="sf-btm-bar">
			                        <p><a class="hover-modal-btn" href="#boirNeedHelp23"><img src="images/Bell.png" alt="" /> PRIVACY ACT AND PAPERWORK REDUCTION ACT NOTICE</a></p>
			                  </div>
			                  </aside>
			               </div>
			            </div>
			         </div>
			      </div>
			   </div>
			   </div>
			</section>
            <section class="page-cont">
               <div class="step" id="step6">
                  <div class="cust-cf">
                     <div class="breadcrumb-bar">
                        <div class="row">
                           <aside class="col-sm-6 bb-left">
                              <a href="#">BOI E-Filing</a>
                              <a href="#">File BOIR</a>
                           </aside>
                           <aside class="col-sm-6 bb-right">
                              <a href="#"><img src="images/help.png" alt=""> Help</a>
                           </aside>
                        </div>
                     </div>
                  </div>
                  <div class="mid-content">
                     <div class="container">
                        <h2>Beneficial Ownership Information Report (BOIR)</h2>
                        <p>Complete the report in its entirety with all required information. Fields marked with an asterisk (*) symbol are the fields that, at a minimum, must be completed by all companies to file the report. Reporting companies, however, must include all information 31 CFR 1010.380(b) requires them to provide, regardless of whether a field is marked with an asterisk (*) symbol. These information requirements are summarized above under HELP.</p>
                        <div class="step-form-main">
                           <div class="sf-top">
                              <h2>Step 6 of 7</h2>
                           </div>
						   <div class="sf-form-top" style="margin-bottom: 30px;">
						   		<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress6" style="width:83.33%; background-color:#B31942;">
						   					<span class="progress-percentage" id="progress-percentage6">83%</span>
						   				</div>
						   			</div>
						   		</div>
						   	</div>
                           <div class="sf-main">
                              <div class="row">
                                 <aside class="col-lg-3 sf-main-left">
                                    <ul>
                                       <li><a>Filing Information <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Reporting Company <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Company Applicant(s) <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Beneficial Owner(s) <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>General Information <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li class="active"><a>Submitter Information</a></li>
                                       <li><a>Acknowledgement</a></li>
                                    </ul>
                                 </aside>
                                 <aside class="col-lg-9 sf-main-right">
                                    <div id="previewContainer"></div>
                                    <div class="sf-form-footer">
                                       <div class="row">
                                          <aside class="col-sm-4 sf-foot-left">
                                             <!--<div class="g-recaptcha" data-sitekey="6LdGwaQqAAAAAFdnhAV6p4lS3B4wdRbSVWpcxxtC"></div>
                                             <span id="recaptcha-error-preview" style="color: #B31942; font-size: 14px; font-weight: 500;"></span>
                                             <div class="help-block with-errors"></div>-->
                                          </aside>
                                          <aside class="col-sm-8 sf-foot-right">
                                             <div class="sf-btns">
                                                <button class="brdr-btn" id="prev5">Previous</button>
												<button class="bg-btn loading-button" data-bs-toggle="modal" data-bs-target="#submitnowModal" id="submitnowpopup"><span class="btn-text">Submit BOIR</span><div class="spinner"></div></button>
												<!--added -->
<!--												<a href="#" data-bs-toggle="modal" data-bs-target="#startnowModal" id="startnowpopup"><u>Compare</u></a>-->
													<div class="modal modal fade" id="submitnowModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
														<div class="modal-dialog modal-fullscreen modal-dialog-centered"> 
															<div class="container">
																<div class="modal modal fade show" id="submitnowModal" tabindex="-1" style="display: block; padding-left: 0px;" aria-modal="true" role="dialog">
																	<div class="modal-dialog modal-fullscreen modal-dialog-centered">
																		<div class="container">
																			<div class="user-data-form step-form-modal modal-content final-submit-modal">
																				<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
																				<div class="modal-cont">
																					<div class="boddy" style="text-align: left;">
																						<h2>While Your BOIR is Being Processed...</h2>
																						<p>Consider taking advantage of our additional services to simplify your business operations.</p>
																						<form>
                                                                  <div class="sf-form-body">
                                                                     <div class="form-fields">
                                                                     <label class="main-label">Select an option below, and a member of our team will contact you shortly to assist.</label>
																						   <label class="check-field">
																							   <input type="checkbox" id="submitYes" value="us_bankAccount" name="myCheckbox">
																							   I’d like to learn more about Accounting, Bookkeeping, and Tax Filing Services.
																						 </label>
																						 <label class="check-field">
																								 <input type="checkbox" id="submitNo" value="taxFIlingServices" name="myCheckbox">
																								 I’m interested in opening a US Bank Account for my business.
																						   </label>
																						 <input id="bankAccount" name="bankAccount" type="text" style="display: none;"/>
																						 <input id="taxFIlingServices" name="firsttaxFIlingServicesName" type="text" style="display: none;"/>
                                                                 </div>
                                                               </div>
																						</form>
																						<p class="final-check-submit">By selecting either of these options, you consent to being contacted by our team via email or phone regarding these services.</p>
																						<div class="modal-btns step-mod-btns pt-10">
																						   <button class="bg-btn loading-button" id="next6"><span class="btn-text">Submit BOIR</span><div class="spinner"></div></button>
																						<!--<button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok" style="width:50%;">Submit</button>-->
																						</div>
																						<div id="ThankYouBank" style="display:none">
																							<h2 style="font-size: 30px; margin-bottom:10px; text-align:center;">Thank You!</h2>
																							<p style="text-align:center;"><b>We will reach out to you shortly to assist with your inquiry.</b></p>
																						</div>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
                                             </div>
                                          </aside>
                                       </div>
                                    </div>
                                 </aside>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </section>
            <section class="page-cont">
               <div class="step" id="step7">
                  <div class="cust-cf">
                     <div class="breadcrumb-bar">
                        <div class="row">
                           <aside class="col-sm-6 bb-left">
                              <a href="#">BOI E-Filing</a>
                              <a href="#">File BOIR</a>
                           </aside>
                           <aside class="col-sm-6 bb-right">
                              <a href="#"><img src="images/help.png" alt=""> Help</a>
                           </aside>
                        </div>
                     </div>
                  </div>
                  <div class="mid-content">
                     <div class="container">
                        <h2>Beneficial Ownership Information Report (BOIR)</h2>
                        <p>Complete the report in its entirety with all required information. Fields marked with an asterisk (*) symbol are the fields that, at a minimum, must be completed by all companies to file the report. Reporting companies, however, must include all information 31 CFR 1010.380(b) requires them to provide, regardless of whether a field is marked with an asterisk (*) symbol. These information requirements are summarized above under HELP.</p>
                        <div class="step-form-main">
                           <div class="sf-top">
                              <h2>Step 7 of 7</h2>
                           </div>
						   <div class="sf-form-top" style="margin-bottom: 30px;">
						   		<div class="progress-container">
						   			<div class="progress-bar-wrapper">
						   				<div class="progress-bar" id="progress7" style="width:100%; background-color:#B31942;">
						   						<span class="progress-percentage" id="progress-percentage7">100%</span>
						   				</div>
						   			</div>
						   		</div>
						   	</div>
                           <div class="sf-main">
                              <div class="row">
                                 <aside class="col-lg-3 sf-main-left">
                                    <ul>
                                       <li><a>Filing Information <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Reporting Company <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Company Applicant(s) <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Beneficial Owner(s) <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>General Information <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li><a>Submitter Information <i class="bi bi-check custom-icon"></i></a></a></li>
                                       <li class="active"><a>Acknowledgement</a></li>
                                    </ul>
                                 </aside>
                                 <aside class="col-lg-9 sf-main-right">
                                    <div id="Acknowledgement">
                                       <table class="box-bg-sec res-table-sec">
                                          <tr><th colspan="2" class="rt-heading">Filing Information</td></tr>
                                          <tr height="10"><td></td></tr>
                                          <tr>
                                             <td>Type Of Filing</td>
                                             <td>Individual</td>
                                          </tr>
                                          <tr>
                                             <td>Process ID</td>
                                             <td><span id="processId"></span></td>
                                          </tr>
                                          <tr>
                                             <td>Submission Status</td>
                                             <td><span id="submissionStatus"></span></td>
                                          </tr>
                                          <tr>
                                             <td>BOIR ID</td>
                                             <td><span id="boirid"></span></td>
                                          </tr>
                                          <tr>
                                             <td>Fincen ID</td>
                                             <td><span id="fincenID"></span></td>
                                          </tr>
                                          <tr>
                                             <td>Date Filed</td>
                                             <td><span id="initiatedTimestamp"></span></td>
                                          <tr>
                                             <td>Errors</td>
                                             <td><span id="errordata"></span></td>
                                          </tr>
                                       </table>
									   <div class="align-fields" style="display: flex; flex-wrap: wrap; justify-content: center;">
	                                       <div id="submissionStatusfields" style="display:none;" >
	                                          <div  class="form-fields gapbele d-flex">
	                                             <a id="certificate" href="#" target="_blank" class="bg-btn btn-four">View Certificate</a>
	                                             <a class="bg-btn btn-four" id="transcript" target="_blank">Download Transcript</a>
	                                          </div>
	                                       </div>
										   <div  class="form-fields gapbele d-flex">
		                                        <a id="" href="/dashboard" class="bg-btn btn-four">Return to dashboard</a>
		                                   </div>
									   </div>
                                    </div>
                                 </aside>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </section>
         </section>
         <!--popup for 3rd form Existing reporting company -->
         <div class="existingrepot-modal modal fade" id="existingrepotModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
            <div class="modal-dialog modal-fullscreen modal-dialog-centered">
               <div class="container">
                  <div class="user-data-form step-form-modal modal-content">
                     <!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
                     <div class="modal-cont">
                        <h2 style="font-size:30px;">Confirm Existing Reporting Company Status</h2>
                        <p>If your company was existing before January 1, 2024, you won’t need to provide information for Company Applicant. These fields will be cleared and disabled. Would you like to proceed?</p>
                        <div class="modal-btns step-mod-btns"><button class="blue-btn" data-bs-dismiss="modal" id="existok">Okay</button></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!--popup for 2nd form Foreign pooled investment vehicle -->
         <div class="foreignvehicle-modal modal fade" id="foreigninvevehicleModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
            <div class="modal-dialog modal-fullscreen modal-dialog-centered">
               <div class="container">
                  <div class="user-data-form step-form-modal modal-content">
                     <!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
                     <div class="modal-cont">
                        <h2 style="font-size:30px">Confirm Foreign Pooled Investment Vehicle Status</h2>
                        <p>If this entity is a Foreign Pooled Investment Vehicle, you won’t need to provide information for Company Applicant and all but the first Beneficial Owner. These fields will be cleared and disabled. Would you like to proceed?</p>
                        <div class="modal-btns step-mod-btns"><button class="blue-btn" data-bs-dismiss="modal" id="foreignvehicleok">Okay</button></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
		 <!-------------------------------------------Automated Data Extraction---------------------------------------------------------------------------------->
 		 <div class="auto-data-extract-modal modal fade" id="auto-data-extract-popup[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
 		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
 		         <div class="container">
 		             <div class="user-data-form step-form-modal modal-content">
 		                 <button type="button" class="btn-close" id="auto-data-extract-manual" data-bs-dismiss="modal" aria-label="Close"></button>
 		                 <div class="modal-cont">
 		                     <div class="boddy">
 		                         <h3 class="modal-head">Automated Data Extraction</h3>
 		                         <p class="text-left">Would you like the system to automatically extract the necessary fields from the Identifying Document you uploaded using Doc AI?</p>
 		                         <p class="text-left">This will help populate the relevant fields quickly and accurately.  </p>
 		                         <a href="#" class="btn-four" id="auto-data-extract-proceed">Proceed with Doc AI</a>
 		                         <a href="#" class="btn-four"  data-bs-dismiss="modal" id="auto-data-extract-manual">I’ll Input Manually</a><br>
 		                     </div>
<!-- 		                     <div class="modal-btns step-mod-btns">-->
<!-- 		                     </div>-->
 		                 </div>
 		             </div>
 		         </div>
 		     </div>
 		 </div>

 		 <!----------------------------------------- Extracting Information---------------------------------------------------------------------------------->
 		 <div class="extract-info-modal modal fade" id="extract-info-popup[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
 		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
 		         <div class="container">
 		             <div class="user-data-form step-form-modal modal-content">
 		              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
 		                 <div class="modal-cont">
 		                     <div class="boddy">
 		                         <h3 class="modal-head">Extracting Information...</h3>
 		                         <p style="text-align: left;font-size: 15px;">We’re automatically extracting the necessary details from your uploaded document. This won’t take long!</p>
 		                         <p style="  text-align: left;font-size:11px;">Please do not refresh the page during this process. </p>
 		                         <img class="spinner1" src="images/loading.png" alt="">
 		                     </div>
 		                     <div class="modal-btns step-mod-btns" style="margin-top:-20px">
 		                     </div>
 		                 </div>
 		             </div>
 		         </div>
 		     </div>
 		 </div>
 		 <!----------------------------------------- Data population Successful---------------------------------------------------------------------------------->
 		 <div class="foreignvehicle-modal auto-data-exe-modal modal fade" id="extract-info-complete[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
 		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
 		         <div class="container">
 		             <div class="user-data-form step-form-modal modal-content w-600">
 		                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
 		                 <div class="modal-cont">
 		                     <div class="boddy">
 		                         <h3 class="modal-head">Auto-population Complete</h3>
 		                         <p class="text-left">
 		                             <b>Your document has been submitted successfully</b>
 		                         </p>
 		                         <p class="text-left">The fields in this form have been auto-populated using the document you uploaded. Please review the information and make any necessary changes before proceeding </p>
 		                         <a href="#" data-bs-dismiss="modal" class="btn-four mt-20">Got it</a>
 		                         <br>
 		                     </div>
 		                     <div class="modal-btns step-mod-btns" style="margin-top:-20px">
 		                     </div>
 		                 </div>
 		             </div>
 		         </div>
 		     </div>
 		 </div>
 		 <!----------------------------------------- Unsupported Document Type---------------------------------------------------------------------------------->
 		 <div class="foreignvehicle-modal modal-lg-sec modal fade" id="unsupportedTypePopup" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" >
 		 	<div class="modal-dialog modal-fullscreen modal-dialog-centered">
 		 		<div class="container">
 		 		<div class="user-data-form step-form-modal modal-content">
 		 			<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
 		 				<div class="modal-cont">
 		 					<div class="boddy">
 		 							<h3 class="modal-head">Unsupported Document Type</h3>
 		 							<p style="  text-align: left;">Your document has been submitted successfully. However, it appears that the document type you uploaded is not supported for Doc AI extraction. Please enter the required fields manually to proceed.</p>
 		 							<a href="#" class="btn-four mt-20" value="true" id="unsupportedTypeUpload" >Upload another document</a>
 		 							<a href="#" class="btn-four mt-20" value="false" data-bs-dismiss="modal" style="min-width: 40%;">Enter manually</a><br>
 							</div>
 		 				</div>
 		 			</div>	
 		 		</div>
 		 	</div>
 		 </div>
 		 
 		 <!-------------------------------------------Automated Data Extraction---------------------------------------------------------------------------------->
  		 <div class="auto-data-extract-modal modal fade" id="auto-data-extract-popup2[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
  		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
  		         <div class="container">
  		             <div class="user-data-form step-form-modal modal-content">
  		                 <button type="button" class="btn-close" id="auto-data-extract-manual" data-bs-dismiss="modal" aria-label="Close"></button>
  		                 <div class="modal-cont">
  		                     <div class="boddy">
  		                         <h3 class="modal-head">Automated Data Extraction</h3>
  		                         <p class="text-left">Would you like the system to automatically extract the necessary fields from the Identifying Document you uploaded using Doc AI?</p>
  		                         <p class="text-left">This will help populate the relevant fields quickly and accurately.  </p>
  		                         <a href="#" class="btn-four" id="auto-data-extract-proceed">Proceed with Doc AI</a>
  		                         <a href="#" class="btn-four"  data-bs-dismiss="modal" id="auto-data-extract-manual">I’ll Input Manually</a>
  		                     </div>
  		                     <!-- <div class="modal-btns step-mod-btns" style="margin-top:-20px">
  		                     </div> -->
  		                 </div>
  		             </div>
  		         </div>
  		     </div>
  		 </div>

  		 <!----------------------------------------- Extracting Information---------------------------------------------------------------------------------->
  		 <div class="extract-info-modal modal fade" id="extract-info-popup2[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
  		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
  		         <div class="container">
  		             <div class="user-data-form step-form-modal modal-content">
  		                 	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  		                 <div class="modal-cont">
  		                     <div class="boddy">
  		                         <h3 class="modal-head">Extracting Information...</h3>
  		                         <p style="text-align: left;font-size: 15px;">We’re automatically extracting the necessary details from your uploaded document. This won’t take long!</p>
  		                         <p style="  text-align: left;font-size:11px;">Please do not refresh the page during this process</p>
  		                         <img class="spinner1" src="images/loading.png" alt="">
  		                     </div>
  		                 </div>
  		             </div>
  		         </div>
  		     </div>
  		 </div>
  		 <!----------------------------------------- Data population Successful---------------------------------------------------------------------------------->
  		 <div class="foreignvehicle-modal modal fade" id="extract-info-complete2[0]" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
  		     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
  		         <div class="container">
  		             <div class="user-data-form step-form-modal modal-content w-600">
  		                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  		                 <div class="modal-cont">
  		                     <div class="boddy">
  		                         <h3 class="modal-head">Auto-population Complete</h3>
  		                         <p class="text-left">
  		                             <b>Your document has been submitted successfully</b>
  		                         </p>
  		                         <p class="text-left">The fields in this form have been auto-populated using the document you uploaded. Please review the information and make any necessary changes before proceeding </p>
  		                         <a href="#" data-bs-dismiss="modal" class="btn-four mt-20">Got it</a>
  		                         <br>
  		                     </div>
  		                     <div class="modal-btns step-mod-btns" style="margin-top:-20px">
  		                     </div>
  		                 </div>
  		             </div>
  		         </div>
  		     </div>
  		 </div>
 		 <!----------------------------------------- Document Type Mismatch---------------------------------------------------------------------------------->
 		 <div class="foreignvehicle-modal modal-lg-sec modal fade" id="docTypeMismatch" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
 		 		<div class="modal-dialog modal-fullscreen modal-dialog-centered">
 		 			<div class="container">
 		 				<div class="user-data-form step-form-modal modal-content">
 		 				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
 		 				<div class="modal-cont">
 		 					<div class="boddy">
 		 					<h3 class="modal-head">Document Type Mismatch</h3>
 		 					<p style="  text-align: left;">It looks like the type of document you selected (e.g., U.S. Passport) does not match the document you uploaded (e.g., Foreign Passport).</p>
 		 					<p style="  text-align: left;">Your document has been submitted, but Doc AI extraction cannot proceed with this mismatch. Please either upload the correct document or manually enter the required fields. </p>
 		 					<a href="/home" class="btn-four mt-20">UPLOAD ANOTHER DOCUMENT</a>
 		 					<a href="/home" class="btn-four mt-20" style="min-width: 40%;">Enter Manually</a><br>
 		 					</div>
 		 					</div>
 		 				</div>	
 		 			</div>
 		 		</div>
 		 	</div>
<!----------------------------------------- Document Type Mismatch---------------------------------------------------------------------------------->
<div class="modal fade" id="BeneEmailSuccessModel" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
		<div class="modal-dialog modal-fullscreen modal-dialog-centered">
			<div class="container">
				<div class="user-data-form step-form-modal modal-content">
				<div class="modal-cont">
					<div class="boddy">
					<h3 class="modal-head">Mail sent!</h3>
					<p class="text-left">Your form has been recorded. We'll notify you once the beneficial owner submits their form, so you can complete the final BOIR filing.</p>
					<a href="/dashboard" class="btn-four">Return to Dashboard</a><br>
					</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
	<!----------------------------------------- Title cards---------------------------------------------------------------------------------->
	<div class="modal hover-modal fade" id="queModal" tabindex="-1" aria-labelledby="queModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
		<div class="modal-content" id="boirNeedHelp0">
		  <div class="modal-header">
		    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
		    <p>
			Instructions – Type of filing: • Check box “Initial report” if this is the first BOIR filed for the reporting company. • Check box “Correct prior report” if the report corrects inaccurate information from a previously filed BOIR. • Check box “Update prior report” if the report updates a previously filed BOIR, for example, to include one or more new beneficial owners. • Check box “Newly exempt entity” if, after having filed a BOIR, the reporting company is now exempt from BOI reporting requirements. If this checkbox is selected, then filer must fill out fields (reporting company information associated with most recent report) and no other fields in the BOIR. • If type of filing is selected, enter values for “Legal name”, 1f “Tax identification type”, and “Tax identification number” for the reporting company that match the most recently filed BOIR. For example, if the reporting company previously filed an initial report and then an updated report, the reporting company information in the next updated report should match the reporting company information provided on the most recently filed updated report rather than the initial report. • For, select the tax identification type (i.e., a U.S. Employer Identification Number (EIN), a U.S. Social Security Number or Individual Taxpayer Identification Number (SSN-ITIN), or foreign taxpayer identification number (Foreign)) the reporting company reported in the most recently filed BOIR. If tax identification type entered in is “Foreign”, select the corresponding foreign country/jurisdiction in “Country/Jurisdiction (if foreign tax ID only)” associated with the foreign tax identification number. Instructions – Date prepared: This item is automatically populated with the current date.
		 </p>
		  </div>
		</div>

		<div class="modal-content" id="boirNeedHelp1">
		  <div class="modal-header">
		    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
		    <p>	Reporting company information is entered in fields of the BOIR.
		Instructions – Request to receive FinCEN Identifier (FinCEN ID):
		Check this box to receive a unique FinCEN Identifier for the reporting company. The FinCEN Identifier will be provided in the submission confirmation details provided to the filer after the BOIR is accepted.
		 
		Instructions– Foreign pooled investment vehicle:
		Check this box if the reporting company is a foreign pooled investment vehicle required to report information pursuant to 31 CFR 1010.380(b)(2)(iii).
		•If the reporting company is a foreign pooled investment vehicle, the company need only report one beneficial owner who exercises substantial control over the entity. If more than one individual exercise substantial control over the entity, the entity shall report information with respect to the individual who has the greatest authority over the strategic management of the entity. The report should not include any information about company applicants.</p>
		  </div>
		</div>

		<div class="modal-content" id="boirNeedHelp2">
		  <div class="modal-header">
		    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
		    <p>Instructions – Reporting company legal name: Enter the reporting company’s full legal name as recorded on the articles of incorporation or other documents creating or registering the entity. Instructions – Alternate name: Enter any of the reporting company’s trade names, “doing business as” or DBA names, or “trading as” or T/A names. If the reporting company has multiple alternate names, use the “+” or “-“ buttons in the BOIR to add additional alternate name fields (one field for each alternate name). Do not include the acronyms DBA or AKA with the alternate name.</p>
		  </div>
		</div>

			<div class="modal-content" id="boirNeedHelp3">
		     <div class="modal-header">
		       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		     </div>
		     <div class="modal-body">
		       <p>		Instructions – Tax identification type:
			Select “EIN” if the reporting company has a U.S. Employer Identification Number (EIN). Select “SSN-ITIN” if the reporting company utilizes a U.S. Social Security Number (SSN) or Individual Taxpayer Identification Number (ITIN) as a tax identification number. Select “Foreign” if the reporting company has a tax identification number issued by a foreign jurisdiction and does not have a U.S. tax identification number.
			Instructions – Tax identification number:
			Enter the tax identification number for the reporting company.
			Instructions – Country/Jurisdiction:
			If the tax identification type is “Foreign”, select the foreign country/jurisdiction that issued the foreign tax identification number.</p>
		     </div>
		   </div>

		  <div class="modal-content" id="boirNeedHelp4">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		      <p>Instructions – Jurisdiction of formation or first registration: Enter the country/jurisdiction of formation. If United States is selected, then next two fields should be completed, identifying the State or Tribal jurisdiction of formation. If a U.S. Territory is selected in country/jurisdiction, then item state is automatically populated with the relevant U.S. Territory, and then remain two fields are unavailable. If Item country/jurisdiction is a foreign country, then another two fields should be completed, identifying the State/U.S. Territory or Tribal jurisdiction in which the foreign reporting company first registered to do business in the United States. If the Tribal jurisdiction of formation or Tribal jurisdiction of first registration is not listed in the drop-down, select “Other” and enter the name of the Tribe in other two fields.</p>
		    </div>
		  </div>
		  
		  <div class="modal-content" id="boirNeedHelp5">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
			<p>		Instructions – Reporting company address:
			        Enter the reporting company’s complete current street address information, including city, State, ZIP Code, and select whether the address is in the United States or a specific U.S. Territory. If the reporting company has a principal place of business in the United States or U.S. Territory, the street address should be that of the principal place of business. Otherwise, the street address should be the primary location in the United States or U.S. Territory where the reporting company conducts business. If a U.S. Territory is selected , then it automatically populated with the relevant U.S. Territory.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp6">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Tax identification type:
			Select “EIN” if the reporting company has a U.S. Employer Identification Number (EIN). Select “SSN-ITIN” if the reporting company utilizes a U.S. Social Security Number (SSN) or Individual Taxpayer Identification Number (ITIN) as a tax identification number. Select “Foreign” if the reporting company has a tax identification number issued by a foreign jurisdiction and does not have a U.S. tax identification number.
			Instructions – Tax identification number:
			Enter the tax identification number for the reporting company.
			Instructions – Country/Jurisdiction:
			If the tax identification type is “Foreign”, select the foreign country/jurisdiction that issued the foreign tax identification number.</p>
		    </div>
		  </div>

		  <div class="modal-content" id="boirNeedHelp7">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		      <p>	Instructions – FinCEN ID:
		                                                                  Reporting companies may report the FinCEN ID for a company applicant instead of the information in fields. Enter the FinCEN ID as a single text string. If a FinCEN ID for the company applicant is not provided, information about the company applicant must be provided in fields.</p>
		    </div>
		  </div>

		  <div class="modal-content" id="boirNeedHelp8">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
			<p>
				Instructions – Identifying document type:
				Select the company applicant’s identifying document type from the list of acceptable documents: a non-expired State-issued driver’s license, a non-expired State/local/Tribe-issued identification document issued for the purpose of identifying the individual, a non-expired U.S. passport, or, only if the company applicant does not have one of these identifying documents, a non-expired foreign passport.
				Instructions – Identifying document number:
				Enter the identifying document number from the company applicant’s identifying document.
				Instructions – Identifying document issuing jurisdiction:
				Enter the country/jurisdiction that issued the company applicant’s identifying document. If a U.S. Territory issued the identifying document, select the applicable U.S. Territory (the same U.S. Territory will then be automatically populated “State” as a result). Enter the State issuing the identifying document when country/jurisdiction is United States, if applicable. If a local or Tribal government issued the identifying document, select “United States” and then select the applicable local or Tribal description. If the name of the relevant local or Tribal jurisdiction is not included in the drop-down menu, select “Other” and enter the name of the local or Tribal jurisdiction.
				Instructions for Item 19 – Identifying document image:
				Drag a file or click “choose from folder” to attach a clear, readable image of the page or side of the identifying document referenced containing the unique identifying number and other identifying data. Use the “Remove” button to remove the attached image if necessary. An attachment to a BOIR cannot be larger than four (4) megabytes of data and must be in one of the following formats: JPG/JPEG, PNG, or PDF. Only one (1) attachment file may be added per company applicant. Attachment file names should not contain spaces, and can only contain letters, numbers, or the following characters !@#$%()_-.=+[]|;~
			</p>
		    </div>
		  </div>



		  <div class="modal-content" id="boirNeedHelp9">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Suffix:
			Enter the company applicant's middle name if the company applicant’s legal name has a middle name. Leave this item blank if the company applicant does not have a middle name.
			Instructions – First name:
			Enter the company applicant’s legal first name.
			Instructions – Middle name:
			Enter the company applicant's middle name if the company applicant’s legal name has a middle name. Leave this item blank if the company applicant does not have a middle name.
			Instructions – Last name:
			Enter the company applicant’s legal last name.
			Instructions – Date of birth:
			        Enter the company applicant’s date of birth using the format MM/DD/YYYY where MM = month, DD = day, and YYYY = year (e.g., 01/25/1970). The month, day, and year must be provided; no partial dates are accepted.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp10">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Address type:
			Indicate address type as “Business address” or “Residential address” for the company applicant. For a company applicant who forms or registers an entity in the course of their business, such as paralegals, report the street address of such business. In any other case, the individual’s residential street address must be reported.
			Instructions– Company applicant address:
			        Enter the company applicant’s street address information, including the city, country or jurisdiction, State, and ZIP code or foreign postal code. U.S. Territories are included in the drop-down menu for “Country/Jurisdiction.” The “State” will be automatically populated when a U.S. Territory is selected in the “Country/Jurisdiction”.“State” is required if the country selected in is the United States, Canada, or Mexico.
				</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp11">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Parent/Guardian information instead of minor child:
			                                                                 If the beneficial owner for the reporting company is a minor child, you may check this box and complete Part III with information about a parent or legal guardian of the minor child.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp12">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions– FinCEN ID:
			                                                                  Reporting companies may provide a FinCEN Identifier for a beneficial owner. Enter the FinCEN ID as a single text string. If a FinCEN ID for the beneficial owner is not provided, information about the beneficial owner must be provided.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp13">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Exempt entity:
																	Check this box if the beneficial owner holds its ownership interest in the reporting company exclusively through one or more exempt entities, and the name of that exempt entity or entities are being reported in lieu of the beneficial owner’s information. If checked, provide the legal name of the exempt entity in field.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp14">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Identifying document type:
			      Select the beneficial owner’s non-expired identifying document type from the list of acceptable identification documents: a State-issued driver’s license, a State/local/Tribe-issued identification document issued for the purpose of identifying the individual, a U.S. passport, or, only if the beneficial owner does not have one of these three types of identifying documents, a foreign passport.
			      Instructions – Identifying document number:
			      Enter the identifying document number from the beneficial owner’s identifying document.
			      Instructions – Identifying document issuing jurisdiction:
			      Enter the country/jurisdiction that issued the beneficial owner’s identifying document. If a U.S. Territory issued the identifying document, select the applicable U.S. Territory in (the same U.S. Territory will then be automatically populated in “State” as a result). Enter in the State that issued the identifying document when country/jurisdiction is United States, if applicable. If a local or Tribal government issued the identifying document, select “United States” and then select the applicable local or Tribal description. If the name of the relevant local or Tribal jurisdiction is not included in the drop-down menu, select “Other” and enter the name of the local or Tribal jurisdiction.
			      Instructions – Identifying document image:
			      Drag a file or click “choose from folder” to attach a clear, readable image of the page or side of the identifying document referenced containing the unique identifying number and other identifying data. Use the “Remove” button to remove the attached image if necessary. An attachment to a BOIR cannot be larger than four (4) megabytes of data and must be in one of the following formats: JPG/JPEG, PNG, or PDF. Only one (1) attachment file may be added per beneficial owner. Attachment file names should not contain spaces, and can only contain letters, numbers, or the following characters !@#$%()_-.=+[]|;~</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp15">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Individual’s last name or entity’s legal name:
			       Enter the beneficial owner's legal last name or the exempt entity's legal name. An entity’s legal name is the name on the articles of incorporation or other document that created or registered the entity. Do not abbreviate names unless an abbreviation is part of the legal name.
			       Instructions – First name:
			       Enter the beneficial owner's legal first name.
			       Instructions – Middle name:
			       Enter the beneficial owner's middle name if the beneficial owner’s legal name includes a middle name. Leave this item blank if the beneficial owner does not have a middle name.
			       Instructions – Suffix:
			       Enter the beneficial owner’s suffix such as JR, SR, III, etc., if the beneficial owner has a suffix to their legal name. Leave this item blank if the beneficial owner’s legal name does not include a suffix.
			       Instructions – Date of birth:
			       Enter the beneficial owner’s date of birth, using the format MM/DD/YYYY where MM = month, DD = day, and YYYY = year (e.g., 01/25/1970). The month, day, and year must be provided; no partial dates will be accepted.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp16">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>		Instructions – Beneficial owner address:
			       Enter the beneficial owner’s residential street address information, including the city, country or jurisdiction, State, and ZIP code or foreign postal code. U.S. Territories are included in the drop-down menu for “Country/Jurisdiction.” The “State” will be automatically populated when a U.S. Territory is selected in the “Country/ Jurisdiction”. “State” is required if the country selected is the United States, Canada, or Mexico.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp17">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		  	<p>				Company applicant information is entered in fields of the BOIR. Company applicants are individuals; no companies or legal entities may be reported as company applicants. Reporting companies may also provide FinCEN Identifiers for company applicants instead of this information. See detailed description below.
				  Use the “Add Company Applicant” or “Remove Company Applicant” keys at the top of this section to add or remove additional company applicants. No more than two company applicants should be reported.
				  If existing reporting company was checked, company applicant information is not required; proceed to Part III.</p>
		    </div>
		  </div>


		  <div class="modal-content" id="boirNeedHelp18">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
			<p>	Beneficial owner information is entered in fields of the BOIR. Reporting companies may also report a FinCEN Identifier for a beneficial owner instead of this information. See detailed description below.
	 			Use the “Add Beneficial Owner” or “Remove Beneficial Owner” keys at the top of this section to add or remove additional beneficial owners. There is no limit on the number of beneficial owners that may be reported.</p>
		    </div>
		  </div>

        <div class="modal-content" id="boirNeedHelp19">
         <div class="modal-header">
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
          <p>This notice is given under the Privacy Act of 1974 (Privacy Act) and the Paperwork Reduction Act of 1995 (Paperwork Reduction Act). The Privacy Act and Paperwork Reduction Act require that FinCEN inform persons of the following when requesting and collecting information in connection with this collection of information.
            This collection of information is authorized under 31 U.S.C. 5336 and 31 C.F.R. 1010.380. The principal purpose of this collection of information is to generate a database of information that is highly useful in facilitating national security, intelligence, and law enforcement activities, as well as compliance with anti-money laundering, countering the financing of terrorism, and customer due diligence requirements under applicable law. Pursuant to 31 U.S.C. 5336 and 31 C.F.R. 1010.380, reporting companies and certain other persons must provide specified information. The provision of that information is mandatory and failure to provide that information may result in criminal and civil penalties. The provision of information for the purpose of requesting a FinCEN Identifier is voluntary; however, failure to provide such information may result in the denial of such a request.
            Generally, the information within this collection of information may be shared as a “routine use” with other government agencies and financial institutions that meet certain criteria under applicable law. The complete list of routine uses of the information is set forth in the relevant Privacy Act system of record notice available at https://www.federalregister.gov/documents/2023/09/13/2023-19814/privacy-act-of-1974-system-of-records.
            According to the Paperwork Reduction Act of 1995, no persons are required to respond to a collection of information unless it displays a valid OMB control number. The valid OMB control number for this information collection is 1506-0076. It expires on November 30, 2026.
            The estimated average burden associated with this collection of information from reporting companies is 90 to 650 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with reporting companies updating information previously provided is 40 to 170 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with this collection of information from individuals applying for FinCEN identifiers is 20 minutes per applicant. The estimated average burden associated with individuals who have obtained FinCEN identifiers updating information previously provided is 10 minutes per individual. Comments regarding the accuracy of this burden estimate, and suggestions for reducing the burden should be directed to the Financial Crimes Enforcement Network, P. O. Box 39, Vienna, VA 22183, Attn: Policy Division.</p>
         </div>
        </div>
		
		
		<div class="modal-content" id="boirNeedHelp20">
        <div class="modal-header">
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
         <p>This notice is given under the Privacy Act of 1974 (Privacy Act) and the Paperwork Reduction Act of 1995 (Paperwork Reduction Act). The Privacy Act and Paperwork Reduction Act require that FinCEN inform persons of the following when requesting and collecting information in connection with this collection of information.
			This collection of information is authorized under 31 U.S.C. 5336 and 31 C.F.R. 1010.380. The principal purpose of this collection of information is to generate a database of information that is highly useful in facilitating national security, intelligence, and law enforcement activities, as well as compliance with anti-money laundering, countering the financing of terrorism, and customer due diligence requirements under applicable law. Pursuant to 31 U.S.C. 5336 and 31 C.F.R. 1010.380, reporting companies and certain other persons must provide specified information. The provision of that information is mandatory and failure to provide that information may result in criminal and civil penalties. The provision of information for the purpose of requesting a FinCEN Identifier is voluntary; however, failure to provide such information may result in the denial of such a request.
			Generally, the information within this collection of information may be shared as a “routine use” with other government agencies and financial institutions that meet certain criteria under applicable law. The complete list of routine uses of the information is set forth in the relevant Privacy Act system of record notice available at https://www.federalregister.gov/documents/2023/09/13/2023-19814/privacy-act-of-1974-system-of-records.
			According to the Paperwork Reduction Act of 1995, no persons are required to respond to a collection of information unless it displays a valid OMB control number. The valid OMB control number for this information collection is 1506-0076. It expires on November 30, 2026.
			The estimated average burden associated with this collection of information from reporting companies is 90 to 650 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with reporting companies updating information previously provided is 40 to 170 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with this collection of information from individuals applying for FinCEN identifiers is 20 minutes per applicant. The estimated average burden associated with individuals who have obtained FinCEN identifiers updating information previously provided is 10 minutes per individual. Comments regarding the accuracy of this burden estimate, and suggestions for reducing the burden should be directed to the Financial Crimes Enforcement Network, P. O. Box 39, Vienna, VA 22183, Attn: Policy Division.</p>
        </div>
       </div>
			   
	   <div class="modal-content" id="boirNeedHelp21">
	        <div class="modal-header">
	          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        <div class="modal-body">
	         <p>This notice is given under the Privacy Act of 1974 (Privacy Act) and the Paperwork Reduction Act of 1995 (Paperwork Reduction Act). The Privacy Act and Paperwork Reduction Act require that FinCEN inform persons of the following when requesting and collecting information in connection with this collection of information.
				This collection of information is authorized under 31 U.S.C. 5336 and 31 C.F.R. 1010.380. The principal purpose of this collection of information is to generate a database of information that is highly useful in facilitating national security, intelligence, and law enforcement activities, as well as compliance with anti-money laundering, countering the financing of terrorism, and customer due diligence requirements under applicable law. Pursuant to 31 U.S.C. 5336 and 31 C.F.R. 1010.380, reporting companies and certain other persons must provide specified information. The provision of that information is mandatory and failure to provide that information may result in criminal and civil penalties. The provision of information for the purpose of requesting a FinCEN Identifier is voluntary; however, failure to provide such information may result in the denial of such a request.
				Generally, the information within this collection of information may be shared as a “routine use” with other government agencies and financial institutions that meet certain criteria under applicable law. The complete list of routine uses of the information is set forth in the relevant Privacy Act system of record notice available at https://www.federalregister.gov/documents/2023/09/13/2023-19814/privacy-act-of-1974-system-of-records.
				According to the Paperwork Reduction Act of 1995, no persons are required to respond to a collection of information unless it displays a valid OMB control number. The valid OMB control number for this information collection is 1506-0076. It expires on November 30, 2026.
				The estimated average burden associated with this collection of information from reporting companies is 90 to 650 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with reporting companies updating information previously provided is 40 to 170 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with this collection of information from individuals applying for FinCEN identifiers is 20 minutes per applicant. The estimated average burden associated with individuals who have obtained FinCEN identifiers updating information previously provided is 10 minutes per individual. Comments regarding the accuracy of this burden estimate, and suggestions for reducing the burden should be directed to the Financial Crimes Enforcement Network, P. O. Box 39, Vienna, VA 22183, Attn: Policy Division."</p>
	        </div>
	       </div>
		   
		   
	   <div class="modal-content" id="boirNeedHelp22">
   	        <div class="modal-header">
   	          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
   	        </div>
   	        <div class="modal-body">
   	         <p>This notice is given under the Privacy Act of 1974 (Privacy Act) and the Paperwork Reduction Act of 1995 (Paperwork Reduction Act). The Privacy Act and Paperwork Reduction Act require that FinCEN inform persons of the following when requesting and collecting information in connection with this collection of information.
				This collection of information is authorized under 31 U.S.C. 5336 and 31 C.F.R. 1010.380. The principal purpose of this collection of information is to generate a database of information that is highly useful in facilitating national security, intelligence, and law enforcement activities, as well as compliance with anti-money laundering, countering the financing of terrorism, and customer due diligence requirements under applicable law. Pursuant to 31 U.S.C. 5336 and 31 C.F.R. 1010.380, reporting companies and certain other persons must provide specified information. The provision of that information is mandatory and failure to provide that information may result in criminal and civil penalties. The provision of information for the purpose of requesting a FinCEN Identifier is voluntary; however, failure to provide such information may result in the denial of such a request.
				Generally, the information within this collection of information may be shared as a “routine use” with other government agencies and financial institutions that meet certain criteria under applicable law. The complete list of routine uses of the information is set forth in the relevant Privacy Act system of record notice available at https://www.federalregister.gov/documents/2023/09/13/2023-19814/privacy-act-of-1974-system-of-records.
				According to the Paperwork Reduction Act of 1995, no persons are required to respond to a collection of information unless it displays a valid OMB control number. The valid OMB control number for this information collection is 1506-0076. It expires on November 30, 2026.
				The estimated average burden associated with this collection of information from reporting companies is 90 to 650 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with reporting companies updating information previously provided is 40 to 170 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with this collection of information from individuals applying for FinCEN identifiers is 20 minutes per applicant. The estimated average burden associated with individuals who have obtained FinCEN identifiers updating information previously provided is 10 minutes per individual. Comments regarding the accuracy of this burden estimate, and suggestions for reducing the burden should be directed to the Financial Crimes Enforcement Network, P. O. Box 39, Vienna, VA 22183, Attn: Policy Division.</p>
   	        </div>
   	       </div>
		   

		  <div class="modal-content" id="boirNeedHelp23">
		    <div class="modal-header">
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		     <p>This notice is given under the Privacy Act of 1974 (Privacy Act) and the Paperwork Reduction Act of 1995 (Paperwork Reduction Act). The Privacy Act and Paperwork Reduction Act require that FinCEN inform persons of the following when requesting and collecting information in connection with this collection of information.
		       This collection of information is authorized under 31 U.S.C. 5336 and 31 C.F.R. 1010.380. The principal purpose of this collection of information is to generate a database of information that is highly useful in facilitating national security, intelligence, and law enforcement activities, as well as compliance with anti-money laundering, countering the financing of terrorism, and customer due diligence requirements under applicable law. Pursuant to 31 U.S.C. 5336 and 31 C.F.R. 1010.380, reporting companies and certain other persons must provide specified information. The provision of that information is mandatory and failure to provide that information may result in criminal and civil penalties. The provision of information for the purpose of requesting a FinCEN Identifier is voluntary; however, failure to provide such information may result in the denial of such a request.
		       Generally, the information within this collection of information may be shared as a “routine use” with other government agencies and financial institutions that meet certain criteria under applicable law. The complete list of routine uses of the information is set forth in the relevant Privacy Act system of record notice available at https://www.federalregister.gov/documents/2023/09/13/2023-19814/privacy-act-of-1974-system-of-records.
		       According to the Paperwork Reduction Act of 1995, no persons are required to respond to a collection of information unless it displays a valid OMB control number. The valid OMB control number for this information collection is 1506-0076. It expires on November 30, 2026.
		       The estimated average burden associated with this collection of information from reporting companies is 90 to 650 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with reporting companies updating information previously provided is 40 to 170 minutes per respondent for reporting companies with simple or complex beneficial ownership structures, respectively. The estimated average burden associated with this collection of information from individuals applying for FinCEN identifiers is 20 minutes per applicant. The estimated average burden associated with individuals who have obtained FinCEN identifiers updating information previously provided is 10 minutes per individual. Comments regarding the accuracy of this burden estimate, and suggestions for reducing the burden should be directed to the Financial Crimes Enforcement Network, P. O. Box 39, Vienna, VA 22183, Attn: Policy Division.</p>
		    </div>
		   </div>
		   




		</div>
	</div>
   </body>
   <!-- Include Footer -->
   <%@ include file="/WEB-INF/views/footer.jsp" %>
   <!--footer end-->
   <button class="scroll-top">
   <i class="bi bi-arrow-up-short"></i>
   </button>
   <!-- Custom Jquery for validation links -->
   <script src="vendor/jquery.min.js"></script>
   <script src="js/jquery.validate.min.js"></script>
   <script src="js/additional-methods.min.js"></script>
   <!-- <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
   <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script> -->
   <!-- Bootstrap JS -->
   <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
   <!-- WOW js -->
   <script src="vendor/wow/wow.min.js"></script>
   <!-- Slick Slider -->
   <script src="vendor/slick/slick.min.js"></script>
   <!-- Fancybox -->
   <script src="vendor/fancybox/dist/jquery.fancybox.min.js"></script>
   <!-- Lazy -->
   <script src="vendor/jquery.lazy.min.js"></script>
   <!-- js Counter -->
   <script src="vendor/jquery.counterup.min.js"></script>
   <script src="vendor/jquery.waypoints.min.js"></script>
   <!-- validator js -->
   <script src="vendor/validator.js"></script>
   <!-- Theme js -->
   <script src="js/theme.js"></script>
   <script src="js/boirValidator.js"></script>
   <script src="js/boirdocai.js"></script>
   <script src="js/boirValidator2.js"></script>
   </div>
   
   <script>
       $('#filingpre').prop('disabled', true);

   //3rd form 16 existing report	 
   $('#existyes').on('change', function() {
       if ($(this).is(':checked')) {
           $('#existingrepotModal').modal('show');
       }
   });

   let idArray = ['#addcom', '.comfincin-id', '.com-idt', '.com-idi', '.com-idn', '.com-counjuri', '.com-state', '.com-suffix', '.com-fn', '.com-midname', '.com-lname', '.com-dob', '.com-addtype', '.com-address', '.com-city', '.com-countryjuri', '.company-state', '.com-zipcode'];

   $('#existok').on('click', function() {
       $('#existingrepotModal').modal('hide');
	   $('.radio-que-sec-para').show();
       if (foreignVehicleConfirmed) {
           // If the foreign vehicle modal has been confirmed, use foriegnArray
           foriegnArray.forEach(function(selector) {
               $(selector).prop('disabled', true);
           });
       } else {
           // Otherwise, use the original idArray
           idArray.forEach(function(selector) {
               $(selector).prop('disabled', true);
           });
       }
   });

   $('#existno').on('click', function() {
       if (foreignVehicleConfirmed) {
           // If the foreign vehicle modal has been confirmed, use foriegnArray
           foriegnArray.forEach(function(selector) {
               $(selector).prop('disabled', true);
           });
		   $('.radio-que-sec-para').show();
       } else {
           // Otherwise, use the original idArray
           idArray.forEach(function(selector) {
               $(selector).prop('disabled', false);
           });
		   $('.radio-que-sec-para').hide();
       }
   });

   //2nd form Foreign pooled investment vehicle	
   let foreignVehicleConfirmed = false;

   $('#foreigninveyes').on('change', function() {
       if ($(this).is(':checked')) {
           $('#foreigninvevehicleModal').modal('show');
       }
   });

   let foriegnArray = ['#addcom', '.comfincin-id', '.com-idt', '.com-idi', '.com-idn', '.com-counjuri', '.com-state', '.com-suffix', '.com-fn', '.com-midname', '.com-lname', '.com-dob', '.com-addtype', '.com-address', '.com-city', '.com-countryjuri', '.company-state', '.com-zipcode', '#addBeneficial'];

   $('#foreignvehicleok').on('click', function() {
       $('#foreigninvevehicleModal').modal('hide');
       foreignVehicleConfirmed = true;

       foriegnArray.forEach(function(selector) {
           $(selector).prop('disabled', true);
       });
   });

   $('#foreigninveno').on('click', function() {
       foreignVehicleConfirmed = false;
       foriegnArray.forEach(function(selector) {
           $(selector).prop('disabled', false);
       });
   });

   // 3 rd form Fencenid Start

   $('.comfincin-id').on('blur', function() {
             let fincenValue = $(this).val().trim(); // Get trimmed value
             let isValidFincen = /^\d{4}-\d{4}-\d{4}$/.test(fincenValue); // Validate the format
             if (fincenValue.length === 0 || !isValidFincen) {
                 $('#existrepotcom').show(); // Show the error div if the value is invalid
             } else {
                 $('#existrepotcom').hide(); // Hide the error div if valid
             }
         });
         // Clear field if invalid format on focus on other inputs
         $('input').not('.comfincin-id').on('focus', function() {
             let fincenField = $('.comfincin-id');
             let fincenValue = fincenField.val().trim(); // Get the trimmed value
             let isValidFincen = /^\d{4}-\d{4}-\d{4}$/.test(fincenValue); // Validate the format
             if (!isValidFincen && fincenValue.length > 0) {
                 // Clear the value if it's invalid
                 fincenField.val('');
             }
         });
	// 3 rd form Fencenid End	
	
   //4th form fincenid hide code

   $(document).ready(function() {
        $('.ben-fincenid').on('blur', function() {
            let fincenValue = $(this).val().trim();
            let isValidFincen = /^\d{4}-\d{4}-\d{4}$/.test(fincenValue);
            
            if (fincenValue.length === 0 || !isValidFincen) {
                // Show the div if the value is invalid
                $('#benificialfinid').show();
				$('#benficialnamefieldp2').hide();
            } else {
                // Hide the div if the value is valid
                $('#benificialfinid').hide();
				$('#benficialnamefieldp2').show();
            }
        });
	  $('input').not('.ben-fincenid').on('focus', function() {
	           let fincenField = $('.ben-fincenid');
	           let fincenValue = fincenField.val().trim();
	           let isValidFincen = /^\d{4}-\d{4}-\d{4}$/.test(fincenValue);
 
	           if (!isValidFincen && fincenValue.length > 0) {
	               // Clear the value if it's invalid
             fincenField.val('');
	           }
	       });
    });

   //4th form benificial

   $('input[name^="beneficialOwner"]').on('change', function() {
    });
   //$('input[name="beneficialOwner[0].exemptEntity"]').on('change', function() {
   $(document).ready(function() {
       $('#beneficialOwner\\[0\\]\\.exemptEntity').on('change', function() {
            // Extract the index from the name attribute
           var nameAttr = $(this).attr('name');
           var indexMatch = nameAttr.match(/\[(\d+)\]/);

           if (indexMatch) {
               var index = indexMatch[1]; // This is the dynamic index
                let flag = $(this).val();
               try {
                   // Use the dynamic index in the selector for 'exemptEntity' field
 
                   if (flag === "true") {
                        $('#parentfinceid').hide();
                       $('.benexemptidi').hide();
                       $('#benficialexempt').hide();
                   } else if (flag === "false") {
                        $('#parentfinceid').show();
                       $('.benexemptidi').show();
                       $('#benficialexempt').show();
                   }
               } catch (e) {
                }
               // Perform your logic for the specific beneficialOwner index
           }
       });
   });

   $('#beneficialOwner\\[2\\]\\.exemptEntity').on('change', function() {
    });

   // new script for fincen ID start
   $(document).ready(function() {
       // Automatically format input with hyphens and block non-digit characters immediately
       $(document).on('input', 'input[name^="companyApplicantInfo"][name$="finCenId"]', function() {
           // Capture the value and remove any non-digit characters immediately
           let value = $(this).val().replace(/[^\d]/g, '');
           if (value.length > 12) {
               value = value.substring(0, 12); // Limit to 12 digits
           }
           // Insert hyphens after every 4 digits
           let formattedValue = value.replace(/(\d{4})(?=\d)/g, '$1-');
           $(this).val(formattedValue);
       });

       // Define the custom validation method
       $.validator.addMethod("fincenFormat", function(value, element) {
           return this.optional(element) || /^\d{4}-\d{4}-\d{4}$/.test(value);
       }, "FinCEN ID must be 12 numeric characters");

       // Apply the validation rules to each element with the specified name pattern
       $(document).on('focusin', 'input[name^="companyApplicantInfo"][name$="finCenId"]', function() {
           $(this).rules("add", {
               fincenFormat: true,
               maxlength: 14, // 12 digits + 2 hyphens
               minlength: 14,
               messages: {
                   fincenFormat: "FinCEN ID must be 12 numeric characters.",
                   maxlength: "FinCEN ID must be exactly 12 digits with hyphens.",
                   minlength: "FinCEN ID must be exactly 12 digits with hyphens."
               }
           });
       });
   });


   // new script for fincen ID start for 4th form  
   $(document).ready(function() {
         // Automatically format input with hyphens and block non-digit characters immediately
         $(document).on('input', 'input[name^="beneficialOwner"][name$="finCenId"]', function() {
             let value = $(this).val().replace(/[^\d]/g, ''); // Remove non-digit characters
             if (value.length > 12) {
                 value = value.substring(0, 12); // Limit to 12 digits
             }
             let formattedValue = value.replace(/(\d{4})(?=\d)/g, '$1-'); // Insert hyphens
             $(this).val(formattedValue);
         });
   
         // Custom validation method for FinCEN format
         $.validator.addMethod("fincenFormat", function(value, element) {
             return this.optional(element) || /^\d{4}-\d{4}-\d{4}$/.test(value);
         }, "FinCEN ID must be 12 numeric characters");
   
         // Apply validation when focusing on FinCEN ID field
         $(document).on('focusin', 'input[name^="beneficialOwner"][name$="finCenId"]', function() {
             $(this).rules("add", {
                 fincenFormat: true,
                 maxlength: 14, // 12 digits + 2 hyphens
                 minlength: 14,
                 messages: {
                     fincenFormat: "FinCEN ID must be 12 numeric characters.",
                     maxlength: "FinCEN ID must be exactly 12 digits with hyphens.",
                     minlength: "FinCEN ID must be exactly 12 digits with hyphens."
                 }
             });
         });
     });
   // new script for fincen ID End

   // Script for 33, 34 fields for country and state start
   $(document).ready(function() {
       // U.S. Territories
       var usTerritories = {
           "AS": "American Samoa",
           "GU": "Guam",
           "MH": "Marshall Islands",
           "FM": "Micronesia, Federated States",
           "MP": "Northern Mariana Islands",
           "PW": "Palau",
           "PR": "Puerto Rico",
           "VI": "U.S. Virgin Islands"
       };

       // Countries that should disable the "State" dropdown
       var disableStateCountries = ["AF", "AX", "AL", "DZ", /* ... other countries ... */ ];

       // Store the original options of the state dropdown
       var originalStateOptions = $('#companyApplicantInfo\\[0\\]\\.address\\.state').html();

       // Delegate event listener to a parent element for dynamically added elements
       $(document).on('change', '[id^="companyApplicantInfo"][id$="\\.address\\.country"]', function() {
           var selectedCountry = $(this).val();
           var formIndex = $(this).attr('id').match(/\d+/)[0]; // Extract the index from the element's ID
           var stateDropdown = $('#companyApplicantInfo\\[' + formIndex + '\\]\\.address\\.state');

           // Handle United States of America
           if (selectedCountry === "US") {
			document.getElementById('comStateStar').style.display = 'inline';
               stateDropdown.prop('disabled', false).empty().append(originalStateOptions); // Restore original options
           }
           // Handle U.S. Territories
           else if (usTerritories.hasOwnProperty(selectedCountry)) {
               stateDropdown.prop('disabled', true).empty(); // Disable and empty the dropdown
               // Populate with the same value and label for the selected territory
			   document.getElementById('comStateStar').style.display = 'none';
               stateDropdown.append('<option value="' + selectedCountry + '">' + usTerritories[selectedCountry] + '</option>');
               stateDropdown.val(selectedCountry);
           }
           // Handle countries that should completely disable the "State" dropdown
           else if (disableStateCountries.includes(selectedCountry)) {
               stateDropdown.prop('disabled', true).empty();
			   document.getElementById('comStateStar').style.display = 'none';
           }
           // Reset for other countries
           else {
               stateDropdown.prop('disabled', true).empty();
			   document.getElementById('comStateStar').style.display = 'none';
           }
       });
   });

   // Script for 33, 34  fields for country and state end

   // Script for 54, 55  fields for country and state start


   $(document).ready(function() {
       // U.S. Territories
       var usTerritories = {
           "AS": "American Samoa",
           "GU": "Guam",
           "MH": "Marshall Islands",
           "FM": "Micronesia, Federated States",
           "MP": "Northern Mariana Islands",
           "PW": "Palau",
           "PR": "Puerto Rico",
           "VI": "U.S. Virgin Islands"
       };

       // Countries that should disable the "State" dropdown
       var disableStateCountries = ["AF", "AX", "AL", "DZ", /* ... other countries ... */ ];
       // Store the original options of the state dropdown
       var originalStateOptions = $('select[name^="beneficialOwner"][name$=".address.state"]').html();
       // Delegate event listener to a parent element for dynamically added elements
       $(document).on('change', 'select[name^="beneficialOwner"][name$=".address.country"]', function() {
           var selectedCountry = $(this).val();
           var formIndex = $(this).attr('name').match(/\d+/)[0]; // Extract the index from the element's name attribute
           var stateDropdown = $('select[name="beneficialOwner[' + formIndex + '].address.state"]');

           // Handle United States of America
           if (selectedCountry === "US") {
			document.getElementById('benStateStar').style.display = 'inline';
               stateDropdown.prop('disabled', false).empty().append(originalStateOptions); // Restore original options
           }
           // Handle U.S. Territories
           else if (usTerritories.hasOwnProperty(selectedCountry)) {
               stateDropdown.prop('disabled', true).empty(); // Disable and empty the dropdown
               // Populate with the same value and label for the selected territory
			   document.getElementById('benStateStar').style.display = 'none';
               stateDropdown.append('<option value="' + selectedCountry + '">' + usTerritories[selectedCountry] + '</option>');
               stateDropdown.val(selectedCountry);
           }
           // Handle countries that should completely disable the "State" dropdown
           else if (disableStateCountries.includes(selectedCountry)) {
			document.getElementById('benStateStar').style.display = 'none';
               stateDropdown.prop('disabled', true).empty();
           }
           // Reset for other countries
           else {
			document.getElementById('benStateStar').style.display = 'none';
               stateDropdown.prop('disabled', true).empty();
           }
       });
   });

   // Script for 54,55 fields for country and state end  
      $(document).ready(function() {
   		$('#submitnowpopup').on('click', function(event) {
   			//event.preventDefault(); // Prevent the default link behavior
   			 	$('#submitnowModal').modal('show'); // Show the modal manually
   		});
   		$('input[type="checkbox"]').on('change', function() {
              // Check if #submitYes is checked
              if ($('#submitYes').is(':checked')) {
                  $('#bankAccount').val('True'); 
              } else {
                  $('#bankAccount').val('False');
              }

              // Check if #submitNo is checked
              if ($('#submitNo').is(':checked')) {
                  $('#taxFIlingServices').val('True');
              } else {
                  $('#taxFIlingServices').val('False');
              }
          });
       $("#next6").click(function(e) {
		$(this).prop("disabled", true);
           e.preventDefault(); // Prevent default action to ensure form submission does not happen automatically
 		   if (document.getElementById('submitNo').checked || document.getElementById('submitYes').checked) {
		       document.getElementById('ThankYouBank').style.display = 'block';
		   }
           // Validate the reCAPTCHA
 //         let response = grecaptcha.getResponse();
 //         if (response.length === 0 && !window.location.href.includes("localhost")) {
 //             $('#recaptcha-error-preview').text('Please confirm you are not a robot');
 //          } else {
 //             $('#recaptcha-error-preview').text(''); // Clear the error message if reCAPTCHA is completed
               // Show loader and proceed with AJAX request
               //showLoader();
               $(this).addClass("loading").prop("disabled", true);
               setTimeout(() => $(this).removeClass("loading").prop("disabled", false), 90000);
               let filingInfoId = document.getElementById("filingInfoId").value;
               $.ajax({
                   url: '/submitBoir/' + filingInfoId,
                   type: 'POST',
				   timeout:300000,
   				   data: 'bankAccount=' + $("#bankAccount").val()+'&taxFIlingServices='+$("#taxFIlingServices").val()+'&filingInfoId'+filingInfoId,
                   success: function(response) {
                       if (response.success) {
                           $("#step6").removeClass("active");
                           $("#step7").addClass("active");
						   var reportingCom = $("#Acknowledgement");
						   if (reportingCom.length > 0) {
						       var firstField = reportingCom.find("table").first();
						       if (firstField.length > 0) {

						           // Optionally scroll to the first field (if needed)
						           $('html, body').animate({

						               scrollTop: firstField.offset().top - 200 // Adjust the offset as needed
						           }, 500);
						       } else {
						           console.error("No radio buttons found inside #Acknowledgement.");
						       }
						   } else {
						       console.error("#Acknowledgement element not found.");
						   }
                           // Update the form fields with response data
                           $("#processId").html(response.processId);
                           $("#submissionStatus").html(response.submissionStatus);
                           $("#boirid").html(response.boirid);
                           $("#fincenID").html(response.fincenID);
                           if (response.submissionStatus != null && response.submissionStatus == "submission_accepted") {
                               $("#errordata").html("No Errors");
                           } else {
                               $("#errordata").html(response.errordata);
                           }
                           $("#initiatedTimestamp").html(response.initiatedTimestamp);
                           $("#Beneficialowner").html(response.Beneficialowner);
                           if (response.submissionStatus === "submission_accepted") {
                               $("#submissionStatusfields").show();
							   
                           } else {
                               $("#submissionStatusfields").hide();
                           }
                           $.each(response.Beneficialowner, function(index, owner) {
                               var fullName = owner.firstName + " " + owner.legalName;
                               $("#BeneficialownerlegalName").append(
                                   $('<option></option>').val(fullName).text(fullName)
                               );
                               var certificateurl = "/certificate/" + filingInfoId + "/" + encodeURIComponent(fullName);
                               $("#certificate").attr("href", certificateurl);

                               return false;
                           });
                           var lcertificateurl = "/certificate/" + filingInfoId;
                           $("#lcertificate").attr("href", lcertificateurl);
                           var transcripturl = "/transcript/" + filingInfoId;
                           $("#transcript").attr("href", transcripturl);
                           //alert("Boir Submitted successfully");
						   $('#submitnowModal').modal('hide');
                           hideLoader();
                       } else {
                           hideLoader();
                           // Display an error message
						   alert('Form submission failed: ' + response.message);
 
                       }
                   },
                   error: function(xhr, status, error) {
                       // Hide the loader
                       hideLoader();
                       // Display an error message
					   alert("Please review the current request status in the 'Submitted Reports' section of your dashboard before resubmitting." + error);
					   window.location.href = '/dashboard';

                    }
               });
 //          }
       });
   });
   window.onload = function() {
       // Find the checked radio button on page load
       const checkedRadioButton = document.querySelector('input[name="filingType"]:checked');

       // If there is a checked radio button, trigger the 'change' event manually
       if (checkedRadioButton) {
           checkedRadioButton.dispatchEvent(new Event('change'));
       }
   };
   //ended by Ananth
 </script>

<script src="js/stepform.js"></script>
<script>
$(document).ready(function () {
  // $(".hover-modal-btn").mouseover(function(){
  //   $(".hover-modal").modal('show');
  // });


  $(document).on('click','.hover-modal-btn',function(){
  var myTargetModal =  $(this).attr('href');
    $('#queModal').modal('hide');
    $('.hover-modal .modal-content').hide();
    
     $(myTargetModal).show();
    $('#queModal').modal('show');
    
    //return false;
  });

  $("body" ).on( "click",".close", function() {
      $('#queModal').hide();
      $('.hover-modal .modal-content').hide();
  });

 
});
</script>
   </body>
</html>