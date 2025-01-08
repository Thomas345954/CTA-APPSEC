package com.cta.boir.controller;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.cta.boir.model.OtpData;
import com.cta.boir.model.User;
import com.cta.boir.service.CustomEntityService;
import com.cta.boir.service.OtpDataService;
import com.cta.boir.service.UserService;

@RestController
public class CustomEntityController {
	@Autowired
	private OtpDataService otpDataService;
    @Autowired
    private CustomEntityService entityService;
    @Autowired
	private UserService userService;
    @GetMapping("/dynamic-query")
    public List<Map<String, Object>> getDynamicQuery() {
    	String sql ="select now() dateOne,now() dateTwo";
    	Map<String, Object> parameters = null;
        return entityService.getDynamicQueryResults(sql, parameters);
    }
    
    
	/*
	 * @GetMapping("/checkotp/{otp}") public String otpvalidator(@PathVariable
	 * String otp) { Authentication authentication =
	 * SecurityContextHolder.getContext().getAuthentication();
	 * 
	 * if (authentication != null &&
	 * !authentication.getPrincipal().toString().equals("anonymousUser")) {
	 * 
	 * String userName = authentication.getName(); User user =
	 * userService.findByEmail(userName); long
	 * storedotp=otpDataService.getOtpDataByEmail(user.getEmail()).get(0).getOtp();
	 * if(storedotp==Long.valueOf(otp)) { return "true"; } } return "false"; }
	 */
    
    @PostMapping("/checkotp")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> validateAndGenerateRedirect(@RequestBody Map<String, String> payload) {
		String filingInfoId = payload.get("filingInfoId");
		String otp = payload.get("otp");

		Map<String, Object> response = new HashMap<>();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
			String userName = authentication.getName();
			User user = userService.findByEmail(userName);
			List<OtpData> otpDataList = otpDataService.getOtpDataByEmail(user.getEmail());
			long storedotp = 0;
			if (!otpDataList.isEmpty()) {
				storedotp = otpDataList.get(0).getOtp();
				if (storedotp == Long.valueOf(otp)) {
					String redirectUrl = "/boirfiling?filingInfoId=" + filingInfoId + "&email="
							+ URLEncoder.encode(userName, StandardCharsets.UTF_8);
					response.put("valid", true);
					response.put("redirectUrl", redirectUrl); // Provide the secure redirect URL
				} else {
					response.put("valid", false);
				}
			} else {
				response.put("valid", false);
			}
		} else {
			response.put("valid", false);
		}

		return ResponseEntity.ok(response);
	}
    
}
