<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title>Head Navi</title>

      <%!
      boolean isset(String str)
      {
        if(str == null) return false;
        if(str.equals("")) return false;
        return true;
      }

      %>

      <link href="./stylesheet/reset.css" rel="stylesheet" type="text/css">
      <link href="./stylesheet/head.css" rel="stylesheet" type="text/css">  

</head>
<body>
    <div id="layer_fixed">
    <table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
    <tr>
       <td style="vertical-align:middle; padding-left: 20px; padding-right: 20px;">
      
        <%
        if(!isset((String)session.getAttribute("user_id")))
        {
          out.println("로그인정보 없음. 로그인해주세여");
          out.println("<input type=\"button\" value=\"로그인\" onClick=\"location.href='http://www.flagwiki.co.kr/Login'\">"); 
          out.println("<input type=\"button\" value=\"회원가입\" onClick=\"location.href='http://www.flagwiki.co.kr/Join'\">");
        }
        else
        {
          out.println((String)session.getAttribute("user_id") + "님 방가방가");
         
          out.println("<input type=\"button\" value=\"로그아웃\" onClick=\"location.href='http://www.flagwiki.co.kr/Login/sessionLogout.jsp'\">"); 
         }

         %> 


       </td>
    </tr>
    </table>
    </div>
 
 
</body>
</html>