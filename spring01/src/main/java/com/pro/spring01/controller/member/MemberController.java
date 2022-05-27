package com.pro.spring01.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.validation.Validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pro.spring01.model.member.dto.MemberDTO;
import com.pro.spring01.model.member.dto.PagerDTO;
import com.pro.spring01.service.member.MemberService;
import com.pro.spring01.validator.FindPwdValidator;
import com.pro.spring01.validator.MemberValidator;


@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Inject
	MemberService memberService;
	
    @Autowired
    JavaMailSender mailSender;
    
    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;


    @RequestMapping("list.do")
	public ModelAndView list(@RequestParam(defaultValue="name") String search_option, 
			@RequestParam(defaultValue="") String keyword, @RequestParam(defaultValue="1") int curPage, ModelAndView mav) throws Exception {
		
		int count = memberService.countMember(search_option, keyword);
		
		PagerDTO dto = new PagerDTO(count, curPage);
		int start = dto.getPageBegin();
		int end = dto.getPageEnd();
		
		List<MemberDTO> list = memberService.list(search_option, keyword, start, end);
		
		mav.setViewName("member/list");
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("curPage", curPage);
	    map.put("pager", dto); 
		map.put("search_option", search_option);
		map.put("keyword",keyword);
		mav.addObject("map", map);
		return mav; 	
	}
	
	@RequestMapping("write.do")
	public String write(Model model) {
		model.addAttribute("memberDto",new MemberDTO());
		return "member/write";
	}
	
	@RequestMapping("admin.do")
	public String admin() {
		return "member/admin";
	}
		
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute("memberDto") MemberDTO dto, @RequestParam String userid, Errors errors, Model model) throws Exception  {
		new MemberValidator().validate(dto, errors);
		
		//int result = memberService.idCheck(userid);
		
		String pwd = bCryptPasswordEncoder.encode(dto.getUserpwd());
		dto.setUserpwd(pwd);
		
		if (errors.hasErrors()) return "member/write";
			
//		if (result == 1) { // 중복된 아이디가 있을경우 
//			// 아이디 비밀번호 초기화
//			dto.setUserid("");
//			dto.setUserpwd("");
//			return "member/write";
//		}
		
		memberService.insert(dto);
		model.addAttribute("message","signup");
		return "redirect:/member/login.do";
	}
	
	@RequestMapping("detail.do")
	public String detail(@RequestParam String userid, Model model) {
		// 회원정보를 model에 저장
		model.addAttribute("dto",memberService.detail(userid));
		//view.jsp로 포워딩
		return "member/detail";
	}
	
	@RequestMapping("userinfo.do")
	public String userinfo(@RequestParam String userid, Model model) {
		// 회원정보를 model에 저장
		model.addAttribute("dto",memberService.detail(userid));
		//view.jsp로 포워딩
		return "member/userinfo";
	}

	
	@RequestMapping("update.do")
	public String update(@RequestParam String userid, @ModelAttribute MemberDTO dto, Model model, Errors errors) {
		if (errors.hasErrors()) return "redirect:/member/userinfo.do";
	
		memberService.userUpdate(dto);
		return "redirect:/";	
	}
	

	@RequestMapping("deleted.do")
	public String deleted(@RequestParam String userid, Model model) {
		memberService.delete(userid);
		return "redirect:/";
	}
	
	@RequestMapping("idCheck.do")
	public String idcheck(@RequestParam String userid, Model model) {
		int result = memberService.idCheck(userid);
		model.addAttribute("userid",userid);
		model.addAttribute("result",result);
		return "member/idCheck";
	}
	
	@RequestMapping("login.do")
	public String login() {
		return "member/login";
	}
	
	@RequestMapping("logirnCheck.do")
	public ModelAndView loginCheck(@ModelAttribute MemberDTO dto, HttpSession session) {
		boolean result;
		MemberDTO memberDto = memberService.loginCheck(dto, session);
		ModelAndView mav = new ModelAndView();
		
		if (memberDto != null) {
			result = bCryptPasswordEncoder.matches(dto.getUserpwd(), memberDto.getUserpwd());
			
		} else {
			result = false;
		}
		
		if (memberDto != null && result) { // 로그인 성공
			if (memberDto.getPower().equals("admin")) {
				mav.addObject("message","success");
				mav.setViewName("membe/admin");
				
			} else {
				mav.setViewName("home");
			}
			
		} else {  // 로그인 실패하면 login 페이지로 이동 
			result = false;
			mav.setViewName("member/login");
			mav.addObject("message","error");
			
		}
		
		return mav;
	}

	
	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {
		memberService.logout(session);
		mav.setViewName("member/login");
		mav.addObject("message","logout");
		return mav;
	}
	
	@RequestMapping("info.do")
	public String userinfo(Model model, HttpSession session) {
		String userid = (String)session.getAttribute("userid");
		
		// 회원정보를 model에 저장
		if (userid != null) {
			model.addAttribute("dto",memberService.detail(userid));
			session.setAttribute("userid", userid);
		}
		
		//view.jsp로 포워딩
		return "member/info";
	}

	@RequestMapping("userUpdate.do")
	public String userUpdate(@ModelAttribute MemberDTO dto, Model model, HttpSession session) {
		//비밀번호 체크
		MemberDTO memberDto = memberService.loginCheck(dto);
		boolean result =  bCryptPasswordEncoder.matches(dto.getUserpwd(), memberDto.getUserpwd());
//		boolean result = memberService.pwdCheck(dto.getUserid(), dto.getUserpwd());
		
		if (memberDto != null && result) {
			String str = bCryptPasswordEncoder.encode(dto.getUserpwd());
			dto.setUserpwd(str);
			memberService.userUpdate(dto);
			
			return "redirect:/member/info.do";
			
		} else {
			// 비밀번호가 틀렸을시에 가입자가 지워지지 않도록 처리
			result = false;
			
			MemberDTO dto2 = memberService.detail(dto.getUserid());
			
			dto.setRegdate(dto2.getRegdate());
			dto.setGender(dto2.getGender());
			dto.setUdtdate(dto2.getUdtdate());
			
			model.addAttribute("dto",dto);
			model.addAttribute("message","notMatching");
			
			return "member/info";
		}
	}
	
	@RequestMapping("userDelete.do")
	public String userdelete(@RequestParam String userid, @RequestParam String userpwd, HttpSession session, Model model, MemberDTO dto) {
		MemberDTO memberDto = memberService.loginCheck(dto);
		boolean result =  bCryptPasswordEncoder.matches(dto.getUserpwd(), memberDto.getUserpwd());
//		boolean result = memberService.pwdCheck(userid, userpwd);
		
		if (memberDto != null && result) {
			memberService.delete(userid);
			memberService.logout(session);
			model.addAttribute("message","delete");
			
			return "redirect:/member/login.do";
			
		} else {
			result = false;
			model.addAttribute("dto",memberService.detail(userid));
			model.addAttribute("message","notMatching");
			
			return "member/info";
		}
	}
	
	@RequestMapping("changePwdForm.do")
	public String changepwdForm (Model model, HttpSession session) {
		String userid = (String)session.getAttribute("userid");
		model.addAttribute("dto",memberService.detail(userid));
		session.setAttribute("userid", userid);
		
		return "member/changePwdForm";
	}
	
	@RequestMapping("change.do")
	public String change(@ModelAttribute MemberDTO dto, Model model, HttpSession session ) {
		String userid = (String)session.getAttribute("userid");
		MemberDTO memberDto = memberService.detail(userid);
		boolean chk = memberService.pwdCheck(userid, dto.getUserpwd());
		boolean result;
		
		if (memberDto != null) {
			result = bCryptPasswordEncoder.matches(dto.getUserpwd(), memberDto.getUserpwd());
			
		} else {
			result = false;
		}
		
		
		if (!dto.isnewuserpwdEqualToConfirmPassword()) {
			model.addAttribute("message","error");
			
			return "member/changePwdForm";
		}
		
		if (result && chk) {
			if (dto.getUserpwd().equals(dto.getNewuserpwd())) {
				model.addAttribute("message","error2");
				
				return "member/changePwdForm";
				
			} else {
				String newPwd = bCryptPasswordEncoder.encode(dto.getNewuserpwd());
				dto.setNewuserpwd(newPwd);
				memberService.changePwd(userid, dto.getUserpwd(), dto.getNewuserpwd());
				memberService.logout(session);
				model.addAttribute("message","change");
				
				return "redirect:/member/login.do";
			}
			
		} else {
			result = false;
			model.addAttribute("dto",memberService.detail(userid));
			model.addAttribute("message","error1");
			
			return "member/changePwdForm";
		}
			
	}
	
	
	@RequestMapping("findPwd.do")
	public String findPwd(Model model) {
		model.addAttribute("memberDto",new MemberDTO());
		return "member/findPwd";
	}
	
	
	@RequestMapping("send.do")
	public String mailSending(Model model, HttpServletResponse response, @ModelAttribute("memberDto")MemberDTO dto, Errors errors) {
		MemberDTO memberDto = memberService.findPwd(dto.getUserid(), dto.getEmail());
		new FindPwdValidator().validate(dto, errors);
		
		if (errors.hasErrors()) return "member/findPwd";

		if (memberDto != null) {
			String setfrom = "home";
			String tomail = dto.getEmail(); // 받는 사람 이메일
			String title = memberDto.getName() + "님의 비밀번호 입니다."; // 제목
			String content = "비밀번호는 ["+ memberDto.getUserpwd() + "] 입니다. "; // 내용
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); 
				
				message.setFrom(new InternetAddress(setfrom)); 
				messageHelper.setTo(tomail); // 받는사람 이메일
				message.setSubject(title); // 메일제목 
				message.setContent(content, "text/plain; charset=UTF-8"); // 메일 내용
				mailSender.send(message);
				response.setContentType("text/plain; charset=UTF-8");
			
				return "member/sendSuccess";

			} catch (Exception e) {
				System.out.println(e);
			}
			
		} else {
			model.addAttribute("msg","아이디나 이메일을 확인해주세요");
			return "member/findPwd";
		}
		
		return "member/sendSuccess";
	}

	
}
