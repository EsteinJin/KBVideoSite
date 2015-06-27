<%@codepage = 936%>

<!--#include file="../include/function.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("Please Login First","admin_login.asp")
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<title>Back Office Mgmt System--后台管理页面</title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
</head>
<body>


<dl class="sidebar">
	<dd><a href="admin_main.asp" target="in">Main Page</a></dd>
    <dd><a href="../index.asp" target="_blank">前台页面</a></dd>
	<dd><a href="admin_logout.asp" target="_parent">Log Out</a></dd>
</dl>

<dl class="sidebar">
	<dt>◆常规操作◆</dt>
	<dd>◇<a href="admin_nav.asp" target="in">栏目管理</a>◇</dd>
	<dd>◇<a href="admin_nav2.asp" target="in">首选栏目</a>◇</dd>    
	<dd>◇<a href="admin_article_add.asp" target="in">内容发布</a>◇</dd>      
	<dd>◇<a href="admin_article.asp" target="in">内容管理</a>◇</dd>      
</dl>



<dl class="sidebar">
	<dt>◆其他功能◆</dt>
	<dd>◇<a href="admin_ListGenerate.asp" target="in">列表生成</a>◇</dd>      


</dl>


</body>
</html>