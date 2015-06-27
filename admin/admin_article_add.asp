<%@codepage = 936%>


<!--#include file="../include/function.asp"-->

<!--#include file="conn.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("Error Occured!","admin_login.asp")
	end if
	
	'接收添加的内容
	if request.form("send") = "Submit" then
		dim addsql,sort,title,top,rmp,pic,bold,color,tag,keyword,info,name
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
		
		'主要内容
		
		
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
		
		'添加数据之前，先进行Tag标签的添加或积累
		dim tagArr,i,tagrs,tagsql
		tagArr = split(tag,",")  '通过split函数，将Tag标签分组
		
		'通过取得数组的上下标来逐个对Tag标签进行操作
		for i = lbound(tagArr) to ubound(tagArr)
			'取得标签，先判断是否在数据库里有这个标签
			'如果有，就累计+1
			'如果没有，就新增一个Tag标签
			set tagrs = server.createobject("adodb.recordset")
			tagsql = "select * from CMS_Tag where CMS_TagName='"&tagArr(i)&"'"
			tagrs.open tagsql,conn,1,1
			
			if not tagrs.eof then
				'有数据，累计
				sql = "Update CMS_Tag Set CMS_TagCount=CMS_TagCount+1 where CMS_TagName='"&tagArr(i)&"'"
				conn.execute(sql)
			else
				'没数据，新增	
				sql = "Insert into CMS_Tag (CMS_TagName,CMS_Date) values ('"&tagArr(i)&"',now())"			
				conn.execute(sql)
			end if
			tagrs.close
			set tagrs = nothing
		next

		addsql = "Insert into CMS_Movie (CMS_Sort,CMS_Title,CMS_Top,CMS_Rmp,CMS_Pic,CMS_Bold,CMS_Color,CMS_Tag,CMS_Keyword,CMS_Name,CMS_Info,CMS_Date,CMS_PosterImage,CMS_MovieLink) values ("&sort&",'"&title&"',"&top&","&rmp&","&pic&","&bold&",'"&color&"','"&tag&"','"&keyword&"','"&name&"','"&info&"',now(),'"&CMS_PosterImage&"','"&CMS_MovieLink&"')"
		conn.execute(addsql)
		call sussLoctionHref("Added Successfully!","admin_article.asp")
		
		
		
	end if
	

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

<form name="add" id="articleadd" method="post" action="admin_article_add.asp">
	<dl>
		<dt>请发布文章</dt>
		<dd>选择类别
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
					<option value="<%=rs2("CMS_ID")%>">----<%=rs2("CMS_NavName")%></option>					
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
		<dd>电影标题：<input type="text" name="title" class="text" /></dd>
		<dd>
				电影类型：
				<input type="checkbox" class="radio" name="top" value="1" /> <span  style="color:red; font-weight:bold;">置顶</span>
				<input type="checkbox" class="radio" name="rmp" value="1" /> <span  style="color:red; font-weight:bold;">分发</span>
			    <input type="checkbox" class="radio" name="bold" value="1" /> 流行
				<input type="checkbox" class="radio" name="pic" disabled="disabled" value="1" /> 高亮                
		</dd>
		<dd>颜色类型：
			<input type="radio" name="color" value="black" checked="checked" /> 黑色
			<input type="radio" name="color" value="red" /> 红色
			<input type="radio"  name="color" value="green" /> 绿色
		</dd>
		<dd>TAG 标签：<input type="text" name="tag" class="text" /> (多个标签请使用英文逗号","隔开)</dd>
		<dd>关 键 字：<input type="text" name="keyword" class="text" /> (多个关键字请使用英文逗号","隔开)</dd>
		<dd>发 布 者：<input type="text" name="name" value="<%=session("Admin")%>" class="text" /></dd>
		<dd>
				电影简介：<textarea cols="30" rows="2" name="info"></textarea>	
		</dd>
		

	</dl>
    
    <p>上传电影：<iframe scrolling="no" frameborder="0" src="Uploadform.asp" style="height:35px; border:none; width:600px; "></iframe></p>

 <p>上传截图：<iframe scrolling="no" frameborder="0" src="posteruploadform.asp" style="height:35px; border:none; width:600px; "></iframe></p>
		<dd>电影链接：<input type="text" name="CMS_MovieLink" class="text" /></dd>
		<dd>电影截图：<input type="text" name="CMS_PosterImage" class="text" /></dd>
    
    
		<dd><input type="submit" onclick="return check();" name="send" value="Submit" style=" margin-left:250px;" /></dd>
</form>

</body>
</html>