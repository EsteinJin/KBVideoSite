<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../include/function.asp"-->
<%
	if session("Admin") <> "" then
		response.write "<script>alert('You have already being Logged In!');history.back();</script>"
		response.end
	end if
	
	'接收登录信息

	
	if request.form("send") = "Login" then
		dim adminname,adminpass,yzm
		adminname = request.form("adminname")
		adminpass = request.form("adminpass")
		yzm = request.form("yzm")
		
		if len(adminname) <2 then
			call errorHistoryBack("Username should not be less than 2 charactors")
		end if 
		if len(adminpass) < 6 then
			call errorHistoryBack("Password should not be less than 6 charactors")
		end if
		if len(yzm) <> 4 then
			call errorHistoryBack("Digit Match with 4 Charactors")
		end if		
		if not isnumeric(yzm) then
			call errorHistoryBack("Digit Match Only with Numbers")
		end if
		if cint(yzm) <> Session("CheckCode") then
			call errorHistoryBack("Digit Does not Match")
		end if

%>
		<!--#include file="conn.asp"-->
		<!--#include file="../include/md5.asp"-->

<%
dim rs,sql
		set rs = server.createobject("adodb.recordset")
		sql = "select * from CMS_Admin where CMS_AdminName='"&adminname&"' and CMS_AdminPass='"&md5(adminpass)&"'"
		rs.open sql,conn,1,1
		
		if not rs.eof then
			'Correct
			session("Admin") = adminname
			response.redirect "admin_index.asp"
		else
			'Incorrect
			call close_rs
			call close_conn
			call errorHistoryBack("UserName Or Password is incorrect!")
		end if
		
		call close_rs
		call close_conn
    	end if 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<title>Back Office Mgmt System--后台管理系统</title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
</head>
<body>

<form method="post" action="admin_login.asp" id="login">
	<h1>管理员登陆</h1>
	<label for="username">用户名：<input type="text" name="adminname" id="username" class="text" /></label>
	<label for="password">密　码：<input type="password" name="adminpass" id="password" class="text" /></label>
	<label for="yzm">验证码：<input type="text" name="yzm" id="yzm" class="text yzm" /> <img src="../include/code.asp" onclick="javascript:this.src='code.asp?tm='+Math.random()" style="cursor:pointer" alt="验证码" /></label>
	<input type="submit" value="Login" name="send" class="submit" />
    
</form>
<span style="margin:20px;  "><a href="../index.asp">点击返回</a>&nbsp;&nbsp;前台首页</span>
</body>
</html>
	