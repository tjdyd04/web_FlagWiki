<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 "/>
<!-- include jQuery and jQueryUI libraries -->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>

<script type="text/javascript">

    var emailSuccess = false;
    var idSuccess = false;
    var pwSuccess = false;

function submitDB(form){

    if(checking(form)==true)
    {
        if(!emailSuccess)
        {
            alert ("이메일 중복체크를 해주세요."); 
        }
        else if(!idSuccess)
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

    if (form.email.value == "") 
    { 
        alert ("이메일을 입력해주세요"); 
        form.email.focus(); 
        return false; 
    }     


    if (form.user_id.value == "") 
    { 
        alert ("아이디를 입력해주세요"); 
        form.user_id.focus(); 
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

function checkEmail()
{
    var email = document.memberForm.email.value;
    
    if( email == "" )
    {
        alert('이메일을 입력하세요');
    }   
    else
    {
        var url ="check_emailDB.jsp?email=" + email;
        window.open(url, "",  "width=500, height=150,screenX=500,screenY=200");
        emailSuccess = true;
    }
}

function checkID()
{
    var id = document.memberForm.user_id.value;
    
    if( id == "" )
    {
        alert('아이디를 입력하세요');
    }   
    else
    {
        var url ="check_idDB.jsp?user_id=" + id;
        window.open(url, "",  "width=500, height=150,screenX=500,screenY=200");
        idSuccess=true;
    }
}



</script>


</head>    
<body>


<h1>Join FlagWiki</h1>
<p class="lead">Play Better Game.</p>

<!-- 아이디 중복체크버튼용 -->
<form name="func">
    <input onclick="disableID()" type="hidden" name="disable_id" />
</form>    

<!-- 메인폼 -->
<form name="memberForm" action="connectDB.jsp" method="post">

    <table align="center">
        <tr>
            <td colspan="4"><hr noshade="noshade" /></td>
        </tr>
        <tr> 
            <td>이메일</td>
            <td> <input type="text" name="email"/>@</td>
            <td><select name="email_domain">
                    <option value="naver"> naver.com </option>
                    <option value="nate"> nate.com </option>
                    <option value="daum"> daum.net </option>
                </select> </td>
            <td><input type="button" value="이메일중복체크" onClick="javascript:checkEmail()"> </td>
        </tr>

        <tr>
            <td> 아이디 </td>
            <td><input type="text" name="user_id" style="ime-mode:disabled"/></td>
            <td><input type="button" name="checker" value="아이디중복체크" onclick="javascript:checkID()"/></td>
            <td></td>
        </tr>

        <tr> 
            <td> 비밀번호 </td>
            <td><input type="password" name="pw"/> </td>
        </tr>
        <tr>  
            <td> 비밀번호재확인 </td>
            <td><input type="password" name="re_pw"/> </td>
        </tr>
        <tr>
            <td colspan="4"><hr noshade="noshade" /></td>
        </tr>
        <tr>
            <td><input type="reset" value="재입력" /></td>
            <td></td>
            <td><input type="button" value="가입완료" onClick="javacript:submitDB(memberForm)"/></td>
        </tr>

    </table>




</form>    
    
</body>    
</html>    