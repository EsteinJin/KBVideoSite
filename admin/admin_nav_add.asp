<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>

<!--#include file="../include/function.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("Please Login First","admin_login.asp")
	end if
	'接收添加的类?
	dim sid
	sid = request.querystring("sid")	
%>

<!--#include file="conn.asp"-->
<%
'添加栏目
	if request.form("send") = "添加栏目" then
		dim nav,rs,sql
		nav = request.form("nav")
		sid = request.form("sid")
		
		if len(nav) < 2 or len(nav) > 40 then
			call errorHistoryBack("Not Less than 2 and more than 40")
		end if
		
		'新增之前验证是否重复
		set rs = server.createobject("adodb.recordset")
		sql = "select * from CMS_Nav where CMS_NavName='"&nav&"'"
		rs.open sql,conn,1,1
		
'		if not rs.eof then
'			call errorHistoryBack("Already Exist")
'			call close_rs
'			call close_conn
'		end if
		
		call close_rs  '关闭销毁表
		
		'新增,这里采用的是SQL新增，
		'如果采用SQL新增，那么复制ID的值比较困难
		'所以，我们将这里换成recordset来新增
		'sql = "insert into CMS_Nav (CMS_NavName,CMS_Sid,CMS_Date) 
		'values ('"&nav&"',"&sid&",now())"
		'conn.execute(sql)
		
		'采用recordset新增，1,3
		set rs = server.createobject("adodb.recordset")
		sql = "select * from CMS_Nav"
		rs.open sql,conn,1,3   '1,1表示只读，1,3表示可写
		
		rs.addnew
		rs("CMS_NavName") = nav
		rs("CMS_Sid") = sid
		rs("CMS_Date") = now()
		rs("CMS_Sort") = rs("CMS_ID") '这句话将刚刚新增的数据的ID赋值给sort字段
		rs.update
		
		call close_rs '关闭
		
		
		call close_conn '关闭销毁数据库
		
		call sussLoctionHref("Successfully Added!","admin_nav.asp")
		
	end if
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>Back Office Mgmt System--后台管理页面</title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
</head>
<body style="margin:20px;font-size:14px;">

<h4 style="margin:10px 0;color:green;text-align:center;">添加栏目</h4>
<p style="margin:10px 0;"><a href="admin_nav.asp">返回栏目管理</a></p>


<%
	'dim navname
	'set rs = server.createobject("adodb.recordset")
	'sql = "select * from CMS_Nav where CMS_ID="&sid
	'rs.open sql,conn,1,1
	
	'if not rs.eof then
	'	navname = rs("CMS_NavName")
	'end if
	
	'call close_rs
	
	dim location,navname,sid2,navname2,id
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Nav where CMS_ID="&sid
	rs.open sql,conn,1,1
	
	if not rs.eof then
		navname = rs("CMS_NavName")
		sid2 = rs("CMS_Sid")
		location = navname
		
		if sid2 <> 0 then   '当不是主类的情况下，去执行
			
			'做个死循环，来把所有的上级类别给循环出来
			do while true
				if sid2 = 0 then exit do  '只要循环到最上级的类别，也就是主类
				dim rs2,sql2
				set rs2 = server.createobject("adodb.recordset")
				sql2 = "select * from CMS_Nav where CMS_ID="&sid2
				rs2.open sql2,conn,1,1
				
				if not rs2.eof then
					navname2 = rs2("CMS_NavName")
					sid2 = rs2("CMS_Sid")
					id = rs2("CMS_ID")
					location = "<a href='admin_nav_add.asp?sid="&id&"'>" & navname2 & "</a> >> " & location
				end if
				
				rs2.close
				set rs2 = nothing	
			
			loop
			
		end if
		
		
		
	end if
	
	call close_rs
%>

<p class="nav_h">
	<a href="admin_nav.asp">首页</a> >> <%=location%>
    [<a href="admin_nav_mof.asp?ShowId=<%=sid%>">修改</a>]
	[<a onclick="return confirm('您确定进行删除吗？')" href="admin_nav_del.asp?ShowId=<%=sid%>">删除</a>]
</p>



<p class="nav_h">
	
	<%
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Nav where CMS_Sid="&sid
	rs.open sql,conn,1,1
	
	if not rs.eof then
		do while not rs.eof
	
			response.write "<a href='admin_nav_add.asp?sid="&rs("CMS_ID")&"'>" & rs("CMS_NavName") & "</a> | "
			
			rs.movenext
		loop
	else
		response.write "本类已无子类"
	end if
	
	
	%>
	
</p>




<form id="form_nav_add" method="post" action="admin_nav_add.asp">
	<input type="hidden" value="<%=sid%>" name="sid" />
	栏目名称：<input type="text" name="nav" /> <input type="submit" name="send" value="添加栏目" />
</form>

</body>
</html>
<%
	call close_conn
%>