<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="../include/function.asp"-->
<!--#include file="conn.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("Please Login First","admin_login.asp")
	end if
	
	'接收修改
	if request.form("send") = "修改" then
		dim navid,sql2,navname2
		navid = request.form("navid")
		navname2 = request.form("navname")
		sql2 = "update CMS_Nav set CMS_NavName='"&navname2&"' where CMS_ID="&navid
		conn.execute(sql2)
		
		'跳转
		call sussLoctionHref("Successfully Modified!","admin_nav_add.asp?sid="&navid)
		
	end if
	
	
	dim showid
	showid = request.querystring("ShowId")
	
	'判断showid有效
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("error Occured!")
	end if

	'判断showid这个栏目是否存在
	dim rs,sql,navname
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Nav where CMS_ID="&showid
	rs.open sql,conn,1,1
	
	if rs.eof then
		call close_rs
		call close_conn
		call errorHistoryBack("Not Existing Data!")
	else
		navname = rs("CMS_NavName")
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>Back Office Mgmt System--后台管理页面</title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
</head>
<body>

	
	<form method="post" action="admin_nav_mof.asp" style="font-size:14px;margin:30px;">
		<input type="hidden" name="navid" value="<%=showid%>" />
		<p>[<a href="admin_nav_add.asp?sid=<%=showid%>">返回</a>]</p>
		<p>您要修改的栏目名称：<input type="text" name="navname" value="<%=navname%>"  /></p>
		<p><input type="submit" name="send" value="修改" /></p>
	</form>

</body>
</html>