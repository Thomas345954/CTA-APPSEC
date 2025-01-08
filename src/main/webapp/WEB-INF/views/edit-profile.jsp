<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
   <head>
	
   <!--Externa;-->
	<%@ include file="/WEB-INF/views/css.jsp" %>
      
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<title>Edit Profile</title>
   </head>
   <style>
       #name-error, #email-error, #last_name-error, #id_code-error, #number-error {
           color: #B31942;
       }
   </style>
   <body>	
      <div id="tabContent">
		<!-- Profile Image successfully uploaded popup-->
			<div class="profilepopup-modal modal fade" id="profilepopupsucc" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
			     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
			         <div class="container">
			             <div class="user-data-form step-form-modal modal-content">
							<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
			                 <div class="modal-cont">
			                     <h2>Profile Picture Uploaded</h2>
			                     <p>Your new profile picture looks great! Don’t forget to hit 'Save' to make sure it updates on your profile.</p>
			                    <div class="modal-btns step-mod-btns">
			                         <button class="blue-btn" data-bs-dismiss="modal" id="sucOkButton">Okay</button>
			                     </div>
			                 </div>
			             </div>
			         </div>
			     </div>
			 </div>
			 
			 <!-- Profile Image successfully uploaded popup-->
					<div class="lengthyy modal fade" id="profilepopupfail" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
					     <div class="modal-dialog modal-fullscreen modal-dialog-centered">
					         <div class="container">
					             <div class="user-data-form step-form-modal modal-content">
									<!--<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
					                 <div class="modal-cont">
					                     <h2>Unable to Upload Profile Picture</h2>
					                     <p>Only the following file types are allowed: JPEG, JPG, PNG, PDF, and TIFF</p>
					                    <div class="modal-btns step-mod-btns">
					                         <button class="blue-btn" data-bs-dismiss="modal" id="faiOkButton">Okay</button>
					                     </div>
					                 </div>
					             </div>
					         </div>
					     </div>
					 </div>
    
         <div class="prof-details">
			<div class="up-top" style="margin-top: -62px;">
			 <div class="up-top-in">
			 <div class="up-img"><img src="${user.image}" alt="profile image"  onerror="this.src='/images/profileperson.svg';" style="width: 100px;height:100px;" id="userImage"></div>
				<span style="right: 50px;" id="edit-profile-image"><img src="images/editprofile.png" width="30px" height="30px"></span>
				<input type="file" id="fileInput" style="display:none;" />
                </div>
				<p id="profileimg" style="text-align:center;color:green;margin:-25px;"></p>
			 </div>
			<div class="row">
               <aside class="col-sm-6 udf-top-left">
                  <h3>Edit Profile</h3>
               </aside>
			   <aside class="col-sm-6 udf-top-right"><span  class="ref-text">Last Refreshed on <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MM/dd/yyyy HH:mm:ss" />
			   </span></aside>
            </div>


			
			<form id="editprofilejq" action="/saveuser" method="post" onsubmit="return validateForm()">
			   <input type="hidden" name="id" value="${user.id}" />
			   <div class="row">
				  <aside class="col-sm-6 mb-15">
					<label for="name">Name<em style="color: #ff0000;">*</em></label>
					<input type="text" id="name" name="name" value="${user.name}" class="form-field" />
					<div id="name-error" class="error-message" style="display: none;"></div>
					<input type="hidden" style="display: none;" id="image" name="image" value="${user.image}" class="form-field" />
					
				</aside>
			      <aside class="col-sm-6 mb-15">
			         <label>Email<em style="color: #ff0000;">*</em></label>
			         <input type="text" id="email" name="email" value="${user.email}" class="form-field" readonly />
			      </aside>
			      <aside class="col-sm-6 mb-15">
			         <div class="row">
			           
			               <label>Mobile Number</label>	  
                           <div class="col-sm-4 col-3">
			               <input type="text" name="" value="+91" class="form-field" placeholder="">
			            </div>
			            <div class="col-sm-8 col-9">
			               
			               <input type="text" id="number" name="number" value="${user.number}" class="form-field" />
			            </div>
			         </div>
			      </aside>
			      <aside class="col-sm-6 mb-15">
			         <label>Date of birth</label>
			         <input type="date" id="dob" name="dob" value="${user.dob}" class="form-field" max="" />
			      </aside>
				  <aside class="col-sm-6 mb-15">
				  			         <label>Address</label>
				  			         <input type="text" id="address" name="address" value="${user.address}" class="form-field" />
				  			      </aside>
			      <aside class="col-sm-6 mb-15">
			         <label>Country</label>
			         <select class="form-field" id="country" name="country" value="${user.country}" onchange="handleCountryChange()">
			            <option >Select a country</option>
			            <option ${"United States of America".equals(user.country) ? "selected" : ""} >United States of America</option>
			            <option ${"American Samoa".equals(user.country) ? "selected" : ""} >American Samoa</option>
			            <option ${"Guam".equals(user.country) ? "selected" : ""} >Guam</option>
			            <option ${"Marshall Islands".equals(user.country) ? "selected" : ""} >Marshall Islands</option>
			            <option ${"Micronesia, Federated States".equals(user.country) ? "selected" : ""} >Micronesia, Federated States</option>
			            <option ${"Northern Mariana Islands".equals(user.country) ? "selected" : ""} >Northern Mariana Islands</option>
			            <option ${"Palau".equals(user.country) ? "selected" : ""} >Palau</option>
			            <option ${"Puerto Rico".equals(user.country) ? "selected" : ""} >Puerto Rico</option>
			            <option ${"U.S. Virgin Islands".equals(user.country) ? "selected" : ""} >U.S. Virgin Islands</option>
			            <option ${"Afghanistan".equals(user.country) ? "selected" : ""} >Afghanistan</option>
			            <option ${"Åland Islands".equals(user.country) ? "selected" : ""} >Åland Islands</option>
			            <option ${"Albania".equals(user.country) ? "selected" : ""} >Albania</option>
			            <option ${"Algeria".equals(user.country) ? "selected" : ""} >Algeria</option>
			            <option ${"Andorra".equals(user.country) ? "selected" : ""} >Andorra</option>
			            <option ${"Angola".equals(user.country) ? "selected" : ""} >Angola</option>
			            <option ${"Anguilla".equals(user.country) ? "selected" : ""} >Anguilla</option>
			            <option ${"Antarctica".equals(user.country) ? "selected" : ""} >Antarctica</option>
			            <option ${"Antigua And Barbuda".equals(user.country) ? "selected" : ""} >Antigua And Barbuda</option>
			            <option ${"Argentina".equals(user.country) ? "selected" : ""} >Argentina</option>
			            <option ${"Armenia".equals(user.country) ? "selected" : ""} >Armenia</option>
			            <option ${"Aruba".equals(user.country) ? "selected" : ""} >Aruba</option>
			            <option ${"Australia".equals(user.country) ? "selected" : ""} >Australia</option>
			            <option ${"Austria".equals(user.country) ? "selected" : ""} >Austria</option>
			            <option ${"Azerbaijan".equals(user.country) ? "selected" : ""} >Azerbaijan</option>
			            <option ${"Bahamas".equals(user.country) ? "selected" : ""} >Bahamas</option>
			            <option ${"Bahrain".equals(user.country) ? "selected" : ""} >Bahrain</option>
			            <option ${"Bangladesh".equals(user.country) ? "selected" : ""} >Bangladesh</option>
			            <option ${"Barbados".equals(user.country) ? "selected" : ""} >Barbados</option>
			            <option ${"Belarus".equals(user.country) ? "selected" : ""} >Belarus</option>
			            <option ${"Belgium".equals(user.country) ? "selected" : ""} >Belgium</option>
			            <option ${"Belize".equals(user.country) ? "selected" : ""} >Belize</option>
			            <option ${"Benin".equals(user.country) ? "selected" : ""} >Benin</option>
			            <option ${"Bermuda".equals(user.country) ? "selected" : ""} >Bermuda</option>
			            <option ${"Bhutan".equals(user.country) ? "selected" : ""} >Bhutan</option>
			            <option ${"Bolivia, Plurinational State Of".equals(user.country) ? "selected" : ""} >Bolivia, Plurinational State Of</option>
			            <option ${"Bonaire, Sint Eustatius And Saba".equals(user.country) ? "selected" : ""} >Bonaire, Sint Eustatius And Saba</option>
			            <option ${"Bosnia And Herzegovina".equals(user.country) ? "selected" : ""} >Bosnia And Herzegovina</option>
			            <option ${"Botswana".equals(user.country) ? "selected" : ""} >Botswana</option>
			            <option ${"Bouvet Island".equals(user.country) ? "selected" : ""} >Bouvet Island</option>
			            <option ${"Brazil".equals(user.country) ? "selected" : ""} >Brazil</option>
			            <option ${"British Indian Ocean Territory".equals(user.country) ? "selected" : ""} >British Indian Ocean Territory</option>
			            <option ${"Brunei Darussalam".equals(user.country) ? "selected" : ""} >Brunei Darussalam</option>
			            <option ${"Bulgaria".equals(user.country) ? "selected" : ""} >Bulgaria</option>
			            <option ${"Burkina Faso".equals(user.country) ? "selected" : ""} >Burkina Faso</option>
			            <option ${"Burundi".equals(user.country) ? "selected" : ""} >Burundi</option>
			            <option ${"Cambodia".equals(user.country) ? "selected" : ""} >Cambodia</option>
			            <option ${"Cameroon".equals(user.country) ? "selected" : ""} >Cameroon</option>
			            <option ${"Canada".equals(user.country) ? "selected" : ""} >Canada</option>
			            <option ${"Cape Verde".equals(user.country) ? "selected" : ""} >Cape Verde</option>
			            <option ${"Cayman Islands".equals(user.country) ? "selected" : ""} >Cayman Islands</option>
			            <option ${"Central African Republic".equals(user.country) ? "selected" : ""} >Central African Republic</option>
			            <option ${"Chad".equals(user.country) ? "selected" : ""} >Chad</option>
			            <option ${"Chile".equals(user.country) ? "selected" : ""} >Chile</option>
			            <option ${"China".equals(user.country) ? "selected" : ""} >China</option>
			            <option ${"Christmas Island".equals(user.country) ? "selected" : ""} >Christmas Island</option>
			            <option ${"Cocos (Keeling) Islands".equals(user.country) ? "selected" : ""} >Cocos (Keeling) Islands</option>
			            <option ${"Colombia".equals(user.country) ? "selected" : ""} >Colombia</option>
			            <option ${"Comoros".equals(user.country) ? "selected" : ""} >Comoros</option>
			            <option ${"Congo".equals(user.country) ? "selected" : ""} >Congo</option>
			            <option ${"Congo, The Democratic Republic Of The".equals(user.country) ? "selected" : ""} >Congo, The Democratic Republic Of The</option>
			            <option ${"Cook Islands".equals(user.country) ? "selected" : ""} >Cook Islands</option>
			            <option ${"Costa Rica".equals(user.country) ? "selected" : ""} >Costa Rica</option>
			            <option ${"Côte D'ivoire".equals(user.country) ? "selected" : ""} >Côte D'ivoire</option>
			            <option ${"Croatia".equals(user.country) ? "selected" : ""} >Croatia</option>
			            <option ${"Cuba".equals(user.country) ? "selected" : ""} >Cuba</option>
			            <option ${"Curaçao".equals(user.country) ? "selected" : ""} >Curaçao</option>
			            <option ${"Cyprus".equals(user.country) ? "selected" : ""} >Cyprus</option>
			            <option ${"Czech Republic".equals(user.country) ? "selected" : ""} >Czech Republic</option>
			            <option ${"Denmark".equals(user.country) ? "selected" : ""} >Denmark</option>
			            <option ${"Djibouti".equals(user.country) ? "selected" : ""} >Djibouti</option>
			            <option ${"Dominica".equals(user.country) ? "selected" : ""} >Dominica</option>
			            <option ${"Dominican Republic".equals(user.country) ? "selected" : ""} >Dominican Republic</option>
			            <option ${"Ecuador".equals(user.country) ? "selected" : ""} >Ecuador</option>
			            <option ${"Egypt".equals(user.country) ? "selected" : ""} >Egypt</option>
			            <option ${"El Salvador".equals(user.country) ? "selected" : ""} >El Salvador</option>
			            <option ${"Equatorial Guinea".equals(user.country) ? "selected" : ""} >Equatorial Guinea</option>
			            <option ${"Eritrea".equals(user.country) ? "selected" : ""} >Eritrea</option>
			            <option ${"Estonia".equals(user.country) ? "selected" : ""} >Estonia</option>
			            <option ${"Ethiopia".equals(user.country) ? "selected" : ""} >Ethiopia</option>
			            <option ${"Falkland Islands (Malvinas)".equals(user.country) ? "selected" : ""} >Falkland Islands (Malvinas)</option>
			            <option ${"Faroe Islands".equals(user.country) ? "selected" : ""} >Faroe Islands</option>
			            <option ${"Fiji".equals(user.country) ? "selected" : ""} >Fiji</option>
			            <option ${"Finland".equals(user.country) ? "selected" : ""} >Finland</option>
			            <option ${"France".equals(user.country) ? "selected" : ""} >France</option>
			            <option ${"French Guiana".equals(user.country) ? "selected" : ""} >French Guiana</option>
			            <option ${"French Polynesia".equals(user.country) ? "selected" : ""} >French Polynesia</option>
			            <option ${"French Southern Territories".equals(user.country) ? "selected" : ""} >French Southern Territories</option>
			            <option ${"Gabon".equals(user.country) ? "selected" : ""} >Gabon</option>
			            <option ${"Gambia".equals(user.country) ? "selected" : ""} >Gambia</option>
			            <option ${"Georgia".equals(user.country) ? "selected" : ""} >Georgia</option>
			            <option ${"Germany".equals(user.country) ? "selected" : ""} >Germany</option>
			            <option ${"Ghana".equals(user.country) ? "selected" : ""} >Ghana</option>
			            <option ${"Gibraltar".equals(user.country) ? "selected" : ""} >Gibraltar</option>
			            <option ${"Greece".equals(user.country) ? "selected" : ""} >Greece</option>
			            <option ${"Greenland".equals(user.country) ? "selected" : ""} >Greenland</option>
			            <option ${"Grenada".equals(user.country) ? "selected" : ""} >Grenada</option>
			            <option ${"Guadeloupe".equals(user.country) ? "selected" : ""} >Guadeloupe</option>
			            <option ${"Guatemala".equals(user.country) ? "selected" : ""} >Guatemala</option>
			            <option ${"Guernsey".equals(user.country) ? "selected" : ""} >Guernsey</option>
			            <option ${"Guinea".equals(user.country) ? "selected" : ""} >Guinea</option>
			            <option ${"Guinea-Bissau".equals(user.country) ? "selected" : ""} >Guinea-Bissau</option>
			            <option ${"Guyana".equals(user.country) ? "selected" : ""} >Guyana</option>
			            <option ${"Haiti".equals(user.country) ? "selected" : ""} >Haiti</option>
			            <option ${"Heard Island And Mcdonald Islands".equals(user.country) ? "selected" : ""} >Heard Island And Mcdonald Islands</option>
			            <option ${"Holy See (Vatican City State)".equals(user.country) ? "selected" : ""} >Holy See (Vatican City State)</option>
			            <option ${"Honduras".equals(user.country) ? "selected" : ""} >Honduras</option>
			            <option ${"Hong Kong".equals(user.country) ? "selected" : ""} >Hong Kong</option>
			            <option ${"Hungary".equals(user.country) ? "selected" : ""} >Hungary</option>
			            <option ${"Iceland".equals(user.country) ? "selected" : ""} >Iceland</option>
			            <option ${"India".equals(user.country) ? "selected" : ""} >India</option>
			            <option ${"Indonesia".equals(user.country) ? "selected" : ""} >Indonesia</option>
			            <option ${"Iran, Islamic Republic Of".equals(user.country) ? "selected" : ""} >Iran, Islamic Republic Of</option>
			            <option ${"Iraq".equals(user.country) ? "selected" : ""} >Iraq</option>
			            <option ${"Ireland".equals(user.country) ? "selected" : ""} >Ireland</option>
			            <option ${"Isle Of Man".equals(user.country) ? "selected" : ""} >Isle Of Man</option>
			            <option ${"Israel".equals(user.country) ? "selected" : ""} >Israel</option>
			            <option ${"Italy".equals(user.country) ? "selected" : ""} >Italy</option>
			            <option ${"Jamaica".equals(user.country) ? "selected" : ""} >Jamaica</option>
			            <option ${"Japan".equals(user.country) ? "selected" : ""} >Japan</option>
			            <option ${"Jersey".equals(user.country) ? "selected" : ""} >Jersey</option>
			            <option ${"Jordan".equals(user.country) ? "selected" : ""} >Jordan</option>
			            <option ${"Kazakhstan".equals(user.country) ? "selected" : ""} >Kazakhstan</option>
			            <option ${"Kenya".equals(user.country) ? "selected" : ""} >Kenya</option>
			            <option ${"Kiribati".equals(user.country) ? "selected" : ""} >Kiribati</option>
			            <option ${"Korea, Democratic People's Republic Of".equals(user.country) ? "selected" : ""} >Korea, Democratic People's Republic Of</option>
			            <option ${"Korea, Republic Of".equals(user.country) ? "selected" : ""} >Korea, Republic Of</option>
			            <option ${"Kuwait".equals(user.country) ? "selected" : ""} >Kuwait</option>
			            <option ${"Kyrgyzstan".equals(user.country) ? "selected" : ""} >Kyrgyzstan</option>
			            <option ${"Lao People's Democratic Republic".equals(user.country) ? "selected" : ""} >Lao People's Democratic Republic</option>
			            <option ${"Latvia".equals(user.country) ? "selected" : ""} >Latvia</option>
			            <option ${"Lebanon".equals(user.country) ? "selected" : ""} >Lebanon</option>
			            <option ${"Lesotho".equals(user.country) ? "selected" : ""} >Lesotho</option>
			            <option ${"Liberia".equals(user.country) ? "selected" : ""} >Liberia</option>
			            <option ${"Libya".equals(user.country) ? "selected" : ""} >Libya</option>
			            <option ${"Liechtenstein".equals(user.country) ? "selected" : ""} >Liechtenstein</option>
			            <option ${"Lithuania".equals(user.country) ? "selected" : ""} >Lithuania</option>
			            <option ${"Luxembourg".equals(user.country) ? "selected" : ""} >Luxembourg</option>
			            <option ${"Macao".equals(user.country) ? "selected" : ""} >Macao</option>
			            <option ${"Macedonia, The Former Yugoslav Republic Of".equals(user.country) ? "selected" : ""} >Macedonia, The Former Yugoslav Republic Of</option>
			            <option ${"Madagascar".equals(user.country) ? "selected" : ""} >Madagascar</option>
			            <option ${"Malawi".equals(user.country) ? "selected" : ""} >Malawi</option>
			            <option ${"Malaysia".equals(user.country) ? "selected" : ""} >Malaysia</option>
			            <option ${"Maldives".equals(user.country) ? "selected" : ""} >Maldives</option>
			            <option ${"Mali".equals(user.country) ? "selected" : ""} >Mali</option>
			            <option ${"Malta".equals(user.country) ? "selected" : ""} >Malta</option>
			            <option ${"Martinique".equals(user.country) ? "selected" : ""} >Martinique</option>
			            <option ${"Mauritania".equals(user.country) ? "selected" : ""} >Mauritania</option>
			            <option ${"Mauritius".equals(user.country) ? "selected" : ""} >Mauritius</option>
			            <option ${"Mayotte".equals(user.country) ? "selected" : ""} >Mayotte</option>
			            <option ${"Mexico".equals(user.country) ? "selected" : ""} >Mexico</option>
			            <option ${"Moldova, Republic Of".equals(user.country) ? "selected" : ""} >Moldova, Republic Of</option>
			            <option ${"Monaco".equals(user.country) ? "selected" : ""} >Monaco</option>
			            <option ${"Mongolia".equals(user.country) ? "selected" : ""} >Mongolia</option>
			            <option ${"Montenegro".equals(user.country) ? "selected" : ""} >Montenegro</option>
			            <option ${"Montserrat".equals(user.country) ? "selected" : ""} >Montserrat</option>
			            <option ${"Morocco".equals(user.country) ? "selected" : ""} >Morocco</option>
			            <option ${"Mozambique".equals(user.country) ? "selected" : ""} >Mozambique</option>
			            <option ${"Myanmar".equals(user.country) ? "selected" : ""} >Myanmar</option>
			            <option ${"Namibia".equals(user.country) ? "selected" : ""} >Namibia</option>
			            <option ${"Nauru".equals(user.country) ? "selected" : ""} >Nauru</option>
			            <option ${"Nepal".equals(user.country) ? "selected" : ""} >Nepal</option>
			            <option ${"Netherlands".equals(user.country) ? "selected" : ""} >Netherlands</option>
			            <option ${"New Caledonia".equals(user.country) ? "selected" : ""} >New Caledonia</option>
			            <option ${"New Zealand".equals(user.country) ? "selected" : ""} >New Zealand</option>
			            <option ${"Nicaragua".equals(user.country) ? "selected" : ""} >Nicaragua</option>
			            <option ${"Niger".equals(user.country) ? "selected" : ""} >Niger</option>
			            <option ${"Nigeria".equals(user.country) ? "selected" : ""} >Nigeria</option>
			            <option ${"Niue".equals(user.country) ? "selected" : ""} >Niue</option>
			            <option ${"Norfolk Island".equals(user.country) ? "selected" : ""} >Norfolk Island</option>
			            <option ${"Norway".equals(user.country) ? "selected" : ""} >Norway</option>
			            <option ${"Oman".equals(user.country) ? "selected" : ""} >Oman</option>
			            <option ${"Pakistan".equals(user.country) ? "selected" : ""} >Pakistan</option>
			            <option ${"Palestinian Territory, Occupied".equals(user.country) ? "selected" : ""} >Palestinian Territory, Occupied</option>
			            <option ${"Panama".equals(user.country) ? "selected" : ""} >Panama</option>
			            <option ${"Papua New Guinea".equals(user.country) ? "selected" : ""} >Papua New Guinea</option>
			            <option ${"Paraguay".equals(user.country) ? "selected" : ""} >Paraguay</option>
			            <option ${"Peru".equals(user.country) ? "selected" : ""} >Peru</option>
			            <option ${"Philippines".equals(user.country) ? "selected" : ""} >Philippines</option>
			            <option ${"Pitcairn".equals(user.country) ? "selected" : ""} >Pitcairn</option>
			            <option ${"Poland".equals(user.country) ? "selected" : ""} >Poland</option>
			            <option ${"Portugal".equals(user.country) ? "selected" : ""} >Portugal</option>
			            <option ${"Qatar".equals(user.country) ? "selected" : ""} >Qatar</option>
			            <option ${"Réunion".equals(user.country) ? "selected" : ""} >Réunion</option>
			            <option ${"Romania".equals(user.country) ? "selected" : ""} >Romania</option>
			            <option ${"Russian Federation".equals(user.country) ? "selected" : ""} >Russian Federation</option>
			            <option ${"Rwanda".equals(user.country) ? "selected" : ""} >Rwanda</option>
			            <option ${"Saint Barthélemy".equals(user.country) ? "selected" : ""} >Saint Barthélemy</option>
			            <option ${"Saint Helena, Ascension And Tristan Da Cunha".equals(user.country) ? "selected" : ""} >Saint Helena, Ascension And Tristan Da Cunha</option>
			            <option ${"Saint Kitts And Nevis".equals(user.country) ? "selected" : ""} >Saint Kitts And Nevis</option>
			            <option ${"Saint Lucia".equals(user.country) ? "selected" : ""} >Saint Lucia</option>
			            <option ${"Saint Martin (french Part)".equals(user.country) ? "selected" : ""} >Saint Martin (french Part)</option>
			            <option ${"Saint Pierre And Miquelon".equals(user.country) ? "selected" : ""} >Saint Pierre And Miquelon</option>
			            <option ${"Saint Vincent And The Grenadines".equals(user.country) ? "selected" : ""} >Saint Vincent And The Grenadines</option>
			            <option ${"Samoa".equals(user.country) ? "selected" : ""} >Samoa</option>
			            <option ${"San Marino".equals(user.country) ? "selected" : ""} >San Marino</option>
			            <option ${"Sao Tome And Principe".equals(user.country) ? "selected" : ""} >Sao Tome And Principe</option>
			            <option ${"Saudi Arabia".equals(user.country) ? "selected" : ""} >Saudi Arabia</option>
			            <option ${"Senegal".equals(user.country) ? "selected" : ""} >Senegal</option>
			            <option ${"Serbia".equals(user.country) ? "selected" : ""} >Serbia</option>
			            <option ${"Seychelles".equals(user.country) ? "selected" : ""} >Seychelles</option>
			            <option ${"Sierra Leone".equals(user.country) ? "selected" : ""} >Sierra Leone</option>
			            <option ${"Singapore".equals(user.country) ? "selected" : ""} >Singapore</option>
			            <option ${"Sint Maarten (dutch Part)".equals(user.country) ? "selected" : ""} >Sint Maarten (dutch Part)</option>
			            <option ${"Slovakia".equals(user.country) ? "selected" : ""} >Slovakia</option>
			            <option ${"Slovenia".equals(user.country) ? "selected" : ""} >Slovenia</option>
			            <option ${"Solomon Islands".equals(user.country) ? "selected" : ""} >Solomon Islands</option>
			            <option ${"Somalia".equals(user.country) ? "selected" : ""} >Somalia</option>
			            <option ${"South Africa".equals(user.country) ? "selected" : ""} >South Africa</option>
			            <option ${"South Georgia And The South Sandwich Islands".equals(user.country) ? "selected" : ""} >South Georgia And The South Sandwich Islands</option>
			            <option ${"South Sudan".equals(user.country) ? "selected" : ""} >South Sudan</option>
			            <option ${"Spain".equals(user.country) ? "selected" : ""} >Spain</option>
			            <option ${"Sri Lanka".equals(user.country) ? "selected" : ""} >Sri Lanka</option>
			            <option ${"Sudan".equals(user.country) ? "selected" : ""} >Sudan</option>
			            <option ${"Suriname".equals(user.country) ? "selected" : ""} >Suriname</option>
			            <option ${"Svalbard And Jan Mayen".equals(user.country) ? "selected" : ""} >Svalbard And Jan Mayen</option>
			            <option ${"Swaziland".equals(user.country) ? "selected" : ""} >Swaziland</option>
			            <option ${"Sweden".equals(user.country) ? "selected" : ""} >Sweden</option>
			            <option ${"Switzerland".equals(user.country) ? "selected" : ""} >Switzerland</option>
			            <option ${"Syrian Arab Republic".equals(user.country) ? "selected" : ""} >Syrian Arab Republic</option>
			            <option ${"Taiwan".equals(user.country) ? "selected" : ""} >Taiwan</option>
			            <option ${"Tajikistan".equals(user.country) ? "selected" : ""} >Tajikistan</option>
			            <option ${"Tanzania, United Republic Of".equals(user.country) ? "selected" : ""} >Tanzania, United Republic Of</option>
			            <option ${"Thailand".equals(user.country) ? "selected" : ""} >Thailand</option>
			            <option ${"Timor-leste".equals(user.country) ? "selected" : ""} >Timor-leste</option>
			            <option ${"Togo".equals(user.country) ? "selected" : ""} >Togo</option>
			            <option ${"Tokelau".equals(user.country) ? "selected" : ""} >Tokelau</option>
			            <option ${"Tonga".equals(user.country) ? "selected" : ""} >Tonga</option>
			            <option ${"Trinidad And Tobago".equals(user.country) ? "selected" : ""} >Trinidad And Tobago</option>
			            <option ${"Tunisia".equals(user.country) ? "selected" : ""} >Tunisia</option>
			            <option ${"Turkey".equals(user.country) ? "selected" : ""} >Turkey</option>
			            <option ${"Turkmenistan".equals(user.country) ? "selected" : ""} >Turkmenistan</option>
			            <option ${"Turks And Caicos Islands".equals(user.country) ? "selected" : ""} >Turks And Caicos Islands</option>
			            <option ${"Tuvalu".equals(user.country) ? "selected" : ""} >Tuvalu</option>
			            <option ${"Uganda".equals(user.country) ? "selected" : ""} >Uganda</option>
			            <option ${"Ukraine".equals(user.country) ? "selected" : ""} >Ukraine</option>
			            <option ${"United Arab Emirates".equals(user.country) ? "selected" : ""} >United Arab Emirates</option>
			            <option ${"United Kingdom".equals(user.country) ? "selected" : ""} >United Kingdom</option>
			            <option ${"Uruguay".equals(user.country) ? "selected" : ""} >Uruguay</option>
			            <option ${"Uzbekistan".equals(user.country) ? "selected" : ""} >Uzbekistan</option>
			            <option ${"Vanuatu".equals(user.country) ? "selected" : ""} >Vanuatu</option>
			            <option ${"Venezuela, Bolivarian Republic Of".equals(user.country) ? "selected" : ""} >Venezuela, Bolivarian Republic Of</option>
			            <option ${"Viet Nam".equals(user.country) ? "selected" : ""} >Viet Nam</option>
			            <option ${"Virgin Islands, British".equals(user.country) ? "selected" : ""} >Virgin Islands, British</option>
			            <option ${"Wallis And Futuna".equals(user.country) ? "selected" : ""} >Wallis And Futuna</option>
			            <option ${"Western Sahara".equals(user.country) ? "selected" : ""} >Western Sahara</option>
			            <option ${"Yemen".equals(user.country) ? "selected" : ""} >Yemen</option>
			            <option ${"Zambia".equals(user.country) ? "selected" : ""} >Zambia</option>
			            <option ${"Zimbabwe".equals(user.country) ? "selected" : ""} >Zimbabwe</option>
			         </select>
			      </aside>
			      <aside class="col-sm-6">
			         <label>State <em id="benStateStar" style="display: none; color: #ff0000;">*</em></label>
			         <select class="form-field" id="state" name="state" value="${user.state}">
			            <option value="">Select a state</option>
			            <option ${"Alabama".equals(user.state) ? "selected" : ""} >Alabama</option>
			            <option ${"Alaska".equals(user.state) ? "selected" : ""} >Alaska</option>
			            <option ${"Armed Forces Europe/Middle-East/Canada".equals(user.state) ? "selected" : ""} >Armed Forces Europe/Middle-East/Canada</option>
			            <option ${"Armed Forces Americas (except Canada)".equals(user.state) ? "selected" : ""} >Armed Forces Americas (except Canada)</option>
			            <option ${"Armed Forces Pacific".equals(user.state) ? "selected" : ""} >Armed Forces Pacific</option>
			            <option ${"Arizona".equals(user.state) ? "selected" : ""} >Arizona</option>
			            <option ${"Arkansas".equals(user.state) ? "selected" : ""} >Arkansas</option>
			            <option ${"California".equals(user.state) ? "selected" : ""} >California</option>
			            <option ${"Colorado".equals(user.state) ? "selected" : ""} >Colorado</option>
			            <option ${"Connecticut".equals(user.state) ? "selected" : ""} >Connecticut</option>
			            <option ${"Delaware".equals(user.state) ? "selected" : ""} >Delaware</option>
			            <option ${"District of Columbia".equals(user.state) ? "selected" : ""} >District of Columbia</option>
			            <option ${"Florida".equals(user.state) ? "selected" : ""} >Florida</option>
			            <option ${"Georgia".equals(user.state) ? "selected" : ""} >Georgia</option>
			            <option ${"Hawaii".equals(user.state) ? "selected" : ""} >Hawaii</option>
			            <option ${"Idaho".equals(user.state) ? "selected" : ""} >Idaho</option>
			            <option ${"Illinois".equals(user.state) ? "selected" : ""} >Illinois</option>
			            <option ${"Indiana".equals(user.state) ? "selected" : ""} >Indiana</option>
			            <option ${"Iowa".equals(user.state) ? "selected" : ""} >Iowa</option>
			            <option ${"Kansas".equals(user.state) ? "selected" : ""} >Kansas</option>
			            <option ${"Kentucky".equals(user.state) ? "selected" : ""} >Kentucky</option>
			            <option ${"Louisiana".equals(user.state) ? "selected" : ""} >Louisiana</option>
			            <option ${"Maine".equals(user.state) ? "selected" : ""} >Maine</option>
			            <option ${"Maryland".equals(user.state) ? "selected" : ""} >Maryland</option>
			            <option ${"Massachusetts".equals(user.state) ? "selected" : ""} >Massachusetts</option>
			            <option ${"Michigan".equals(user.state) ? "selected" : ""} >Michigan</option>
			            <option ${"Minnesota".equals(user.state) ? "selected" : ""} >Minnesota</option>
			            <option ${"Mississippi".equals(user.state) ? "selected" : ""} >Mississippi</option>
			            <option ${"Missouri".equals(user.state) ? "selected" : ""} >Missouri</option>
			            <option ${"Montana".equals(user.state) ? "selected" : ""} >Montana</option>
			            <option ${"Nebraska".equals(user.state) ? "selected" : ""} >Nebraska</option>
			            <option ${"Nevada".equals(user.state) ? "selected" : ""} >Nevada</option>
			            <option ${"New Hampshire".equals(user.state) ? "selected" : ""} >New Hampshire</option>
			            <option ${"New Jersey".equals(user.state) ? "selected" : ""} >New Jersey</option>
			            <option ${"New Mexico".equals(user.state) ? "selected" : ""} >New Mexico</option>
			            <option ${"New York".equals(user.state) ? "selected" : ""} >New York</option>
			            <option ${"North Carolina".equals(user.state) ? "selected" : ""} >North Carolina</option>
			            <option ${"North Dakota".equals(user.state) ? "selected" : ""} >North Dakota</option>
			            <option ${"Ohio".equals(user.state) ? "selected" : ""} >Ohio</option>
			            <option ${"Oklahoma".equals(user.state) ? "selected" : ""} >Oklahoma</option>
			            <option ${"Oregon".equals(user.state) ? "selected" : ""} >Oregon</option>
			            <option ${"Pennsylvania".equals(user.state) ? "selected" : ""} >Pennsylvania</option>
			            <option ${"Rhode Island".equals(user.state) ? "selected" : ""} >Rhode Island</option>
			            <option ${"South Carolina".equals(user.state) ? "selected" : ""} >South Carolina</option>
			            <option ${"South Dakota".equals(user.state) ? "selected" : ""} >South Dakota</option>
			            <option ${"Tennessee".equals(user.state) ? "selected" : ""} >Tennessee</option>
			            <option ${"Texas".equals(user.state) ? "selected" : ""} >Texas</option>
			            <option ${"Utah".equals(user.state) ? "selected" : ""} >Utah</option>
			            <option ${"Vermont".equals(user.state) ? "selected" : ""} >Vermont</option>
			            <option ${"Virginia".equals(user.state) ? "selected" : ""} >Virginia</option>
			            <option ${"Washington".equals(user.state) ? "selected" : ""} >Washington</option>
			            <option ${"West Virginia".equals(user.state) ? "selected" : ""} >West Virginia</option>
			            <option ${"Wisconsin".equals(user.state) ? "selected" : ""} >Wisconsin</option>
			            <option ${"Wyoming".equals(user.state) ? "selected" : ""} >Wyoming</option>
			         </select>
			      </aside>
			   </div>
			   <div class="sf-form-footer profile-form-footer">
			      <div class="row">
			         <aside class="col-sm-12 sf-foot-right">
			            <div class="sf-btns">
			               <button class="bg-btn" type="submit" value="submit">Save</button>
			            </div>
			         </aside>
			      </div>
			   </div>
			</form>
         </div>
         </aside>
      </div>
      </div>
      </div>
      </div>
      </div>
      </section>
      <button class="scroll-top">
      <i class="bi bi-arrow-up-short"></i>
      </button>
     
	  <%@ include file="/WEB-INF/views/js.jsp" %>
	  <script src="js/editProfileValidator.js"></script>
	  
	  	  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	  	  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	  	  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	  <script>
		let originalStateOptions = ''; // Declare globally to store original state options

		// Function to handle country change and reset state options
		function handleCountryChange() {
		    const countrySelect = document.getElementById('country');
		    const stateSelect = document.getElementById('state');
		    const stateStar = document.getElementById('benStateStar');

		    // U.S. Territories with full names as in your dropdown options
		    const usTerritories = {
		        "American Samoa": "American Samoa",
		        "Guam": "Guam",
		        "Marshall Islands": "Marshall Islands",
		        "Micronesia, Federated States": "Micronesia, Federated States",
		        "Northern Mariana Islands": "Northern Mariana Islands",
		        "Palau": "Palau",
		        "Puerto Rico": "Puerto Rico",
		        "U.S. Virgin Islands": "U.S. Virgin Islands"
		    };

		    // Countries that should disable the "State" dropdown
		    const disableStateCountries = ["Afghanistan", "Albania", "Algeria", /* other countries */];

		    const selectedCountry = countrySelect.value;

		    // Store original state options if not stored yet
		    if (!originalStateOptions) {
		        originalStateOptions = stateSelect.innerHTML; // Save the initial state options
		    }

		    // Handle United States of America
		    if (selectedCountry === 'United States of America') {
		        stateStar.style.display = 'inline'; // Show state required indicator
		        stateSelect.disabled = false; // Enable state select
		        stateSelect.innerHTML = originalStateOptions; // Restore original state options
		        stateSelect.style.backgroundColor = ''; // Reset styles
		        stateSelect.style.color = '';
		        stateSelect.style.cursor = '';
		    }
		    // Handle U.S. Territories (matching full country names)
		    else if (usTerritories.hasOwnProperty(selectedCountry)) {
		        stateStar.style.display = 'none'; // Hide state required indicator
		        stateSelect.disabled = true; // Disable state select
		        stateSelect.innerHTML = ''; // Clear state options

		        // Populate the state select with the selected U.S. territory
		        const option = document.createElement('option');
		        option.value = selectedCountry;
		        option.text = usTerritories[selectedCountry];
		        stateSelect.appendChild(option);
		        stateSelect.value = selectedCountry; // Set the selected territory
		        stateSelect.style.backgroundColor = '#e9ecef';  
		        stateSelect.style.color = '#6c757d';            
		        stateSelect.style.cursor = 'not-allowed';
		    }
		    // Handle countries that should completely disable the "State" dropdown
		    else if (disableStateCountries.includes(selectedCountry)) {
		        stateStar.style.display = 'none'; // Hide state required indicator
		        stateSelect.disabled = true; // Disable state select
		        stateSelect.innerHTML = ''; // Clear state options
		        stateSelect.style.backgroundColor = '#e9ecef';  
		        stateSelect.style.color = '#6c757d';            
		        stateSelect.style.cursor = 'not-allowed';
		    }
		    // Reset for other countries
		    else {
		        stateStar.style.display = 'none'; // Hide state required indicator
		        stateSelect.disabled = true; // Disable state select
		        stateSelect.innerHTML = ''; // Clear state options
		        stateSelect.style.backgroundColor = '#e9ecef';  
		        stateSelect.style.color = '#6c757d';            
		        stateSelect.style.cursor = 'not-allowed';
		    }
		}

		setTimeout(function() {
		   handleCountryChange();
		}, 100);
				
		 const profilepopupsuc = new bootstrap.Modal(document.getElementById('profilepopupsucc'));
		 const profilepopupfail = new bootstrap.Modal(document.getElementById('profilepopupfail'));
		function validateForm() {
		    const nameField = document.getElementById('name');
		    const nameError = document.getElementById('name-error');
		    const nameValue = nameField.value.trim(); // Remove whitespace

		    // Clear previous error message	
		    nameError.style.display = 'none';
		    nameError.textContent = '';

		    if (nameValue === '') {
		        nameError.textContent = 'Please enter your name'; // Set error message
		        nameError.style.display = 'block'; // Show error message
		        nameField.focus(); // Set focus back to the name field
		        return false; // Prevent form submission
		    }

		    return true; // Allow form submission
		}

		var user = {
		          setImage: function(url) {
		              // Update the image URL in the user object
		              this.image = url;

		              // Optionally update the image on the page
		              $('#userImage').attr('src', url);
		          },
		          image: ''
		      };
	         $(document).ready(function() {
	             $('#edit-profile-image').on('click', function(event) {
	                 event.preventDefault(); // Prevent the default link behavior
	                 $('#fileInput').click(); // Show the file input dialog
	             });

	             $('#fileInput').on('change', function(event) {
	                 const file = event.target.files[0];
	                 if (file) {
	                     // Prepare form data
	                     const formData = new FormData();
	                     formData.append('file', file);
						 formData.append('documentType', 'jpg');
	                     // Send the AJAX request
	                     $.ajax({
	                         url: '/upload/profile', // Your upload URL
	                         type: 'POST',
	                         data: formData,
	                         contentType: false,
	                         processData: false,
	                         success: function(response) {
	                             if (response && response.fileUrl) {
	                                 // Handle successful upload
 									 //$('#profileimg').text("Profile uploaded suceessfully. To Update the profile click on Save button");
									 // Store image URL in user object
									// user.setImage(response.fileUrl);
									profilepopupsuc.show(); 
									
									 $('#image').val(response.fileUrl); 
	                             } else {
	                                 // Handle errors from server
	                                 //alert(response.errorMessage || 'Upload failed');
									profilepopupfail.show();
 	                             }
	                             $('#fileInput').val(''); // Clear file input
	                         },
	                         error: function(jqXHR, textStatus, errorThrown) {
	                             alert('Upload failed: ' + textStatus);
 	                             $('#fileInput').val(''); // Clear file input
	                         }
	                     });
	                 }
	             });
	         });
			 $('#sucOkButton').on('click', function() {
	 			    profilepopupsuc.hide();// Hide the modal
	 			 });	
				 $('#faiOkButton').on('click', function() {
	 			    profilepopupfail.hide(); // Hide the modal
	 			 });
	   
      </script>
      </div>
   </body>
</html>