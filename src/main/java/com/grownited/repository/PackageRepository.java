package com.grownited.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.PackageEntity;


@Repository
public interface PackageRepository extends JpaRepository<PackageEntity, UUID> {

	//find the pacakage by the serviceId
	Optional<PackageEntity> findByServiceEntity_ServiceId(UUID serviceId);
}
