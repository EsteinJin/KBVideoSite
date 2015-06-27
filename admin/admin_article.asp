<%@codepage = 936%>
<!--#include file="../include/function.asp"-->
<!--#include file="conn.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("非法操作","admin_login.asp")
	end if



	dim rs,sql,title,i
	set rs = server.createobject("adodb.recordset")
	sql = "SELECT CMS_Movie.CMS_ID as CMS_ID, CMS_Movie.CMS_Title as CMS_Title,CMS_Nav.CMS_NavName as CMS_NavName,CMS_Movie.CMS_Name as CMS_Name,CMS_Movie.CMS_Date as CMS_Date  FROM CMS_Movie INNER JOIN CMS_Nav ON CMS_Movie.CMS_Sort = CMS_Nav.CMS_ID  order by CMS_NavName"
	rs.open sql,conn,1,1
	rs.pagesize=10
	if isnumeric(request.querystring("page")) then
		if request.querystring("page") = "" or cint(request.querystring("page"))<1 then
			rs.absolutepage = 1
		elseif cint(request.querystring("page"))>rs.pagecount then
			rs.absolutepage = rs.pagecount
		else
			rs.absolutepage = request.querystring("page")
		end if
	else
		rs.absolutepage = 1
	end if 
	
	'删除模块
	if request.querystring("del")="ok" then
		dim showid,delrs,delsql,delsql2
		
		showid = request.querystring("ShowId")
		'非法操作
		if showid = "" or not isnumeric(showid) then
			call errorHistoryBack("非法操作")
		end if
		
		'判断数据是否存在
		set delrs = server.createobject("adodb.recordset")
		delsql = "select * from CMS_Movie where CMS_ID="&showid
		delrs.open delsql,conn,1,1
		
		'如果数据不存在
		if delrs.eof then
			call close_rs
			call close_conn
			delrs.close
			set delrs = nothing
			call errorHistoryBack("你要删除的数据不存在")
		else
		    call ConfirmDel()
			'执行删除命令
			delsql2 = "delete from CMS_Movie where CMS_ID="&showid
			conn.execute(delsql2)
			call sussLoctionHref("删除成功","admin_article.asp")
		end if
		
		delrs.close
		set delrs = nothing
		
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>后台管理</title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
</head>
<body>
	

<table border="1" id="listcontent">
	<tr><th>编号</th><th>标题</th><th>文档所属</th><th>发表者</th><th>发布时间</th><th>操作</th></tr>
	<%
		for i=1 to rs.pagesize
			if rs.eof then exit for	
			title = rs("CMS_Title")
			if len(title) >40 then
				title = left(title,40)
				title = title & "..."
			end if
	%>
	<tr><td><%=rs("CMS_ID")%></td><td><%=title%></td><td><%=rs("CMS_NavName")%></td><td><%=rs("CMS_Name")%></td><td><%=rs("CMS_Date")%></td><td class="d"><a href="admin_article_mof.asp?ShowId=<%=rs("CMS_ID")%>">修改</a> | <a  onclick="return confirm('您确定进行删除吗？')" href="admin_article.asp?del=ok&ShowId=<%=rs("CMS_ID")%>">删除</a></td></tr>
	<%
	rs.movenext
	next	
	%>
</table>

	<p style="text-align:center;padding:10px;">
    <%
	for i = 1 to rs.pagecount
		response.write "<a href='admin_article.asp?page="&i&"'>" & i & "</a> | "
	next
%>
    
    </p>
	
	
</body>
</html>
<%
	call close_rs
	call close_conn
%>