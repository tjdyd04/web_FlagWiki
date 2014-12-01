<%@ page info="user_email check" errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*,java.io.*,java.net.*" %>

<%
    Connection conn = null;
    Statement  stmt = null;
    ResultSet  rs   = null;

    // User Email값 받기
    String email = request.getParameter("email");
    String query  = new String();
    int check_count = 0;  // 해당레코드 카운드

    try {

    	Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");
        stmt = conn.createStatement(); // 커넥션으로부터 Statement 생성

        // 아이디 조회
        query = "Select count(*) as count from member where email='" + email + "'";
        rs = stmt.executeQuery(query);
        rs.next();
        check_count = rs.getInt("count");

    } catch(SQLException e){
 	   e.printStackTrace();
    } finally {
        conn.close();
        stmt.close();
        rs.close();
    }
%>

<html>
<head>
<title>이메일 중복검사</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%-- 외부 스타일시트 지정 --%>
<link rel="StyleSheet" href="style.css" type="text/css">
<%-- 자바스크립트 영역 시작 --%>
<script language="JavaScript">

         //메일 유효성체크
function checkValue(em) { 
  
  var email = em;  
  var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a- z]{2})?)$/;   
  
  if(regex.test(email) === false) {  
      alert("잘못된 이메일 형식입니다.");  
      return false;  
  } else {  
      return true;  
  }  

}

function checkEnd(){
    var form = document.email_check;

    opener.memberForm.email.value = form.email.value;
    opener.memberForm.user_id.focus();
  	window.close();
}

function doCheck(){
    var form = document.email_check;

    if(!checkValue(form.email){
        return;
    }

    form.submit();
}


</script>


<form name="email_check" method="post" action="check_emailDB.jsp">
  <input type="hidden" name="check_count" value="<%=check_count%>">
  <table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td> 이메일 주소를 입력해주세요.</td>
    </tr>
  </table>
  <table width="500" border="0" bgcolor="#B6C1D6" height="39" align="center">
    <tr> 
      <td bgcolor="#ffffff" width="40%" align="center"> 
        <input type="text" name="email" value="<%=email%>" onFocus="this.value=''" maxlength="20" size="30" class="oneborder" height="30">
        <input type="button" value="중복확인" onClick="doCheck()" class="oneborder">
      </td>
    </tr>
    <tr>
      <td>
<%
    if(check_count > 0){
%>
      [<%=email%>]은 이미 등록되어있는 이메일 주소입니다.<br> 다시 시도해주십시오.
<%
    }else{
%>
      [<%=email%>]은 사용 가능합니다.
<%
    }
%>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td align="center">
        <input type="button" value="확인" onClick="checkEnd()" class="oneborder">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
