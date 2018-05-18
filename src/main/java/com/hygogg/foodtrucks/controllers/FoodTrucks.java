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
	
	private UserService userService;
	private UserValidator userValidator;
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
			flash.addFlashAttribute("welcome", String.format("Welcome back, %s!", user.getUsername()));
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
			flash.addFlashAttribute("welcome", String.format("Welcome to the site, %s!", user.getUsername()));
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
	public String newFoodtruck(Model model, HttpSession session, RedirectAttributes flash) {		
		model.addAttribute("foodtruck", new FoodTruck());
		User user = (User) session.getAttribute("user");
		if(user == null) {
			flash.addFlashAttribute("errors", "You must be logged in to do this!");
			return "redirect:/";
		}
		return "new";
	}
	
	@RequestMapping("foodtruck/{id}/edit")
	public String newFoodtruck(Model model, @PathVariable("id") Long id, HttpSession session, RedirectAttributes flash) {
		FoodTruck ft = ftservice.findOne(id);
		User user = (User) session.getAttribute("user");
		if(user == null) {
			flash.addFlashAttribute("errors", "You must be logged in to do this!");
			return "redirect:/";
		}else if(user.getId() != ft.getOp().getId()) {
			flash.addFlashAttribute("errors", "You cannot edit this foodtruck!");
			return "redirect:/";
		}
		model.addAttribute("foodtruck", ft);
		return "edit";
	}
	
	@PostMapping("foodtrucks")
	public String foodtrucks(@Valid @ModelAttribute("foodtruck") FoodTruck foodTruck, BindingResult result, HttpSession session, RedirectAttributes flash) {
		User user = (User) session.getAttribute("user");
		if(user == null) {
			flash.addFlashAttribute("errors", "You must be logged in to do this!");
			return "redirect:/";
		}
		if(result.hasErrors()) {
			return "new";
		}
		ftservice.create(foodTruck);
		return "redirect:/";
	}
	
	@PostMapping("foodtruck/{id}/update")
	public String newFoodtruck(@Valid @ModelAttribute("foodtruck") FoodTruck foodTruck, BindingResult result, @PathVariable("id") Long id, HttpSession session, RedirectAttributes flash) {
		FoodTruck ft = ftservice.findOne(id);
		User user = (User) session.getAttribute("user");
		if(user == null) {
			flash.addFlashAttribute("errors", "You must be logged in to do this!");
			return "redirect:/";
		}else if(user.getId() != ft.getOp().getId()) {
			flash.addFlashAttribute("errors", "You cannot edit this foodtruck!");
			return "redirect:/";
		}
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
	public String review(@Valid @ModelAttribute("review") Review review, BindingResult result, Model model, @PathVariable("id") Long id, HttpSession session, RedirectAttributes flash) {
		User user = (User) session.getAttribute("user");
		if(user == null) {
			flash.addFlashAttribute("errors", "You must be logged in to do this!");
			return String.format("redirect:/foodtruck/%d", id);
		}
		if(result.hasErrors()) {
			model.addAttribute("foodtruck", ftservice.findOne(id));
			model.addAttribute("stars", stars);
			return "foodtruck";
		}
		FoodTruck t = ftservice.findOne(id);
		List<Review> reviews = t.getReviews();
		for(Review rev: reviews) {
			if(rev.getUser().getId() == user.getId()) {
				flash.addFlashAttribute("errors", "You have already left a review!");
				return String.format("redirect:/foodtruck/%d", id);
			}
		}
		review.setId(null);
		rService.create(review);
		reviews = t.getReviews();
		Double sum = 0.0;
		for(Review rev: reviews) {
			sum += rev.getRating();
		}
		t.setAvgRating(sum/reviews.size());
		ftservice.update(t);
		return String.format("redirect:/foodtruck/%d", id);
	}
	
}
