<html>
<head>
<!--#include file="include/function.asp"-->
<!--#include file="conn.asp"-->
<script type="text/javascript" src="swfobject.js"></script>
<style type="text/css">
*{ margin:0px; padding:0px; background:#000000;}
body{ overflow:hidden;}

</style>
<%
	dim showid
	showid = request.querystring("ShowId")
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("error Occured!")
	end if
	set rs = server.createobject("adodb.recordset")
	sql = "select * from CMS_Movie where CMS_ID="&showid
	rs.open sql,conn,1,1

	if rs.eof then
		call errorHistoryBack("No Menu Exists")
	else 
		filename = rs("CMS_MovieLink")
		postimg=rs("CMS_PosterImage")
	end if
	
	call close_rs	

%>
</head>
<body>
<%
if instr(filename,".avi") then 

%>
<object classid="clsid:67DABFBF-D0AB-41fa-9C46-CC0F21721616" width="600" height="300" codebase="http://go.divx.com/plugin/DivXBrowserPlugin.cab">
  <param name="custommode" value="none" />
  <param name="autoPlay" value="false" />
  <param name="src" value="upload/Adult/<%=filename%>" />
  <embed type="video/divx" src="upload/Adult/<%=filename%>" custommode="none" width="600" height="300" autoPlay="false"  pluginspage="http://go.divx.com/plugin/download/"> </embed>
</object>
<br />
No video? <a href="http://www.divx.com/software/divx-plus/web-player" target="_blank">Download</a> the DivX Plus Web Player. 

<%
else 
%>


<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >

<div id="player1" style="background:#000000; "   ><a href="http://www.macromedia.com/go/getflashplayer">Get the Flash Player</a> to see this player.</div>
<script type="text/javascript">
	var s1 = new SWFObject("flvplayer.swf","single","600","300","7");
	s1.addParam("allowfullscreen","true");
	s1.addVariable("file","upload/movies/<%=filename%>");
	s1.addVariable("image","upload/images/<%=postimg%>");
	s1.addVariable("width","600");
	s1.addVariable("height","300");
	s1.write("player1");
</script>


<%
end if 
%>

</body>
</html>