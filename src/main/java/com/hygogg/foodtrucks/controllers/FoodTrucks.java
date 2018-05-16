package com.hygogg.foodtrucks.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hygogg.foodtrucks.models.FoodTruck;
import com.hygogg.foodtrucks.models.Review;
import com.hygogg.foodtrucks.models.User;
import com.hygogg.foodtrucks.services.FoodTruckService;
import com.hygogg.foodtrucks.services.ReviewService;
import com.hygogg.foodtrucks.services.UserService;
import com.hygogg.foodtrucks.validators.UserValidator;

@Controller
public class FoodTrucks {
	
	public UserValidator userValidator;
	private UserService userService;
	private FoodTruckService ftservice;
	private ReviewService rService;
	private String[] stars = {"★★★★★","★★★★☆","★★★☆☆","★★☆☆☆","★☆☆☆☆"};
	
	public FoodTrucks(UserService userService, UserValidator userValidator, FoodTruckService ftservice, ReviewService rService) {
		this.userService = userService;
		this.userValidator = userValidator;
		this.ftservice = ftservice;
		this.rService = rService;
	}
	
	@RequestMapping("")
	public String index(Model model) {
		model.addAttribute("foodtrucks", ftservice.findAll());
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
	
	@RequestMapping("foodtrucks/new")
	public String newFoodtruck(Model model) {			
		model.addAttribute("foodtruck", new FoodTruck());
		return "new";
	}
	
	@RequestMapping("foodtruck/{id}/edit")
	public String newFoodtruck(Model model, @PathVariable("id") Long id) {
		model.addAttribute("foodtruck", ftservice.findOne(id));
		return "edit";
	}
	
	@PostMapping("foodtrucks")
	public String foodtrucks(@Valid @ModelAttribute("foodtruck") FoodTruck foodTruck, BindingResult result) {
		System.out.println(foodTruck.getOp().getUsername());
		System.out.println(foodTruck.getName());
		if(result.hasErrors()) {
			return "new";
		}
		ftservice.create(foodTruck);
		return "redirect:/";
	}
	
	@PostMapping("foodtruck/{id}/update")
	public String newFoodtruck(@Valid @ModelAttribute("foodtruck") FoodTruck foodTruck, BindingResult result, @PathVariable("id") Long id) {
		if(result.hasErrors()) {
			return "edit";
		} 
		ftservice.update(foodTruck);
		return "redirect:/";
	}
	
	@RequestMapping("foodtruck/{id}")
	public String foodtruck(Model model, @PathVariable("id") Long id) {
		model.addAttribute("foodtruck", ftservice.findOne(id));
		model.addAttribute("review", new Review());
		model.addAttribute("stars", stars);
		return "foodtruck";
	}
	
	@PostMapping("foodtruck/{id}/review")
	public String review(@Valid @ModelAttribute("review") Review review, BindingResult result, Model model, @PathVariable("id") Long id) {
		if(result.hasErrors()) {
			model.addAttribute("foodtruck", ftservice.findOne(id));
			model.addAttribute("stars", stars);
			return "foodtruck";
		}
		review.setId(null);
		Review r = rService.create(review);
		FoodTruck t = ftservice.findOne(id);
		List<Review> reviews = t.getReviews();
		Double sum = 0.0;
		for(Review rev: reviews) {
			sum += rev.getRating();
		}
		System.out.println(sum);
		System.out.println(sum/reviews.size());
		t.setAvgRating(sum/reviews.size());
		ftservice.update(t);
		return String.format("redirect:/foodtruck/%d", id);
	}
	
}
