package com.cta.boir.service;

import java.io.IOException;
import java.net.URI;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.cta.boir.vo.DocumentApiRequest;
import com.cta.boir.vo.DocumentResponse;
import com.cta.boir.vo.Entity;
import com.cta.boir.vo.MainDocument;
import com.cta.boir.vo.RawDocument;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.AccessToken;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;


@Service
public class DocumentAiService {

	private static final Logger LOGGER = LoggerFactory.getLogger(DocumentAiService.class);

	@Autowired 
	RestTemplate restTemplate;

	@Autowired
	private ResourceLoader resourceLoader;

	static Map<String, String> states;


	static {
		states = new HashMap<>();
		states.put("ALABAMA", "AL");
		states.put("ALASKA", "AK");
		states.put("ARIZONA", "AZ");
		states.put("ARKANSAS", "AR");
		states.put("CALIFORNIA", "CA");
		states.put("COLORADO", "CO");
		states.put("CONNECTICUT", "CT");
		states.put("DELAWARE", "DE");
		states.put("FLORIDA", "FL");
		states.put("GEORGIA", "GA");
		states.put("HAWAII", "HI");
		states.put("IDAHO", "ID");
		states.put("ILLINOIS", "IL");
		states.put("INDIANA", "IN");
		states.put("IOWA", "IA");
		states.put("KANSAS", "KS");
		states.put("KENTUCKY", "KY");
		states.put("LOUISIANA", "LA");
		states.put("MAINE", "ME");
		states.put("MARYLAND", "MD");
		states.put("MASSACHUSETTS", "MA");
		states.put("MICHIGAN", "MI");
		states.put("MINNESOTA", "MN");
		states.put("MISSISSIPPI", "MS");
		states.put("MISSOURI", "MO");
		states.put("MONTANA", "MT");
		states.put("NEBRASKA", "NE");
		states.put("NEVADA", "NV");
		states.put("NEW HAMPSHIRE", "NH");
		states.put("NEW JERSEY", "NJ");
		states.put("NEW MEXICO", "NM");
		states.put("NEW YORK", "NY");
		states.put("NORTH CAROLINA", "NC");
		states.put("NORTH DAKOTA", "ND");
		states.put("OHIO", "OH");
		states.put("OKLAHOMA", "OK");
		states.put("OREGON", "OR");
		states.put("PENNSYLVANIA", "PA");
		states.put("RHODE ISLAND", "RI");
		states.put("SOUTH CAROLINA", "SC");
		states.put("SOUTH DAKOTA", "SD");
		states.put("TENNESSEE", "TN");
		states.put("TEXAS", "TX");
		states.put("UTAH", "UT");
		states.put("VERMONT", "VT");
		states.put("VIRGINIA", "VA");
		states.put("WASHINGTON", "WA");
		states.put("WEST VIRGINIA", "WV");
		states.put("WISCONSIN", "WI");
		states.put("WYOMING", "WY");

	}


	public DocumentResponse getFileData(MultipartFile file, String contentType, String url, String docType) {

		DocumentResponse docResponse =null;

		try {

			String base64Request= fileToBase64Str(file);
			String token = generateToken();

			LOGGER.info(" base64Request: {} and token: {}",base64Request, token );
			String auth ="Bearer "+token;

			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", auth);
			headers.set("Content-Type", "application/json");
			headers.setBearerAuth(token);

			DocumentApiRequest request = prepareDocumentApiRequest(base64Request, contentType);

			//LOGGER.info("Requst we are passing to Document Ai api : {} ",request);

			HttpEntity<DocumentApiRequest> entity = new HttpEntity<>(request, headers);
			ResponseEntity<String> response = restTemplate.exchange(new URI(url), HttpMethod.POST, entity, String.class);

			docResponse =readJson(response.getBody(), docType);

		} catch(HttpClientErrorException ex) {
			LOGGER.error("HttpClientErrorException while reading", ex.getResponseBodyAsString());

		} catch(Exception e){
			LOGGER.error("Error occurred while reading file. Error: ", e);


		}
		return docResponse;
	}


	public static DocumentResponse readJson(String json, String docType) throws JsonMappingException, JsonProcessingException, ParseException  {
		//LOGGER.info("response json ::{}", json);

		String sourceDateFormat ="dd MMM yyyy";
		JsonFactory factory = new JsonFactory();
		DocumentResponse response = new DocumentResponse();

		try {

			ObjectMapper mapper = new ObjectMapper(factory);

			MainDocument doc = mapper.readValue(json, MainDocument.class);

			if(docType.equalsIgnoreCase("37")) {
				sourceDateFormat ="MM/dd/yyyy";
				response.setDocType("State issued driver's license");
				response.setCountry("US");

				for(Entity entity : doc.getDocument().getEntities()) {

					if(entity.getType().equalsIgnoreCase("surname") || entity.getType().equalsIgnoreCase("FN")) response.setFirstName(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("givenname") || entity.getType().equalsIgnoreCase("LN")) response.setLastName(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("dateofbirth")) response.setDob(convertDate(entity.getMentionText(),sourceDateFormat));
					if(entity.getType().equalsIgnoreCase("Drivinglicensenumber")) response.setDocNumber(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("address")) response.setStreetAddress(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("state")) response.setState(getStateShortForm(entity.getMentionText()));

				}	
			}else if(docType.equalsIgnoreCase("38")) {
				sourceDateFormat ="MM/dd/yyyy";
				response.setDocType("State/local/tribe-issued ID");
				response.setCountry("US");


				for(Entity entity : doc.getDocument().getEntities()) {

					if(entity.getType().equalsIgnoreCase("surname")) response.setFirstName(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("givenname")) response.setLastName(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("dateofbirth")) response.setDob(convertDate(entity.getMentionText(),sourceDateFormat));
					if(entity.getType().equalsIgnoreCase("address")) response.setStreetAddress(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("state")) response.setState(getStateShortForm(entity.getMentionText()));


				}
			} else  if(docType.equalsIgnoreCase("39")) {
				sourceDateFormat ="dd MMM yyyy";
				response.setDocType("U.S. passport");
				response.setCountry("US");

				for(Entity entity : doc.getDocument().getEntities()) {

					if(entity.getType().equalsIgnoreCase("surname")) response.setFirstName(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("givenname")) response.setLastName(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("passportno")) response.setDocNumber(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("dateofbirth")) response.setDob(convertDate(entity.getMentionText(),sourceDateFormat));



				}

			}  else if(docType.equalsIgnoreCase("40")) {
				sourceDateFormat ="dd/MM/yyyy";
				String country="";
				String countryCode="";
				response.setDocType("Foreign Passport");



				for(Entity entity : doc.getDocument().getEntities()) {

					if(entity.getType().equalsIgnoreCase("CountryCode")) {
						countryCode=entity.getMentionText();
						if(entity.getMentionText()!=null) {
							country = countryCode.substring(0,2);
							response.setCountry(country);
							switch (countryCode) {
							case "JPN" -> sourceDateFormat ="dd MMM yyyy";
							case "CHN" -> {sourceDateFormat ="dd MMM yy";response.setCountry("CN");}
							case "ARE" -> response.setCountry("AE");
							case "AUS" -> sourceDateFormat ="dd MMM yyyy";
							case "IRL" -> {response.setCountry("IE"); }
							case "SGP" -> sourceDateFormat ="dd MMM yyyy";
							default -> sourceDateFormat ="dd/MM/yyyy";
							}
						}

						break;
					}

				}


				for(Entity entity : doc.getDocument().getEntities()) {

					if(response.getCountry()!=null && "CN".equalsIgnoreCase(response.getCountry())) {
						if(entity.getType().equalsIgnoreCase("surname")) response.setFirstName(formatToEnglish(entity.getMentionText()));
						if(entity.getType().equalsIgnoreCase("givenname")) response.setLastName(formatToEnglish(entity.getMentionText()));
					}else {
						if(entity.getType().equalsIgnoreCase("surname")) response.setFirstName(entity.getMentionText());
						if(entity.getType().equalsIgnoreCase("givenname")) response.setLastName(entity.getMentionText());
					}
					if(entity.getType().equalsIgnoreCase("passportno")) response.setDocNumber(entity.getMentionText());
					if(entity.getType().equalsIgnoreCase("address")) response.setStreetAddress(entity.getMentionText());
					if(response.getCountry()!=null && "IE".equalsIgnoreCase(response.getCountry())) {
						if(entity.getType().equalsIgnoreCase("dateofbirth")) response.setDob(parseDate(entity.getMentionText()));
					}else if(response.getCountry()!=null && "CA".equalsIgnoreCase(response.getCountry())) {
						if(entity.getType().equalsIgnoreCase("dateofbirth")) response.setDob(parseCanadaDate(entity.getMentionText()));
					}else {
						if(entity.getType().equalsIgnoreCase("dateofbirth")) response.setDob(convertDate(entity.getMentionText(),sourceDateFormat));
					}
				}



			}


			LOGGER.info("response : {} ", response);

		} catch(Exception e){
			LOGGER.error("Error occurred while reading file. Error: ", e);


		}

		return response;


	}


	private static String getStateShortForm(String input) {
		try {
			if(input!=null && input.length()>2)
				input = states.get(input.toUpperCase());
		}catch(Exception e) {
		}

		return input;
	}


	private static String formatToEnglish(String input) {
		try {
			if(input!=null && input.contains("/")) {
				String[] parts = input.split("/");
				return parts[parts.length - 1].trim();
			}
		}catch(Exception e) {
			return input;
		}

		return input;
	}

	private static String getLastname(String input) {
		try {
			if(input!=null && input.contains(" ")) {
				String[] parts = input.split(" ");
				return parts[parts.length - 1].trim();
			}
		}catch(Exception e) {
			return input;
		}

		return input;
	}

	public static String getFirstName(String fullName) {
		String[] nameParts = fullName.split(" ");
		return nameParts.length > 0 ? nameParts[0] : "";
	}

	private DocumentApiRequest prepareDocumentApiRequest(String base64Request, String contentType) {

 		DocumentApiRequest documentApiRequest = new DocumentApiRequest();
		RawDocument rawDocument = new RawDocument();

		rawDocument.setContent(base64Request);
		rawDocument.setMimeType(contentType);

		documentApiRequest.setRawDocument(rawDocument);
		documentApiRequest.setSkipHumanReview(true);


		return documentApiRequest;
	}

	private String fileToBase64Str(MultipartFile file) throws Exception {

		byte [] bytes = file.getBytes();

		return Base64.getEncoder().encodeToString(bytes);

	}

	public String generateToken() throws IOException {
		Resource resource = resourceLoader.getResource("classpath:cta-harbour-doc-ai-76dbe1c7a8dd.json");

		// Read the service account key file
		GoogleCredentials credentials = ServiceAccountCredentials.fromStream(resource.getInputStream())
				.createScoped(Collections.singletonList("https://www.googleapis.com/auth/cloud-platform"));

		// Obtain an access token
		AccessToken token = credentials.refreshAccessToken();
 
		return token.getTokenValue();
	}

	public static String convertDate(String date, String sourceforamt) {
		String finalDateStr ="";
		try {
			SimpleDateFormat format1 = new SimpleDateFormat(sourceforamt);
			SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
			Date finalDate = format1.parse(date);
			finalDateStr = format2.format(finalDate);
		}catch(Exception e) {
			LOGGER.error("Exception occured while parsing date");
			try {
				SimpleDateFormat format1 = new SimpleDateFormat("dd MMM yyyy");
				SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
				Date finalDate = format1.parse(date);
				finalDateStr = format2.format(finalDate);
			}catch(Exception e1) {

				try {
					SimpleDateFormat format1 = new SimpleDateFormat("dd-MM-yyyy");
					SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
					Date finalDate = format1.parse(date);
					finalDateStr = format2.format(finalDate);
				}catch(Exception e2) {

				}

			}
		}

		return finalDateStr;

	}


	private static String parseDate(String dateString) {
		Map<String, Integer> monthMap = new HashMap<>();
		monthMap.put("JAN", 1);
		monthMap.put("FEB", 2);
		monthMap.put("MAR", 3);
		monthMap.put("APR", 4);
		monthMap.put("MAY", 5);
		monthMap.put("JUN", 6);
		monthMap.put("JUL", 7);
		monthMap.put("AUG", 8);
		monthMap.put("SEP", 9);
		monthMap.put("OCT", 10);
		monthMap.put("NOV", 11);
		monthMap.put("DEC", 12);
		monthMap.put("BEA", 5); // Assuming BEA corresponds to MAY
		monthMap.put("EAN", 1);
		monthMap.put("FEA", 2);
		monthMap.put("MÁR", 3);
		monthMap.put("AIB", 4);
		monthMap.put("MEI", 6);
		monthMap.put("IÚI", 7);
		monthMap.put("LÚN", 8);
		monthMap.put("MFO", 9);
		monthMap.put("DFO", 10);
		monthMap.put("SAM", 11);
		monthMap.put("NOL", 12);


		// Split the string to extract parts
		String[] parts = dateString.split(" ");
		if (parts.length != 3) {
			return null; // Invalid format
		}

		try {
			int day = Integer.parseInt(parts[0]);
			String monthStr = parts[1].substring(0, 3); // Take the first three characters
			int month = monthMap.getOrDefault(monthStr, -1);
			int year = Integer.parseInt(parts[2]);

			if (month == -1) {
				return null; // Invalid month
			}

			LocalDate localDate=  LocalDate.of(year, month, day);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			return localDate.format(formatter);

		} catch (NumberFormatException | DateTimeParseException e) {
			return null; // Invalid number format or parsing error
		}
	}

	private static String parseCanadaDate(String dateString) {
		Map<String, Integer> monthMap = new HashMap<>();
		monthMap.put("JAN", 1);
		monthMap.put("FEB", 2);
		monthMap.put("MAR", 3);
		monthMap.put("APR", 4);
		monthMap.put("MAY", 5);
		monthMap.put("JUN", 6);
		monthMap.put("JUL", 7);
		monthMap.put("AUG", 8);
		monthMap.put("SEP", 9);
		monthMap.put("OCT", 10);
		monthMap.put("NOV", 11);
		monthMap.put("DEC", 12);
		monthMap.put("JANV", 1);
		monthMap.put("FÉVR", 2);
		monthMap.put("MARS", 3);
		monthMap.put("AVR", 4);
		monthMap.put("MAI", 5); // Assuming BEA corresponds to MAY
		monthMap.put("JUIN", 6);
		monthMap.put("JUIL", 7);
		monthMap.put("AOÛT", 8);
		monthMap.put("SEPT", 9);
//		monthMap.put("OCT", 10);
//		monthMap.put("NOV", 11);
		monthMap.put("DÉC", 12);


		// Split the string to extract parts
		String[] parts = dateString.split(" ");
		if (parts.length != 3) {
			return null; // Invalid format
		}

		try {
			int day = Integer.parseInt(parts[0]);
			String monthStr = parts[1].substring(0, 3); // Take the first three characters
			int month = monthMap.getOrDefault(monthStr, -1);
 			int year;

			if (month == -1) {
				return null; // Invalid month
			}

			if (parts[2].length() == 2) {
				// Two-digit year
				int twoDigitYear = Integer.parseInt(parts[2]);
				year = (twoDigitYear < 50) ? 2000 + twoDigitYear : 1900 + twoDigitYear; 
			} else if (parts[2].length() == 4) {
				// Four-digit year
				year = Integer.parseInt(parts[2]);
			} else {
				return null; // Invalid year format
			}

			LocalDate localDate=  LocalDate.of(year, month, day);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			return localDate.format(formatter);

		} catch (NumberFormatException | DateTimeParseException e) {
			return null; // Invalid number format or parsing error
		}
	}

	String getCountryValue(String countryCode){
		try {

			if("USA".equalsIgnoreCase(countryCode))
				return "US";

		}catch(Exception e) {
			LOGGER.error("get country error");
		}

		return "";


	}


}
