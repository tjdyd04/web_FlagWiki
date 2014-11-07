<%@ page language="java" contentType="text/html; charset=UTF-8"
    page import = "java.sql.*" pageEncoding="UTF-8"%>

<%--페이지시팅1, MySQL연결 --%>
<%

String PageNum_temp = request.getParameter("PageNum");	// 문자열 생성후 PageNum파라미터값 받음
if(PageNum_temp == null)
	PageNum_temp = "1"; // 만약 값이 NULL이면 초기값 1페이지로 세팅
	int PageNum = Integer.parseInt(PageNum_temp);
	int PagePerNum = 10;	// 페이지당 게시물 갯수
	int totalData = 0; // 전체 행의 갯수
	String searchKey = "";	//검색할 문자열
	
try{	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");
	Statement stmt = conn.createStatement();
	
	String sql = "SELECT * FROM jykim limit" + ((PageNum-1)*PagePerNum)+"," + (PagePerNum)
					+ ";";	// limit 쿼리문
	ResultSet rs = stmt.executeQuery(sql);
%>

<%
	searchKey = request.getParameter("searchkey");
%>

<!-- 행 내용 table 처리 -->
<% 
while(rs.next()){
%>

<!--  ?? -->
<tr align="center">
<td><a href="test.jsp?searchKey=<%=rs.getString(1) %>"></a><td><!--  -->
<%=rs.getString(2) %>
<!--  ?? -->

<br><br>

<%--페이징세팅2, href 하단 네비게이션 처리부분 --%>
<%
int PageBlock = 5 // 페이징 블럿 갯수 (5개씩)
int pageCount = totalData/PagePerNum + (totalData%PagePerNum==0?0:1); // 페이징 갯수 전체 카운트
int startPage = (PageBlock*((PageNum-1)/PageBlock))+1;	//시작페이지
int endPage = startPage + (PageBock-1);	// 끝페이지

if(pageCount < endPage) endPage = pageCount;	//마지막 페이지가 전체 페이징 갯수 보다 크면 값을 같게 한다.

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Flagwiki Main Page</title>
</head>
<body>
	<style type=text/css>
	#Search{
		height : 30px;
		border: 1px solid #cfcfcf;
	}
	#Main_Search{
		margin-bottom: 150px;
		text-align: center;
	}
	#Main_Login{
		margin-bottom: 300px;
		margin-left : 1100px;
	}
	h1{
		font-size: 100px;
		font-weight: bold;
		font-family: "맑은고딕";
		color : #8041D9;
	}
	</style>
</head>
<body>
	<br/><br/><span id="Main_Login">
	<input type="button" value="로그인">
	<input type="button" value="회원가입">
	</span>
	<p id=Main_Search></p>
	<span id="Main_Search">	
	<h1>Flag Wiki</h1>
	<form action="searchlist.jsp" method="post">
	<input type="hidden" name="ie" value="utf8">
	<input id="Search" name="searchKey" type="text" size="50"/>
	<input id="Search" type="submit" value="검색"/>
	</span>
	<br/><br/><br/><br/>
	
	
	</form>


</body>
</html>