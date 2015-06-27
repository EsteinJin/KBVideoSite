<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../include/function.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("Please Login First","admin_login.asp")
	end if
%>

<%
if session("Admin")="" then 
response.Write("<script>alert('Please Login First');location.href='admin_login.asp';</script>")
response.End()
end if 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<link rel="stylesheet" type="text/css" href="style/admin.css" />
<title>Back Office Mgmt System--后台管理系统</title>
</head>
<frameset cols="20%,80%">
	<frame src="sidebar.asp">
	<frame src="admin_main.asp" name="in">
</frameset><noframes></noframes>
</html>
