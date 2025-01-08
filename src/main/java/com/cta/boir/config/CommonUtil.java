package com.cta.boir.config;

import java.util.regex.Pattern;

public class CommonUtil {
	private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

	public static boolean isNotEmail(String username) {
		Pattern pattern = Pattern.compile(EMAIL_REGEX);
		return !pattern.matcher(username).matches();
	}

}
