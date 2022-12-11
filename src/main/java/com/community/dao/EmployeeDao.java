package com.community.dao;

import com.community.util.SqlMapper;
import com.community.vo.Employee;

public class EmployeeDao {
	

	// 입력한 employee 객체를 DB에 저장하는 sql문
	public void insertEmployee(Employee employee) {
		SqlMapper.insert("employees.insertEmployee", employee);
	}
	
	// 직원번호empNo로 DB에 저장된 직원정보를 조회하는 sql문
	public Employee getEmployeeByNo(int empNo) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByNo", empNo);
	}
	
	// 직원폰번호phone으로 DB에 저장된 직원정보를 조회하는 sql문
	public Employee getEmployeeByPhone(String phone) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByPhone", phone);
	}
	
	// 입력한 employee객체를 DB에 업데이트하는 sql문
	public void updateEmployee(Employee employee) {
		SqlMapper.update("employees.updateEmployee", employee);
	}
	
	public Employee getEmployeeByNoJoin(int empNo) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByNoJoin", empNo);
	}
}
