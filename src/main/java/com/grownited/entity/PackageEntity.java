package com.grownited.entity;

import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Builder.Default;
import lombok.Data;
import lombok.ToString;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "packages")
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PackageEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	UUID packageId;
	String packageName;
	float price;
	
	float tax;
	float commission;
	
	@ManyToOne
	@JoinColumn(name = "serviceId",referencedColumnName = "serviceId")
	ServiceEntity serviceEntity;
	
	 @ManyToOne
	 @JoinColumn(name = "serviceProviderId", nullable = false)
	 UserEntity serviceProvider;
	 
	 @ManyToOne
	 @JsonIgnore
	 @JoinColumn(name = "categoryId", referencedColumnName = "categoryId")
	 CategoryEntity category;
	
	 @OneToMany(mappedBy = "packageEntity",cascade = CascadeType.ALL)
	 @JsonIgnore
	 List<BookingEntity> bookings;

	
	@PrePersist
    public void setDefaultValues() {
        if (commission == 0.0f) {
            commission = 5.0f;
            tax=8.0f;
        }
    }
}
