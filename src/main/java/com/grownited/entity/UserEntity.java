package com.grownited.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.grownited.enumD.Role;
import com.grownited.enumD.Status;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@Table(name = "users")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	UUID userId;
	String name;
	@Column(unique = true)
	String emailId;
	String phone;
	String password;
	@Enumerated(EnumType.STRING)
	Role role;
	@Enumerated(EnumType.STRING)
	Status status;
	@Transient
	MultipartFile profilePic;
	String profilePicUrl;
	Date createdAt;
	Date updatedAt;
	
	@OneToOne(mappedBy = "userEntity" , cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
	UserAddressEntity userAddressEntity;
	
	@OneToMany(mappedBy = "userEntity",cascade = CascadeType.ALL, orphanRemoval = true)
	@ToString.Exclude
	List<ServiceEntity> serviceEntities=new ArrayList<>();

	//package
	@OneToMany(mappedBy = "serviceProvider", cascade = CascadeType.ALL)
     List<PackageEntity> packages=new ArrayList<>();
	
//	
//	@OneToMany(mappedBy = "userEntity",cascade = CascadeType.ALL, orphanRemoval = true)
//	@ToString.Exclude
//	List<PackageEntity> packageEntities;
//	
//	@OneToOne(mappedBy = "userEntity" , cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
//	PackageEntity packageEntity;
//	
	
	//booking
	
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    List<BookingEntity> userBookings=new ArrayList<>();

    @OneToMany(mappedBy = "serviceProvider", cascade = CascadeType.ALL)
    List<BookingEntity> serviceBookings=new ArrayList<>();

	@Override
	public String toString() {
		return "UserEntity [userId=" + userId + ", name=" + name + ", emailId=" + emailId + ", phone=" + phone
				+ ", password=" + password + ", role=" + role + "]";
	}


	
}
