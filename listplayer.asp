<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="conn.asp"-->
	<style type="text/css">
		body { background-color: #fff; padding: 0 20px; color:#000; font: 13px/18px Arial, sans-serif; }
		a { color: #360; }
		h3 { padding-top: 20px; }
		ol { margin:5px 0 15px 16px; padding:0; list-style-type:square; }
	</style>

</head>
<body>
<%
dim showid
	


	showid = request.querystring("ShowId")
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("error Occured!")
	end if
	dim title
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Nav where CMS_ID="&showid
	rs.open sql,conn,1,1

	if rs.eof then
		call errorHistoryBack("No Menu Exists")
	else 
		filename = rs("CMS_NavName")&".xml"
	end if
response.Write filename	
	call close_rs
	%>

	<div id="mediaplayer"></div>
<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >	
<script type='text/javascript' src='../jwplayer.js'></script> 
<div id='mediaspace'>This text will be replaced</div> 
<script type='text/javascript'>
jwplayer('mediaspace').setup({
'flashplayer': '../player.swf',
'playlistfile': '/jw/upload/<%=filename%>',
'playlist': 'right',
'controlbar': 'bottom',
'width': '700',
'height': '400'
});
</script>
	<!-- END OF THE PLAYER EMBEDDING -->





</body>
</html>