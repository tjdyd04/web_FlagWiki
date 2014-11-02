<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판 등록</title>
    <script type="text/javascript" src="/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="/ckeditor_full/ckeditor.js"></script>
    
</head>
<body>
    
    <textarea cols="80" id="contents" name="contents" rows="10"></textarea>
    <script type="text/javascript">
   	CKEDITOR.replace('contents');
    </script>
    
</body>
</html>
