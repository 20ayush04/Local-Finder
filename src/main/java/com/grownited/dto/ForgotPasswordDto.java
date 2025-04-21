package com.grownited.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ForgotPasswordDto {

	String emailId;
	Integer otp;
	String password;
	String cpassword;
	@Override
	public String toString() {
		return "ForgotPasswordDto [emailId=" + emailId + ", otp=" + otp + ", password=" + password + ", cpassword="
				+ cpassword + "]";
	}
	
	
	
	
}
