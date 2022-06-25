package com.pro.spring01.controller.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pro.spring01.model.cart.dto.CartDTO;
import com.pro.spring01.service.cart.CartService;


@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Inject
	CartService cartService;
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute CartDTO dto, HttpSession session) {
		// 로그인 여부를 체크하기 위해 세션에 저장된 아이디 확인
		String userid = (String)session.getAttribute("userid");
		dto.setUserid(userid);
		cartService.insert(dto); // 장바구니 테이블에 저장됨 
		
		return "redirect:/cart/list.do"; // 장바구니 목록으로 이동
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		Map<String, Object> map = new HashMap<>();
		String userid = (String)session.getAttribute("userid");
		
		if (userid != null) { //로그인상태
			List<CartDTO> list = cartService.list(userid); // 장바구니 목록 
			int sumMoney = cartService.sumMoney(userid);
			int fee = sumMoney >= 100000 ? 0 : 2500; // 배송료 계산
			
			map.put("fee", fee); // 배송료
			map.put("sumMoney", sumMoney); // 장바구니 합계 금액 
			map.put("sum", sumMoney+fee); // 전체 금액
			map.put("list", list); // 장바구니 목록
			map.put("count", list.size()); // 레코드 갯수
			
			mav.setViewName("cart/cartList");
			mav.addObject("map",map);
			
			return mav;
			
		} else {
			return new ModelAndView("member/login","", null);
		}
	}
	
	@ResponseBody
	@RequestMapping("delete.do")
	public int delete(HttpSession session, @RequestParam(value = "chbox[]") List<String> chArr, CartDTO dto) {
		int result = 0;
		int cartid = 0;
		String userid = (String)session.getAttribute("userid");
		
		if (userid != null) {
			for (String i : chArr) {   
				cartid = Integer.parseInt(i);
				dto.setCartid(cartid);
				cartService.delete(cartid);
			}
			
			result = 1;
		}
		
		return result;
	}
	
	@RequestMapping("deleted.do")
	public String deleted(HttpSession session, @RequestParam int cartid) {
		cartService.delete(cartid);
		return "redirect:/cart/list.do";
	}
	
	@RequestMapping("deleteAll.do")
	public String deleteAll(HttpSession session) {
		String userid = (String)session.getAttribute("userid");
		
		if (userid != null) cartService.deleteAll(userid);

		return "redirect:/cart/list.do";
	}
	
	@RequestMapping("update.do")
	public String update(int[] amount, int[] cartid, HttpSession session) {
		String userid = (String)session.getAttribute("userid");
		
		for (int i = 0; i < cartid.length; i++) {
			if (amount[i] == 0) {
				cartService.delete(cartid[i]);
				
			} else {
				CartDTO dto = new CartDTO();
				
				dto.setUserid(userid);
				dto.setCartid(cartid[i]);
				dto.setAmount(amount[i]);
				cartService.update(dto); 
			}
		}
		return "redirect:/cart/list.do";
	}
}
