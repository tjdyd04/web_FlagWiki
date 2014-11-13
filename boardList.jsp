<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 사용할 객체 초기화
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
			whereSQL = " WHERE SUBJECT LIKE CONCAT('%',?,'%') OR WRITER LIKE CONCAT('%',?,'%') OR CONTENTS LIKE CONCAT('%',?,'%') ";
		} else if ("SUBJECT".equals(searchType)) {
			whereSQL = " WHERE SUBJECT LIKE CONCAT('%',?,'%') ";
		} else if ("WRITER".equals(searchType)) {
			whereSQL = " WHERE WRITER LIKE CONCAT('%',?,'%') ";
		} else if ("CONTENTS".equals(searchType)) {
			whereSQL = " WHERE CONTENTS LIKE CONCAT('%',?,'%') ";
		}
	}
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://127.0.0.1:3306/stone", "root", "1234");
		// 게시물의 총 수를 얻는 쿼리 실행
		pstmt = conn.prepareStatement("SELECT COUNT(NUM) AS TOTAL FROM BOARD" + whereSQL);
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
		pstmt = conn.prepareStatement("SELECT NUM, SUBJECT, WRITER, REG_DATE, HIT FROM BOARD "+whereSQL+" ORDER BY NUM DESC LIMIT ?, ?");
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
<style type="text/css">
	* {font-size: 9pt;}
	p {width: 600px; text-align: right;}
	table thead tr th {background-color: gray;}
	#Center{
		text-align : center;
	}
	#Search{
		height : 30px;
		border: 1px solid #cfcfcf;
	}
	#Main_Search{
		margin-bottom: 180px;
		text-align: center;
	}
	#Main_Login{
		margin-bottom: 300px;
		margin-left : 1100px;
	}
	#link{
		font-size: 50px;
		font-weight: bold;
		font-family: "맑은고딕";
		color = "#8041D9";
		link = "#8041D9";
		alink = "#8041D9";
		vlink = "#8041D9";
		style = text-decoration:none;
		text-decoration: none;
	}
	h1{
		font-size: 50px;
		font-weight: bold;
		font-family: "Comic Sans MS";
		color : #24A6BD;
		text-align : center;
	}
	.button {
   border: 1px solid #858f94;
   background: #ffffff;
   background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#ffffff));
   background: -webkit-linear-gradient(top, #ffffff, #ffffff);
   background: -moz-linear-gradient(top, #ffffff, #ffffff);
   background: -ms-linear-gradient(top, #ffffff, #ffffff);
   background: -o-linear-gradient(top, #ffffff, #ffffff);
   background-image: -ms-linear-gradient(top, #ffffff 0%, #ffffff 100%);
   padding: 10px 20px;
   -webkit-border-radius: 8px;
   -moz-border-radius: 8px;
   border-radius: 8px;
   -webkit-box-shadow: rgba(255,255,255,0.4) 0 1px 0, inset rgba(255,255,255,0.4) 0 1px 0;
   -moz-box-shadow: rgba(255,255,255,0.4) 0 1px 0, inset rgba(255,255,255,0.4) 0 1px 0;
   box-shadow: rgba(255,255,255,0.4) 0 1px 0, inset rgba(255,255,255,0.4) 0 1px 0;
   text-shadow: #7ea4bd 0 1px 0;
   color: #06426c;
   font-size: 16px;
   font-family: helvetica, serif;
   text-decoration: none;
   vertical-align: middle;
   }
.button:hover {
   border: 1px solid #0a3c59;
   text-shadow: #1e4158 0 1px 0;
   background: #9ba3a8;
   background: -webkit-gradient(linear, left top, left bottom, from(#b4bdc2), to(#9ba3a8));
   background: -webkit-linear-gradient(top, #b4bdc2, #9ba3a8);
   background: -moz-linear-gradient(top, #b4bdc2, #9ba3a8);
   background: -ms-linear-gradient(top, #b4bdc2, #9ba3a8);
   background: -o-linear-gradient(top, #b4bdc2, #9ba3a8);
   background-image: -ms-linear-gradient(top, #b4bdc2 0%, #9ba3a8 100%);
   color: #fff;
   }
   .Lbutton {
   border: 1px solid #707375;
   background: #ffffff;
   background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#ffffff));
   background: -webkit-linear-gradient(top, #ffffff, #ffffff);
   background: -moz-linear-gradient(top, #ffffff, #ffffff);
   background: -ms-linear-gradient(top, #ffffff, #ffffff);
   background: -o-linear-gradient(top, #ffffff, #ffffff);
   background-image: -ms-linear-gradient(top, #ffffff 0%, #ffffff 100%);
   padding: 10px 20px;
   -webkit-border-radius: 8px;
   -moz-border-radius: 8px;
   border-radius: 8px;
   -webkit-box-shadow: rgba(255,255,255,0.4) 0 1px 0, inset rgba(255,255,255,0.4) 0 1px 0;
   -moz-box-shadow: rgba(255,255,255,0.4) 0 1px 0, inset rgba(255,255,255,0.4) 0 1px 0;
   box-shadow: rgba(255,255,255,0.4) 0 1px 0, inset rgba(255,255,255,0.4) 0 1px 0;
   text-shadow: #7ea4bd 0 1px 0;
   color: #06426c;
   font-size: 12px;
   font-family: helvetica, serif;
   text-decoration: none;
   vertical-align: middle;
   }
.Lbutton:hover {
   border: 1px solid #0a3c59;
   text-shadow: #1e4158 0 1px 0;
   background: #9ba3a8;
   background: -webkit-gradient(linear, left top, left bottom, from(#b4bdc2), to(#9ba3a8));
   background: -webkit-linear-gradient(top, #b4bdc2, #9ba3a8);
   background: -moz-linear-gradient(top, #b4bdc2, #9ba3a8);
   background: -ms-linear-gradient(top, #b4bdc2, #9ba3a8);
   background: -o-linear-gradient(top, #b4bdc2, #9ba3a8);
   background-image: -ms-linear-gradient(top, #b4bdc2 0%, #9ba3a8 100%);
   color: #fff;
   }
</style>
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
			location.href=boardResult.jsp;
		return true;
	}
</script>
</head>
<body>
	
	<br/><span id="Main_Login">
		<input class="Lbutton" type="button" value="로그인">
		<input class="Lbutton"type="button" value="회원가입">
		</span>
	
	<form name="searchForm" action="boardResult.jsp" method="get" onsubmit="return searchCheck();" >	
	<div id="Center"><img src="//lh3.ggpht.com/UJd2DDqEYGe-Z1co3kQl0Erc20K5rv0tWJiBvaZbWdoh2qOltYCOu4_rglQijnPJ-ypXLeosuFP-orUTVyk8u3a4-1BNdYVmjjskGv9I=s660" >	
	</div>
		<a id="link" href=# /><h1>Flag Wiki</h1>
		<div id="Main_Search">
		<select style="height:34px;" name="searchType">
			<option value="ALL" selected="selected">전체검색</option>
			<option value="SUBJECT" <%if ("SUBJECT".equals(searchType)) out.print("selected=\"selected\""); %>>제목</option>
			<option value="WRITER" <%if ("WRITER".equals(searchType)) out.print("selected=\"selected\""); %>>작성자</option>
			<option value="CONTENTS" <%if ("CONTENTS".equals(searchType)) out.print("selected=\"selected\""); %>>내용</option>
		</select>
		<input type="text" id="Search" size="50" name="searchText" value="<%=searchTextUTF8%>" />
		<input class="button" type="submit" value="검색">
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