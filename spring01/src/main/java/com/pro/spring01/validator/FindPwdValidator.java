package com.pro.spring01.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.pro.spring01.model.member.dto.MemberDTO;

public class FindPwdValidator implements Validator {
	private static final String emailExp =
			"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
	
	private Pattern pattern;
	
	public FindPwdValidator() {
		pattern = Pattern.compile(emailExp);
	}


	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		MemberDTO dto = (MemberDTO)obj;
		if(dto.getEmail() == null || dto.getEmail().trim().isEmpty()) {
			errors.rejectValue("email", "required");
		}else {
			 Matcher matcher = pattern.matcher(dto.getEmail());
			 if(!matcher.matches()) {
				 errors.rejectValue("email", "wrong");
			 }
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userid", "required");
		
	}
	 
}
