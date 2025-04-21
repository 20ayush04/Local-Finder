package com.grownited.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.UserEntity;
import com.grownited.enumD.Role;


public interface UserRepository extends JpaRepository<UserEntity,UUID> {
	UserEntity findByEmailIdAndPassword(String emailId, String password);
	Optional<UserEntity> findByEmailId(String emailId);
	
	
	long count();

    // Active Customers (Role = CUSTOMER and Status = ACTIVE)
    long countByRoleAndStatus(Role role, com.grownited.enumD.Status active);
    
    
	
    
    //service
    UserEntity findByUserId(UUID userId);
    

}
