package com.grownited.dto;

import java.util.Date;
import java.util.UUID;

import com.grownited.enumD.Role;
import com.grownited.enumD.Status;

public class UserDto {
	UUID userId;
	String name;
	String emailId;
	String phone;
	Role role;
	Status status;
	String profilePicUrl;
	Date createdAt;
}
