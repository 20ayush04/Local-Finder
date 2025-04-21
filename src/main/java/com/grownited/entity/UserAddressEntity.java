package com.grownited.entity;

import java.util.UUID;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "userAddresses")
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserAddressEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	UUID id;
	
	String addressLine;
//	String city;
//	String state;
//	String postalCode;
//	String country;
	Double latitude;
	Double longtitude;

	@OneToOne
	@JoinColumn(name = "userId", referencedColumnName = "userId")
	UserEntity userEntity;
}
