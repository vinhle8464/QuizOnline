package com.demo.services.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;

import com.demo.models.Salary;

public interface SalaryServiceAdmin {

	
	public List<Salary> findAllSalary();

	public Salary findNewestSalary();
	
	public Salary findNewestSalaryByAccountId(int accountId); 
	
	public Salary findById(int id);

	public Salary create(Salary Salary);

	public Salary update(Salary Salary);

	public void deleteById(int id);

//	public SalaryAjax findByIdAjax(int SalaryId);
//	

	public Page<Salary> getPage(int currentPage, int pageSize, String sort);

}