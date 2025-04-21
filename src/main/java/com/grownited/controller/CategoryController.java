package com.grownited.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ServiceEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.PackageRepository;
import com.grownited.repository.ServicesRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.CategoryService;

@Controller
public class CategoryController {

	@Autowired 
	private CategoryService categoryService;
	
	@Autowired
	private CategoryRepository categoryRepository;
	@Autowired
	private ServicesRepository servicesRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private PackageRepository packageRepository;
	
	@Autowired
 	Cloudinary cloudinary;
	
	@GetMapping("/opencategory")
	public String addCategory() {
		return "AddCategory";
	}
	
	//login user can see the avalible service

	@GetMapping("/categorydetails")
	public String categoryDetails(@RequestParam("categoryId") UUID categoryId, Model model) {
	    
	    // Fetch category safely
	    CategoryEntity category = categoryRepository.findById(categoryId)
	        .orElse(null);

	    if (category == null) {
	        model.addAttribute("error", "Category not found");
	        return "ErrorPage"; // Redirect to an error page
	    }

	    // Fetch services for the category
	    List<ServiceEntity> serviceList = servicesRepository.findByCategory_CategoryId(categoryId);

	    // Fetch packages for each service safely
	    for (ServiceEntity serviceEntity : serviceList) {
	        packageRepository.findByServiceEntity_ServiceId(serviceEntity.getServiceId())
	            .ifPresent(pack -> System.out.println("PackageDetails: " + pack));
//	        System.out.println("UserEntity name is here "+serviceEntity.getUserEntity().getName());
//	        System.out.println("User" + serviceEntity.getUserEntity().getUserId());
	    }
	    
	   

	    
	    
	    // Fetch and set UserEntity for each ServiceEntity
//	    for (ServiceEntity serviceEntity : serviceList) {
//	    	Optional<UserEntity> userOptional = servicesRepository.findUserByServiceId(serviceEntity.getServiceId());

//	    	if (userOptional.isPresent()) {
//	    	    UserEntity user = userOptional.get();
//	    	    System.out.println("User Found: " + user.getName());
//	    	    serviceEntity.setUserEntity(user);
//	    	} else {
//	    	    System.out.println("No User Found for this Service ID");
//	    	}  // Set the user in serviceEntity
//	    }

	    // Add data to model
	    model.addAttribute("category", category);
	    model.addAttribute("services", serviceList);
	    return "CategoryDetails";
	}

//	@GetMapping("/categorydetails")
//	public String categoryDetails(@RequestParam("categoryId") UUID categoryId, Model model) {
//	    
//	    // Fetch category safely
//	    CategoryEntity category = categoryRepository.findById(categoryId).orElse(null);
//
//	    if (category == null) {
//	        model.addAttribute("error", "Category not found");
//	        return "ErrorPage"; // Redirect to an error page
//	    }
//
//	    // Fetch services for the category
//	    List<ServiceEntity> serviceList = servicesRepository.findByCategory_CategoryId(categoryId);
//
//	    // Fetch users for each service
//	    Map<UUID, List<UserEntity>> serviceUsersMap = new HashMap<>();
//
//	    for (ServiceEntity serviceEntity : serviceList) {
//	        List<UserEntity> users =userRepository.findByServiceEntity_ServiceId(serviceEntity.getServiceId());
//	        serviceUsersMap.put(serviceEntity.getServiceId(), users);
//	    }
//
//	    // Add data to model
//	    model.addAttribute("category", category);
//	    model.addAttribute("services", serviceList);
//	    model.addAttribute("serviceUsersMap", serviceUsersMap);
//
//	    return "CategoryDetails";
//	}

	
	@PostMapping("addcategory")
	public String saveCategory(CategoryEntity categoryEntity)
	{
		Map result;
		try {
			result = cloudinary.uploader().upload(categoryEntity.getCategoryImage().getBytes(), ObjectUtils.emptyMap());

			//System.out.println(result);
			//System.out.println(result.get("url"));
			categoryEntity.setCategoryPicUrl(result.get("url").toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		categoryService.createCategory(categoryEntity);
		return "redirect:/listcategory";
	}
	
	//this will list all the category on webapp
	@GetMapping("/listcategory")
	public String getAllCategory(Model model) {
		List<CategoryEntity> categoryList=categoryService.getAllCategory();
		
		model.addAttribute("categoryList", categoryList);
		return "CategoryList";
	}
	
	//this for the delete category by id
	@GetMapping("/deletecategory/{categoryId}")
	public String deleteCategoryById(@PathVariable UUID categoryId) {
		categoryService.deleteCategory(categoryId);
		return "redirect:/listcategory";
	}
	
	@GetMapping("/editcategory/{categoryId}")
	public String editCategoryById(@PathVariable UUID categoryId,Model model) {
		CategoryEntity category=categoryService.getCategoryById(categoryId);
		model.addAttribute("category",category);
		return "EditCategory";
	}
	
	@PostMapping("/updatecategory")
	public String updateCategory(@ModelAttribute CategoryEntity categoryEntity) {
		CategoryEntity category=	categoryService.updateCategory(categoryEntity,categoryEntity.getCategoryId());
		Map result;
		try {
			result = cloudinary.uploader().upload(categoryEntity.getCategoryImage().getBytes(), ObjectUtils.emptyMap());

			//System.out.println(result);
			//System.out.println(result.get("url"));
			category.setCategoryPicUrl(result.get("url").toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		category.setCategoryName(categoryEntity.getCategoryName());
		category.setCategoryDescription(categoryEntity.getCategoryDescription());
		categoryRepository.save(category);
		return "redirect:/listcategory";
	}
}

