package com.grownited.service;

import java.util.List;
import java.util.UUID;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.UserEntity;

public interface CategoryService {

	
	CategoryEntity createCategory(CategoryEntity categoryEntity);
	CategoryEntity getCategoryById(UUID categoryId);
	List<CategoryEntity> getAllCategory();
	CategoryEntity updateCategory(CategoryEntity categoryEntity,UUID categoryId);
	void deleteCategory(UUID categoryId);
	
}
