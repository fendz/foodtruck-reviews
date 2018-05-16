package com.hygogg.foodtrucks.services;

import org.springframework.stereotype.Service;

import com.hygogg.foodtrucks.models.Review;
import com.hygogg.foodtrucks.repositories.ReviewRepository;

@Service
public class ReviewService {

	private ReviewRepository reviewRepo;
	
	public ReviewService(ReviewRepository reviewRepo) {
		this.reviewRepo = reviewRepo;
	}
	
	public Review create(Review review) {
		return reviewRepo.save(review);
	}
	
}
