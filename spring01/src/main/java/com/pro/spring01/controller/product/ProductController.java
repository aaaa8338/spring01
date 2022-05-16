package com.pro.spring01.controller.product;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pro.spring01.model.product.dto.PagerDTO;
import com.pro.spring01.model.product.dto.ProductDTO;
import com.pro.spring01.service.product.ProductService;

@Controller
@RequestMapping("/product/*") 
public class ProductController {
	
	@Inject
	ProductService productService; 
	
	@RequestMapping("allList.do")
	public ModelAndView allList( @RequestParam(defaultValue="all") String search_option, @RequestParam(defaultValue="") String keyword, 
		@RequestParam(defaultValue="1") int curPage) throws Exception{
		
		int count = productService.countProduct(search_option, keyword);
		
		PagerDTO pagerDto = new PagerDTO(count, curPage);
        int start=pagerDto.getPageBegin();
        int end=pagerDto.getPageEnd();
        
		List<ProductDTO> list= productService.allList(search_option, keyword, start, end); 
		ModelAndView mav=new ModelAndView(); 
		
		mav.setViewName("product/allList"); 
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("curPage", curPage);
	    map.put("pager", pagerDto); 
		map.put("search_option", search_option);
		map.put("keyword",keyword);
		mav.addObject("map", map);
		
		return mav; 			
	}
	
	@RequestMapping("ringList.do")
	public ModelAndView ringList(@RequestParam(defaultValue="all") String search_option, @RequestParam(defaultValue="") String keyword, 
			@RequestParam() String kind, @RequestParam(defaultValue="1") int curPage) throws Exception{
		
		int count = productService.countProduct1(search_option, keyword, kind); 
		
		PagerDTO pagerDto = new PagerDTO(count, curPage);
        int start=pagerDto.getPageBegin();
        int end=pagerDto.getPageEnd();
		
		List<ProductDTO> list= productService.kindList(search_option, keyword, kind, start, end); 
		ModelAndView mav=new ModelAndView(); 
		
		mav.setViewName("product/ringList"); 
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("curPage", curPage);
	    map.put("pager", pagerDto); 
		map.put("keyword",keyword);
		map.put("kind", kind);
		mav.addObject("map", map);
		
		return mav; 	
	}
	
	@RequestMapping("necklaceList.do")
	public ModelAndView necklaceList( @RequestParam(defaultValue="all") String search_option,@RequestParam(defaultValue="") String keyword, 
			@RequestParam() String kind, @RequestParam(defaultValue="1") int curPage) throws Exception{
		
		int count = productService.countProduct1(search_option, keyword, kind); 
		
		PagerDTO pagerDto = new PagerDTO(count, curPage);
        int start=pagerDto.getPageBegin();
        int end=pagerDto.getPageEnd();
		
		List<ProductDTO> list= productService.kindList(search_option, keyword, kind, start, end); 
		ModelAndView mav=new ModelAndView(); 
		
		mav.setViewName("product/necklaceList"); 
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("curPage", curPage);
	    map.put("pager", pagerDto); 
		map.put("keyword",keyword);
		map.put("kind", kind);
		mav.addObject("map", map);
		
		return mav; 	
	}
	
	@RequestMapping("detail.do")
	public ModelAndView detail(@RequestParam int productid, @RequestParam(defaultValue="all") String search_option,
			@RequestParam(defaultValue="") String keyword, @RequestParam(defaultValue="1") int curPage, ModelAndView mav) {
		
		mav.setViewName("product/detail");
		mav.addObject("curPage",curPage);
        mav.addObject("search_option",search_option);
        mav.addObject("keyword",keyword);
		mav.addObject("dto",productService.detail(productid));
		
		return mav;
	}
	
	@RequestMapping("write.do")
	public String write() {
		return "product/write";
	}
	
	@RequestMapping("insert.do")
	public String insert(ProductDTO dto) {
		String filename="-";
		
		if (!dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			// 개발 디렉토리
//			String path = "C:\\Program Files\\Java\\workspace_sts\\spring03\\src\\main\\webapp\\WEB-INF\\views\\images\\";
			String path = "C:\\Users\\user\\git\\spring\\spring03\\src\\main\\webapp\\WEB-INF\\views\\images\\";
			
			try {
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path+filename));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		dto.setPictureurl(filename);
		productService.insert(dto);
		
		return "redirect:/product/allList.do";
	}
	
	@RequestMapping("edit.do")
	public ModelAndView edit(@RequestParam int productid, @RequestParam(defaultValue="all") String search_option,
			@RequestParam(defaultValue="") String keyword, @RequestParam(defaultValue="1") int curPage, ModelAndView mav) {
		
		mav.setViewName("product/edit");
		mav.addObject("curPage",curPage);
        mav.addObject("search_option",search_option);
        mav.addObject("keyword",keyword);
		mav.addObject("dto",productService.detail(productid));
		
		return mav;
	}
	
	@RequestMapping("update.do")
	public String update(ProductDTO dto) {
		String filename="-";
		if (!dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			
			String path = "C:\\Users\\user\\git\\spring\\spring03\\src\\main\\webapp\\WEB-INF\\views\\images\\";

			try {
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path+filename));
				
			} catch (Exception e) {
				e.printStackTrace();	
			}
			
			dto.setPictureurl(filename);
			
		} else {
			ProductDTO dto2 = productService.detail(dto.getProductid());
			dto.setPictureurl(dto2.getPictureurl());			
		}
		
		productService.update(dto);
		
		return "redirect:/product/allList.do";
	}
	
	@RequestMapping("delete.do")
	public String delete(@RequestParam int productid) {
		String filename= productService.fileInfo(productid);
		//첨부 파일이름
		if (filename != null && filename.equals("-")) {
			String path = "C:\\Users\\user\\git\\spring\\spring03\\src\\main\\webapp\\WEB-INF\\views\\images\\";
			File file = new File(path+filename);
			
			if (file.exists()) file.delete(); // 파일이 존재한다면 파일 삭제
			
		}
		
		productService.delete(productid); // 레코드 삭제
		return "redirect:/product/allList.do";
	}
	
	@RequestMapping(value = "productCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public int productCheck(@RequestParam String productname) {
		int result = productService.count(productname);
		return result;
	}
	
}
