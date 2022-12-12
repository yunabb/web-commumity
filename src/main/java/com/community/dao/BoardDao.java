package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Board;


public class BoardDao {
	
	private static BoardDao instance = new BoardDao();
	private BoardDao() {}
	public static BoardDao getInstance() {
		return instance;
	}
	
	public void insertBoard(Board board) {
		SqlMapper.insert("boards.insertBoard", board);
	}
	
	@SuppressWarnings("unchecked")
	public List<Board> getBoards() {
		return (List<Board>) SqlMapper.selectList("boards.getBoards");
	}
	
	@SuppressWarnings("unchecked")
	public List<Board> getBoardByNo(int boardNo) {
		return (List<Board>) SqlMapper.selectList("boards.getBoardByNo", boardNo);
	}
	
	public void updateBoard(Board board) {
		SqlMapper.update("boards.updateBoard", board);
	}
	
	public void deleteBoard(int boardNo) {
		SqlMapper.delete("boards.deleteBoard", boardNo);
	}

}
