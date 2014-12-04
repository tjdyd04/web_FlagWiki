<!-- 회원리스트 -->

<%@ page  contentType="text/html;charset=euc-kr" 
        import="java.sql.*" %>
<%
  response.setContentType("text/html;charset=euc-kr;");
  request.setCharacterEncoding("euc-kr");     //charset, Encoding 설정
  Class.forName("com.mysql.jdbc.Driver");    // load the drive
  String DB_URL = 
          "jdbc:mysql://localhost:3306/jykim";
           
  String DB_USER = "admin";
  String DB_PASSWORD= "1234";
  Connection conn= null;
  Statement stmt = null;
  ResultSet rs   = null;

  try {
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim", "jykim","wjstks25@");
      stmt = conn.createStatement();

      String query = "SELECT user,pw FROM member";
      rs = stmt.executeQuery(query);
 %>

// <form action="delete_do.jsp" method="post">
<table border="1" cellspacing="0">
<th> 회원목록 </th>
<tr>

<td>user</td>
<td>pw</td>
</tr>
<%
    while(rs.next()) { //rs 를 통해 테이블 객체들의 필드값을 넘겨볼 수 있다.
%><tr>
<td><%=rs.getString("user")%></td>
<td><%=rs.getString("pw")%></td>
</tr>
<%
    } // end while
%></table>
</form>
<%
  rs.close();        // ResultSet exit
  stmt.close();     // Statement exit
  conn.close();    // Connection exit
}
catch (SQLException e) {
      out.println("err:"+e.toString());
} 
%>