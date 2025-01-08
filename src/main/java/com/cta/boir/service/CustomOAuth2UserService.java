package com.cta.boir.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.cta.boir.model.User;
import com.cta.boir.repository.UserRepository;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private UserRepository userRepository;

    public CustomOAuth2UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);
        // Custom processing to save or update the OAuth2 user in the database
        String email = oAuth2User.getAttribute("email");
        User user = userRepository.findByEmail(email);// .orElseThrow(() -> new UsernameNotFoundException("User not found"));;
        if (user == null) {
            user = new User();
            user.setEmail(email);
            user.setName(oAuth2User.getAttribute("name"));
            user.setProvider("GOOGLE");
            // Set other attributes as needed
            userRepository.save(user);
        }
        
  
       // Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
         return oAuth2User;
    }
}
