package com.cta.boir.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

@Service
public class GeoIPService {
	@Value("${GeoIPService.apikey}")
	private String geoIp;

    private final RestTemplate restTemplate;

    public GeoIPService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public String getCountryByIP(String ip) {
        String url = "http://api.ipstack.com/" + ip + "?access_key=" + geoIp;
        try {
            String response = restTemplate.getForObject(url, String.class);
            // Assuming the response contains a field "country_code"
            // Parse the JSON response to get the "country_code"
            // Using a simple string search for demo purposes; better to use a JSON parser
             JSONParser createparser = new JSONParser();
			JSONObject createjsonObj=(JSONObject) createparser.parse(response);
            return createjsonObj.get("country_code").toString();
        } catch (Exception e) {
           // e.printStackTrace();
            return "US"; // Default to "US" if there's an error
        }
    }
    
    
}
