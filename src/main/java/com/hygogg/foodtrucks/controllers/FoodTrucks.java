package com.hygogg.foodtrucks.controllers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hygogg.foodtrucks.models.User;
import com.hygogg.foodtrucks.services.UserService;
import com.hygogg.foodtrucks.validators.UserValidator;

@Controller
public class FoodTrucks {
	
	public UserValidator userValidator;
	private UserService userService;
	
	public FoodTrucks(UserService userService, UserValidator userValidator) {
		this.userService = userService;
		this.userValidator = userValidator;
	}
	
	@RequestMapping("")
	public String index() {
		return "index";
	}
	
	@RequestMapping("sign_in")
	public String signin() {
		return "signin";
	}
	
	@RequestMapping("sign_up")
	public String signup() {
		return "signup";
	}
	
	@PostMapping("login")
	public String login(@RequestParam Map<String, String> body, RedirectAttributes flash, HttpSession session) {
		User user = userValidator.login(body);
		if(user != null) {
			session.setAttribute("user", user);
			return "redirect:/";
		} else {
			flash.addFlashAttribute("errors", "Invalid login!");
			return "redirect:/sign_in";
		}
	}
	
	@PostMapping("register")
	public String register(@RequestParam Map<String, String> body, RedirectAttributes flash, HttpSession session) {
		HashMap<String, Object> response = userValidator.validate(body);
		if((boolean) response.get("valid")) {
			User user = userService.create(body);
			session.setAttribute("user", user);
		} else {
			flash.addFlashAttribute("errors", response);
			return "redirect:/sign_up";
		}
		return "redirect:/";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "redirect:/";
	}
	
}
