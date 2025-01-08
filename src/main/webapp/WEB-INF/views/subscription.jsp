<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns:th="http://www.thymeleaf.org">
   <head>
      <title>Subscription</title>
      <!--Bootstrap 4 CSS-->
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!--Bootstrap 4 JavaScript-->
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
      <!--Stripe JavaScript Library-->
      <script src="https://js.stripe.com/v3/"></script>
   </head>
   <body class="bg-light pt-5">
      <!--hero section-->
      <section class="py-5">
         <div class="container">
            <div class="row">
               <div class="col-lg-6 col-md-8 col-12 my-auto mx-auto">
                  <h1>
                     Stripe Recurring Subscription
                  </h1>
                  <p class="lead mb-4">
                     Please fill the form below to complete the payment
                  </p>
                  <h5 class="mb-2">Choose your payment plan</h5>
                  <p class="text-muted">
                     60% OFF when you upgrade to annual plan.
                  </p>
                  <div class="py-2">
                     <div class="custom-control custom-radio">
                        <input class="custom-control-input" id="monthly-plan" name="premium-plan" type="radio"
                           value="monthly-subscription"/>
                        <label class="custom-control-label" for="monthly-plan">
                        <strong>Monthly $100.00</strong><br/>
                        <small class="text-muted">
                        Pay $100.00 every month and get access to all premium features.
                        </small>
                        </label>
                     </div>
                     <div class="custom-control custom-radio mt-3">
                        <input checked="" class="custom-control-input" id="annually-plan" name="premium-plan"
                           type="radio" value="annual-subscription"/>
                        <label class="custom-control-label" for="annually-plan">
                        <strong>Yearly $800.00</strong>
                        <span class="badge badge-primary ml-1">60% OFF</span>
                        <br/>
                        <small class="text-muted">
                        Pay $800.00 every year and get access to all premium features.
                        </small>
                        </label>
                     </div>
                  </div>
                  <form action="#" id="payment-form" method="post">
                     <input id="api-key" type="hidden" th:value="${stripePublicKey}">
                     <div class="form-group">
                        <label class="font-weight-medium" for="card-element">
                        Enter credit or debit card below
                        </label>
                        <div class="w-100" id="card-element">
                           <!-- A Stripe Element will be inserted here. -->
                        </div>
                     </div>
                     <div class="form-group">
                        <input class="form-control" id="email" name="email"
                           placeholder="Email Address" type="email" required>
                     </div>
                     <div class="form-group">
                        <input class="form-control" id="coupon" name="coupon"
                           placeholder="Coupon code (optional)" type="text">
                     </div>
                     <!-- Used to display Element errors. -->
                     <div class="text-danger w-100" id="card-errors" role="alert"></div>
                     <div class="form-group pt-2">
                        <button class="btn btn-primary btn-block" id="submitButton" type="submit">
                        Pay With Your Card
                        </button>
                        <div class="small text-muted mt-2">
                           Pay securely with Stripe. By clicking the button above, you agree
                           to our <a target="_blank" href="#">Terms of Service</a>,
                           <a target="_blank" href="#">Privacy</a> and
                           <a target="_blank" href="#">Refund</a> policies.
                        </div>
                     </div>
                  </form>
                  <p class="mt-5 text-muted">
                     <small>An example project by <a th:href="@{https://github.com/GretiCani}" target="_blank">Greti</a>.</small>
                  </p>
               </div>
            </div>
         </div>
      </section>
      <!--custom javascript for handling subscription-->
      <script>
         $(function () {
             var API_KEY = $('#api-key').val();
             // Create a Stripe client.
             var stripe = Stripe(API_KEY);
         
             // Create an instance of Elements.
             var elements = stripe.elements();
         
             // Create an instance of the card Element.
             var card = elements.create('card');
         
             // Add an instance of the card Element into the `card-element` <div>.
             card.mount('#card-element');
         
             // Handle real-time validation errors from the card Element.
             card.addEventListener('change', function (event) {
                 var displayError = document.getElementById('card-errors');
                 if (event.error) {
                     displayError.textContent = event.error.message;
                 } else {
                     displayError.textContent = '';
                 }
             });
         
             // Handle form submission.
             var form = document.getElementById('payment-form');
             form.addEventListener('submit', function (event) {
                 event.preventDefault();
                 //validate coupon if any
                 var code = $('#coupon').val().trim();
                 if (code.length > 0) {
                     $.post(
                         "/coupon-validator",
                         {code: code},
                         function (data) {
                             if (data.status) {
                                 handlePayments();
                             } else {
                                 alert(data.details);
                             }
                         }, 'json');
                 } else {
                     handlePayments();
                 }
             });
         
             //handle card submission
             function handlePayments() {
                 stripe.createToken(card).then(function (result) {
                     if (result.error) {
                         // Inform the user if there was an error.
                         var errorElement = document.getElementById('card-errors');
                         errorElement.textContent = result.error.message;
                     } else {
                         // Send the token to your server.
                         var token = result.token.id;
                         var plan = $('input[name="premium-plan"]:checked').val();
                         var email = $('#email').val();
                         var coupon = $('#coupon').val();
                         $.post(
                             "/create-subscription",
                             {email: email, token: token, plan: plan, coupon: coupon},
                             function (data) {
                                 alert(data.details);
                             }, 'json');
                     }
                 });
             }
         });
      </script>
   </body>
</html>