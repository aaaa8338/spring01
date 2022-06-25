package com.pro.spring01.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.springframework.validation.annotation.Validated;

import com.pro.spring01.model.member.dto.MemberDTO;

@Validated
public class MemberValidator implements Validator {
	private static final String emailExp =
			"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
	private static final String idExp ="^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$";
	private static final String phoneExp = 
			"^01(?:0)-(\\d{4})-(\\d{4})$";
	public MemberValidator() {
		
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}
	
	@Override
	public void validate(Object obj, Errors errors) {
		
		
		MemberDTO dto = (MemberDTO)obj;
		if(dto.getUserid() == null || dto.getUserid().trim().isEmpty()) {
			errors.rejectValue("userid", "required");
		}
//		else {
//			Matcher matcher = Pattern.compile(idExp).matcher(dto.getUserid());
//			if(!matcher.matches()) {
//				errors.rejectValue("userid", "wrong1");
//			}
//		}	
		
		if(dto.getEmail() == null || dto.getEmail().trim().isEmpty()) {
			errors.rejectValue("email", "required");
		}
		else {
			 Matcher matcher1 = Pattern.compile(emailExp).matcher(dto.getEmail());
			 if(!matcher1.matches()) {
				 errors.rejectValue("email", "wrong");
			 }
		}	
		
		
		if(!dto.getTel().equals("") || !dto.getTel().trim().isEmpty()) {
			Matcher matcher2 = Pattern.compile(phoneExp).matcher(dto.getTel());
			if(!matcher2.matches()) {
				errors.rejectValue("tel", "telbad");
			}
		}
		
		if(!dto.getUserpwd().isEmpty()) {
			if(!dto.isuserpwdEqualToConfirmPassword()) {
				errors.rejectValue("confirmPassword", "nomatch");
			}
		}
		
		if(dto.getPower().isEmpty() || !dto.getPower().equals("admin") ||
				dto.getPower().length()>100) {
			dto.setPower("user");
		}else {
			dto.setPower(dto.getPower());
		}
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userpwd", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "zipcode", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "gender", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address1", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address2", "required");
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "power", "required");
	}

}
