<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 "/>
<!-- include jQuery and jQueryUI libraries -->
<link rel="stylesheet" href="css/join.css">

<script type="text/javascript">


    var idSuccess = false;
    var pwSuccess = false;

function submitDB(form){

    if(checking(form)==true)
    {
        if(!idSuccess)
        {
            alert ("아이디 중복체크를 해주세요."); 

        }
        else if(!pwSuccess)
        {
            alert ("비밀번호가 일치하지 않습니다."); 
        }   
        else
        { 
            document.memberForm.submit();
        }
    }
}

function checking(form){ 


    if (form.user.value == "") 
    { 
        alert ("아이디를 입력해주세요"); 
        form.user.focus(); 
        return false; 
    }       

                    
    if(!form.pw.value) { 
        alert("비밀번호를 입력해주세요"); 
        form.pw.focus(); 
        return (false); 
    } 

    if(!form.re_pw.value) { 
        alert("비밀번호확인을 입력하세요."); 
        form.re_pw.focus(); 
        return (false); 
    } 

    if(form.pw.value!=form.re_pw.value) { 
        alert("비밀번호가 일치하지 않습니다."); 
        form.re_pw.focus(); 
        return (false); 
    } 

    if(form.pw.value==form.re_pw.value) { 
        pwSuccess=true; 
    } 

    return true;
} 

//  이메일보류 
// function checkEmail()
// {
//     var email = document.memberForm.email.value;
    
//     if( email == "" )
//     {
//         alert('이메일을 입력하세요');
//     }
//     else if( checkEmail(email) == false )
//     {
//         alert('잘못된 형식입니다. 다시입력해주세요');
//     }
//     else
//     {
//         var url ="check_emailDB.jsp?email=" + email;
//         window.open(url, "",  "width=500, height=150,screenX=500,screenY=200");
//         emailSuccess = true;
//     }
// }


function checkID()
{
    var id = document.memberForm.user.value;
    
    if( id == "" )
    {
        alert('아이디를 입력하세요');
    }   
    else
    {
        var url ="check_idDB.jsp?user=" + id;
        window.open(url, "",  "width=500, height=150,screenX=500,screenY=200");
        idSuccess = true;
    }
}

</script>
</head>    
<body>

<!-- 아이디 중복체크버튼용 -->
<form name="func">
    <input onclick="disableID()" type="hidden" name="disable_id" />
</form>    

<!-- 메인  -->
<div class="setup-wrapper">

  <div class="setup-header setup-org">
      <h1>Join FlagWiki</h1>
      <p class="lead">Join us AND Do Better Game!</p>
  </div>

  <div class="setup-main ">
    <div class="setup-form-container">

      
   
<form accept-charset="UTF-8" name="memberForm" action="./connectDB.jsp" autocomplete="off"  method="post">


  <h2 class="setup-form-title">
    Create your personal account
  </h2>

<!-- 이메일 보류 
  <dl class="form">
    <dt class="input-label">
        <label autocapitalize="off" autofocus="autofocus" data-autocheck-url="/signup_check/username" name="user[email]">Email Address</label></dt>
        <dd>
            <input autocapitalize="off" autofocus="autofocus" name="email" size="30" type="text"> <input type="button" value="이메일중복체크" onClick="javascript:checkEmail()">
            <p class="note"> 이메일형식은 "aaaaaa @ aaaa . aaa" 입니다.</p>
        </dd>

    </dl>
-->

  <dl class="form">
    <dt class="input-label">
        <label autocapitalize="off" autofocus="autofocus" data-autocheck-url="/signup_check/username" name="user[login]">User ID</label></dt>
        <dd>
            <input autocapitalize="off" autofocus="autofocus" name="user" size="30" type="text"> <button type="button" class="btn btn-default" onClick="javascript:checkID()"> 아이디중복체크</button>

            <p class="note"> 사용하실 아이디를 입력해주세요. </p>
        </dd>

    </dl>

  <dl class="form">
    <dt class="input-label">
        <label for="user_password" name="user[password]">Password</label>
    </dt>
    <dd><input name="pw" size="30" type="password"><p class="note"> 비밀번호를 입력해주세요. </p>
    </dd></dl>

  <dl class="form">
    <dt class="input-label">
        <label for="user_password_confirmation"> Confirm your password </label></dt><dd>
        <input name="re_pw" size="30" type="password"></dd></dl>



  <input type="hidden" name="source_label" value="Detail Form">

  
 

  <div class="form-actions">

     <button type="button" class="btn btn-success " onClick="javacript:submitDB(memberForm)"> Create an account </button>
    </div>

   
  </div>

</form>
    </div> 
  </div>
</div>



</form>    
    
</body>    
</html>    