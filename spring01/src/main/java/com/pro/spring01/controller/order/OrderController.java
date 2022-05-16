package com.pro.spring01.controller.order;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pro.spring01.model.cart.dto.CartDTO;
import com.pro.spring01.model.member.dto.MemberDTO;
import com.pro.spring01.model.order.dto.OrderDTO;
import com.pro.spring01.model.order.dto.OrderDetailDTO;
import com.pro.spring01.service.cart.CartService;
import com.pro.spring01.service.order.OrderDetailService;
import com.pro.spring01.service.order.OrderService;

@Controller
public class OrderController {
	
	@Inject
	OrderService orderService; 
	
	@Autowired
	OrderDetailService orderDetailService;
	
	@Autowired
	CartService cartService;
	
	@RequestMapping("/order/insert.do")
	public String insert(OrderDetailDTO detailDto, HttpSession session,CartDTO cartDto,
			OrderDTO dto, @RequestParam(value = "chk[]") List<String> chArr) {
		
		String userid = (String)session.getAttribute("userid");
		
		if (userid != null) {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			String month = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
			String day = month + new DecimalFormat("00").format(cal.get(Calendar.DATE));
			String subNum = "";

			for (int i = 1; i <= 6; i++) {
				subNum += (int)(Math.random()*10);
			}

			String orderid = day + "-" + subNum;
			
			dto.setUserid(userid);
			dto.setOrderid(orderid);
			orderService.insert(dto);
			 
			detailDto.setOrderid(orderid);
			detailDto.setUserid(userid);
		
			int cartid = 0;
			
			for (String i : chArr){
				cartid = Integer.parseInt(i);
				cartDto.setCartid(cartid);
				orderDetailService.insertDetail(userid,orderid,cartid);
				cartid = Integer.parseInt(i);
				cartService.delete(cartid);
			}

//			for (String i : chArr){
//				cartid = Integer.parseInt(i);
//				cartService.delete(cartid);
//			}
		
		}
		return "redirect:/cart/list.do";
		
	}
	
	@RequestMapping("/order/inserted.do")
	public String inserted(OrderDetailDTO detailDto, HttpSession session, OrderDTO dto) {
		String userid = (String)session.getAttribute("userid");
		
		if (userid != null) {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			String month = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
			String day = month + new DecimalFormat("00").format(cal.get(Calendar.DATE));
			String subNum = "";

			for (int i = 1; i <= 6; i++) {
				subNum += (int)(Math.random()*10);
			}

			String orderid = day + "-" + subNum;
			
			dto.setUserid(userid);
			dto.setOrderid(orderid);
			orderService.insert(dto);
			 
			detailDto.setOrderid(orderid);
			detailDto.setUserid(userid);
		
			orderDetailService.insertDetailed(userid,orderid);
		
		}
		return "/order/list.do";
		
	}
	
	@RequestMapping("/order/list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav, OrderDTO dto) {
		String userid = (String)session.getAttribute("userid");
		Map<String, Object> map = new HashMap<>();
		
		if (userid != null) {
			List<OrderDTO> list = orderService.list(userid);
			int sumMoney = cartService.sumMoney(userid);
			int fee = sumMoney >= 100000 ? 0 : 2500; 
			
			map.put("fee", fee); // 배송료
			map.put("sumMoney", sumMoney); 
			map.put("sum", sumMoney+fee); 
			map.put("list", list); 
			map.put("count", list.size()); 
			
			mav.setViewName("order/orderList");
			mav.addObject("map",map);
			session.setAttribute("userid", userid);
			
			return mav;
			
		} else {
			return new ModelAndView("member/login","", null);
		}
	}
	
	@RequestMapping("/order/adminList.do")
	public ModelAndView adminlist(HttpSession session, ModelAndView mav, OrderDTO dto) {
		Map<String, Object> map = new HashMap<>();
		List<OrderDTO> list = orderService.adminList();
		
		map.put("list", list); 
		map.put("count", list.size()); 
		mav.setViewName("order/orderAdminList");
		mav.addObject("map",map);
		
		return mav;
	}
	
	@RequestMapping("/order/orderDetailList.do")
	public String detailList(@RequestParam String orderid, Model model, OrderDTO dto, HttpSession session) {
		String userid = (String)session.getAttribute("userid");
		
		dto.setUserid(userid);
		dto.setOrderid(orderid);
		
		List<OrderDTO> orderDto = orderService.detailList(dto);
		
		if (userid != null) model.addAttribute("orderDto",orderDto);
	
		return "order/orderDetailList";	
	}
	
	@RequestMapping("/order/adminDetailList.do")
	public String adminDetailList(@RequestParam String orderid, Model model, @RequestParam String userid, 
			OrderDTO dto, HttpSession session) {

		dto.setUserid(userid);
		dto.setOrderid(orderid);
		
		List<OrderDTO> orderDto = orderService.detailList(dto);
		
		model.addAttribute("orderDto",orderDto);
		
		return "order/adminDetailList";
			
	}
}
