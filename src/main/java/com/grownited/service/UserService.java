package com.grownited.service;

import java.util.UUID;
import java.util.*;
import com.grownited.entity.UserEntity;




public interface UserService {

	UserEntity createUser(UserEntity userEntity);
	UserEntity getUserById(UUID userId);
	List<UserEntity> getAllUser();
	
	UserEntity updateUser(UserEntity userEntity, UUID userId);
	void deleteUser(UUID userId);
	
	UserEntity findWithEmailAndPassword(String emailId,String password);
}
