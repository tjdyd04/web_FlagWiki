<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 사용할 객체 초기화
	String url = "jdbc:mysql://localhost:3306/jykim";        
    	String id = "jykim";                                                    
   	String pw = "wjstks25@"; 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int pageNumTemp = 1;
	int listCount = 10;
	int pagePerBlock = 10;
	String whereSQL = "";
	// 파라미터
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	// 파라미터 초기화
	if (searchText == null) {
		searchType = "";
		searchText = "";
	}
	if (pageNum != null) {
		pageNumTemp = Integer.parseInt(pageNum);
	}
	// 한글파라미터 처리
	String searchTextUTF8 = new String(searchText.getBytes("ISO-8859-1"), "UTF-8");
	// 데이터베이스 커넥션 및 질의문 실행
	// 검색어 쿼리문 생성
	if (!"".equals(searchText)) {
		if ("ALL".equals(searchType)) {
			whereSQL = " WHERE title LIKE CONCAT('%',?,'%') OR user LIKE CONCAT('%',?,'%') OR description LIKE CONCAT('%',?,'%') ";
		} else if ("title".equals(searchType)) {
			whereSQL = " WHERE title LIKE CONCAT('%',?,'%') ";
		} else if ("user".equals(searchType)) {
			whereSQL = " WHERE user LIKE CONCAT('%',?,'%') ";
		} else if ("description".equals(searchType)) {
			whereSQL = " WHERE description LIKE CONCAT('%',?,'%') ";
		}
	}
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		
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
				pstmt.setInt(4, listCount * (pageNumTemp-1));
				pstmt.setInt(5, listCount);			
			} else {
				pstmt.setString(1, searchTextUTF8);
				pstmt.setInt(2, listCount * (pageNumTemp-1));
				pstmt.setInt(3, listCount);			
			}
		} else {	
			pstmt.setInt(1, listCount * (pageNumTemp-1));
			pstmt.setInt(2, listCount);
		}
		rs = pstmt.executeQuery();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>Main page</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <!-- 부트스트랩 -->
 <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="Main.css" rel="stylesheet" type="text/css">
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
		else
		{
			location.href=boardResult.jsp;
			return true;
		}
	}
</script>
</head>
<body>

	<!-- 머리 폼 -->
	<jsp:include page="../Head_Navigation/head.jsp" flush="false" />
	
	<br/>
	
	<form name="searchForm" action="boardResult.jsp" method="get" onsubmit="return searchCheck();" >	
	<div id="Center"><img src="//lh3.ggpht.com/UJd2DDqEYGe-Z1co3kQl0Erc20K5rv0tWJiBvaZbWdoh2qOltYCOu4_rglQijnPJ-ypXLeosuFP-orUTVyk8u3a4-1BNdYVmjjskGv9I=s660" >	
	</div>
		<a id="link" href=# /><h1>Flag Wiki</h1>
		<div id="Main_Search">
		<select style="height:31px;" name="searchType">
			<option value="ALL" selected="selected">전체검색</option>
			<option value="title" <%if ("title".equals(searchType)) out.print("selected=\"selected\""); %>>제목</option>
			<option value="user" <%if ("user".equals(searchType)) out.print("selected=\"selected\""); %>>작성자</option>
			<option value="description" <%if ("description".equals(searchType)) out.print("selected=\"selected\""); %>>설명</option>
		</select>
		<input type="text" id="Search" size="50" name="searchText" value="<%=searchTextUTF8%>" />
		<input class="btn btn-default" type="submit" value="검색" />

		</div>
	</form>
		
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
%>