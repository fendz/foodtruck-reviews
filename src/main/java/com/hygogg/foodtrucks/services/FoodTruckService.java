package com.hygogg.foodtrucks.services;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.hygogg.foodtrucks.models.FoodTruck;
import com.hygogg.foodtrucks.repositories.FoodTruckRepository;

@Service
public class FoodTruckService {

	private FoodTruckRepository ftrepo;
	
	public FoodTruckService(FoodTruckRepository ftrepo) {
		this.ftrepo = ftrepo;
	}
	
	public FoodTruck create(FoodTruck foodTruck) {
		return ftrepo.save(foodTruck);
	}
	
	public FoodTruck update(FoodTruck foodTruck) {
		return ftrepo.save(foodTruck);
	}
	
	public ArrayList<FoodTruck> findAll() {
		return (ArrayList<FoodTruck>) ftrepo.findAll();
	}
	
	public FoodTruck findOne(Long id) {
		return ftrepo.findOne(id);
	}
	
}
