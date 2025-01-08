package com.cta.boir.service;

 

import java.util.List;

import com.cta.boir.dto.UserDto;
import com.cta.boir.model.User;

public interface UserService {
    void saveUser(UserDto userDto);

    User findByEmail(String email);

    List<UserDto> findAllUsers();
    
    User convertEntityToDto(UserDto userDto);

	void saveUserObject(User user, String password);

	User save(User user);
}
