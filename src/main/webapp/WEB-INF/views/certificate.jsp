<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/css.jsp" %>
	<%@ include file="/WEB-INF/views/right-click.jsp" %>
	<%@ include file="/WEB-INF/views/js.jsp" %>
	<meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta property="og:title" content="CTAHarbor Certificate">
		<meta property="og:description" content="This Certificate is awarded in recognition of the successful completion of a Beneficial Ownership Information Report (BOIR) filing.">
<!--		<meta property="og:description" content="Just completed my BOIR filing with CTAHarbor! The process was quick and hassle-free. If You're looking to file efficiently, check it out! [${referralLink}]">-->
	   <meta property="og:image" content="https://micassets.micnxt.com/CTA/certificate.png">
	   
	   <meta name="twitter:card" content="width=device-width, initial-scale=1.0">
	       <meta name="twitter:title" content="CTAHarbor Certificate">
	       <meta name="twitter:description" content="This Certificate is awarded in recognition of the successful completion of a Beneficial Ownership Information Report (BOIR) filing.">
	       <meta name="twitter:image" content="https://micassets.micnxt.com/CTA/certificate.png">

	   <meta property="og:type" content="website">
    <title>Certificate</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Cormorant+Infant:wght@400;700&family=Satoshi:wght@400;700&display=swap">
	<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
	<style type="text/css">
	        * {
	            margin: 0;
	            padding: 0;
	            color: #0B1217;
	        }
			.download-container {
			      display: flex;
			      justify-content: center;
			      align-items: center;
			      gap: 20px; /* Space between the elements */
			      padding: 20px; /* Add some padding around the container */
			  }
		  .hide-in-pdf {
	  	        display: none !important;
	  	    }
			  

		  		.download-box {
			      display: flex;
			      align-items: center;
			      gap: 10px;
			      border: 1px solid #C4C4D6;
			      border-radius: 5px;
			      padding: 13px;
			  }

			  .download-box img {
			      height: 24px; /* Adjust the icon size */
			      width: 24px;
			  }

			  .download-box a {
			      text-decoration: none;
			      color: #000;
			      font-weight: bold;
			  }
	        @media print {
	            body {
	                -webkit-print-color-adjust: exact;
	                -moz-print-color-adjust: exact;
	                -ms-print-color-adjust: exact;
	                print-color-adjust: exact;
	            }
				.download-container {
				        visibility: hidden;
				       margin: 0%;
				        overflow: hidden;
				    }
	        }
	    </style>
	</head>
<body>
	<div id="content" class="certificate-container">
		<c:if test="${DownloadIcons == 'true'}">
			<div id="buttonscontainer" class="download-container">
	            <div class="dropdown-box">
					<c:if test="${multipleBeneficialOwners == 'true'}">
		                <select class="form-field" id="submitternames-dropdown" onchange="updateCertificateName()">
							<option value="" disabled selected>BOIR Owner</option>
		                   <c:forEach var="submitternames" items="${submitternames}">
								<option>${submitternames}</option>
							</c:forEach>
		                </select>
					</c:if>
	            </div>
				<button type="button" id="download" class="download-box">
					Download
				    <img src="/images/Downloadicon.png" alt="Download Icon">
				</button>
	            <div class="download-box">
	                Share
					<a href="https://www.facebook.com/share.php?u=${DomainURL}&title=Title" target="_blank"><img src="/images/FBicon.png" alt="Share Icon"></a>
					<c:set var="encodedDomainURL" value="${fn:replace(DomainURL, ' ', '%20')}"/>
					<a href="https://twitter.com/intent/tweet?url=${encodedDomainURL}" target="_blank"><img src="/images/icon/Twitter.svg" alt="twitter-icon"/></a>
					<a href="https://www.linkedin.com/shareArticle?mini=true&url=${DomainURL}&title=Check%20out%20this%20certificate!&source=YourSource" target="_blank"><img src="/images/linkedinicon.png" alt="linkedin-icon"/></a>
	            </div>
	        </div>
					
		</c:if>
		
		<table align="center" style=" font-family: 'Open Sans', sans-serif; font-weight: 500; margin: auto; width: 815px; background-image: url(/images/main-bg.jpg); background-repeat: no-repeat; background-position: 0 0; background-size: cover;" cellspacing="0" cellpadding="0">
		        <tr height="110"></tr>
		        <tr>
		            <td style=" padding-left: 70px; padding-right: 70px;">
		                <table cellpadding="0" cellspacing="0" width="100%">
		                    <tr>
		                        <td style=' text-align: center; font-size: 55px; font-family: "Cormorant Infant", serif; text-transform: uppercase; font-weight: 600; color: #003B67;'>Certificate</td>
		                    </tr>
		                    <tr>
		                        <td style=" text-align: center; font-size: 21px; color: #B31942; text-transform: uppercase;">of BOIR filing</td>
		                    </tr>
		                    <tr height="40"></tr>
		                    <tr>
		                        <td style=" text-align: center; font-size: 15px; line-height: 24px; letter-spacing: 0.1px;">This Certificate is awarded in recognition of the successful completion of a <strong style=" color: #003B67;">Beneficial Ownership Information Report (BOIR) filing</strong> for & to: </td>
		                    </tr>
		                    <tr height="40"></tr>
		                    <tr>
		                        <td style=" width: 100%;">
		                            <table cellpadding="0" cellspacing="0" width="100%" style=" margin: auto; text-align: center;">
		                                <tr>
		                                    <td style=" text-align: center; font-size: 40px; font-weight: 700; display: inline-block; border-bottom: 1px solid rgba(0, 59, 106, 0.3); color: #003B6A;">${reportingCompanyName}</td>
		                                </tr>
		                            </table>
		                        </td>
		                    </tr>
		                    <tr height="40"></tr>
		                    <tr>
		                        <td id="certificatename" style=" text-align: center; font-size: 18px; font-weight: 700; color: #003B6A;">Name: ${certificatename}</td>
		                    </tr>
		                    <tr height="40"></tr>
		                    <tr>
		                        <td style=" font-size: 15px; line-height: 25px; text-align: center;">The BOIR filing was submitted through the<br /><a href="CTAHarbor.com" style=" color: #003B67; font-weight: 700;">CTAHarbor.com</a> portal on <span style=" color: #003B67; font-weight: 700;">${filingInfodate}</span></td>
		                    </tr>
		                    <tr height="40"></tr>
		                    <tr>
		                        <td style=" font-size: 15px; text-align: center;">BOIR ID: <span style=" color: #003B67">${boirid}</span></td>
		                    </tr>
		                    <tr height="40"></tr>
		                    <tr>
								<td style=" display:none; text-align: center;"><img src="/images/CHfavicon-linkedin.png" alt="" /></td>
		                        <td style=" text-align: center;"><img src="/images/certificate-line.png" alt="" /></td>
		                    </tr>
		                    <tr height="20"></tr>
		                    <tr>
		                        <td>
		                            <table cellpadding="0" cellspacing="0" width="100%" style=" margin: auto; text-align: center;">
		                                <tr>
		                                    <td width="90px">&nbsp;</td>
		                                    <td style=" font-size: 14px; line-height: 25px;">This certificate acknowledges this entity's compliance with the <span style=" color: #003B67">BOIR filing</span> requirements set forth by the Financial Crimes Enforcement Network <span style=" color: #003B67">(FinCEN)</span>.</td>
		                                    <td width="90px">&nbsp;</td>
		                                </tr>
		                            </table>
		                        </td>

		                    </tr>
		                    <tr height="55"></tr>
		                    <tr>
		                        <td>
		                            <table cellpadding="0" cellspacing="0" width="350px" style=" margin: auto; text-align: center;">
		                                <tr>
		                                    <td><img src="/images/nybacs-logo.png" alt="" style=" width: 138px;" /></td>
		                                    <td style=" padding-left: 30px; padding-right: 30px;"><img src="/images/vertical-line.png" alt="" /></td>
		                                    <td><img src="/images/CTA_logo.svg" alt="" /></td>
		                                </tr>
		                            </table>
		                        </td>
		                    </tr>
		                    <tr height="20"></tr>
		                    <tr>
		                        <td style=" font-size: 13px; text-align: center; font-style: italic;">An approved API Participant of US Dept of Treasury to transmit BOIR information to FinCEN</td>
		                    </tr>
		                    <tr height="30"></tr>
		                    <tr>
		                        <td style=" font-size: 13px; text-align: center; font-style: italic;">for <span style=" text-transform: uppercase;">New York Business Advisory & Corporate Services Inc.</span></td>
		                    </tr>
		                    <tr height="30"></tr>
		                    <tr>
		                        <td style=" text-align: center;"><img src="/images/Mukund.S.png" alt="" style=" width: 185px;" /></td>
		                    </tr>
		                    <tr height="10"></tr>
		                    <tr>
		                        <td style=" text-align: center;">Mukund Srinivas, Business Head</td>
		                    </tr>
		                    <tr height="50"></tr>
		                </table>
		            </td>
		        </tr>
<!-- <tr height="20"></tr>-->		       
		    </table>
			</div>
	<script>
	
    /*document.getElementById("download").addEventListener("click", function () {
    	document.getElementById("buttonscontainer").style.display = "none";
        const element = document.getElementById("content");

        const opt = {
                margin: 0, // No margins for fitting on a single page
                filename: 'document-a4.pdf',
                image: { type: 'jpeg', quality: 1 },
                html2canvas: { scale: 2,useCORS: true  },
                jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };
        html2pdf().from(element).set(opt).save().finally(() => {
            document.getElementById("buttonscontainer").style.display = "block";
        });
 
    });*/
	document.getElementById("download").addEventListener("click", function () {
		    const buttonsContainer = document.getElementById("buttonscontainer");
	 
		    // Hide the buttons for PDF generation
		    buttonsContainer.classList.add("hide-in-pdf");
	 
		    const element = document.getElementById("content");
			

			// Example usage
			let currentDate = new Date();
 
		    const opt = {
		        margin: 0,
		        filename: 'Certificate of BOIR Filing_NYBACS_CTAHarbor_'+formatMMDDYYYY(currentDate)+'.pdf',
		        image: { type: 'jpeg', quality: 1 },
		        html2canvas: { scale: 2, useCORS: true },
		        jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
		    };
	 
		    html2pdf().from(element).set(opt).save().finally(() => {
		        // Show the buttons again after PDF generation
		        buttonsContainer.classList.remove("hide-in-pdf");
		    });
		});
    
		
		function formatMMDDYYYY(date) {
					    // Get the month, day, and year
					    let month = (date.getMonth() + 1).toString().padStart(2, '0'); // getMonth() returns 0-11
					    let day = date.getDate().toString().padStart(2, '0');
					    let year = date.getFullYear();

					    // Return the formatted date as MMDDYYYY
					    return month + day + year;
					}
		
		//logic for handel the href by when onchange form dropdown
	    function updateCertificateName() {
	        var dropdown = document.getElementById("submitternames-dropdown");
	        var selectedValue = dropdown.options[dropdown.selectedIndex].value;
	        var encodedValue = encodeURIComponent(selectedValue);
	        window.location.href = "/certificate/${filingInfoId}/"+encodedValue;
	    }
		//logic to handle the div visiblitiy when page rendered from facebook.
		window.onload = function() {
		    if (window.location.href.indexOf("fbclid") !== -1) {
		        document.getElementById("buttonscontainer").style.display = "none";
		    }
		};
		
		//logic for save the current url for social media share dynamically.
		window.onload = function() {
		    var currentUrl = window.location.href;
		    localStorage.setItem("savedUrl", currentUrl);
		    var savedUrl = localStorage.getItem("savedUrl");
 		    var facebookShareLink = document.getElementById("facebookShare");
		    facebookShareLink.href = "https://www.facebook.com/share.php?u=" + encodeURIComponent(savedUrl) + "&title=Title";
		};
		//logic to hide div if it rendered from any other thirdparty sites or applications expect "ctadev.micnxt.com"
		


	</script>
</body>
</html>