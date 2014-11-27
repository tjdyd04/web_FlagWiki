<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.net.URLEncoder; " %>
<%


	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int pageNumTemp = 1;
	int listCount = 5;
	int pagePerBlock = 5;
	int count = 0;
	
	int listCount_Log = 10;
	int pagePerBlock_Log = 10;
	
	
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
				"jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");
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
		pstmt = conn.prepareStatement("SELECT NUM, SUBJECT, WRITER, REG_DATE, HIT,MOD_DATE FROM BOARD "+whereSQL+" ORDER BY NUM DESC LIMIT ?, ?");
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
<title>게시판 목록</title>
<style type="text/css">
	* {font-size: 9pt;}
	p {width: 1050px; text-align: right;}
	table thead tr th {background-color: gray;}
	#Search{
		height : 30px;
		border: 1px solid #cfcfcf;
	}
	#Main_Search{
		text-align: center;
	}
	#Main_Login{
		margin-left : 800px;
	}
	#Search_Top{
		margin-left: 300px;
		margin-right: 300px;
	}
	
	
	#line{
		border-bottom:1px solid #D5D5D5;
		border-top:1px solid #D5D5D5;
		}

	
	
	
	.link{
		font-size: 40px;
		font-weight: bold;
		font-family: "Comic Sans MS";
		style = text-decoration:none;
		text-decoration: none;
	}
	
	.link:link {color:#24A6BD;}
	.link:visited{color:#24A6BD;}	
	

	.links:link {color:#4374D9;}
	.links:visited{color:#4374D9;}
	
	
	#Security{
		margin-top : 30px;
		margin-left: 430px;
		font-size: 20px;
		
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
		return true;
	}
</script>
</head>
<body>
	
	<div id=Search_Top>
		</br>
		<span id="Main_Login">
		<div style="margin-top:33px;"></div>
		</span>

		<form name="searchForm" action="boardResult.jsp" method="get" onsubmit="return searchCheck();" >
			<a class="link" href = "boardList.jsp" >FlagWiki</a>&nbsp;&nbsp;&nbsp;	
			<select style="height:34px;" name="searchType">
			<option value="ALL" selected="selected">전체검색</option>
			<option value="SUBJECT" <%if ("SUBJECT".equals(searchType)) out.print("selected=\"selected\""); %>>제목</option>
			<option value="WRITER" <%if ("WRITER".equals(searchType)) out.print("selected=\"selected\""); %>>작성자</option>
			<option value="CONTENTS" <%if ("CONTENTS".equals(searchType)) out.print("selected=\"selected\""); %>>내용</option>	
			</select>
			<input type="text" id="Search" size="50" name="searchText" value="<%=searchTextUTF8%>" />
			<input class="button" type="submit" value="검색" />
		</form>
	</div>
	
	<br/><br/><hr></hr>
	
<form name="boardWriteForm" action="boardProcess.jsp" method="post" onsubmit="return boardWriteCheck();">
	<br/>
	<input type="hidden" name="mode" value="W" />
		<a style="margin-left:382px;">제목</a>
		<input type="text" id="Search" name="subject" size="80" maxlength="100" /><br/>
		<br/><br/>
		<div align="center">			
		<textarea name="contents" cols="80" rows="20"></textarea>
		</div>
		<br/><br/>
	<hr width="50%"/>
	
	<div id="Security" style="margin-left:500px">	
		<input type="radio" name=Security value=public checked>Public</input><br/>
		게시글을 모두가 볼수있게 공개합니다.<br/><br/>
		<input type="radio" name=Security value=private checked>Private</input><br/>
		허용한 사람들만 게시글을 볼수있습니다.
		<br/><br/><br/>
		<div style="margin-left : 450px;">
		<input class="button" type="button" value="목록" onclick="goUrl('RepositorieList.jsp');" />
		<input class="button" type="submit" value="만들기" />
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
