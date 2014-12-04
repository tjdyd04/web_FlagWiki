<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String title = request.getParameter("rep");
	String view = request.getParameter("view");
	String desc = request.getParameter("desc");
	String cate = request.getParameter("cate");
	String idx="";
	String sql = "INSERT INTO mainboard(title,user,tree)" + " values(?,?,?)";  
	String tree_sql = "INSERT INTO tree(title,user,view,description,category)" + " values(?,?,?,?,?)";  
	String select_idx_sql = "SELECT * FROM tree WHERE title=? AND user=?";
	String tree_member_sql ="INSERT INTO tree_member(idx_tree,user)" + " values(?,?)";
	String insert_history = "INSERT INTO history(tree,b_user,user,content,type) VALUES(?,?,?,?,?)";
	String insert_flag ="INSERT INTO flag(tree_idx,version,comment,writer) VALUES(?,?,?,?)";
	String templete="";

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
	pstmt.setString(4,desc);
	pstmt.setString(5,cate);
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
	pstmt.close();

	pstmt = conn.prepareStatement(insert_flag);
	pstmt.setString(1,idx);
	pstmt.setString(2,"0");
	pstmt.setString(3,"초기상태");
	pstmt.setString(4,user);
	pstmt.executeUpdate();
	templete="<span class=\"label label-default\">" + user + "</span>님이 <span class=\"label label-success\">" + title + "</span>를 <strong>생성</strong> 하였습니다.";
	pstmt.close();
	pstmt = conn.prepareStatement(insert_history);
	pstmt.setString(1,title);
	pstmt.setString(2,user);
	pstmt.setString(3,user);
	pstmt.setString(4,templete);
	pstmt.setString(5,"add");
	pstmt.executeUpdate();

	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();} catch(SQLException e){}
		if(pstmt != null) try{pstmt.close();} catch(SQLException e){}
		if(rs != null) try{rs.close();} catch(SQLException e){}
	}

%>
<script>
alert('추가하였습니다');
window.location="/Search/Repositores.jsp";
</script>
