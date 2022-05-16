package com.pro.spring01.model.member.dto;

import java.util.Date;

import com.pro.spring01.exception.IdPasswordNotMatchingException;

public class MemberDTO {
	private int regcode;
	private String power;
	private String userid;
	private String userpwd;
	private String confirmPassword;
	private String newuserpwd;
	private String name;
	private String email;
	private String tel;
	private String gender;
	private int zipcode;
	private String address1;
	private String address2;	
	private Date regdate;
	private Date udtdate;
	
	public int getRegcode() {
		return regcode;
	}
	public void setRegcode(int regcode) {
		this.regcode = regcode;
	}
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	public String getNewuserpwd() {
		return newuserpwd;
	}
	public void setNewuserpwd(String newuserpwd) {
		this.newuserpwd = newuserpwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getZipcode() {
		return zipcode;
	}
	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUdtdate() {
		return udtdate;
	}
	public void setUdtdate(Date udtdate) {
		this.udtdate = udtdate;
	}
	public boolean isnewuserpwdEqualToConfirmPassword() {
		return newuserpwd.equals(confirmPassword);
	}
	public boolean isuserpwdEqualToConfirmPassword() {
		return userpwd.equals(confirmPassword);
	}
	public void changePassword(String userpwd, String newuserpwd) {
		this.userpwd = newuserpwd;
	}
	
	@Override
	public String toString() {
		return "MemberDTO [regcode=" + regcode + ", power=" + power + ", userid=" + userid + ", userpwd=" + userpwd
				+ ", confirmPassword=" + confirmPassword + ", newuserpwd=" + newuserpwd + ", name=" + name + ", email="
				+ email + ", tel=" + tel + ", gender=" + gender + ", zipcode=" + zipcode + ", address1=" + address1
				+ ", address2=" + address2 + ", regdate=" + regdate + ", udtdate=" + udtdate + "]";
	}
	
	
}
