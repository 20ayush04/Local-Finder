package com.grownited.entity;

import java.util.Date;
import java.util.UUID;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Entity
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PaymentEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	UUID paymentId;
	Float amount;
	String paymentMethod;
	String paymentStatus;
	String transactionId;
	Date createdAt;
	
//	fk
	UUID bookingId;

}
