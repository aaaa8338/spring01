package com.pro.spring01.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.pro.spring01.model.member.dto.MemberDTO;

public class ChangePwdValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		MemberDTO dto = (MemberDTO)obj;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userpwd", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "newuserpwd", "required");
		
		if(!dto.getConfirmPassword().isEmpty()) {
			if(!dto.isnewuserpwdEqualToConfirmPassword()) {
				errors.rejectValue("confirmPassword", "nomatch");
			}
		}
	}
	

}
