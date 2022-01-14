package com.demo.controllers.user;


import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.models.Account;
import com.demo.models.Quiz;
import com.demo.services.AccountService;
import com.demo.services.admin.CategoryServiceAdmin;
import com.demo.services.user.CourseService;


@Controller
@RequestMapping(value = {"user/course"})
public class CourseController {
	
	@Autowired
	private AccountService accountService;

	@Autowired
	private CourseService courseService;
	
	@Autowired
	private CategoryServiceAdmin categoryServiceAdmin;
	
	private int categoryIdd;
	
	@RequestMapping(value = { "index" }, method = RequestMethod.GET)
	public String index(@RequestParam(name = "categoryId") int categoryId, ModelMap modelMap, Model model, Authentication authentication) {
		
		this.categoryIdd = categoryId;
	
		return pagination(1, 25, "quiz_id", modelMap, model, authentication);
		
	}


	@RequestMapping(value = { "pagination" }, method = RequestMethod.GET)
	public String pagination(@RequestParam(name = "currentPage") int currentPage,
			@RequestParam(name = "pageSize") int pageSize, @RequestParam(name = "sort") String sort, ModelMap modelMap,
			Model model, Authentication authentication) {

		Account username = accountService.findByUsername(authentication.getName());
		
		modelMap.put("accountUsername", username);
		modelMap.put("categories", categoryServiceAdmin.findAllCategory());
		int pageSizee = pageSize;

		Page<Quiz> pages = courseService.getAllQuizByCategoryId(currentPage, pageSizee, sort, categoryIdd);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", pages.getTotalPages());
		model.addAttribute("totalElements", pages.getTotalElements());
		model.addAttribute("pageSize", pageSizee);
		model.addAttribute("sort", sort);
		model.addAttribute("quizs", pages.getContent());


		Account account = new Account();
		account.setDob(new Date());
		
		modelMap.put("account", account);
		modelMap.put("categories", categoryServiceAdmin.findAllCategory());
		

		return "user/course/index";
	}
	
}
