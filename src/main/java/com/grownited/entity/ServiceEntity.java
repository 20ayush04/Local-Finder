package com.grownited.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.grownited.enumD.Role;
import com.grownited.enumD.Status;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AccessLevel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "services")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ServiceEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	UUID serviceId;
	String serviceName;
	String description;
	Date createdAt;
	Date updatedAt;
	@Transient
	MultipartFile servicePhoto;
	String servicePicUrl;
	
	//this both fk
//	UUID providerId;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="providerId", referencedColumnName ="userId")  //referancedcolumnnmae is need to match with the userEntity primary key
	@ToString.Exclude
	UserEntity userEntity;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "categoryId", referencedColumnName = "categoryId")
	CategoryEntity category;

	
	//for packageEntity
	@OneToOne(mappedBy = "serviceEntity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    PackageEntity packageEntity;
	
	@OneToMany(mappedBy = "service", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	List<BookingEntity> bookings=new ArrayList<>();

	
	
}
