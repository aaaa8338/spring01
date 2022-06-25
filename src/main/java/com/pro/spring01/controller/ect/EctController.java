package com.pro.spring01.controller.ect;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EctController {
	
	@RequestMapping("/ect/photo.do")
	public String photo() {
		return "ect/photo";
	}
}
