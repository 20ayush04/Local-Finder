package com.grownited.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.CategoryEntity;

public interface CategoryRepository  extends JpaRepository<CategoryEntity, UUID>{

}
