package com.hygogg.foodtrucks.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.hygogg.foodtrucks.models.FoodTruck;

public interface FoodTruckRepository extends CrudRepository<FoodTruck, Long> {
	
	@Query(value="SELECT * FROM foodtrucks ORDER BY avg_rating DESC;", nativeQuery=true)
	List<FoodTruck> findAll();
	
}
