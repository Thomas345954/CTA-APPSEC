package com.cta.boir.service;

import com.cta.boir.model.User;
import com.cta.boir.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EditProfileService {
    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUser() {
        return userRepository.findAll();
    }


    public User saveUser(User user) {
        return userRepository.save(user);
    }

     
    
}
