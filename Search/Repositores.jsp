<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <!-- 부트스트랩 -->
 <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>레파지토리 목록</title>
<link href="style/wikiflag.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="TopSearch.jsp" flush="true"/>
	<div id=Search_Middle align="right">
		<div id="aside">
		<jsp:include page="MyRepositorie.jsp" flush="true"/>
		<jsp:include page="Contribute.jsp" flush="true"/>
		</div>
	<jsp:include page="Log.jsp" flush="true"/>
	</div>
	
	</br></br></br>
	
</body>
</html>