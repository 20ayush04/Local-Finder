package com.grownited.service.impl;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.grownited.exception.*;
import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;

	@Override
	public UserEntity createUser(UserEntity userEntity) {
		userEntity = userRepository.save(userEntity);
		return userEntity;
	}

	@Override
	public UserEntity getUserById(UUID userId) {
		UserEntity user = userRepository.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("User", " Id ", userId));
		return user;
	}

	@Override
	public List<UserEntity> getAllUser() {
		List<UserEntity> userList=userRepository.findAll();
		return userList;
	}

	@Override
	public UserEntity updateUser(UserEntity userEntity, UUID userId) {
		UserEntity user = userRepository.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("User", " Id ", userId));
		if(user != null) {
			user=userRepository.save(userEntity);
		}
		return null;
	}

	@Override
	public void deleteUser(UUID userId) {
		UserEntity user = userRepository.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("User", " Id ", userId));
		userRepository.delete(user);		
		
	}

	@Override
	public UserEntity findWithEmailAndPassword(String emailId, String password) {
		UserEntity user =userRepository.findByEmailIdAndPassword(emailId, password);
		if(user != null) {
			return user;
		}
		return null;
	}

}
