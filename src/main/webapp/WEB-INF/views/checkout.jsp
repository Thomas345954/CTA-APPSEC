					   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/css.jsp" %>
	<%@ include file="/WEB-INF/views/header-login.jsp" %>
	<%@ include file="/WEB-INF/views/log-reg.jsp" %>
    <title>Payment Screen</title>
  
    <style>
        .step {
            display: none;
        }
 
        .step.active {
            display: block;
        }
 
        .center-text {
            text-align: center;
        }
 
        .center-form {
            max-width: 400px; /* Set a max width for the form */
            margin: 0 auto; /* Center the form horizontally */
        }
 
        .center-button {
            display: block;
            margin: 20px auto;
            width: 100%; /* Make the button full width within the form */
        }
		

		   		   .boody {
		   		    font-family: Arial, sans-serif;
		   		    background-color: #f4f9fe;
		   		    display: flex;
		   		    justify-content: center;
		   		    align-items: center;
		   		    min-height: 100vh;
		   		    margin: 0;
		   			margin-bottom: -10% !important;
		   		}
		    
		   		.container2 {
		   		    display: flex;
		   		    flex-direction: row;
		   		    background-color: #fff;
		   		    border-radius: 10px;
		   		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		   		    width: 90%;
		   		    max-width: 100%;
		   		    overflow: hidden;
		   		}
		    
		   		.payment-summary, .payment-form {
		   		    padding: 30px;
		   		}
		    
		   		.payment-summary {
		   		    border-right: 1px solid #e6e6e6;
		   		    width: 40%;
		   		}
		    
		   		.payment-summary h1 {
		   		    font-size: 24px;
		   		    color:#003B6A;
		   		    margin-bottom: 20px;
		   		}
		    
		   		.payment-summary h2 {
		   		    font-size: 30px;
		   		    color:#003B6A;
		   		    margin: 20px;
		   		}
		    
		   		.payment-summary h3 {
		   		    font-size: 36px;
		   		    color:#003B6A;
		   		    margin-bottom: 30px;
		   		}
		    
		   		.payment-summary .product-list p {
		   			color:#003B6A;
		   		    font-size: 16px;
		   		    margin: 10px 0;
		   		    display: flex;
		   		    justify-content: space-between;
		   		}
		    
		   		.payment-form {
		   		    width: 60%;
					text-align: center;
		   		}
		    
		   		.payment-form h2 {
					text-align: center;
					    font-size: 30px;
					    color: #003B6A;
					    margin-bottom: 20px;
					    font-weight: bold;
		 
		   		}
		    
		   		.payment-form form {
		   		    display: flex;
		   		    flex-direction: column;
		   		}
		    
		   		.payment-form label {
		   		    font-size: 14px;
		   		    margin-bottom: 5px;
		   		    color: #003B6A;
		   		}
		    
		   		.payment-form input, .payment-form select {
		   		    font-size: 16px;
		   		    padding: 10px;
		   		    margin-bottom: 20px;
		   		    border: 1px solid #ddd;
		   		    border-radius: 5px;
		   		    width: 100%;
		   		}
		    
		   		.payment-form .card-details {
		   		    display: flex;
		   		    justify-content: space-between;
		   		    gap: 10px;
		   		}
		    
		   		.payment-form .card-details input {
		   		    width: calc(50% - 5px);
		   		}
		    
		   		.payment-form button {
		   		    background-color: #F4F4F4;
		   		    color: white;
		   		    font-size: 16px;
		   		    padding: 15px;
		   		    border: none;
		   		    border-radius: 5px;
		   		    cursor: pointer;
		   		    transition: background-color 0.3s;
		   		    width: 50%;
		   			margin-left: 30%;
		   		}
		    
		   		.payment-form button:hover {
		   		    background-color: #f8f9fa;
		   		}
		    	.referalinput{
					    background-repeat: no-repeat;
					    background-position: right 15px center;
					    padding-right: 45px;
					    appearance: none;
					    width: 60%;
					    height: 51px;
				}
				.inputwrongimage{
					background-image: url(../images/warning-red.svg);
					background-color: #F2D8DF !important;
				}
				.inputtickimage{
					background-image: url(../images/tickmark.svg);
				}
				
		   		/* Mobile Styles */
		   		@media screen and (max-width: 768px) {
		   		    .container2 {
		   		        flex-direction: column;
		   		        width: 90%;
		   		        max-width: 100%;
		   		    }
					.btn-four{
						font-size: 10px !important;
					}
		   		    .payment-summary, .payment-form {
		   		        width: 100%;
		   		        padding: 20px;
		   		        border: none;
		   		    }
		    
		   		    .payment-summary {
		   		        border-bottom: 1px solid #e6e6e6;
		   		        text-align: center;
		   		    }
		    
		   		    .payment-summary h1 {
		   		        font-size: 22px;
		   		    }
		    
		   		    .payment-summary h2 {
		   		        font-size: 18px;
		   		    }
		    
		   		    .payment-summary h3 {
		   		        font-size: 32px;
		   		    }
		   		    .payment-summary p {
		   		        color:#003B6A;
		   		    }
		   			
		    
		   		    .payment-summary .product-list p {
		   		        font-size: 14px;
		   		    }
		    
		   		    .payment-form h2 {
		   		        font-size: 18px;
		   		        text-align: center;
		   		    }
		    
		   		    .payment-form .card-details {
		   		        flex-direction: column;
		   		    }
		    
		   		    .payment-form .card-details input {
		   		        width: 100%;
		   		    }
		    
		   		    .payment-form button {
		   		        font-size: 16px;
		   		        padding: 12px;
		   		    }
				}
		    
		   		  
    </style>
	
</head>
<body>
<div class="main-page-wrapper">
 
<br>
    <!-- Main Content -->
    <div class="ud-main">
		    <div class="checkout-sec">
				
		    <div class="container" id="stripepayment">
			   <div class="stripe-sec">
		        <div class="payment-summary">
					<div class="product-list">
						<div id="strikePriceContainer" style="display:none;">
							<span class="strike">$${amount}</span>
						</div>
					<p class="ps-head">Pay CTAHarbor<span style="font-size:30px;"id="totalAmount">$${amount}</span></p>
					<p><b><span>Product plan</span></b><span>${pricingPlan}</span></p>
				    <p><b><span>No of files</span></b><span>${nooffiles}</span></p>
					<div  id="strikePriceContainer2" style=" display:none;">
					<span class="strike">$${costperfile}</span>
					</div>
					<p><b><span>Cost per file</span></b><span id="costperfile">$${costperfile}</span></p>
				  <div id="strikePriceContainer3" style="display:none;">
                  <span class="strike">$${amount}</span>
				  </div>
				  <p><b><span>Amount</span></b><span id="amount">$${amount}</span></p>
					<b><h6>Have a Referral Code?</h6></b>
					<div class="form-group" style="display: flex; align-items: center; justify-content: flex-start;">
					    <input class="col-10 referalinput alternate-name form-field form-control" 
					           
					           placeholder="Enter Code Here" type="text" name="code" id="code">
					    <span class="col-2">
					        <a href="#" class="btn-four" style="border-radius: 8px;" id="apply" name="apply">Apply</a>
					    </span>
					</div>					
					<div id="couponResponseMessage" style="padding-top: 10px;color: #003B6A;font-size: 16px;"></div> 
				
					    
					
		             
		        </div>
				</div>
				
				<div class="payment-form">
			            <h2 style="font-size:26px">Select Your Preferred Payment Gateway </h2>
						<!-- Retrieve country code from model -->
						<c:set var="countryCode" value="${countryCode}" />
						<c:choose>
							<c:when test="${countryCode == 'US'}">
			            		<button type="button" name="checkoutButton" id="checkoutButton" ><img src="/images/stripeimage.png" width="100px" height="30px" alt="">
								</button><br>
							</c:when>
						<c:otherwise>
			        			<button type="button" name="tpbutton" id="tpbutton" ><img src="/images/tazapayimage.png" width="100px" height="30px" alt=""></button>
						</c:otherwise>
					</c:choose>
				  </div>
				</div>
		</div>
    </div>
 

	<script>
		var globalPercentage = ""; // To track the percentage discount globally
 
		$(document).ready(function() {
		    $("#apply").click(function(event) {
		        event.preventDefault(); // Prevent default form submission
		        var ccode = document.getElementById("code").value;
 
		        $.ajax({
		            url: '/validateCoupon',
		            type: 'GET', // Adjust the HTTP method as needed
		            data: {
		                couponCode: ccode
		            },
		            success: function(response) {
 		                const data = JSON.parse(response);
 
		                // Get elements for updating prices
		                var amountSpan = document.getElementById("amount");
		                var TotalAmount = document.getElementById("totalAmount");
		                var costperfile = document.getElementById("costperfile");
 
		                if (data.messagecode === "200") { // Valid coupon
		                    globalPercentage = data.percentage;
 
		                    // Calculate new amount after discount
		                    var amount = '${amount}' * (1 - globalPercentage / 100);
		                    var roundedNumber = Math.round(amount);
 
		                    // Update the amount after applying the discount
		                    amountSpan.textContent = "$" + roundedNumber;
		                    TotalAmount.textContent = "$" + roundedNumber;
		                    costperfile.textContent = "$" + roundedNumber / eval('${nooffiles}');
 
		                    // Show the original price with strike-through
		                    $('#strikePriceContainer').css('display', 'block');
		                    $('#strikePriceContainer2').css('display', 'block');
		                    $('#strikePriceContainer3').css('display', 'block');
 
		                    // Add success classes and messages
		                    $('#code').removeClass('inputwrongimage'); // Remove error class if present
		                    $('#code').addClass('inputtickimage'); // Add success class
		                    $('.strike').css({
		                        'text-align': 'right',
		                        'text-decoration': 'line-through',
		                        'color': '#B3B3B3'
		                    });
 
		                    // Reset message to success
		                    $('#couponResponseMessage').html("Referral Code Applied!<br>You’ve saved " + globalPercentage + "% on your filing.") .css("color", "#003B6A");
		                       
 
		                } else {
		                    globalPercentage = 0;
 
		                    // Reset the amount to the original value
		                    var originalAmount = '${amount}';
		                    amountSpan.textContent = "$" + originalAmount;
		                    TotalAmount.textContent = "$" + originalAmount;
		                    costperfile.textContent = "$" + originalAmount / eval('${nooffiles}');
 
		                    // Hide the strike-through price container
		                    $('#strikePriceContainer').css('display', 'none');
		                    $('#strikePriceContainer2').css('display', 'none');
		                    $('#strikePriceContainer3').css('display', 'none');
 
		                    // Remove success class and add error class
		                    $('#code').removeClass('inputtickimage'); // Remove success class
		                    $('#code').addClass('inputwrongimage'); // Add error class
 
		                    if (data.messagecode === "201") {
		                        $('#couponResponseMessage').html("The referral code you have entered<br> is invalid or expired. Please try again.")
		                            .css("color", "#B31942"); // Error color
		                    } else if (data.messagecode === "404") {
		                        $('#couponResponseMessage').html("Coupon already used.")
		                            .css("color", "#B31942"); // Error color
		                    } else if (data.messagecode === "405") {
								$('#couponResponseMessage').html("It looks like this coupon has reached its maximum limit")
								.css("color", "#B31942");
							}
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error('Error:', error);
		            }
		        });
		    });
		});
		
			
		    $("#tpbutton").click(function(e) {
				var ccode=document.getElementById("code");
				ccode=ccode.value;
		        e.preventDefault(); // Prevent the default form submission
 		        // Collect form data
				var amount='${amount}' * (1 - globalPercentage / 100)
				var roundedNumber = Math.round(amount);

		        var formData = {
					couponCode: ccode,
					encryptKey:'${encryptKey}'
		        };
		        // jQuery POST request
		        $.ajax({
		            type: "POST",
		            url: "/redirectionHandler",  // Replace with your server endpoint
		            data: formData,
		            dataType: "json",
		            success: function(response) {
		                // Handle success
		              window.location.href=response.details;
							            },
							            error: function(xhr, status, error) {
							                // Handle error
 							                alert("Failed to submit the form!");
							            }
							        });
							    });
							
							
				
					$(document).ready(function() {	
						
					const stripe = Stripe('${stripeprivatekey}'); // Replace with your Stripe Publishable Key
						
				 $("#checkoutButton").click(function(e) {
					var ccode=document.getElementById("code");
					ccode=ccode.value;

					e.preventDefault();
 							        // Collect form data
				var amount='${amount}' * (1 - globalPercentage / 100)
				var roundedNumber = Math.round(amount);
									 
					var formData = {
					  paymentGateway:'stripe',
					  couponCode: ccode,
					  encryptKey:'${encryptKey}'

						 };
					
				    // Call the backend to create the checkout session
				    fetch("/api/checkout/create-session", {
				        method: "POST",
						headers: {
						          "Content-Type": "application/json" // Set the content type to JSON
						      },
						      body: JSON.stringify(formData) // Convert the data to a JSON string
				    })
				    .then(function (response) {
				        return response.json();
				    })
				    .then(function (session) {
				        // Redirect to the Stripe Checkout page
				        return stripe.redirectToCheckout({ sessionId: session.id });
				    })
				    .then(function (result) {
				        if (result.error) {
				            alert(result.error.message);
				        }
				    })
				    .catch(function (error) {
				        console.error("Error:", error);
				    });
				});
				});
							
    		</script>
	
    <!-- Include Footer --><script src="https://js.stripe.com/v3/"></script>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
	<%@ include file="/WEB-INF/views/js.jsp" %>
</div>
</body>
</html>
 