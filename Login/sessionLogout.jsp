<%@ page language ="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<% 
	session.invalidate(); 
%> 

<script>
alert("로그아웃 되었습니다.");
location.href="index.html"; //로그인페이지로 이동
</script>