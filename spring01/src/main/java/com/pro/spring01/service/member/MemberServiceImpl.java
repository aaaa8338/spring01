package com.pro.spring01.service.member;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.pro.spring01.model.member.dao.MemberDAO;
import com.pro.spring01.model.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDAO memberDao;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public List<MemberDTO> list(String search_option, String keyword,int start, int end)throws Exception {
		return memberDao.list(search_option, keyword, start, end);
	}

	@Override
	public void insert(MemberDTO dto) {
		memberDao.insert(dto);

	}

	@Override
	public MemberDTO detail(String userid) {
		return memberDao.detail(userid);
	}

	@Override
	public void delete(String userid) {
		memberDao.delete(userid);

	}

	@Override
	public void update(MemberDTO dto) {
		memberDao.update(dto);

	}
	
	@Override
	public void userUpdate(MemberDTO dto) {
		memberDao.userUpdate(dto);

	}

	@Override
	public int idCheck(String userid) {
		return memberDao.idCheck(userid);
	}
	
	@Override
	public boolean pwdCheck(String userid, String userpwd) {
		
		return memberDao.pwdCheck(userid, userpwd);
	}

	@Override
	public MemberDTO loginCheck(MemberDTO dto, HttpSession session) {
		MemberDTO memberDto = memberDao.loginCheck(dto);
		if(memberDto != null) {
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name",memberDto.getName());
			session.setAttribute("power",memberDto.getPower());
			
		}
		return memberDto;
	}
	
	@Override
	public MemberDTO loginCheck(MemberDTO dto) {
		MemberDTO memberDto = memberDao.loginCheck(dto);
		
		return memberDto;
	}
	

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public void changePwd(String userid, String userpwd, String newuserpwd) {
		MemberDTO memberdto = memberDao.detail(userid);
		if(memberdto != null) {
			memberdto.changePassword(userpwd,newuserpwd);
			memberDao.changePwd(memberdto);
		}
	}

	@Override
	public MemberDTO findPwd(String userid, String email) {
		return memberDao.findPwd(userid, email);
	}

	@Override
	public int countMember(String search_option, String keyword) {
		return memberDao.countMember(search_option, keyword);
	}

	@Override
	public int count(String userid) {
		return 0;
	}

	


}
