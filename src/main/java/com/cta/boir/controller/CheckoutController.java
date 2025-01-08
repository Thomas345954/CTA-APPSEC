package com.cta.boir.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cta.boir.config.EncryptionUtil;
import com.cta.boir.model.GeneratedCoupon;
import com.cta.boir.model.PaymentRequest;
import com.cta.boir.model.User;
import com.cta.boir.service.GeneratedCouponService;
import com.cta.boir.service.PaymentService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Customer;
import com.stripe.model.checkout.Session;
import com.stripe.param.CustomerCreateParams;
import com.stripe.param.checkout.SessionCreateParams;

@RestController
@RequestMapping("/api/checkout")
public class CheckoutController {
	@Value("${nybacsAdmin.api.entity.service}")
	private String entity;
	@Value("${nybacs.payment.gateway.context}")
	private String context;
	@Value("${Stripe.apiKey}")
	private String stripeapiKey;
	@Value("${nybacs.payment.gateway.receiptcontext}")
	private String receiptcontext;
	@Value("${nybacs.payment.gateway.chargecontext}")
	private String chargecontext;
	@Value("${encryption.key}")
	private String encryptionkey;
	@Autowired
	GeneratedCouponService generatedCoupon;
	@Autowired
	PaymentService ps;

	@Autowired
	WraperService wraperService;

	@Autowired
	private UserService userService;

	public IvParameterSpec generateRandomIV() {
		// Generate a secure random IV
		// SecureRandom random = new SecureRandom();
		// byte[] ivBytes = new byte[16]; // AES block size is 16 bytes
		// random.nextBytes(ivBytes);
		IvParameterSpec iv = new IvParameterSpec(new byte[16]);
		return iv;
	}

	private final SecretKey secretKey = new SecretKeySpec(Base64.getDecoder().decode("AAECAwQFBgcICQoLDA0ODw=="),
			"AES");

	public CheckoutController() {
		// Set your secret key. Remember to use the test key for testing.
		Stripe.apiKey = stripeapiKey; // Replace with your Stripe Secret Key
	}

	@PostMapping("/create-session")
	public Map<String, String> createCheckoutSession(@RequestBody Map<String, Object> data) {
		Stripe.apiKey = stripeapiKey;
		String couponCode = "";
		if (data.get("couponCode") != null)
			couponCode = (String) data.get("couponCode");
		String couponcode = couponCode.toUpperCase();// "MICJC";
		List<GeneratedCoupon> gc = generatedCoupon.getGeneratedCouponBycode(couponcode);
		String response = null;
		String percentage = "0";
		if (!gc.isEmpty()) {
			percentage = gc.get(0).getPercentage();
		}
		EncryptionUtil eu = new EncryptionUtil();
		// String requestId=UUID.randomUUID().toString();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}
		User users = userService.findByEmail(principalName);
		String dataencryptKey = (String) data.get("encryptKey");
		IvParameterSpec iv = generateRandomIV();
		String[] dataParams = null;
		try {
			dataParams = eu.decrypt(dataencryptKey, secretKey, iv).split("@");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String, String> responseData = new HashMap<>();
		// String successUrl = receiptcontext+"payment_intent={PAYMENT_INTENT}";
		// Build the session create parameters

		// String customerName = (String) data.get("customerName");
		String planId = dataParams[2];

		String pricingIndividualData = wraperService.postDataResp(entity,
				"{\r\n" + "    \"entityName\" : \"pricing\",\r\n" + "    \"whereClause\" : \"id ='" + dataParams[2]
						+ "' order by c_priority\"\r\n" + "}");

		JsonParser springParserPricingInd = JsonParserFactory.getJsonParser();
		List<Object> pricingIndJsonList = springParserPricingInd.parseList(pricingIndividualData);
		String pricingPlan = "";
		for (Object obj : pricingIndJsonList) {
			if (obj instanceof Map) {
				Map<String, Object> map = (Map<String, Object>) obj;
				pricingPlan = map.get("c_name").toString();
			}
		}

		if (pricingPlan.equals("A")) {
			pricingPlan = "Individual";
		} else if (pricingPlan.equals("B") || pricingPlan.equals("C")) {
			pricingPlan = "Professional";
		}

		long nooffiles = Long.parseLong(dataParams[1].toString());

		long mainamount = Long.parseLong(dataParams[0].toString()); // Amount in cents
		long amount = 0;
		if (!gc.isEmpty()) {
			// amount = mainamount * (1 - Integer.parseInt(percentage) / 100);
			amount = (long) ((1 - Long.valueOf(percentage) / 100.0) * mainamount);
		} else {
			amount = mainamount;
		}
		String encryptKey = null;
		try {
			int priceoffile = ((Integer.parseInt(dataParams[0].toString().toString()))
					/ Integer.parseInt(dataParams[1].toString().toString()));
			encryptKey = eu.encrypt(String.valueOf(Integer.parseInt(dataParams[1].toString().toString()) * priceoffile)
					+ "@" + nooffiles + "@" + dataParams[0].toString() + "@" + "TazaPay", secretKey, iv);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (encryptKey != null) {
			encryptKey = encryptKey.replaceAll("/", "@");
		}
		String cancelUrl = chargecontext + encryptKey;
		CustomerCreateParams params = CustomerCreateParams.builder().setName(users.getName()).setEmail(users.getEmail())
				.build();
		Customer customer = null;
		try {
			customer = Customer.create(params);
		} catch (StripeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (customer != null) {
			SessionCreateParams params1 = SessionCreateParams.builder().setMode(SessionCreateParams.Mode.PAYMENT)
					.setSuccessUrl(receiptcontext + "{CHECKOUT_SESSION_ID}") // Your success URL
					.setCancelUrl(cancelUrl) // Your cancel URL
					.setCustomer(customer.getId())
					.addLineItem(SessionCreateParams.LineItem.builder().setQuantity(nooffiles)
							.setPriceData(SessionCreateParams.LineItem.PriceData.builder().setCurrency("usd") // Specify
																												// currency
									.setUnitAmount((amount / nooffiles) * 100) // Amount in cents (i.e., $20.00)
									.setProductData(SessionCreateParams.LineItem.PriceData.ProductData.builder()
											.setName(pricingPlan) // Name of the product
											.build())
									.build())
							.build())
					.build();
			try {
				// Create the checkout session
				Session session = Session.create(params1);
				responseData.put("id", session.getId());
				PaymentRequest pr = new PaymentRequest();
				pr.setUserId(String.valueOf(users.getId()));
				pr.setPaymentIntentId(session.getId());
				pr.setAmount((amount));
				pr.setPaymentGateway("Stripe");
				pr.setTransactionId(session.getId());
				pr.setNooffiles(String.valueOf(nooffiles));
				pr.setPlanId(planId);
				pr.setCouponCode(couponCode);
				ps.savePaymentRequest(pr);

			} catch (StripeException e) {
				responseData.put("error", e.getMessage());
			}
		}
		return responseData;
	}
}
