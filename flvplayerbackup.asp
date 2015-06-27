<%
case instr(filename,".wmv")>0 and instr(filename,"adult")>0 
%>

<img src="images/close.png" style="float:right; padding-bottom:10px; width:10px; height:10px;"  onClick="tb_remove()" / >
	<div name="mediaspace" id="mediaspace"></div>
	<script type='text/javascript' src="silverlight.js"></script>
	<script type='text/javascript' src="wmvplayer.js"></script>
	<script type="text/javascript">
		var cnt = document.getElementById("mediaspace");
		var src = 'wmvplayer.xaml';
		var cfg = {
		
			file:'http://192.168.0.102/flvcode/upload/<%=filename%>',
			image:'http://192.168.0.102/flvcode/upload/images/<%=postimg%>',
			height:'300',
			width:'590'
		};
		var ply = new jeroenwijering.Player(cnt,src,cfg);
	</script>

