<%@codepage = 936%>


<!--#include file="../include/function.asp"-->

<!--#include file="conn.asp"-->
<%

	if session("Admin") = "" then
		call sussLoctionHref("Error Occured!","admin_login.asp")
	end if
	
	'������ӵ�����
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
		
		'��ʼʹ��VBScript���ֶν�����֤
		
		'����=>����Ϊ�ղ��Ҳ�������4λ�����ܴ���100λ
		if len(title) < 4 or len(title) > 100 then
			call errorHistoryBack("���ⲻС��4λ�����ߴ���100λ")
		end if
		
		'�����߲���Ϊ��
		if name = "" then
			call errorHistoryBack("�����˲���Ϊ��")
		end if
		
		'���ݼ��
		if len(info) < 10 or len(info) > 200 then
			call errorHistoryBack("���ݼ�鲻��С��10λ������200λ")
		end if 
		
		'��Ҫ����
		
		
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
		
		'�������֮ǰ���Ƚ���Tag��ǩ����ӻ����
		dim tagArr,i,tagrs,tagsql
		tagArr = split(tag,",")  'ͨ��split��������Tag��ǩ����
		
		'ͨ��ȡ����������±��������Tag��ǩ���в���
		for i = lbound(tagArr) to ubound(tagArr)
			'ȡ�ñ�ǩ�����ж��Ƿ������ݿ����������ǩ
			'����У����ۼ�+1
			'���û�У�������һ��Tag��ǩ
			set tagrs = server.createobject("adodb.recordset")
			tagsql = "select * from CMS_Tag where CMS_TagName='"&tagArr(i)&"'"
			tagrs.open tagsql,conn,1,1
			
			if not tagrs.eof then
				'�����ݣ��ۼ�
				sql = "Update CMS_Tag Set CMS_TagCount=CMS_TagCount+1 where CMS_TagName='"&tagArr(i)&"'"
				conn.execute(sql)
			else
				'û���ݣ�����	
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
<title>��̨����</title>
<link rel="stylesheet" type="text/css" href="style/admin.css" />
<script type="text/javascript" src="js/content.js"></script>
</head>
<body>

<form name="add" id="articleadd" method="post" action="admin_article_add.asp">
	<dl>
		<dt>�뷢������</dt>
		<dd>ѡ�����
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
		<dd>��Ӱ���⣺<input type="text" name="title" class="text" /></dd>
		<dd>
				��Ӱ���ͣ�
				<input type="checkbox" class="radio" name="top" value="1" /> <span  style="color:red; font-weight:bold;">�ö�</span>
				<input type="checkbox" class="radio" name="rmp" value="1" /> <span  style="color:red; font-weight:bold;">�ַ�</span>
			    <input type="checkbox" class="radio" name="bold" value="1" /> ����
				<input type="checkbox" class="radio" name="pic" disabled="disabled" value="1" /> ����                
		</dd>
		<dd>��ɫ���ͣ�
			<input type="radio" name="color" value="black" checked="checked" /> ��ɫ
			<input type="radio" name="color" value="red" /> ��ɫ
			<input type="radio"  name="color" value="green" /> ��ɫ
		</dd>
		<dd>TAG ��ǩ��<input type="text" name="tag" class="text" /> (�����ǩ��ʹ��Ӣ�Ķ���","����)</dd>
		<dd>�� �� �֣�<input type="text" name="keyword" class="text" /> (����ؼ�����ʹ��Ӣ�Ķ���","����)</dd>
		<dd>�� �� �ߣ�<input type="text" name="name" value="<%=session("Admin")%>" class="text" /></dd>
		<dd>
				��Ӱ��飺<textarea cols="30" rows="2" name="info"></textarea>	
		</dd>
		

	</dl>
    
    <p>�ϴ���Ӱ��<iframe scrolling="no" frameborder="0" src="Uploadform.asp" style="height:35px; border:none; width:600px; "></iframe></p>

 <p>�ϴ���ͼ��<iframe scrolling="no" frameborder="0" src="posteruploadform.asp" style="height:35px; border:none; width:600px; "></iframe></p>
		<dd>��Ӱ���ӣ�<input type="text" name="CMS_MovieLink" class="text" /></dd>
		<dd>��Ӱ��ͼ��<input type="text" name="CMS_PosterImage" class="text" /></dd>
    
    
		<dd><input type="submit" onclick="return check();" name="send" value="Submit" style=" margin-left:250px;" /></dd>
</form>

</body>
</html>