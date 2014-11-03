<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<%

Connection conn = null;                                       

try{
String url = "jdbc:mysql://localhost:3306/jykim";        
String id = "jykim";                                                    
String pw = "wjstks25@";                                               

Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
conn=DriverManager.getConnection(url,id,pw);
Statement stmt = conn.createStatement();// DriverManager 객체로부터 Connection 객체를 얻어온다.
ResultSet rs = stmt.executeQuery("select * from jsontest");                        // 커넥션이 제대로 연결되면 수행된다.
while(rs.next()){
    out.println(" ID : " + rs.getString(3) + "<BR>");
}

}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
e.printStackTrace();
}
%>