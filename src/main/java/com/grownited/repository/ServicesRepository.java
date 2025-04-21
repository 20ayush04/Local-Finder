package com.grownited.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.ServiceEntity;

public interface ServicesRepository extends JpaRepository<ServiceEntity, UUID> {
	
	List<ServiceEntity> findByCategory_CategoryId(UUID categoryId);
	List<ServiceEntity> findByUserEntity_UserId(UUID userId);

//	@Query("SELECT s.userEntity FROM ServiceEntity s WHERE s.serviceId = :serviceId")
//	UserEntity findUserByServiceId(@Param("serviceId") UUID serviceId);



}
