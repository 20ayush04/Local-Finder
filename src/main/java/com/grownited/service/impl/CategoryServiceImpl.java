package com.grownited.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.UserEntity;
import com.grownited.exception.ResourceNotFoundException;
import com.grownited.repository.CategoryRepository;
import com.grownited.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryRepository categoryRepository;
	
	@Override
	public CategoryEntity createCategory(CategoryEntity categoryEntity) {
		categoryEntity= categoryRepository.save(categoryEntity);
		return categoryEntity;
	}

	@Override
	public CategoryEntity getCategoryById(UUID categoryId) {
		CategoryEntity categoryEntity=categoryRepository.findById(categoryId).orElseThrow(()-> new ResourceNotFoundException("Category", "Id", categoryId));
		return categoryEntity;
				}

	@Override
	public List<CategoryEntity> getAllCategory() {
		List<CategoryEntity> categoryList=categoryRepository.findAll();
		
		return categoryList;
	}

	@Override
	public CategoryEntity updateCategory(CategoryEntity categoryEntity, UUID categoryId) {
		CategoryEntity categoryEntity1=categoryRepository.findById(categoryId).orElseThrow(()-> new ResourceNotFoundException("Category", "Id", categoryId));
		
		categoryEntity= categoryRepository.save(categoryEntity);
		
		return categoryEntity;
	}

	@Override
	public void deleteCategory(UUID categoryId) {
		CategoryEntity categoryEntity=categoryRepository.findById(categoryId).orElseThrow(()-> new ResourceNotFoundException("Category", "Id", categoryId));
		
		categoryRepository.delete(categoryEntity); 
		
	}

}
