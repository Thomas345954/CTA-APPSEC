package com.cta.boir.service;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.UUID;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.cta.boir.config.EncryptionUtil;
import com.cta.boir.controller.CheckoutController;
import com.cta.boir.model.GeneratedCoupon;
import com.cta.boir.model.PaymentRequest;
import com.cta.boir.model.User;

import jakarta.servlet.http.HttpServletRequest;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;


@Service
public class WraperService {

	@Autowired
	RestTemplate restTemplate;
	@Value("${nybacs.payment.gateway.context}") private String context;
	@Value("${nybacs.payment.gateway.tazapay.authorization}") private String tazapayauthorization;
	@Value("${nybacs.payment.gateway.tazapay.context}") private String tajapaycontext;
	@Value("${nybacs.payment.gateway.receiptcontext}") private String receiptcontext;
	@Value("${nybacs.payment.gateway.chargecontext}") private String chargecontext;
	@Value("${encryption.key}") private String encryptionkey;
	@Autowired
	GeneratedCouponService  generatedCoupon;
    @Autowired
    private HttpServletRequest httprequest; 
	@Autowired
	GeoIPService geoIPService; 
	
	@Autowired
	EncryptDecrypt encDec;
	
	@Autowired
	PaymentService ps;
	
	@Autowired
	private UserService userService;

	private final  SecretKey secretKey = new SecretKeySpec(Base64.getDecoder().decode("AAECAwQFBgcICQoLDA0ODw=="), "AES");


	public URI buildURI(String s) {
		URI uri = null;
		try {
			uri = new URI(s.replace(" ", "%20"));
		} catch (URISyntaxException e) {

		}
		return uri;
	}

	public HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		//String authString = encDec.decrypt("apiuser") + ":" + encDec.decrypt("password");
		//String encoding = Base64.getEncoder().encodeToString((authString).getBytes());
		//headers.add("Authorization", "Basic " + encoding);
		headers.setContentType(MediaType.APPLICATION_JSON);
		return headers;
	}

	public String postDataResp(String url,String body) {
		HttpEntity<Object> entity = new HttpEntity<>(body, getHeaders());
		return (restTemplate.exchange(buildURI(url), HttpMethod.POST, entity, String.class).getBody());
	}

	public String getData(String url) {
		HttpEntity<Object> entity = new HttpEntity<>(getHeaders());
		return restTemplate.exchange(buildURI(url), HttpMethod.GET, entity, String.class).getBody(); //String we can replace with pojo to handle response 
	}

	
	public void postFPDataResp(String amount,String email,String tid) {
		 
		
		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");
        headers.set("x-api-key", "b043befe20e672a3c298de0f84191a1a");

        // Build the URL with parameters
        URI uri = UriComponentsBuilder.fromHttpUrl("https://firstpromoter.com/api/v1/track/sale")
                .queryParam("email",email )
                .queryParam("event_id", tid)
                .queryParam("amount", amount)
                .build()
                .toUri();

        // Create an HttpEntity with the headers
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // Execute GET request with headers
        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.POST, entity, String.class);

        // Print the response body 

		
	}
	
	//GeoIpService code to get country from IP address
	
	 public String getCurrencyBasedOnIP(String ip) {
	        String countryCode = geoIPService.getCountryByIP(ip);
	        return (countryCode);
	    }

	    private String mapCountryToCurrency(String countryCode) {
	        // Simple mapping of country code to currency
	        Map<String, String> countryCurrencyMap = new HashMap<>();
	        countryCurrencyMap.put("AF", "AFN"); // Afghanistan - Afghani
	        countryCurrencyMap.put("AL", "ALL"); // Albania - Lek
	        countryCurrencyMap.put("DZ", "DZD"); // Algeria - Algerian Dinar
	        countryCurrencyMap.put("AD", "EUR"); // Andorra - Euro
	        countryCurrencyMap.put("AO", "AOA"); // Angola - Kwanza
	        countryCurrencyMap.put("AG", "XCD"); // Antigua and Barbuda - East Caribbean Dollar
	        countryCurrencyMap.put("AR", "ARS"); // Argentina - Argentine Peso
	        countryCurrencyMap.put("AM", "AMD"); // Armenia - Armenian Dram
	        countryCurrencyMap.put("AU", "AUD"); // Australia - Australian Dollar
	        countryCurrencyMap.put("AT", "EUR"); // Austria - Euro
	        countryCurrencyMap.put("AZ", "AZN"); // Azerbaijan - Azerbaijani Manat
	        countryCurrencyMap.put("BS", "BSD"); // Bahamas - Bahamian Dollar
	        countryCurrencyMap.put("BH", "BHD"); // Bahrain - Bahraini Dinar
	        countryCurrencyMap.put("BD", "BDT"); // Bangladesh - Bangladeshi Taka
	        countryCurrencyMap.put("BB", "BBD"); // Barbados - Barbadian Dollar
	        countryCurrencyMap.put("BY", "BYN"); // Belarus - Belarusian Ruble
	        countryCurrencyMap.put("BE", "EUR"); // Belgium - Euro
	        countryCurrencyMap.put("BZ", "BZD"); // Belize - Belize Dollar
	        countryCurrencyMap.put("BJ", "XOF"); // Benin - West African CFA Franc
	        countryCurrencyMap.put("BT", "INR"); // Bhutan - Indian Rupee
	        countryCurrencyMap.put("BO", "BOB"); // Bolivia - Bolivian Boliviano
	        countryCurrencyMap.put("BA", "BAM"); // Bosnia and Herzegovina - Convertible Mark
	        countryCurrencyMap.put("BW", "BWP"); // Botswana - Botswana Pula
	        countryCurrencyMap.put("BR", "BRL"); // Brazil - Brazilian Real
	        countryCurrencyMap.put("BN", "BND"); // Brunei - Brunei Dollar
	        countryCurrencyMap.put("BG", "BGN"); // Bulgaria - Bulgarian Lev
	        countryCurrencyMap.put("BF", "XOF"); // Burkina Faso - West African CFA Franc
	        countryCurrencyMap.put("BI", "BIF"); // Burundi - Burundian Franc
	        countryCurrencyMap.put("KH", "KHR"); // Cambodia - Cambodian Riel
	        countryCurrencyMap.put("CM", "XAF"); // Cameroon - Central African CFA Franc
	        countryCurrencyMap.put("CA", "CAD"); // Canada - Canadian Dollar
	        countryCurrencyMap.put("CV", "CVE"); // Cape Verde - Cape Verdean Escudo
	        countryCurrencyMap.put("CF", "XAF"); // Central African Republic - Central African CFA Franc
	        countryCurrencyMap.put("TD", "XAF"); // Chad - Central African CFA Franc
	        countryCurrencyMap.put("CL", "CLP"); // Chile - Chilean Peso
	        countryCurrencyMap.put("CN", "CNY"); // China - Chinese Yuan
	        countryCurrencyMap.put("CO", "COP"); // Colombia - Colombian Peso
	        countryCurrencyMap.put("KM", "KMF"); // Comoros - Comorian Franc
	        countryCurrencyMap.put("CD", "CDF"); // Congo, Democratic Republic of the - Congolese Franc
	        countryCurrencyMap.put("CG", "XAF"); // Congo, Republic of the - Central African CFA Franc
	        countryCurrencyMap.put("CR", "CRC"); // Costa Rica - Costa Rican Colón
	        countryCurrencyMap.put("HR", "HRK"); // Croatia - Croatian Kuna
	        countryCurrencyMap.put("CU", "CUP"); // Cuba - Cuban Peso
	        countryCurrencyMap.put("CY", "EUR"); // Cyprus - Euro
	        countryCurrencyMap.put("CZ", "CZK"); // Czech Republic - Czech Koruna
	        countryCurrencyMap.put("DK", "DKK"); // Denmark - Danish Krone
	        countryCurrencyMap.put("DJ", "DJF"); // Djibouti - Djiboutian Franc
	        countryCurrencyMap.put("DM", "XCD"); // Dominica - East Caribbean Dollar
	        countryCurrencyMap.put("DO", "DOP"); // Dominican Republic - Dominican Peso
	        countryCurrencyMap.put("EC", "USD"); // Ecuador - United States Dollar
	        countryCurrencyMap.put("EG", "EGP"); // Egypt - Egyptian Pound
	        countryCurrencyMap.put("SV", "USD"); // El Salvador - United States Dollar
	        countryCurrencyMap.put("GQ", "XAF"); // Equatorial Guinea - Central African CFA Franc
	        countryCurrencyMap.put("ER", "ERN"); // Eritrea - Nakfa
	        countryCurrencyMap.put("EE", "EUR"); // Estonia - Euro
	        countryCurrencyMap.put("SZ", "SZL"); // Eswatini - Swazi Lilangeni
	        countryCurrencyMap.put("ET", "ETB"); // Ethiopia - Ethiopian Birr
	        countryCurrencyMap.put("FJ", "FJD"); // Fiji - Fijian Dollar
	        countryCurrencyMap.put("FI", "EUR"); // Finland - Euro
	        countryCurrencyMap.put("FR", "EUR"); // France - Euro
	        countryCurrencyMap.put("GA", "XAF"); // Gabon - Central African CFA Franc
	        countryCurrencyMap.put("GM", "GMD"); // Gambia - Gambian Dalasi
	        countryCurrencyMap.put("GE", "GEL"); // Georgia - Georgian Lari
	        countryCurrencyMap.put("DE", "EUR"); // Germany - Euro
	        countryCurrencyMap.put("GH", "GHS"); // Ghana - Ghanaian Cedi
	        countryCurrencyMap.put("GR", "EUR"); // Greece - Euro
	        countryCurrencyMap.put("GD", "XCD"); // Grenada - East Caribbean Dollar
	        countryCurrencyMap.put("GT", "GTQ"); // Guatemala - Guatemalan Quetzal
	        countryCurrencyMap.put("GN", "GNF"); // Guinea - Guinean Franc
	        countryCurrencyMap.put("GW", "XOF"); // Guinea-Bissau - West African CFA Franc
	        countryCurrencyMap.put("GY", "GYD"); // Guyana - Guyanese Dollar
	        countryCurrencyMap.put("HT", "HTG"); // Haiti - Haitian Gourde
	        countryCurrencyMap.put("HN", "HNL"); // Honduras - Honduran Lempira
	        countryCurrencyMap.put("HU", "HUF"); // Hungary - Hungarian Forint
	        countryCurrencyMap.put("IS", "ISK"); // Iceland - Icelandic Króna
	        countryCurrencyMap.put("IN", "INR"); // India - Indian Rupee
	        countryCurrencyMap.put("ID", "IDR"); // Indonesia - Indonesian Rupiah
	        countryCurrencyMap.put("IR", "IRR"); // Iran - Iranian Rial
	        countryCurrencyMap.put("IQ", "IQD"); // Iraq - Iraqi Dinar
	        countryCurrencyMap.put("IE", "EUR"); // Ireland - Euro
	        countryCurrencyMap.put("IL", "ILS"); // Israel - Israeli New Shekel
	        countryCurrencyMap.put("IT", "EUR"); // Italy - Euro
	        countryCurrencyMap.put("CI", "XOF"); // Ivory Coast - West African CFA Franc
	        countryCurrencyMap.put("JM", "JMD"); // Jamaica - Jamaican Dollar
	        countryCurrencyMap.put("JP", "JPY"); // Japan - Japanese Yen
	        countryCurrencyMap.put("JO", "JOD"); // Jordan - Jordanian Dinar
	        countryCurrencyMap.put("KZ", "KZT"); // Kazakhstan - Kazakhstani Tenge
	        countryCurrencyMap.put("KE", "KES"); // Kenya - Kenyan Shilling
	        countryCurrencyMap.put("KI", "AUD"); // Kiribati - Australian Dollar
	        countryCurrencyMap.put("KP", "KPW"); // Korea, North - North Korean Won
	        countryCurrencyMap.put("KR", "KRW"); // Korea, South - South Korean Won
	        countryCurrencyMap.put("XK", "EUR"); // Kosovo - Euro
	        countryCurrencyMap.put("KW", "KWD"); // Kuwait - Kuwaiti Dinar
	        countryCurrencyMap.put("KG", "KGS"); // Kyrgyzstan - Kyrgyzstani Som
	        countryCurrencyMap.put("LA", "LAK"); // Laos - Lao Kip
	        countryCurrencyMap.put("LV", "EUR"); // Latvia - Euro
	        countryCurrencyMap.put("LB", "LBP"); // Lebanon - Lebanese Pound
	        countryCurrencyMap.put("LS", "LSL"); // Lesotho - Lesotho Loti
	        countryCurrencyMap.put("LR", "LRD"); // Liberia - Liberian Dollar
	        countryCurrencyMap.put("LY", "LYD"); // Libya - Libyan Dinar
	        countryCurrencyMap.put("LI", "CHF"); // Liechtenstein - Swiss Franc
	        countryCurrencyMap.put("LT", "EUR"); // Lithuania - Euro
	        countryCurrencyMap.put("LU", "EUR"); // Luxembourg - Euro
	        countryCurrencyMap.put("MG", "MGA"); // Madagascar - Malagasy Ariary
	        countryCurrencyMap.put("MW", "MWK"); // Malawi - Malawian Kwacha
	        countryCurrencyMap.put("MY", "MYR"); // Malaysia - Malaysian Ringgit
	        countryCurrencyMap.put("MV", "MVR"); // Maldives - Maldivian Rufiyaa
	        countryCurrencyMap.put("ML", "XOF"); // Mali - West African CFA Franc
	        countryCurrencyMap.put("MT", "EUR"); // Malta - Euro
	        countryCurrencyMap.put("MH", "USD"); // Marshall Islands - United States Dollar
	        countryCurrencyMap.put("MR", "MRU"); // Mauritania - Ouguiya
	        countryCurrencyMap.put("MU", "MUR"); // Mauritius - Mauritian Rupee
	        countryCurrencyMap.put("MX", "MXN"); // Mexico - Mexican Peso
	        countryCurrencyMap.put("FM", "USD"); // Micronesia - United States Dollar
	        countryCurrencyMap.put("MD", "MDL"); // Moldova - Moldovan Leu
	        countryCurrencyMap.put("MC", "EUR"); // Monaco - Euro
	        countryCurrencyMap.put("MN", "MNT"); // Mongolia - Mongolian Tögrög
	        countryCurrencyMap.put("ME", "EUR"); // Montenegro - Euro
	        countryCurrencyMap.put("MA", "MAD"); // Morocco - Moroccan Dirham
	        countryCurrencyMap.put("MZ", "MZN"); // Mozambique - Mozambican Metical
	        countryCurrencyMap.put("MM", "MMK"); // Myanmar - Myanmar Kyat
	        countryCurrencyMap.put("NA", "NAD"); // Namibia - Namibian Dollar
	        countryCurrencyMap.put("NR", "AUD"); // Nauru - Australian Dollar
	        countryCurrencyMap.put("NP", "NPR"); // Nepal - Nepalese Rupee
	        countryCurrencyMap.put("NL", "EUR"); // Netherlands - Euro
	        countryCurrencyMap.put("NZ", "NZD"); // New Zealand - New Zealand Dollar
	        countryCurrencyMap.put("NI", "NIO"); // Nicaragua - Nicaraguan Córdoba
	        countryCurrencyMap.put("NE", "XOF"); // Niger - West African CFA Franc
	        countryCurrencyMap.put("NG", "NGN"); // Nigeria - Nigerian Naira
	        countryCurrencyMap.put("MK", "MKD"); // North Macedonia - Macedonian Denar
	        countryCurrencyMap.put("NO", "NOK"); // Norway - Norwegian Krone
	        countryCurrencyMap.put("OM", "OMR"); // Oman - Omani Rial
	        countryCurrencyMap.put("PK", "PKR"); // Pakistan - Pakistani Rupee
	        countryCurrencyMap.put("PW", "USD"); // Palau - United States Dollar
	        countryCurrencyMap.put("PA", "PAB"); // Panama - Panamanian Balboa
	        countryCurrencyMap.put("PG", "PGK"); // Papua New Guinea - Papua New Guinean Kina
	        countryCurrencyMap.put("PY", "PYG"); // Paraguay - Paraguayan Guaraní
	        countryCurrencyMap.put("PE", "PEN"); // Peru - Peruvian Nuevo Sol
	        countryCurrencyMap.put("PH", "PHP"); // Philippines - Philippine Peso
	        countryCurrencyMap.put("PL", "PLN"); // Poland - Polish Zloty
	        countryCurrencyMap.put("PT", "EUR"); // Portugal - Euro
	        countryCurrencyMap.put("QA", "QAR"); // Qatar - Qatari Rial
	        countryCurrencyMap.put("RO", "RON"); // Romania - Romanian Leu
	        countryCurrencyMap.put("RU", "RUB"); // Russia - Russian Ruble
	        countryCurrencyMap.put("RW", "RWF"); // Rwanda - Rwandan Franc
	        countryCurrencyMap.put("KN", "XCD"); // Saint Kitts and Nevis - East Caribbean Dollar
	        countryCurrencyMap.put("LC", "XCD"); // Saint Lucia - East Caribbean Dollar
	        countryCurrencyMap.put("VC", "XCD"); // Saint Vincent and the Grenadines - East Caribbean Dollar
	        countryCurrencyMap.put("WS", "WST"); // Samoa - Samoan Tala
	        countryCurrencyMap.put("SM", "EUR"); // San Marino - Euro
	        countryCurrencyMap.put("ST", "STN"); // Sao Tome and Principe - Dobra
	        countryCurrencyMap.put("SA", "SAR"); // Saudi Arabia - Saudi Riyal
	        countryCurrencyMap.put("SN", "XOF"); // Senegal - West African CFA Franc
	        countryCurrencyMap.put("RS", "RSD"); // Serbia - Serbian Dinar
	        countryCurrencyMap.put("SC", "SCR"); // Seychelles - Seychellois Rupee
	        countryCurrencyMap.put("SG", "SGD"); // Singapore - Singapore Dollar
	        countryCurrencyMap.put("SK", "EUR"); // Slovakia - Euro
	        countryCurrencyMap.put("SI", "EUR"); // Slovenia - Euro
	        countryCurrencyMap.put("SB", "AUD"); // Solomon Islands - Australian Dollar
	        countryCurrencyMap.put("ZA", "ZAR"); // South Africa - South African Rand
	        countryCurrencyMap.put("ES", "EUR"); // Spain - Euro
	        countryCurrencyMap.put("LK", "LKR"); // Sri Lanka - Sri Lankan Rupee
	        countryCurrencyMap.put("SD", "SDG"); // Sudan - Sudanese Pound
	        countryCurrencyMap.put("SR", "SRD"); // Suriname - Surinamese Dollar
	        countryCurrencyMap.put("SE", "SEK"); // Sweden - Swedish Krona
	        countryCurrencyMap.put("CH", "CHF"); // Switzerland - Swiss Franc
	        countryCurrencyMap.put("TW", "TWD"); // Taiwan - New Taiwan Dollar
	        countryCurrencyMap.put("TJ", "TJS"); // Tajikistan - Tajikistani Somoni
	        countryCurrencyMap.put("TZ", "TZS"); // Tanzania - Tanzanian Shilling
	        countryCurrencyMap.put("TH", "THB"); // Thailand - Thai Baht
	        countryCurrencyMap.put("TG", "XOF"); // Togo - West African CFA Franc
	        countryCurrencyMap.put("TT", "TTD"); // Trinidad and Tobago - Trinidad and Tobago Dollar
	        countryCurrencyMap.put("TN", "TND"); // Tunisia - Tunisian Dinar
	        countryCurrencyMap.put("TR", "TRY"); // Turkey - Turkish Lira
	        countryCurrencyMap.put("TM", "TMT"); // Turkmenistan - Turkmenistani Manat
	        countryCurrencyMap.put("TV", "AUD"); // Tuvalu - Australian Dollar
	        countryCurrencyMap.put("UG", "UGX"); // Uganda - Ugandan Shilling
	        countryCurrencyMap.put("UA", "UAH"); // Ukraine - Ukrainian Hryvnia
	        countryCurrencyMap.put("AE", "AED"); // United Arab Emirates - United Arab Emirates Dirham
	        countryCurrencyMap.put("GB", "GBP"); // United Kingdom - British Pound Sterling
	        countryCurrencyMap.put("US", "USD"); // United States - United States Dollar
	        countryCurrencyMap.put("UY", "UYU"); // Uruguay - Uruguayan Peso
	        countryCurrencyMap.put("UZ", "UZS"); // Uzbekistan - Uzbekistani Som
	        countryCurrencyMap.put("VU", "VUV"); // Vanuatu - Vanuatu Vatu
	        countryCurrencyMap.put("VA", "EUR"); // Vatican City - Euro
	        countryCurrencyMap.put("VE", "VES"); // Venezuela - Venezuelan Bolívar
	        countryCurrencyMap.put("VN", "VND"); // Vietnam - Vietnamese Dong
	        countryCurrencyMap.put("YE", "YER"); // Yemen - Yemeni Rial
	        countryCurrencyMap.put("ZM", "ZMW"); // Zambia - Zambian Kwacha
	        countryCurrencyMap.put("ZW", "ZWL"); // Zimbabwe - Zimbabwean Dollar



	        return countryCurrencyMap.getOrDefault(countryCode, "USD"); // Default to USD
	    }
	
	    public String getClientIp(HttpServletRequest request) {
		    String ip = null;

		    // Headers commonly used by proxies/load balancers to pass client IP
		    String[] headers = {
		        "X-Forwarded-For",        // Standard header for proxies
		        "X-Real-IP",              // Nginx proxy/Cloudflare
		        "Proxy-Client-IP",        // Apache HTTP Server proxies
		        "WL-Proxy-Client-IP",     // WebLogic proxies
		        "HTTP_X_FORWARDED_FOR",
		        "HTTP_X_FORWARDED",
		        "HTTP_X_CLUSTER_CLIENT_IP",
		        "HTTP_CLIENT_IP",
		        "HTTP_FORWARDED_FOR",
		        "HTTP_FORWARDED",
		        "HTTP_VIA",
		        "REMOTE_ADDR"             // Standard header for remote address
		    };

		    for (String header : headers) {
		        ip = request.getHeader(header);
		        if (ip != null && !ip.isEmpty() && !"unknown".equalsIgnoreCase(ip)) {
		            // Handle multiple IPs (e.g., X-Forwarded-For: client, proxy1, proxy2)
		            ip = ip.split(",")[0].trim();
		            break;
		        }
		    }

		    // Fallback to request's remote address if no IP found in headers
		    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
		        ip = request.getRemoteAddr();
		    }

		    // Optional: Override for local testing (IPv6 localhost -> desired IP)
		    if ("0:0:0:0:0:0:0:1".equals(ip) || "127.0.0.1".equals(ip)) {
		        ip = "106.222.229.47";  // Replace with desired testing IP
		    }

		    return ip;
		}
	public String checkoutSession(String couponcode,String dataencryptKey) throws Exception {
		
		List<GeneratedCoupon> gc= generatedCoupon.getGeneratedCouponBycode(couponcode.toUpperCase());
    	String percentage="0";
    	if(!gc.isEmpty()) {
    		percentage=gc.get(0).getPercentage();		
    	}
		EncryptionUtil eu=new EncryptionUtil();
		CheckoutController c = new CheckoutController(); 
		IvParameterSpec iv = c.generateRandomIV();
		String[] dataParams = eu.decrypt(dataencryptKey, secretKey, iv).split("@");
		String amount=String.valueOf(Integer.parseInt(dataParams[0]));		
		String amt = "0";
		if (!gc.isEmpty()) {
			//amount = mainamount * (1 - Integer.parseInt(percentage) / 100);
			//String.valueOf(Integer.parseInt(amount) * (1 - Integer.parseInt(percentage) / 100));
			amt = String.valueOf(Math.round((1 - Integer.parseInt(percentage) / 100.0 )* Integer.parseInt(amount))*100);
			

		} else {
			amt = String.valueOf(Integer.parseInt(amount) * 100);
		}
 
		String requestId=UUID.randomUUID().toString();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String principalName="";
    	if(authentication != null) {
             principalName=authentication.getName() ;
        }
    	
    	
    	
    	
    	User users =  userService.findByEmail(principalName);
    	String successUrl =receiptcontext+requestId;
    	String countryCode= getCurrencyBasedOnIP(getClientIp(httprequest));
    	HttpRequest createrequest = HttpRequest.newBuilder()
        .uri(URI.create(tajapaycontext+"/v3/customer"))
    	.header("accept", "application/json")
    	.header("content-type", "application/json")
    	.header("authorization", tazapayauthorization)
    	.method("POST", HttpRequest.BodyPublishers.ofString("{\"name\":\""+users.getName()+"\",\"email\":\""+users.getEmail()+"\",\"country\":\""+countryCode+"\"}"))
    	.build();
    			HttpResponse<String> createresponse = HttpClient.newHttpClient().send(createrequest, HttpResponse.BodyHandlers.ofString());
     			JSONParser createparser = new JSONParser();
    			JSONObject createjsonObj=(JSONObject) createparser.parse(createresponse.body());
    			JSONObject createdata = (JSONObject) createjsonObj.get("data");
    			String customerid=	createdata.get("id").toString();
    		    String encryptKey=null;
    			try {
    			int	priceoffile=((Integer.parseInt(amt)/100)/Integer.parseInt(dataParams[1]));
    	    	encryptKey=eu.encrypt(String.valueOf(Integer.parseInt(dataParams[1])*priceoffile)+"@"+dataParams[1]+"@"+dataParams[2]+"@"+"TazaPay", secretKey, iv);
    			} catch (Exception e) {
    				e.printStackTrace();
    			}
    			if(encryptKey!=null) {
    				encryptKey=encryptKey.replaceAll("/", "@");
    			} 
				String cancelUrl=chargecontext+encryptKey;
    			
		         HttpRequest request = HttpRequest.newBuilder()
			    .uri(URI.create(tajapaycontext+"/v3/checkout"))
			    .header("accept", "application/json")
			    .header("content-type", "application/json")
			    .header("authorization", tazapayauthorization)
			    .method("POST", HttpRequest.BodyPublishers.ofString("{\"customer_details\":{\"country\":\""+countryCode+"\",\"name\":\"" + users.getName() + "\",\"email\":\"" + users.getEmail() + "\"},\"billing_details\":{\"name\":\"" + users.getName() + "\",\"label\":\"" + dataParams[2] + "\"},\"customer\":\"" + customerid + "\",\"invoice_currency\":\"USD\",\"amount\":" + amt + ",\"success_url\":\"" + successUrl + "\",\"cancel_url\":\"" + cancelUrl + "\",\"transaction_description\":\"BOIR FILE\"}"))
			    .build();
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		JSONParser parser = new JSONParser();
		JSONObject jsonObj=(JSONObject) parser.parse(response.body());
		JSONObject data = (JSONObject) jsonObj.get("data");
		String payment_intent_id=	data.get("payin").toString();
	
		PaymentRequest pr=new PaymentRequest();
		//couponcode
		pr.setUserId(String.valueOf(users.getId()));
		pr.setPaymentIntentId(payment_intent_id);
		pr.setAmount(Double.parseDouble(amt)/100);
		pr.setPaymentGateway("TazaPay");
		pr.setTransactionId(requestId);
		pr.setNooffiles(dataParams[1]);
		pr.setPlanId(dataParams[2]);
		if(couponcode!=null) {
		pr.setCouponCode(couponcode);
		}
		
		 ps.savePaymentRequest(pr);
		
		
		// Print the response body 
        return data.get("url").toString();
	}
 
	public String fetchSession(String id) throws IOException, InterruptedException  {
		
		HttpRequest request = HttpRequest.newBuilder()
			    .uri(URI.create(tajapaycontext+"/v3/checkout/"+id))
			    .header("accept", "application/json")
			    .header("authorization", tazapayauthorization)
			    .method("GET", HttpRequest.BodyPublishers.noBody())
			    .build();
			HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
 	
 		return response.body();
    
    
	}
	

}
