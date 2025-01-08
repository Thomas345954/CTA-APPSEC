package com.cta.boir.service;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class StartupService {

	public static String pricingData;
	public static String faqData;
	public static String testimonialData;
	public static String blogData;
	
	@Autowired
	private RestTemplate restTemplate;

	@Autowired
	WraperService wraperService;

	@Value("${nybacsAdmin.api.entity.service}") private String entity;
	
	@PostConstruct
	public void callWebServiceOnStartup() {
		String url = entity;
		pricingData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"pricing\",\r\n"
				+ "    \"whereClause\" : \"c_price in ('119','149') order by c_priority\"\r\n" + "}");
		faqData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"faq\",\r\n"
				+ "    \"whereClause\" : \"c_feature_type = 'A. General Questions' order by datecreated\"\r\n" + "}");
		testimonialData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"testimonials\",\r\n"
				+ "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
		blogData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"blogs\",\r\n"
				+ "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
 	}
	
	
	/*
	 * @EventListener public void callWebServiceOnStartupE() { String url = entity;
	 * pricingData = wraperService.postDataResp(url, "{\r\n" +
	 * "    \"entityName\" : \"pricing\",\r\n" +
	 * "    \"whereClause\" : \"c_price in ('119','149') order by c_priority\"\r\n"
	 * + "}"); faqData = wraperService.postDataResp(url, "{\r\n" +
	 * "    \"entityName\" : \"faq\",\r\n" +
	 * "    \"whereClause\" : \"c_feature_type = 'A. General Questions' order by datecreated\"\r\n"
	 * + "}"); testimonialData = wraperService.postDataResp(url, "{\r\n" +
	 * "    \"entityName\" : \"testimonials\",\r\n" +
	 * "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}"); blogData =
	 * wraperService.postDataResp(url, "{\r\n" +
	 * "    \"entityName\" : \"blogs\",\r\n" +
	 * "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
 	 */
	
}