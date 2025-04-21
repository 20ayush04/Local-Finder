package com.grownited.entity;

import java.util.UUID;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;


@Entity
@Data
@Table(name = "serviceProviderStatus")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ServiceProviderStatusEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	UUID serviceProviderStatusId;
	
	Integer totalBookings;
	Long totalReviews;
	Float averageRating;
	
	//this is fk
	UUID providerId;

}
