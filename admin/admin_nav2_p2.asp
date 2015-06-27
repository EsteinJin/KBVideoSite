<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="../include/function.asp"-->
<!--#include file="conn.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("非法登录","admin_login.asp")
	end if
	
	'确定首选之前先判断一下，是否已经满了6个
	dim countrs,countsql
	set countrs = server.createobject("adodb.recordset")
	countsql = "select * from CMS_Nav where CMS_Level=true"
	countrs.open countsql,conn,1,1
	
	if countrs.recordcount >=6 then
		countrs.close
		set countrs = nothing
		call errorHistoryBack("首选栏目已经达到最大上限6个\n请取消其他的栏目，再来确定此栏目")
		response.end
	end if
	
	countrs.close
	set countrs = nothing
	
	showid = request.querystring("ShowId")
	'非法操作
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("非法操作")
	end if
	
	dim rs,sql,rs2,sql2,count2
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Nav where CMS_ID="&showid
	rs.open sql,conn,1,1
	
	if rs.eof then
		call close_rs
		call close_conn
		call errorHistoryBack("不存在这个项目")
	else 		
		sql = "update CMS_Nav Set CMS_Level=true where CMS_ID="&showid
		conn.execute(sql)
		call close_rs
		call close_conn
		call sussLoctionHref(count2&"确定了首选","admin_nav2.asp")
	end if
%>

