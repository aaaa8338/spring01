package com.pro.spring01.controller.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.pro.spring01.model.board.dto.PagerDTO;
import com.pro.spring01.model.reply.dto.ReplyDTO;
import com.pro.spring01.service.reply.ReplyService;


@Controller // spring 4.0부터 사용 가능
public class ReplyController {
 
    @Inject        
    ReplyService replyService;
    
//  @RequestMapping("/reply/list.do")
//  public ModelAndView list(int bno, @RequestParam(defaultValue = "1") int curPage, 
//  		ModelAndView mav, HttpSession session) {
//      int count = replyService.count(bno);
//  	PagerDTO pagerDto = new PagerDTO(count, curPage);
//  	int start = pagerDto.getPageBegin();
//  	int end = pagerDto.getPageEnd();
//  	
//  	List<ReplyDTO> list=replyService.list(bno,start,end,session); //댓글 목록
//      mav.setViewName("board/replyList"); //뷰의 이름
//      mav.addObject("list", list); //뷰에 전달할 데이터 저장
//      mav.addObject("pagerDto", pagerDto);
//      return mav; //뷰로 이동
//  } 
  
//  @RequestMapping("/reply/insert.do") 
//  public void insert(ReplyDTO dto, HttpSession session) {
//  	
//  	//댓글 작성자 아이디
//  	//현재 접속중인 사용자 아이디
//  	String userid=(String)session.getAttribute("userid");
//  	dto.setReplyer(userid);
//  	
//  	//댓글이 테이블에 저장됨
//  	replyService.insert(dto);
//  	//jsp 페이지로 가거나 데이터를 리턴하지 않음
//  }

    @RequestMapping("board/reply_list.do")
    @ResponseBody
  	public ModelAndView list(int bno, ModelAndView mav, ReplyDTO dto, @RequestParam(value = "curPage")int curPage, 
							@RequestParam(value = "search_option") String search_option, @RequestParam(value = "keyword") String keyword) {
     
	  List<ReplyDTO> list = replyService.list(bno);
      Map<String,Object> map = new HashMap<>(); 
    
      map.put("list", list);
     
      mav.setViewName("board/replyList");    //뷰의 이름
      mav.addObject("curPage", curPage);
      mav.addObject("search_option", search_option);
      mav.addObject("keyword", keyword);
      mav.addObject("bno", bno);
      mav.addObject("map",map);
      
      return mav;
  }
  
//  @RequestMapping("/board/reply_list_json.do")
//  public List<ReplyDTO> Replylist(int bno){
//      return replyService.list(bno);
//  }
  
    // 댓글 등록
    @RequestMapping("/board/reply_insert.do")
    @ResponseBody
    public void insert (ReplyDTO dto, HttpSession session, @RequestParam(value="replytext") String replytext, @RequestParam(value="bno") int bno) {
		if (session.getAttribute("userid") != null) {
			String userid=(String)session.getAttribute("userid");
			dto.setUserid(userid);
		}
  	
      dto.setReplytext(replytext);
      dto.setBno(bno);
      
      replyService.insert(dto);
      System.out.println("dto :"+dto);
  }
  
  
//    @RequestMapping("/reply/update.do")    //세부적인 url pattern
//    public String reply_update (@RequestParam() int rno, @RequestParam() String replytext, HttpSession session, @RequestParam()int bno, ReplyDTO dto) throws Exception{
//    	String userid=(String)session.getAttribute("userid");
//    	dto.setRno(rno);
//    	dto.setReplytext(replytext);
//    	dto.setReplyer(userid);
//      
//    	System.out.println("dto에 있는값들 출력함"+dto);
//
//    	replyService.update(dto);
//    	return "forward:/board/list.do";
//    }
  
  //댓글 수정
    @RequestMapping("/board/reply_update.do")
    @ResponseBody
    public void reply_update (@RequestParam(value = "rno") int rno, ReplyDTO dto, @RequestParam(value = "replytext")String replytext, 
    							@RequestParam(value = "bno") int bno,HttpSession session) throws Exception{
  	
	  	String userid=(String)session.getAttribute("userid");
			dto.setUserid(userid);
//			dto.setReplytext(replytext);
			dto.setRno(rno);
			
	  	replyService.update(dto);
	  	System.out.println("dto :"+dto);

  }
  
  
    //댓글 삭제
    @RequestMapping("/board/reply_delete.do")
    @ResponseBody
    public void reply_delete (@RequestParam(value="rno") int rno, @RequestParam(value="bno") int bno, ReplyDTO dto, HttpSession session) throws Exception{
    	replyService.delete(rno);
    }
  
    @RequestMapping("/board/reply_list_json.do")
    public List<ReplyDTO> list_json(int bno){
    	return replyService.list(bno);
    }
}

