package com.grownited.dto;

import java.util.UUID;

import org.springframework.web.bind.annotation.RequestParam;

import lombok.Data;

@Data
public class IdDto {
	UUID categoryId;
	UUID providerId;
	UUID serviceId;
	UUID packageId;
}
