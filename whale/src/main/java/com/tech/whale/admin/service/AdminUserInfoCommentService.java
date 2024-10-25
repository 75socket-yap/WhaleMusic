package com.tech.whale.admin.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminPFCDto;
import com.tech.whale.admin.util.AdminSearchVO;
import com.tech.whale.community.vo.SearchVO;

@Service
public class AdminUserInfoCommentService implements AdminServiceInter{

	@Autowired
	private AdminIDao adminIDao;
	
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		SearchVO searchVO = (SearchVO) map.get("searchVO");
		String userId = request.getParameter("userId");
		
		if (searchVO == null) {
		    searchVO = new SearchVO();
		    model.addAttribute("searchVO", searchVO);
		}
		
		int total = adminIDao.selectCommentsCnt(userId);
		
		String strPage = request.getParameter("clpage");
		if(strPage == null || strPage.isEmpty()) {
 			strPage="1";
 		}
		
		int page = Integer.parseInt(strPage);
		searchVO.setPage(page);
		searchVO.pageCalculate(total);
		int rowStart = searchVO.getRowStart();
		int rowEnd = searchVO.getRowEnd();
		
		ArrayList<AdminPFCDto> cldto =
				adminIDao.userAccountCommentsSelect(rowStart,rowEnd,userId);
		model.addAttribute("AccountUserCommentsList", cldto);
		model.addAttribute("cltotRowcnt", total);
		model.addAttribute("clsearchVO", searchVO);
	}

}
