<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	String user = (String)session.getAttribute("user");
	String tree = request.getParameter("tree");
	tree = new String(request.getParameter("tree").getBytes("iso-8859-1"), "UTF-8");//get 방식의경우
	String b_user = request.getParameter("b_user");
	String version = request.getParameter("version");
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String tree_idx="";
	String page_mem="";	
	
	String search_idx_sql = "SELECT * FROM tree WHERE title=? AND user=?";
	String comp_mem_sql = "SELECT * FROM tree_member WHERE idx_tree=? AND user=?";
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(search_idx_sql);
		pstmt.setString(1,tree);
		pstmt.setString(2,b_user);
		rs = pstmt.executeQuery();
		while(rs.next()){
			tree_idx=rs.getString(1);
		}
		rs.close();
		pstmt.close();
		
		pstmt = conn.prepareStatement(comp_mem_sql);
		pstmt.setString(1,tree_idx);
		pstmt.setString(2,user);
		rs = pstmt.executeQuery();

		while(rs.next()){
			page_mem=rs.getString(3);
		}

	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	
<script>
	var user ="<%=user%>";
	var tree ="<%=tree%>";
	var b_user ="<%=b_user%>";
	var version="<%=version%>";
	var page_mem="<%=page_mem%>";
	var jidx;
	if(page_mem=="0" || page_mem=="1"){
		var para = encodeURIComponent(tree);
		window.location='board.jsp?tree=' + para +'&b_user=' +b_user;
	}
</script>
