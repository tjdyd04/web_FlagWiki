<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String tree = request.getParameter("tree");
	String b_user = request.getParameter("b_user");
	String mem = request.getParameter("val");
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String tree_idx ="";
	String search_idx = "SELECT * FROM tree WHERE title=? AND user=?";
	String insert_mem = "INSERT INTO tree_member(idx_tree,user,rank) VALUES(?,?,?)";
	String insert_history = "INSERT INTO history(tree,b_user,user,content,type) VALUES(?,?,?,?,?)";
	String templete = "<span class=\"label label-default\">" + user + "</span>님이 <span class=\"label label-success\">" + tree  + "</span>에 <span class=\"label label-primary\">" + mem + "</span> 님을 <strong>협력자</strong>로 추가하였습니다.";
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(search_idx);
		pstmt.setString(1,tree);
		pstmt.setString(2,b_user);
		rs = pstmt.executeQuery();
		while(rs.next()){
			tree_idx=rs.getString(1);
		}
		
		pstmt.close();

		pstmt = conn.prepareStatement(insert_mem);
		pstmt.setString(1,tree_idx);
		pstmt.setString(2,mem);
		pstmt.setString(3,"1");
		pstmt.executeUpdate();
		pstmt.close();

		pstmt = conn.prepareStatement(insert_history);
		pstmt.setString(1,tree);
		pstmt.setString(2,b_user);
		pstmt.setString(3,user);
		pstmt.setString(4,templete);
		pstmt.setString(5,"mem");
		pstmt.executeUpdate();


	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	
