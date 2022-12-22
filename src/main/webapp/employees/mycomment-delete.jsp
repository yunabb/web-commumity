<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.dao.StoryPostDao"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.dao.BoardDao"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.vo.Post"%>
<%@page import="java.sql.Date"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Review"%>
<%@page import="com.community.dao.ReviewDao"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int reviewNo = StringUtils.stringToInt(request.getParameter("reviewNo"));
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	PostDao postDao = PostDao.getInstance();
	BoardDao boardDao = BoardDao.getInstance();
	Review review = reviewDao.getReview(reviewNo);
	Post post = review.getPost();
	Board board = boardDao.getBoardByPostNo(post.getPostNo());
	
	review.setDeleted("Y");
	
	reviewDao.updateReview(review);
	
	String category = null;
	if(board.getBoardNo() == 100) {
		NoticeDao noticeDao = NoticeDao.getInstance();
		Notice notice = noticeDao.getNoticeByPostNo(post.getPostNo());
		
		notice.setCommentCount(notice.getCommentCount() - 1);
		noticeDao.updateNotice(notice);
		
		response.sendRedirect("mycomments.jsp");
	} else if(board.getBoardNo() == 101) {
		category = "file";
	} else if(board.getBoardNo() == 103) {
		category = "temp";
	} else if(board.getBoardNo() == 104) {
		StoryPostDao storyPostDao = StoryPostDao.getInstance();
		StoryPost story = storyPostDao.getStoryPostByNo(post.getPostNo());
		
		story.setCommentCount(story.getCommentCount() - 1);
		
		storyPostDao.updateStoryPost(story);
		
		response.sendRedirect("mycomments.jsp");
	} else if(board.getBoardNo() == 105) {
		QuestionDao questionDao = QuestionDao.getInstance();
		Question question = questionDao.getQuestionByNo(post.getPostNo());
		
		question.setCommentCount(question.getCommentCount() - 1);
		
		questionDao.updateQuestion(question);
		
		response.sendRedirect("mycomments.jsp");
	}
	
	
%>