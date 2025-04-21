package com.grownited.entity;

import java.time.LocalTime;
import java.util.Date;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.grownited.enumD.Bookstatus;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
@Entity
@Table(name = "Bookings")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BookingEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID bookingId;

    Date bookingDate;
    LocalTime bookingTime;

    @Enumerated(EnumType.STRING)
    Bookstatus status = Bookstatus.PENDING;

    // Customer Relationship
    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    @JsonBackReference // Prevents infinite recursion
    UserEntity user;

    // Service Provider Relationship
    @ManyToOne
    @JoinColumn(name = "serviceProviderId", nullable = false)
    @JsonBackReference // Prevents infinite recursion
    UserEntity serviceProvider;

    // The booked service
    @ManyToOne
    @JoinColumn(name = "serviceId", nullable = false)
    @JsonManagedReference
    ServiceEntity service;

    // Package relationship
    @ManyToOne
    @JoinColumn(name="packageId", nullable = false)
    @JsonManagedReference
    PackageEntity packageEntity;

}