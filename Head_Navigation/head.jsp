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
    <table cellspacing="0" cellpadding="0" style="width:100%; height:100%;" align="right">
    <tr>
       <td style="vertical-align:middle; padding-left: 20px; padding-right: 20px;">
      
        <%
        String userName = (String)session.getAttribute("user");
        if(!isset(userName))
        {

          out.println("<button type=\"button\" class=\"btn btn-success btn-lg pull-right\" onClick=\"location.href='http://www.flagwiki.co.kr/Join'\"> 회원가입 </button>");
          out.println("<button type=\"button\" class=\"btn btn-default btn-lg pull-right\" onClick=\"location.href='http://www.flagwiki.co.kr/Login'\"> 로그인 </button>"); 
        }
        else
        {

         out.println("<button type=\"button\" class=\"btn btn-danger pull-right\" onClick=\"location.href='http://www.flagwiki.co.kr/Login/sessionLogout.jsp'\"> 로그아웃 </button>"); 
         
          out.println("<button type=\"button\" class=\"btn btn-default pull-right\" onClick=\"location.href='http://www.flagwiki.co.kr/Search/Repositores.jsp'\"> ");
          out.println( userName +"님");
          out.println("</button>"); 
        
         }

         %> 


       </td>
    </tr>
    </table>
    </div>
 
 
</body>
</html>