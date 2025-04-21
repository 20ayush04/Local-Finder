package com.grownited.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.UserAddressEntity;

public interface UserAddressRepository extends JpaRepository<UserAddressEntity, UUID>{
	
	// Find UserAddressEntity by userEntity's userId
    Optional<UserAddressEntity> findByUserEntity_UserId(UUID userId);
}
