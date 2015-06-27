<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="../include/function.asp"-->
<!--#include file="conn.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("非法登录","admin_login.asp")
	end if
	
	showid = request.querystring("ShowId")
	'非法操作
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("非法操作")
	end if
	
	dim rs,sql
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Nav where CMS_ID="&showid
	rs.open sql,conn,1,1
	
	if rs.eof then
		call close_rs
		call close_conn
		call errorHistoryBack("不存在这个项目")
	else 
		sql = "update CMS_Nav Set CMS_Level=false where CMS_ID="&showid
		conn.execute(sql)
		call close_rs
		call close_conn
		call sussLoctionHref("取消了首选","admin_nav2.asp")
	end if
%>

