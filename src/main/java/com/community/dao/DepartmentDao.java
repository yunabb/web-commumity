package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Department;

public class DepartmentDao {
	
	@SuppressWarnings("unchecked")
	public List<Department> getAllDepts() {
		return (List<Department>) SqlMapper.selectList("departments.getAllDepts");
	}
	
	public Department getNameByEmpNo(int empNo) {
		return (Department) SqlMapper.selectOne("departments.getNameByEmpNo", empNo);
	}
	
	public Department getDeptByNo(int no) {
		return (Department) SqlMapper.selectOne("departments.getDeptByNo", no);
	}
	
	public void insertDept(Department dept) {
		SqlMapper.insert("departments.insertDept", dept);
	}
	
	public void updateDept(Department dept) {
		SqlMapper.update("departments.updateDept", dept);
	}

}
