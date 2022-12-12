package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Department;

public class DepartmentDao {
	
	@SuppressWarnings("unchecked")
	public List<Department> getAllDepts() {
		return (List<Department>) SqlMapper.selectList("departments.getAllDepts");
	}
	
	public Department getDeptByNo(int no) {
		return (Department) SqlMapper.selectOne("departments.getDeptByNo", no);
	}

}
