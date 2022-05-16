package com.pro.spring01.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pro.spring01.model.board.dto.BoardDTO;
import com.pro.spring01.model.board.dto.PagerDTO;
import com.pro.spring01.service.board.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Inject
	BoardService boardService;
	
	   @RequestMapping("list.do") //세부적인 url pattern
	    public ModelAndView list(//RequestParam으로 옵션, 키워드, 페이지의 기본값을 각각 설정해준다.
	    @RequestParam(defaultValue="1") int curPage,
	    @RequestParam(defaultValue="all") String search_option,
	    @RequestParam(defaultValue="") String keyword)
	    //defaultValue를 설정하지 않으면 null point 에러가 발생할수 있기 때문에 기본값을 설정해주어야 한다.
	                        throws Exception{
	        //레코드 갯수 계산
		   	int count = boardService.countArticle(search_option, keyword); // 검색옵션과 키워드를 고려
	        
	        //페이지 관련 설정, 시작번호와 끝번호를 구해서 각각 변수에 저장함
	        PagerDTO pager=new PagerDTO(count, curPage); //레코드 번호와 원하는 페이지의 번호를 주게 되면 
	        int start=pager.getPageBegin();
	        int end=pager.getPageEnd();

	        
	        //게시물 목록을 출력하기 위해 <BoardDTO>타입에 list변수에 게시물 목록관련 값들을 저장함.
	        //넣어야될 값들이 여러개 있으므로 haspmap.put 메소드를 사용해서 값들을 넣어서 list에 저장
	        
	        List<BoardDTO> list= boardService.listAll(start, end, search_option, keyword); //게시물 목록
	        ModelAndView mav=new ModelAndView(); 
	        //자료를 보낼 페이지를 지정해야하고, 자료를 지정해야 하기 때문에 ModelAndView 객체를 생성한다.
	        mav.setViewName("board/list"); //포워딩할 뷰의 이름
	                                               
	        Map<String,Object> map=new HashMap<>(); //여러개의 값들을 저장해야하기 때문에 hashmap() 객체를 생성
	        
	        map.put("list", list); //map에 자료 저장
	        map.put("count", count);
	        map.put("search_option", search_option);
	        map.put("curPage", curPage);
	        map.put("pager", pager); //페이지 네비게이션을 위한 변수
	        map.put("keyword",keyword); 
	        mav.addObject("map", map); //ModelAndView에 map을 저장
	        return mav; // board/list.jsp로 이동
	    }
	  
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute BoardDTO dto, HttpSession session) throws Exception {
		//로그인한 사용자 아이디
		String writer =(String)session.getAttribute("userid");
		dto.setWriter(writer);
		
		//레코드가 저장됨
		boardService.create(dto);
		//목록갱신
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("write.do")
	public String write() {
		return "board/write";
	}
	
	//list.jsp 페이지에서 넘긴 게시물번호, 페이지번호, 검색옵션, 키워드를 받는다.
	
	@RequestMapping(value = "detail.do")
    public ModelAndView view(@RequestParam int bno, 
    	@RequestParam int curPage, @RequestParam String search_option,
        @RequestParam String keyword, HttpSession session) throws Exception  {
 
        //조회수 증가 처리
        boardService.increaseViewcnt(bno);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("board/detail");
        mav.addObject("dto",boardService.read(bno));
        mav.addObject("curPage",curPage);
        mav.addObject("search_option",search_option);
        mav.addObject("keyword",keyword);
        return mav;
	}
	
	@RequestMapping("update.do")
	public String update(BoardDTO dto) throws Exception {
		boardService.update(dto);
		return "redirect:/board/list.do";
	}

	@RequestMapping("delete.do")
	public String delete(int bno) throws Exception {
		boardService.delete(bno);
		return "redirect:/board/list.do";
	}
}
