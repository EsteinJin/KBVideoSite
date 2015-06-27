<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
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
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.STYLE2 {color: #0000FF}
-->
</style>
</head>
<body>

<p class="main STYLE2">欢迎光临后台主页</p>
<p class="main STYLE1"><br />
  制作人：金尚学<br />
  版本：测试版本</p>
</body>
</html>