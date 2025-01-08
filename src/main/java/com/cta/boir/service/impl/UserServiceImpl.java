package com.cta.boir.service.impl;


import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cta.boir.dto.UserDto;
import com.cta.boir.model.Role;
import com.cta.boir.model.User;
import com.cta.boir.repository.RoleRepository;
import com.cta.boir.repository.UserRepository;
import com.cta.boir.service.UserService;


@Service
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository,
                           RoleRepository roleRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void saveUser(UserDto userDto) {
        User user = new User();
        user.setName(userDto.getFirstName() + " " + userDto.getLastName());
        user.setEmail(userDto.getEmail());

        //encrypt the password once we integrate spring security
        //user.setPassword(userDto.getPassword());
        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        Role role = roleRepository.findByName("ROLE_ADMIN");
         if(role == null){
            role = checkRoleExist();
        }
        user.setRoles(Arrays.asList(role));
         userRepository.save(user);
    }
    
    
    @Override
    public void saveUserObject(User user,String password) {
        user.setPassword(passwordEncoder.encode(password));
         userRepository.save(user);
    }
    

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
        //.orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

    @Override
    public List<UserDto> findAllUsers() {
        List<User> users = userRepository.findAll();
        return users.stream().map((user) -> convertEntityToDto(user))
                .collect(Collectors.toList());
    }

    private UserDto convertEntityToDto(User user){
        UserDto userDto = new UserDto();
        String[] name = user.getName().split(" ");
        userDto.setFirstName(name[0]);
        userDto.setLastName(name[1]);
        userDto.setEmail(user.getEmail());
        return userDto;
    }

    private Role checkRoleExist() {
        Role role = new Role();
        role.setName("ROLE_ADMIN");
        return roleRepository.save(role);
    }

	@Override
	public User convertEntityToDto(UserDto userDto) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public User save(User user) {
		// TODO Auto-generated method stub
		userRepository.save(user);
		return user;
	}
	
}
