<html>
<head>
<!--#include file="include/function.asp"-->
<!--#include file="conn.asp"-->
<script type="text/javascript" src="swfobject.js"></script>
<script type="text/javascript" src="../wmvplayer/silverlight.js"></script>
<script type="text/javascript" src="../wmvplayer/player.js"></script>




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
select case true
case instr(filename,".avi")>0 or instr(filename,".AVI")>0 or  (instr(filename,".mkv")>0 and instr(filename,"WMEPlay")<=0  )  or  (instr(filename,".mp4")>0  ) 
'and instr(filename,"heyzo_hd")>0
%>
<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >
<object classid="clsid:67DABFBF-D0AB-41fa-9C46-CC0F21721616" width="590" height="290" codebase="http://go.divx.com/plugin/DivXBrowserPlugin.cab">
  <param name="custommode" value="none" />
  <param name="autoPlay" value="false" />
  <param name="src" value="http://localhost/flvcode/upload/movies/<%=filename%>" />
  <embed type="video/divx" src="http://localhost/flvcode/upload/images/<%=filename%>" custommode="none" width="600" height="300" autoPlay="false"  pluginspage="http://go.divx.com/plugin/download/"> </embed>
</object>

<%
case instr(filename,".wmv")>0 
%>

<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >
	<div name="mediaspace" id="mediaspace"></div>
	<script type='text/javascript' src="silverlight.js"></script>
	<script type='text/javascript' src="wmvplayer.js"></script>
	<script type="text/javascript">
		var cnt = document.getElementById("mediaspace");
		var src = 'wmvplayer.xaml';
		var cfg = {
		
			file:'http://localhost/flvcode/upload/movies/<%=filename%>',
			image:'http://localhost/flvcode/upload/images/<%=postimg%>',
			height:'300',
			width:'590'
		};
		var ply = new jeroenwijering.Player(cnt,src,cfg);
	</script>


<%
case instr(filename,".ts")>0 or  instr(filename,".tp")>0 or instr(filename,".VOB")>0   or  instr(filename,".wmv")>0 or  instr(filename,".m2ts")>0 or  (instr(filename,".mkv")>0 and instr(filename,"WMEPlay")>0  ) or  instr(filename,".mpg")>0 or  instr(filename,".iso")>0 
%>

<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >
	<div name="mediaspace" id="mediaspace">
    
    <OBJECT ID="MediaPlayer" WIDTH="600" HEIGHT="300" CLASSID="CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95"
 STANDBY="Loading Windows Media Player components..." TYPE="application/x-oleobject">
 <PARAM NAME="FileName" VALUE="/flvcode/upload/movies/<%=filename%>">
 <PARAM name="autostart" VALUE="false">
 <PARAM name="ShowControls" VALUE="true">
 <param name="ShowStatusBar" value="false">
 <PARAM name="ShowDisplay" VALUE="false">

 </OBJECT>
    
    
    </div>
	


<%
case instr(filename,".wmv")>0 
%>

<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >
	<div name="mediaspace" id="mediaspace"></div>
	<script type='text/javascript' src="silverlight.js"></script>
	<script type='text/javascript' src="wmvplayer.js"></script>
	<script type="text/javascript">
		var cnt = document.getElementById("mediaspace");
		var src = 'wmvplayer.xaml';
		var cfg = {
		
			file:'http://localhost/flvcode/upload/movies/<%=filename%>',
			image:'http://localhost/flvcode/upload/images/<%=postimg%>',
			height:'300',
			width:'590'
		};
		var ply = new jeroenwijering.Player(cnt,src,cfg);
	</script>



<%
case instr(filename,".rmvb")>0
%>

<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >

<object id="vid" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width=950 height=530> 
<param name="_ExtentX" value="11298"> 
<param name="_ExtentY" value="7938"> 
<param name="AUTOSTART" value="-1"> 
<param name="SHUFFLE" value="0"> 
<param name="displaysize" value="3">
<param name="PREFETCH" value="0"> 

<param name="NOLABELS" value="-1"> 
<param name="SRC" value="http://localhost/flvcode/upload/movies/<%=filename%>"> 
<param name="CONTROLS" value="Imagewindow"> 
<param name="CONSOLE" value="clip1"> 
<param name="LOOP" value="0"> 
<param name="NUMLOOP" value="0"> 
<param name="CENTER" value="0"> 
<param name="MAINTAINASPECT" value="0"> 

<param name="BACKGROUNDCOLOR" value="#000000"> 


</object><BR><object id="vid2" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width=950 height=30> 


<param name="_ExtentX" value="11298"> 
<param name="_ExtentY" value="794"> 
<param name="AUTOSTART" value="-1"> 
<param name="SHUFFLE" value="0"> 

<param name="PREFETCH" value="0"> 
<param name="NOLABELS" value="-1"> 
<param name="SRC" value="http://localhost/flvcode/upload/movies/<%=filename%>"> 
<param name="CONTROLS" value="ControlPanel"> 
<param name="CONSOLE" value="clip1"> 
<param name="LOOP" value="0"> 
<param name="NUMLOOP" value="0"> 
<param name="CENTER" value="0"> 
<param name="MAINTAINASPECT" value="0"> 
<param name="BACKGROUNDCOLOR" value="#000000"> 
</object>





<%
case else 
%>

<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >

<div id="player1" style="background:#000000; "   ><a href="http://www.macromedia.com/go/getflashplayer">Get the Flash Player</a> to see this player.</div>
<script type="text/javascript">
	var s1 = new SWFObject("flvplayer.swf","single","600","300","7");
	s1.addParam("allowfullscreen","true");
	s1.addVariable("file","upload/movies/<%=filename%>");
	s1.addVariable("image","upload/images/<%=postimg%>");
	s1.addVariable("width","640");
	s1.addVariable("height","300");
	s1.write("player1");
</script>


<%
end select 
%>

</body>
</html>