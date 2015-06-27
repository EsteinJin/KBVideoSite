<%@codepage = 936%>
<!--#include file="../include/function.asp"-->
<!--#include file="conn.asp"-->
<%

	'判断是否为管理员
	if session("Admin") = "" then
		call sussLoctionHref("error Occured!","admin_login.asp")
	end if
	
	dim id,showid,sort,title,top,rmp,pic,bold,color,tag,keyword,name,info,content
	
	'接收修改的内容
if request.form("send") = "Update" then
id = request.form("id")
sort = request.form("sort")
title = replace(request.form("title"),"'","")
top = request.form("top")
rmp = request.form("rmp")
pic = request.form("pic")
bold = request.form("bold")
color =  request.form("color")
tag =  request.form("tag")
keyword =  request.form("keyword")
info =  replace(request.form("info"),"'","")
name =  request.form("name")
CMS_MovieLink=  request.form("CMS_MovieLink")
CMS_PosterImage=  request.form("CMS_PosterImage")	
		'开始使用VBScript对字段进行验证
		
		'标题=>不能为空并且不能少于4位，不能大于100位
		if len(title) < 4 or len(title) > 100 then
			call errorHistoryBack("标题不小于4位，或者大于100位")
		end if
		
		'发布者不能为空
		if name = "" then
			call errorHistoryBack("发布人不得为空")
		end if
		
		'内容简介
		if len(info) < 10 or len(info) > 200 then
			call errorHistoryBack("内容简介不得小于10位，大于200位")
		end if 
		

		
		
		if top = "" then 
			top =0
		end if
		
		if rmp = "" then 
			rmp =0
		end if
		
		if pic =  "" then
			pic = 0
		end if
		
		if bold = "" then
			bold = 0
		end if
		
		
		'开始执行修改命令
		updatesql = "update CMS_Movie set CMS_Top="&top&",CMS_Pic="&pic&",CMS_Bold="&bold&",CMS_Rmp="&rmp&",CMS_Title='"&title&"',CMS_Sort="&sort&",CMS_Name='"&name&"',CMS_Info='"&info&"',CMS_Color='"&color&"',CMS_Tag='"&tag&"',CMS_Keyword='"&keyword&"',CMS_MovieLink='"&CMS_MovieLink&"',CMS_PosterImage='"&CMS_PosterImage&"' where CMS_ID="&id
		conn.execute(updatesql)
		call sussLoctionHref("Updated Successfully!","admin_article.asp")
	end if
	
	
	showid = request.querystring("ShowId")

	'非法操作
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("Error Occured!")
	end if
	
	'判断数据是否存在
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Movie where CMS_ID="&showid
	rs.open sql,conn,1,1
	
	if rs.eof then
		call close_rs
		call close_conn
		call errorHistoryBack("No Date Exist!")
		'以上全部是验证数据，已经成功
	else
		sort = rs("CMS_Sort")
		top = rs("CMS_Top")
		rmp = rs("CMS_Rmp")
		pic = rs("CMS_Pic")
		bold = rs("CMS_Bold")
		color = rs("CMS_Color")
		title = rs("CMS_Title")
		tag = rs("CMS_Tag")
		keyword = rs("CMS_Keyword")
		name = rs("CMS_Name")
		info = rs("CMS_Info")
		CMS_MovieLink=  rs("CMS_MovieLink")
		CMS_PosterImage=rs("CMS_PosterImage")
		
	end if
	
	call close_rs
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>后台管理</title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
<script type="text/javascript" src="js/content.js"></script>
</head>
<body>

<form name="add" id="articleadd" method="post" action="admin_article_mof.asp">
	<input type="hidden" value="<%=showid%>" name="id" />
	<dl>
		<dt>请修改文章</dt>
		<dd>类别选择：
			<select name="sort">
				<%
					dim rs,sql,rs2,sql2
					set rs = server.createobject("adodb.recordset")
					sql = "select * from CMS_Nav where CMS_Sid=0 order by CMS_Sort asc"
					rs.open sql,conn,1,1
					do while not rs.eof
				%>
				
								
				<optgroup label="<%=rs("CMS_NavName")%>">
					
					<%
						set rs2 = server.createobject("adodb.recordset")
						sql2 = "select * from CMS_Nav where CMS_Sid<>0 and CMS_Sid="&rs("CMS_ID")
						rs2.open sql2,conn,1,1
						do while not rs2.eof
					%>
					<option value="<%=rs2("CMS_ID")%>"<%
							'如果你传过来的ID中的sort和修改中循环的sort一致的话，那么就selected
							if rs2("CMS_ID") = sort then
								response.write "selected='selected'"
							end if
						%>>----<%=rs2("CMS_NavName")%></option>					
					<%
							rs2.movenext
						loop
					%>
				</optgroup>
				
				
				<%
						rs.movenext
					loop
				%>
			</select>
		</dd>
		<dd>电影的标题：<input type="text" name="title" value="<%=title%>" class="text" /> <span>*</span></dd>
		<dd>
				电影类型：
				<input type="checkbox" <%if top = 1 then response.write "checked='checked'"%> class="radio" name="top" value="1" /> <span  style="color:red; font-weight:bold;">置顶</span>
				<input type="checkbox" <%if rmp = 1 then response.write "checked='checked'"%> class="radio" name="rmp" value="1" /><span  style="color:red; font-weight:bold;">分发</span>
				<input type="checkbox" <%if pic = 1 then response.write "checked='checked'"%> class="radio" name="pic" value="1" /> 流行
				<input type="checkbox" <%if bold = 1 then response.write "checked='checked'"%> class="radio" name="bold" value="1" /> 高亮
		</dd>
		<dd>标题颜色：
			<input type="radio" name="color" value="black" <%if color="black" then response.write "checked='checked'"%> /> 黑色
			<input type="radio" name="color" value="red" <%if color="red" then response.write "checked='checked'"%> /> 红色
			<input type="radio"  name="color" value="green" <%if color="green" then response.write "checked='checked'"%> /> 绿色
		</dd>
		<dd>TAG 标签：<input type="text" value="<%=tag%>" name="tag" class="text" /> (多个标签请使用英文逗号","隔开)</dd>
		<dd>关 键 字：<input type="text" value="<%=keyword%>" name="keyword" class="text" /> (多个关键字请使用英文逗号","隔开)</dd>
		<dd>发 布 者：<input type="text" name="name" value="<%=name%>" class="text" />  <span>*</span></dd>
		<dd>
				电影简介：<textarea cols="30" rows="2" name="info"><%=info%></textarea>	  <span>*</span>
		</dd>
		<dd>
		
		</dd>
 <p>上传电影：<iframe scrolling="no" frameborder="0" src="Uploadform.asp" style="height:35px; border:none; width:600px; "></iframe></p>

 <p>上传截图：<iframe scrolling="no" frameborder="0" src="posteruploadform.asp" style="height:35px; border:none; width:600px; "></iframe></p>
		<dd>电影链接：<input type="text" name="CMS_MovieLink" class="text" value="<%=CMS_MovieLink%>" /></dd>
		<dd>电影截图：<input type="text" name="CMS_PosterImage" class="text" value="<%=CMS_PosterImage%>" /></dd>        
		<dd><input type="submit" onclick="return check();" name="send" value="Update" /></dd>
	</dl>
</form>

</body>
</html>