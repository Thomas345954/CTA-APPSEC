/*
 * package com.cta.boir.config;
 * 
 * import java.io.IOException;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.data.redis.core.RedisTemplate; import
 * org.springframework.security.core.Authentication; import
 * org.springframework.security.web.authentication.logout.
 * SimpleUrlLogoutSuccessHandler; import
 * org.springframework.stereotype.Component;
 * 
 * import jakarta.servlet.ServletException; import
 * jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse;
 * 
 * @Component public class CustomLogoutSuccessHandler extends
 * SimpleUrlLogoutSuccessHandler {
 * 
 * @Autowired private RedisTemplate redisTemplate;
 * 
 * @Override public void onLogoutSuccess(HttpServletRequest request,
 * HttpServletResponse response, Authentication authentication) throws
 * IOException, ServletException { String sessionId = request.getSession(false)
 * != null ? request.getSession(false).getId() : null; if (sessionId != null) {
 * redisTemplate.delete("spring:session:sessions:" + sessionId); }
 * super.onLogoutSuccess(request, response, authentication); } }
 */