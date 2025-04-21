package com.grownited.entity;

import java.util.UUID;

import com.grownited.enumD.Day;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "workingHours")
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WorkingHoursEntity {

	@Id
	@GeneratedValue
	UUID id;
	@Enumerated(EnumType.STRING)
	Day dayOfWeek;
	String startTime;
	String endTime;
	//this is fk
	UUID providerId;

}
