package com.demo.controllers.admin;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.internal.lang.annotation.ajcDeclareAnnotation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.demo.entites.AccountAjax;
import com.demo.entites.QuizAjax;
import com.demo.models.Account;
import com.demo.models.Category;
import com.demo.models.History;
import com.demo.models.Quiz;
import com.demo.models.Role;
import com.demo.services.AccountService;
import com.demo.services.admin.AccountServiceAdmin;
import com.demo.services.admin.CategoryServiceAdmin;
import com.demo.services.admin.QuizServiceAdmin;
import com.demo.services.user.HistoryService;
import com.google.gson.Gson;
import com.nimbusds.jose.shaded.json.JSONArray;

@Controller
@RequestMapping(value = { "admin/dashboard" })
public class DashboardAdminController {

	@Autowired
	private AccountService accountService;
	@Autowired
	private CategoryServiceAdmin categoryServiceAdmin;
	@Autowired
	private QuizServiceAdmin quizServiceAdmin;
	@Autowired
	private AccountServiceAdmin accountServiceAdmin;
	@Autowired
	private HistoryService historyService;

	@RequestMapping(value = { "", "index" }, method = RequestMethod.GET)
	public String index(Authentication authentication, ModelMap modelMap, HttpServletRequest request) {
		int newfaculty1 = 0, newcandidate1 = 0, totalnewuser = 0, totaluser = 0, totalfaculty = 0, totalcandidate = 0,totalquiz=0;
		HttpSession session = request.getSession();
		List<Category> categories = categoryServiceAdmin.findAllCategory();
		List<List<String>> qal = new ArrayList<List<String>>();
		for (Category category : categories) {
			int count = 0;
			List<QuizAjax> quizs = quizServiceAdmin.findAjaxByCategoryId(category.getCategoryId());
			for (QuizAjax quizAjax : quizs) {
				totalquiz++;
			}
			List<String> a = new ArrayList<String>();
			a.add("country: " + category.getTitle());
			a.add(String.valueOf(count));
			qal.add(a);
		}
		Account account = (Account) session.getAttribute("account");
		List<Account> accounts = accountServiceAdmin.findAllAccount();
		for (Account account2 : accounts) {
			for (Role role : account2.getRoles()) {
				if (role.getRoleName().equalsIgnoreCase("ROLE_USER_CANDIDATE")) {
					totalcandidate++;
					totaluser++;
				} else if (role.getRoleName().equalsIgnoreCase("ROLE_USER_FACULTY")) {
					totalfaculty++;
					totaluser++;
				}

			}
		}
		modelMap.put("sumuser", totaluser);
		modelMap.put("sumquiz", totalquiz);
		System.out.println("bao");
		System.out.println(account.getFullname());
		modelMap.put("accountUsername", accountService.findByUsername(authentication.getName()));
		
		return "admin/dashboard/index";
	}

	@RequestMapping(value = { "rne" }, method = RequestMethod.GET)
	public String rne(Authentication authentication, ModelMap modelMap, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		System.out.println("bao");
		System.out.println(account.getFullname());
		modelMap.put("accountUsername", accountService.findByUsername(authentication.getName()));

		return "admin/dashboard/rne";
	}

	@SuppressWarnings("deprecation")
	@RequestMapping(value = { "nmb" }, method = RequestMethod.GET)
	public String nmb(Authentication authentication, ModelMap modelMap, HttpServletRequest request) {
		int newfaculty1 = 0, newcandidate1 = 0, totalnewuser = 0, totaluser = 0, totalfaculty = 0, totalcandidate = 0;
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		System.out.println("bao");
		System.out.println(account.getFullname());
		modelMap.put("accountUsername", accountService.findByUsername(authentication.getName()));
		List<List<String>> nmb = new ArrayList<List<String>>();
		List<Account> accounts = accountServiceAdmin.findAllAccount();
		for (Account account2 : accounts) {
			for (Role role : account2.getRoles()) {
				if (role.getRoleName().equalsIgnoreCase("ROLE_USER_CANDIDATE")) {
					totalcandidate++;
					totaluser++;
				} else if (role.getRoleName().equalsIgnoreCase("ROLE_USER_FACULTY")) {
					totalfaculty++;
					totaluser++;
				}

			}
		}
		for (int i = 1; i <= 12; i++) {
		int	newfaculty = 0,newcandidate = 0;
			List<AccountAjax> accountAjaxs = accountServiceAdmin.findThisYear(java.time.LocalDateTime.now().getYear(),
					i);
			for (AccountAjax accountAjax : accountAjaxs) {
				Account account3 = accountService.findById(accountAjax.getAccountId());

				for (Role role : account3.getRoles()) {
					if (role.getRoleName().equalsIgnoreCase("ROLE_USER_CANDIDATE")) {
						newcandidate++;
						newcandidate1++;
						totalnewuser++;
					} else if (role.getRoleName().equalsIgnoreCase("ROLE_USER_FACULTY")) {
						newfaculty++;
						newfaculty1++;
						totalnewuser++;
					}

				}
			}
			List<String> a = new ArrayList<String>();
			a.add("category: " + String.valueOf(i) + "/" + String.valueOf(java.time.LocalDateTime.now().getYear()));
			a.add("column-1: " + String.valueOf(newcandidate));
			a.add("column-2: " + String.valueOf(newfaculty));
			nmb.add(a);
		}
		String json = new Gson().toJson(nmb).replace("[[", "[{").replace("],[", "},{").replace("]]", "}]")
				.replace("\"category: ", "\"category\":\"").replace("\"column-1: ", "\"column-1\":\"")
				.replace("\"column-2: ", "\"column-2\":\"").replace("\"column-1\":\"", "\"column-1\":")
				.replace("\",\"column-2\"", ",\"column-2\"").replace(",\"column-2\":\"", ",\"column-2\":")
				.replace("\"}", "}");
		;
		System.out.println(json);
		System.out.println("candidate: " + totalcandidate);
		System.out.println("faculty: " + totalfaculty);
		System.out.println("All user: " + totaluser);
		modelMap.put("categories", json);
		modelMap.put("totalnewuser", totalnewuser);
		modelMap.put("newfaculty", newfaculty1);
		modelMap.put("newcandidate", newcandidate1);
		modelMap.put("totaluser", totaluser);
		modelMap.put("totalfaculty", totalfaculty);
		modelMap.put("totalcandidate", totalcandidate);
		return "admin/dashboard/nmb";
	}

	@RequestMapping(value = { "qal" }, method = RequestMethod.GET)
	public String qal(Authentication authentication, ModelMap modelMap, HttpServletRequest request) {
		int totalquiz=0,totalcate=0,totaltimedotest=0;
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		System.out.println("bao");
		System.out.println(account.getFullname());
		modelMap.put("accountUsername", accountService.findByUsername(authentication.getName()));
List<Category> categories2 = categoryServiceAdmin.findAllCategory();
		
		List<List<String>> tt = new ArrayList<List<String>>();
		
		for (Category category : categories2) {
			int counthis=0;
			List<QuizAjax> quizs2 = quizServiceAdmin.findAjaxByCategoryId(category.getCategoryId());
			for (QuizAjax quizAjax : quizs2) {
				List<History> histories= historyService.findByQuizId(quizAjax.getQuizId());
				for(History history:histories) {
					counthis++;
					totaltimedotest++;
				}
			}
			
			List<String> a = new ArrayList<String>();
			a.add("category: " + category.getTitle());
			a.add("column-1: "+String.valueOf(counthis));
			tt.add(a);
		}
		String json2 = new Gson().toJson(tt).replace("[[", "[{").replace("],[", "},{").replace("]]", "}]")
				.replace("\"category: ", "\"category\":\"").replace("\"column-1: ", "\"column-1\":\"").replace("\"column-1\":\"", "\"column-1\":").replace("\"}", "}");
		System.out.println(json2);
		modelMap.put("categories2", json2);
		List<Category> categories = categoryServiceAdmin.findAllCategory();
		List<List<String>> qal = new ArrayList<List<String>>();
		for (Category category : categories) {
			int count = 0;
			totalcate++;
			List<QuizAjax> quizs = quizServiceAdmin.findAjaxByCategoryId(category.getCategoryId());
			for (QuizAjax quizAjax : quizs) {
				count++;
				totalquiz++;
			}
			List<String> a = new ArrayList<String>();
			a.add("country: " + category.getTitle());
			a.add(String.valueOf(count));
			qal.add(a);
		}
		modelMap.put("totalquiz", totalquiz);
		modelMap.put("totalcate", totalcate);
		modelMap.put("totaltimedotest", totaltimedotest);
		String json = new Gson().toJson(qal).replace("[[", "[{").replace("],[", "},{").replace("]]", "}]")
				.replace("\"country: ", "\"country\":\"").replace(",\"", ",\"litres\":").replace("\"}", "}");
		modelMap.put("categories", json);
		System.out.println(json);
		return "admin/dashboard/qal";
	}
	@RequestMapping(value = { "tt" }, method = RequestMethod.GET)
	public String tt(Authentication authentication, ModelMap modelMap, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		System.out.println("bao");
		System.out.println(account.getFullname());
		modelMap.put("accountUsername", accountService.findByUsername(authentication.getName()));
List<Category> categories2 = categoryServiceAdmin.findAllCategory();
		
		List<List<String>> tt = new ArrayList<List<String>>();
		
		for (Category category : categories2) {
			int counthis=0;
			List<QuizAjax> quizs2 = quizServiceAdmin.findAjaxByCategoryId(category.getCategoryId());
			for (QuizAjax quizAjax : quizs2) {
				List<History> histories= historyService.findByQuizId(quizAjax.getQuizId());
				for(History history:histories) {
					counthis++;
				}
			}
			
			List<String> a = new ArrayList<String>();
			a.add("category: " + category.getTitle());
			a.add("column-1: "+String.valueOf(counthis));
			tt.add(a);
		}
		String json2 = new Gson().toJson(tt).replace("[[", "[{").replace("],[", "},{").replace("]]", "}]")
				.replace("\"category: ", "\"category\":\"").replace("\"column-1: ", "\"column-1\":\"").replace("\"column-1\":\"", "\"column-1\":").replace("\"}", "}");
		System.out.println(json2);
		modelMap.put("categories", json2);
		return "admin/dashboard/tt";
	}
}
