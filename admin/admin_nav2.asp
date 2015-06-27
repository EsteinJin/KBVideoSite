<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="../include/function.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("非法登录","admin_login.asp")
	end if
%>
<!--#include file="conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title> </title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
</head>
<body style="margin:20px;font-size:14px;">

<h4 style="margin:10px 0;color:green;text-align:center;">首选栏目</h4>

<div id="nav_show">
	<ul>
	<%
		dim rs,sql,level,navred,navp
		set rs = server.createobject("adodb.recordset")
		sql = "select * from CMS_Nav where CMS_Sid<>0"
		rs.open sql,conn,1,1
		
		do while not rs.eof
			level = rs("CMS_Level")
			if level = true then
				navred = " class='red'"
				navp = "<a href='admin_nav2_p.asp?ShowId="&rs("CMS_ID")&"'>取消</a>"
			else
				navp = "<input type='button' value='首选' onclick=""javascript:location.href='admin_nav2_p2.asp?ShowId="&rs("CMS_ID")&"'"" />"
			end if
	%>
	
		<li<%=navred%>><%=rs("CMS_NavName")%></li>&nbsp;| &nbsp;<li> <%=navp%></li>	
	
	<%
			navred = ""
			navp = ""
			rs.movenext
		loop
	%>
	</ul>
</div>



</body>
</html>
<%
	call close_rs
	call close_conn
%>