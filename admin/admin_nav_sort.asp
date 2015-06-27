<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="../include/function.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("Please login first","admin_login.asp")
	end if
	
	
	dim showid,aa
	showid = request.querystring("ShowId")
	aa = request.querystring("aa")
	
	'判断showid有效
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("error Occured!")
	end if
%>
<!--#include file="conn.asp"-->
<%
	'判断showid这个栏目是否存在
	dim rs,sql,sql2,sort,sort2,showid2
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Nav where CMS_ID="&showid
	rs.open sql,conn,1,1
	
	if rs.eof then
		call close_rs
		call close_conn
		call errorHistoryBack("Not existing Data")
	else
		
		
		if aa = "left" then  '这个表示向左排序
			'通过你传过来的ID，找到比这个ID的sort小的那个最大的数据
			
			sort = rs("CMS_Sort")  '这个是查找到的ID的sort,比如这个是7
			
			
			set rs2 = server.createobject("adodb.recordset")
			sql2 = "select * from CMS_Nav where CMS_Sid=0 and CMS_Sort<"&sort&" order by CMS_Sort desc"
			rs2.open sql2,conn,1,1
	
		
			if not rs2.eof then
				
				sort2 = rs2("CMS_Sort")  '这个是查找到的ID的sort小的那个最大数据的sort，这个就是6
				showid2 = rs2("CMS_ID") 'id
				
				
				'交换
				sql3 = "update CMS_Nav set CMS_Sort="&sort2&" where CMS_ID="&showid
				conn.execute(sql3)
				sql4 = "update CMS_Nav set CMS_Sort="&sort&" where CMS_ID="&showid2
				conn.execute(sql4)
				
				response.redirect "admin_nav.asp"
			else
				call errorHistoryBack("Aready On Top Field")
			end if
		elseif aa = "right" then  '这个表示向右排序
			'通过你传过来的ID，找到比这个ID的sort小的那个最大的数据
			
			sort = rs("CMS_Sort")  '这个是查找到的ID的sort,比如这个是7
			
			
			set rs2 = server.createobject("adodb.recordset")
			sql2 = "select * from CMS_Nav where CMS_Sid=0 and CMS_Sort>"&sort&" order by CMS_Sort asc"
			rs2.open sql2,conn,1,1
	
		
			if not rs2.eof then
				
				sort2 = rs2("CMS_Sort")  '这个是查找到的ID的sort小的那个最大数据的sort，这个就是6
				showid2 = rs2("CMS_ID") 'id
				
				
				'交换
				sql3 = "update CMS_Nav set CMS_Sort="&sort2&" where CMS_ID="&showid
				conn.execute(sql3)
				sql4 = "update CMS_Nav set CMS_Sort="&sort&" where CMS_ID="&showid2
				conn.execute(sql4)
				
				response.redirect "admin_nav.asp"
				
			else
				call errorHistoryBack("Already At the Bottom")
			end if
		end if
		
		
		
		
		
		
		rs2.close
		set rs2 = nothing
	end if
	
	call close_rs
	call close_conn
	
	
	
%>
