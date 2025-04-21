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
@Table(name = "serviceProviderAvailibility")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ServiceProviderAvailabilityEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	UUID serviceProviderAvailid;
	

	Boolean isAvailable;
	
	//fk
	UUID providerId;

}
