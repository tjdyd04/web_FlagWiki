<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String tree = request.getParameter("tree");
	String b_user = request.getParameter("b_user");
	String content = request.getParameter("val");
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String temp="";
	String tree_idx="";
	int flag_version;
	
	String search_idx = "SELECT * FROM tree WHERE title=? AND user=?";
	String sel_ins_sql = "INSERT INTO mainboard(title,content,branch,leaf,branch_num,leaf_num,user,tree,flag) SELECT title,content,branch,leaf,branch_num, leaf_num,user,tree,? FROM mainboard WHERE tree =? AND user =? AND flag=?";
	String tree_update="UPDATE tree SET total_flag=? WHERE title=? AND user=?"; 
	String flag_insert="INSERT INTO flag(tree_idx,version,comment,writer) VALUES(?,?,?,?)";
	
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
			temp=rs.getString(7);
		}
		flag_version = Integer.parseInt(temp);
		rs.close();
		pstmt.close();
		flag_version++;
		
		pstmt = conn.prepareStatement(sel_ins_sql);
		pstmt.setInt(1,flag_version);
		pstmt.setString(2,tree);
		pstmt.setString(3,b_user);
		flag_version--;
		pstmt.setInt(4,flag_version);
		pstmt.executeUpdate();
		
		pstmt.close();
		flag_version++;
		pstmt = conn.prepareStatement(tree_update);
		pstmt.setInt(1,flag_version);
		pstmt.setString(2,tree);
		pstmt.setString(3,b_user);
		pstmt.executeUpdate();


		pstmt = conn.prepareStatement(flag_insert);
		pstmt.setString(1,tree_idx);
		pstmt.setInt(2,flag_version);
		pstmt.setString(3,content);
		pstmt.setString(4,user);
		pstmt.executeUpdate();

	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	

