
package com.grownited.exception;

import java.util.UUID;

import lombok.Data;

//uncheck wexception this use in the runtime
@Data
public class ResourceNotFoundException extends RuntimeException{

	String resourceName;
	String fieldName;
	UUID fieldValue;
	public ResourceNotFoundException(String resourceName, String fieldName, UUID userId) {
		super(String.format("%s not found with %s : %l",resourceName,fieldName,userId));
		this.resourceName = resourceName;
		this.fieldName = fieldName;
		this.fieldValue = userId;
	}
	
	
}
