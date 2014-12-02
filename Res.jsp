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
			whereSQL = " WHERE title LIKE CONCAT('%',?,'%') OR user LIKE CONCAT('%',?,'%') OR description LIKE CONCAT('%',?,'%') ";
		} else if ("title".equals(searchType)) {
			whereSQL = " WHERE title LIKE CONCAT('%',?,'%') ";
		} else if ("user".equals(searchType)) {
			whereSQL = " WHERE user LIKE CONCAT('%',?,'%') ";
		} else if ("CONTENTS".equals(searchType)) {
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
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <!-- 부트스트랩 -->
 <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<link href="wikiflag.css" rel="stylesheet" type="text/css"></link>
<title>검색결과 목록</title>
</head>
<body>
	
	<jsp:include page="Top.jsp" flush="true"/>
	
<div id=Search_Middle>
			<h1> We've found <%=totalCount%> results</h1>
			<br/><br/>
			<table cellspacing="0" cellpadding="25" summary="검색결과">
		
		<colgroup>
			<col width="130" />
			<col width="700" />
			<col width="300" />
			<col width="200" />
			<col width="110" />
		</colgroup>
		
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
				<td id="line" align="left"> <%=totalCount - i + 1 - (pageidxTemp - 1) * listCount %></td>
				<td id="line" ><a class="links" href="boardView.jsp?idx=<%=rs.getInt("idx")%>&amp;pageidx=<%=pageidxTemp%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>"><%=rs.getString("title") %></a></td>
				<td id="line" align="left">설명<br/> <%=rs.getString("description") %></td>
				<td id="line" align="left">ID<br/> <%=rs.getString("user") %></td>
				<td id="line" align="left">조회수<%=rs.getInt("view") %></td>
			</tr>
			
			<%
				}
			}
			%>
		</tbody>
		<tfoot>
		

			<tr>
				<td align="center" colspan="5">
				
				
				<%
				searchText = URLEncoder.encode(searchText,"ISO-8859-1");
				// 페이지 네비게이터
				if(totalCount > 0) {
					int totalidxOfPage = (totalCount % listCount == 0) ? 
							totalCount / listCount :
							totalCount / listCount + 1;
					
					int totalidxOfBlock = (totalidxOfPage % pagePerBlock == 0) ?
							totalidxOfPage / pagePerBlock :
							totalidxOfPage / pagePerBlock + 1;
					
					int currentBlock = (pageidxTemp % pagePerBlock == 0) ? 
							pageidxTemp / pagePerBlock :
							pageidxTemp / pagePerBlock + 1;
					
					int startPage = (currentBlock - 1) * pagePerBlock + 1;
					int endPage = startPage + pagePerBlock - 1;
					
					if(endPage > totalidxOfPage)
						endPage = totalidxOfPage;
					boolean isNext = false;
					boolean isPrev = false;
					if(currentBlock < totalidxOfBlock)
						isNext = true;
					if(currentBlock > 1)
						isPrev = true;
					if(totalidxOfBlock == 1){
						isNext = false;
						isPrev = false;
					}
					StringBuffer sb = new StringBuffer();
					if(pageidxTemp > 1){
						
						sb.append("<a href=\"").append("boardResult.jsp?pageidx=1&amp;searchType="+searchType+"&amp;searchText="+searchText );
						sb.append("\" title=\"<<\"><<</a>&nbsp;");
					}
					if (isPrev) {
						int goPrevPage = startPage - pagePerBlock;			
						sb.append("&nbsp;&nbsp;<a href=\"").append("boardResult.jsp?pageidx="+goPrevPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\"<\"><</a>");
					} else {}
		
					for (int i = startPage; i <= endPage; i++) {
						if (i == pageidxTemp) {
							sb.append("<a href=\"#\"><strong>").append(i).append("</strong></a>&nbsp;&nbsp;");
						} else {
							sb.append("<a href=\"").append("boardResult.jsp?pageidx="+i+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
							sb.append("\" title=\""+i+"\">").append(i).append("</a>&nbsp;&nbsp;");
						}
					}
					if (isNext) {
						int goNextPage = startPage + pagePerBlock;
	
						sb.append("<a href=\"").append("boardResult.jsp?pageidx="+goNextPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\">\">></a>");
					} else {}
					if(totalidxOfPage > pageidxTemp){
						sb.append("&nbsp;&nbsp;<a href=\"").append("boardResult.jsp?pageidx="+totalidxOfPage+"&amp;searchType="+searchType+"&amp;searchText="+searchText);
						sb.append("\" title=\">>\">>></a>");
					}
					out.print(sb.toString());
				}
				%>
				</td>
			</tr>
		</tfoot>
	</table>
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