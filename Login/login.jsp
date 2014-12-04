<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>

  <meta charset="utf-8"  content="text/html; charset=UTF-8"/>
<!--    <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> -->
  <title>Login Form</title>
  <link rel="stylesheet" href="css/login.css">

<script type="text/javascript">
function login(form){

    if(checking(form)){
        document.loginForm.submit();
    }
}

function checking(form){ 

    if (form.user_id.value == ""){ 
        alert ("아이디를 입력해주세요"); 
        form.user_id.focus(); 
        return false; 
    }     
    if (form.pw.value == ""){ 
        alert ("비밀번호를 입력해주세요"); 
        form.pw.focus(); 
        return false; 
    }       
    return true;
} 
</script> 


</head>
<body>
  <section class="container">
    <div class="login">
      <h1>Login to FlagWiki</h1>
      <form name="loginForm"action="sessionLogin.jsp" method="post">
        <p><input type="text" name="user_id" value="" placeholder="User ID"></p>
        <p><input type="password" name="pw" value="" placeholder="Password"></p>

        <p class="submit"><input type="button" value="로그인" onClick="login(loginForm)"></p>
      </form>
    </div>


    <div class="login-help">
      <p>아직 회원이 아니신가요? <a href="http://www.flagwiki.co.kr/Join">여기를 클릭하세요</a>.</p>
    </div>
  </section>

  <section class="about">
    <p class="about-links">
      60122485 정서영 </br>
      60112339 김진용 </br>
      60102331 박민수 </br>
    </p>
  </section>


</body>
</html>
