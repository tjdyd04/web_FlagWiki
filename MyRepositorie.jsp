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
	#Search_Middle{
		margin-left: 250px;
		margin-right: 150px;
	}
	#line{
		border-bottom:1px solid #D5D5D5;
		border-top:1px solid #D5D5D5;
		}
	h1{
		font-size : 25px;
		font-weigh : bold;
	}
	
	h2{
		color : #6B66FF;
		font-weigh : bold;
	}
	
	#lside{
		width:40%;
		height: 1000px;
		margin-top : 12px;
		margin-left : 50px;
		float : left;
	}
	
	#rside{
		width:40%;
		height: 1000px;
		margin-top : 12px;
		float : right;
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
	
	.links{
		font-size: 22px;
		font-weight: bold;
		font-family: "궁서체";
		style = text-decoration:none;
		text-decoration: none;
	}
	
	.links:link {color:#4374D9;}
	.links:visited{color:#4374D9;}
	
	.Rlinks{
		font-size: 22px;
		font-weight: bold;
		font-family: "궁서체";
		style = text-decoration:none;
		text-decoration: none;
	}
	
	.Rlinks:link {color:#B8B8B8;}
	.Rlinks:visited{color:#B8B8B8;}
	
	
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
		<input class="Lbutton" type="button" value="로그인">
		<input class="Lbutton" type="button" value="회원가입">
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
	
<div id=Search_Middle align="left">
			
	<div id="lside">
			<br/><br/>
		<table cellspacing="0" cellpadding="25" summary="Contributions">
		
		<colgroup>
			<col width="800" />
		</colgroup>
		
		<tr>
			<td><a class="Rlinks" href="#" align="center"> Contributions </a> </td>
		</tr>
		
		<tbody>
			<%
			if (totalCount == 0) {
			%>
			<tr>
				<td align="center" colspan="5">등록된 게시물이 없습니다.</td>
			</tr>
			
			
			<%
			} else {
				int i = 0;
				while (rs.next()) {
					i++;
			%>
			
			
			<tr>
				<td id="line" ><a class="links" href="boardView.jsp?num=<%=rs.getInt("NUM")%>&amp;pageNum=<%=pageNumTemp%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>"><%=rs.getString("SUBJECT") %></a></td>
			</tr>
			
			<%
				}
			}
			rs.first();
			rs.previous();
			%>
			
		</tbody>
		<tfoot>
		

			<tr>
				<td align="center" colspan="5">
				
				
				<%
				searchText = URLEncoder.encode(searchText,"ISO-8859-1");
				// 페이지 네비게이터
				if(totalCount > 0) {
					int totalNumOfPage = (totalCount % listCount == 0) ? 
							totalCount / listCount :
							totalCount / listCount + 1;
					
					int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ?
							totalNumOfPage / pagePerBlock :
							totalNumOfPage / pagePerBlock + 1;
					
					int currentBlock = (pageNumTemp % pagePerBlock == 0) ? 
							pageNumTemp / pagePerBlock :
							pageNumTemp / pagePerBlock + 1;
					
					int startPage = (currentBlock - 1) * pagePerBlock + 1;
					int endPage = startPage + pagePerBlock - 1;
					
					if(endPage > totalNumOfPage)
						endPage = totalNumOfPage;
					boolean isNext = false;
					boolean isPrev = false;
					if(currentBlock < totalNumOfBlock)
						isNext = true;
					if(currentBlock > 1)
						isPrev = true;
					if(totalNumOfBlock == 1){
						isNext = false;
						isPrev = false;
					}
					StringBuffer sb = new StringBuffer();
					if(pageNumTemp > 1){
						
						sb.append("<a href=\"").append("MyRepositorie.jsp?pageNum=1&amp;searchType="+searchType+"&amp;searchText="+searchText );
						sb.append("\" title=\"<<\"><<</a>&nbsp;");
					}
					if (isPrev) {
						int goPrevPage = startPage - pagePerBlock;			
						sb.append("&nbsp;&nbsp;<a href=\"").append("MyRepositorie.jsp?pageNum="+goPrevPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\"<\"><</a>");
					} else {}
		
					for (int i = startPage; i <= endPage; i++) {
						if (i == pageNumTemp) {
							sb.append("<a href=\"#\"><strong>").append(i).append("</strong></a>&nbsp;&nbsp;");
						} else {
							sb.append("<a href=\"").append("MyRepositorie.jsp?pageNum="+i+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
							sb.append("\" title=\""+i+"\">").append(i).append("</a>&nbsp;&nbsp;");
						}
					}
					if (isNext) {
						int goNextPage = startPage + pagePerBlock;
	
						sb.append("<a href=\"").append("MyRepositorie.jsp?pageNum="+goNextPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\">\">></a>");
					} else {}
					if(totalNumOfPage > pageNumTemp){
						sb.append("&nbsp;&nbsp;<a href=\"").append("MyRepositorie.jsp?pageNum="+totalNumOfPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\">>\">>></a>");
					}
					out.print(sb.toString());
				}
				%>
				
				</td>
				
			</tr>
			
		</tfoot>
	
	</table>
		</div>
	</div>
	<div id="Search_Middle" align="right">
	<div id="rside" align="right">
			<br/><br/>
		<table cellspacing="0" cellpadding="25" summary="MyRepositories">
		
		<colgroup>
			<col width="800" />
		</colgroup>
		
		<tr>
			<td><a class="Rlinks" href="#" align="center"> MyRepositories </a> </td>
		</tr>
		
		<tbody>
			<%
			if (totalCount == 0) {
			%>
			<tr>
				<td align="center" colspan="5">등록된 게시물이 없습니다.</td>
			</tr>
			
			
			<%
			} else {
				int i = 0;
				while (rs.next()) {
					i++;
			%>
			
			
			<tr>
				<td id="line" ><a class="links" href="boardView.jsp?num=<%=rs.getInt("NUM")%>&amp;pageNum=<%=pageNumTemp%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>"><%=rs.getString("SUBJECT") %></a></td>
			</tr>
			
			<%
				}
			}
			rs.first();
			rs.previous();
			%>
			
		</tbody>
		<tfoot>
		

			<tr>
				<td align="center" colspan="5">
				
				
				<%
				searchText = URLEncoder.encode(searchText,"ISO-8859-1");
				// 페이지 네비게이터
				if(totalCount > 0) {
					int totalNumOfPage = (totalCount % listCount == 0) ? 
							totalCount / listCount :
							totalCount / listCount + 1;
					
					int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ?
							totalNumOfPage / pagePerBlock :
							totalNumOfPage / pagePerBlock + 1;
					
					int currentBlock = (pageNumTemp % pagePerBlock == 0) ? 
							pageNumTemp / pagePerBlock :
							pageNumTemp / pagePerBlock + 1;
					
					int startPage = (currentBlock - 1) * pagePerBlock + 1;
					int endPage = startPage + pagePerBlock - 1;
					
					if(endPage > totalNumOfPage)
						endPage = totalNumOfPage;
					boolean isNext = false;
					boolean isPrev = false;
					if(currentBlock < totalNumOfBlock)
						isNext = true;
					if(currentBlock > 1)
						isPrev = true;
					if(totalNumOfBlock == 1){
						isNext = false;
						isPrev = false;
					}
					StringBuffer sb = new StringBuffer();
					if(pageNumTemp > 1){
						
						sb.append("<a href=\"").append("MyRepositorie.jsp?pageNum=1&amp;searchType="+searchType+"&amp;searchText="+searchText );
						sb.append("\" title=\"<<\"><<</a>&nbsp;");
					}
					if (isPrev) {
						int goPrevPage = startPage - pagePerBlock;			
						sb.append("&nbsp;&nbsp;<a href=\"").append("MyRepositorie.jsp?pageNum="+goPrevPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\"<\"><</a>");
					} else {}
		
					for (int i = startPage; i <= endPage; i++) {
						if (i == pageNumTemp) {
							sb.append("<a href=\"#\"><strong>").append(i).append("</strong></a>&nbsp;&nbsp;");
						} else {
							sb.append("<a href=\"").append("MyRepositorie.jsp?pageNum="+i+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
							sb.append("\" title=\""+i+"\">").append(i).append("</a>&nbsp;&nbsp;");
						}
					}
					if (isNext) {
						int goNextPage = startPage + pagePerBlock;
	
						sb.append("<a href=\"").append("MyRepositorie.jsp?pageNum="+goNextPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\">\">></a>");
					} else {}
					if(totalNumOfPage > pageNumTemp){
						sb.append("&nbsp;&nbsp;<a href=\"").append("MyRepositorie.jsp?pageNum="+totalNumOfPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\">>\">>></a>");
					}
					out.print(sb.toString());
				}
				%>
				
		
				</td>
			</tr>
		</tfoot>
		
	</table>
	</div>
	</div>
</body>
</html>
<%
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try{rs.close();} catch(SQLException e){} 
		if (pstmt != null) try{pstmt.close();} catch(SQLException e){} 
		if (conn != null) try{conn.close();} catch(SQLException e){}
	}
%>