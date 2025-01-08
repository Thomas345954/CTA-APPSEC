package com.cta.boir.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.cta.boir.security.CustomUserDetailsService;
import com.cta.boir.service.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SpringSecurity {

	@Autowired
	private UserDetailsService userDetailsService;

	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@Autowired
	private CustomOAuth2UserService customOAuth2UserService;

	@Bean
	public static PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration)
			throws Exception {
		return authenticationConfiguration.getAuthenticationManager();
	}

	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder());
	}

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		// HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
		// requestCache.setMatchingRequestParameterName(null);
		http.csrf(AbstractHttpConfigurer::disable).authorizeHttpRequests(authorize -> authorize
				.requestMatchers("/register/**").permitAll().requestMatchers("/home").permitAll()
				.requestMatchers("/WEB-INF/views/**").permitAll().requestMatchers(new AntPathRequestMatcher("/"))
				.permitAll().requestMatchers(new AntPathRequestMatcher("/home")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/login")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/certificate/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/filingInfo/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/dupfilingInfo/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/error")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/oauth2/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/aboutus")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/pricing")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/blog")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/contactus")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/faq")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/blogdetails/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/BOIRCertificate/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/privacy")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/savecontact")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/terms")).permitAll()
				// .requestMatchers("/users").hasRole("ADMIN")
				.requestMatchers(new AntPathRequestMatcher("/static/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/css/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/js/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/scss/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/vendor/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/inc/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/images/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/fonts/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/forgotpwd")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/forgotpassword")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/validateOTPsubmit")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/validateOTP")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/resetPassword")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/sendOTP")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/sendemailotp/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/verifyemailotp/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/getOTP/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/resetPassword")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/cookie")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/termsuse")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/checkotp")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/customBoirOTP/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/validateOTPBOIR/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/gencoupons")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/validateCoupon")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/boirdetails")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/upload")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/beneficialOwnerSaveTracking")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/unsubscribe", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ChatbotAPI1", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/confirmUnsubscribe")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/authenticationOTP/**")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/getReferrels", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaHarborBoirStatus", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaHarborBoirPurchasedReport", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborBeneficialOwnersCount", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaHarborPaymentCount", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborPaymentHistory0Amount", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborPaymentHistory0Date", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborPaymentHistory1Amount", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborPaymentHistory1Date", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborPaymentHistory2Amount", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborPaymentHistory2Date", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharboirLastAccessDate", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharboirLastAccessTime", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborLatestBoirId", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborLatestBoirStartDate", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/latestBoirTaxId", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/latestFinCenId", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/latestPaymentMode", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/totalBoirFilesAmount", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/lastNoOfFiles", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/lastCreatedDate", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/lastBoirCouponCode", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/lastReportingCompany", "GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/validate","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaHarborBoirStatus1","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborUpdateDate","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborPaymentStatus","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/ctaharborBoirFilesInProgressCount","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/boirStartDate","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/taxId","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/finCENID","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/boirId","GET")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/saveFeedBack","POST")).permitAll()
				.requestMatchers(new AntPathRequestMatcher("/manualBeneficialFormRemainder")).permitAll()
				

				.requestMatchers(new AntPathRequestMatcher("/enableCoupon")).permitAll().anyRequest().authenticated())
				.formLogin(form -> form
						.loginPage("/login").loginProcessingUrl("/login").defaultSuccessUrl("/dashboard").permitAll())
				.rememberMe(rememberMe -> rememberMe.tokenValiditySeconds(5 * 24 * 60 * 60) // 5 days
						.key("AbcdefghiJklmNoPqRstUvXyz").rememberMeParameter("remember-me") // The name of the checkbox
																								// in the login form
				).oauth2Login(oauth2 -> oauth2.loginPage("/login")
						.userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService) // Custom
																									// OAuth2UserService
						)
				// .successHandler(new CustomAuthenticationSuccessHandler())
				).sessionManagement(session -> session.invalidSessionUrl("/login") // Redirects here on session
																					// expiration
						.maximumSessions(1).expiredUrl("/login") // Redirects here on max sessions exceeded
				).logout(logout -> logout.logoutRequestMatcher(new AntPathRequestMatcher("/logout")).permitAll())
				.requestCache((cache) -> cache.requestCache(new HttpSessionRequestCache()));
		return http.build();
	}

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}

}
