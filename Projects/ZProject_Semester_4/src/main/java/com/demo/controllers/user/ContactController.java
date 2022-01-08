package com.demo.controllers.user;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.demo.configurations.MyConstants;
import com.demo.models.Email;
import com.demo.services.user.EmailService;


@Controller
@RequestMapping(value = {"user/contact"})
public class ContactController {
	
	@Autowired
	private EmailService mailService;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@RequestMapping(value = { "", "index" }, method = RequestMethod.GET)
	public String register(ModelMap modelMap) {
		Email email = new Email();
		modelMap.put("email", email);
		return "user/contact/index";
	}

	@ResponseBody
	@RequestMapping(value = "sendContact", method = RequestMethod.POST)
	public String sendContact(ModelMap modelMap, @ModelAttribute("email") Email email) {
		
		SimpleMailMessage message = new SimpleMailMessage();
        
		String emailUser = "Email: " + email.getEmailUser();
		String phone = "Phone Number: " + email.getPhoneNumber();
		String fullname = "Fullname: " + email.getFullname();
		String content = "Content: \n" + email.getContent();
		
        message.setTo(MyConstants.MY_EMAIL);
        message.setSubject(email.getTitle());
        message.setText(fullname + "\n" + emailUser + "\n" + phone + "\n" + content);

        
     // Send Message!
        javaMailSender.send(message);
		
		email.setSendDate(new Date());
		mailService.save(email);
		if(mailService.save(email) != null) {
			modelMap.put("msg", "Thank you for sending feedback");
		} else {
			modelMap.put("msg", "Sending feedback fail");
		}
		
		return "redirect:/user/contact/success";
	}
	
	@RequestMapping(value = "success", method = RequestMethod.POST)
	public String success() {

		return "user/contact/success";
	}
}
