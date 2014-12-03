<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.net.URLEncoder; " %>
<%

// 사용할 객체 초기화
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
int pageidxTemp = 1;
int listCount = 10;
int pagePerBlock = 10;
int count = 0;

String whereSQL = "";
// 파라미터
String pageidx = request.getParameter("pageidx");
String searchType = request.getParameter("searchType");
String searchText = request.getParameter("searchText");
// 파라미터 초기화
if (searchText == null) {
	searchType = "";
	searchText = "";
}
if (pageidx != null) {
	pageidxTemp = Integer.parseInt(pageidx);
}
// 한글파라미터 처리
String searchTextUTF8 = new String(searchText.getBytes("ISO-8859-1"), "UTF-8");
// 데이터베이스 커넥션 및 질의문 실행
// 검색어 쿼리문 생성
if (!"".equals(searchText)) {
	if ("ALL".equals(searchType)) {
		whereSQL = " WHERE title LIKE CONCAT('%',?,'%') OR user LIKE CONCAT('%',?,'%') OR description LIKE CONCAT('%',?,'%')";
	} else if ("title".equals(searchType)) {
		whereSQL = " WHERE title LIKE CONCAT('%',?,'%') ";
	} else if ("user".equals(searchType)) {
		whereSQL = " WHERE user LIKE CONCAT('%',?,'%') ";
	} else if ("description ".equals(searchType)) {
		whereSQL = " WHERE CONTENTS LIKE CONCAT('%',?,'%') ";
	}
}
try {
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");
	// 게시물의 총 수를 얻는 쿼리 실행
	pstmt = conn.prepareStatement("SELECT COUNT(idx) AS TOTAL FROM tree" + whereSQL);
		
	if (!"".equals(whereSQL)) {
		if ("ALL".equals(searchType)) {
			pstmt.setString(1, searchTextUTF8);
			pstmt.setString(2, searchTextUTF8);
			pstmt.setString(3, searchTextUTF8);
		} else {
			pstmt.setString(1, searchTextUTF8);
		}
	}
	rs = pstmt.executeQuery();
	rs.next();
	int totalCount = rs.getInt("TOTAL");
	// 게시물 목록을 얻는 쿼리 실행
	pstmt = conn.prepareStatement("SELECT idx, title, user,view,description FROM tree "+whereSQL+" ORDER BY idx DESC LIMIT ?, ?");
	if (!"".equals(whereSQL)) {
		// 전체검색일시
		if ("ALL".equals(searchType)) {
			pstmt.setString(1, searchTextUTF8);
			pstmt.setString(2, searchTextUTF8);
			pstmt.setString(3, searchTextUTF8);
			pstmt.setInt(4, listCount * (pageidxTemp-1));
			pstmt.setInt(5, listCount);			
		} else {
			pstmt.setString(1, searchTextUTF8);
			pstmt.setInt(2, listCount * (pageidxTemp-1));
			pstmt.setInt(3, listCount);			
		}
	} else {	
		pstmt.setInt(1, listCount * (pageidxTemp-1));
		pstmt.setInt(2, listCount);
	}
	
	rs = pstmt.executeQuery();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<link href="wikiflag.css rel="stylesheet" type="text/css">

<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 검색 폼 체크
	function searchCheck() {
		var form = document.searchForm;
		if (form.searchText.value == '') {
			alert('검색어를 입력하세요.');
			form.searchText.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	
	<div id=Search_Top>
		</br>
		<span id="Main_Login">
		<input class="btn btn-default" type="button" value="로그인">
		<input class="btn btn-default" type="button" value="회원가입">
		</span>

		<form name="searchForm" action="Res.jsp" method="get" onsubmit="return searchCheck();" >
			<a class="link" href ="#" >FlagWiki</a>&nbsp;&nbsp;&nbsp;	
			<select style="height:34px;" name="searchType">
			<option value="ALL" selected="selected">전체검색</option>
			<option value="title" <%if ("title".equals(searchType)) out.print("selected=\"selected\""); %>>제목</option>
			<option value="user" <%if ("user".equals(searchType)) out.print("selected=\"selected\""); %>>작성자</option>
			<option value="description" <%if ("description ".equals(searchType)) out.print("selected=\"selected\""); %>>설명</option>	
			</select>
			<input type="text" id="Search" size="50" name="searchText" value="<%=searchTextUTF8%>" />
			<input class="btn btn-default" type="submit" value="검색" />
			
		</form>
	</div>
	<br/><br/><hr></hr>
</body>
<%
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try{rs.close();} catch(SQLException e){} 
		if (pstmt != null) try{pstmt.close();} catch(SQLException e){} 
		if (conn != null) try{conn.close();} catch(SQLException e){}
	}
%>
	
		
