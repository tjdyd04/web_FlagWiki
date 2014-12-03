<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String tree = request.getParameter("tree");
	String b_user = request.getParameter("b_user");
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String mem_idx ="no";
	String tree_idx ="";
	String search_mem = "SELECT tree.title,tree.user,tree.view,tree_member.rank, tree_member.user, tree_member.idx FROM tree RIGHT OUTER JOIN tree_member ON tree.idx = tree_member.idx_tree WHERE tree_member.user=? AND tree.title=?"; 
	String search_idx = "SELECT * FROM tree WHERE title=? AND user=?";
	String insert_mem = "INSERT INTO tree_member(idx_tree,user,rank) VALUES(?,?,?)";
	String delete_mem = "DELETE FROM tree_member WHERE idx=?";
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(search_mem);
		pstmt.setString(1,user);
		pstmt.setString(2,tree);
		rs = pstmt.executeQuery();
		while(rs.next()){
			mem_idx = rs.getString(6);
		}
		rs.close();
		pstmt.close();

		pstmt = conn.prepareStatement(search_idx);
		pstmt.setString(1,tree);
		pstmt.setString(2,b_user);
		rs = pstmt.executeQuery();
		while(rs.next()){
			tree_idx=rs.getString(1);
		}

		pstmt.close();

		if(mem_idx.equals("no")){
			pstmt = conn.prepareStatement(insert_mem);
			pstmt.setString(1,tree_idx);
			pstmt.setString(2,user);
			pstmt.setString(3,"2");
			pstmt.executeUpdate();
			pstmt.close();
		}else{
			pstmt = conn.prepareStatement(delete_mem);
			pstmt.setString(1,mem_idx);
			pstmt.executeUpdate();
			pstmt.close();
		}
	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	
