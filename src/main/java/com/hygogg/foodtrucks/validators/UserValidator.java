package com.hygogg.foodtrucks.validators;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.hygogg.foodtrucks.models.User;
import com.hygogg.foodtrucks.services.UserService;

@Component
public class UserValidator {
	
	private BCryptPasswordEncoder bcrypt;
	private UserService userService;
	public static Pattern EMAIL_REGEX = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]+");
	
	public UserValidator(BCryptPasswordEncoder bcrypt, UserService userService) {
		this.bcrypt = bcrypt;
		this.userService = userService;
	}

	public HashMap<String, Object> validate(Map<String, String> body) {

		// what we will be returning
		HashMap<String, Object> response = new HashMap<String, Object>();
		
		// username validations
		if(body.get("username").length() < 3) {
			response.put("username", "Username must be 3 characters or more!");
		}
		
		// email validations
		if(body.get("email").length() < 1) {
			response.put("email", "Email is required!");
		} else if(!EMAIL_REGEX.matcher(body.get("email")).matches()) {
			response.put("email", "Invalid Email!");
		} else if(userService.findByEmail(body.get("email")) != null) {
			response.put("email", "Email already in use!");
		}
		
		// password validations
		if(body.get("password").length() < 8) {
			response.put("password", "Password must be 8 characters or more!");
		}
		
		// confirm password validations
		if(!body.get("confirm").equals(body.get("password"))) {
			response.put("confirm", "Confirm Password must match Password!");
		}
		
		// check if there are any errors
		response.put("valid", response.size() == 0);
		
		// return the if the user is valid and or a list of errors
		return response;
		
	}
	
	public User login(Map<String, String> body) {
		
		boolean valid = true;
		User user = null;
		
		// email validations
		if(body.get("email").length() < 1) {
			valid = false;
		} else if(!EMAIL_REGEX.matcher(body.get("email")).matches()) {
			valid = false;
		} else {
			user = userService.findByEmail(body.get("email"));
			valid = user != null;
		}
		
		// password validations
		if(body.get("password").length() < 8) {
			valid = false;
		} else if(!bcrypt.matches(body.get("password"), user.getPassword())) {
			valid = false;
		}
		
		// if valid login return the user otherwise null
		return valid ? user : null;
		
	}
	
}
