package com.cloud.sample.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SampleRestController {

	
	@GetMapping(value="/getService")
	public String getSampleService() {
		return "Hello Mohan!! This is a sample rest service response";
	}
}
