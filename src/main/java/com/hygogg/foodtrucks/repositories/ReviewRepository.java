package com.hygogg.foodtrucks.repositories;

import org.springframework.data.repository.CrudRepository;

import com.hygogg.foodtrucks.models.Review;

public interface ReviewRepository extends CrudRepository<Review, Long> {
}
