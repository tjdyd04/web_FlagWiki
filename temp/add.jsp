<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String title = request.getParameter("title");
	String view = request.getParameter("view");
	String idx="";
	String sql = "INSERT INTO mainboard(title,user,tree)" + " values(?,?,?)";  
	String tree_sql = "INSERT INTO tree(title,user,view)" + " values(?,?,?)";  
	String select_idx_sql = "SELECT * FROM tree WHERE title=? AND user=?";
	String tree_member_sql ="INSERT INTO tree_member(idx_tree,user)" + " values(?,?)";

	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                       
    String pw = "wjstks25@";            
	try{
    Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,title);
	pstmt.setString(2,user);
	pstmt.setString(3,title);
	pstmt.executeUpdate();
	pstmt.close();

	pstmt = conn.prepareStatement(tree_sql);
	pstmt.setString(1,title);
	pstmt.setString(2,user);
	pstmt.setString(3,view);
	pstmt.executeUpdate();
	pstmt.close();
	
	pstmt = conn.prepareStatement(select_idx_sql);
	pstmt.setString(1,title);
	pstmt.setString(2,user);
	rs = pstmt.executeQuery();
	while(rs.next()){
		idx = rs.getString(1);
	}
	pstmt.close();

	pstmt = conn.prepareStatement(tree_member_sql);
	pstmt.setString(1,idx);
	pstmt.setString(2,user);
	pstmt.executeUpdate();
	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();} catch(SQLException e){}
		if(pstmt != null) try{pstmt.close();} catch(SQLException e){}
		if(rs != null) try{rs.close();} catch(SQLException e){}
	}

%>
<script>
location.href="list.jsp"
</script>
