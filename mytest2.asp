<OBJECT classid='clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B' width="320" height="240" codebase='http://www.apple.com/qtactivex/qtplugin.cab'>
 <param name='src' value="http://mydomain.com/video.mov">
 <param name='autoplay' value="true">
 <param name='controller' value="false">
 <param name='loop' value="false">
 <EMBED src="http://mydomain.com/video.mov" width="320" height="240" autoplay="true" 
controller="false" loop="false" bgcolor="#000000" pluginspage='http://www.apple.com/quicktime/download/'>
 </EMBED>
 </OBJECT> 
 
 
<script type="text/javascript" src="silverlight.js"></script>
 
<script type="text/javascript"  src="wmvplayer.js"></script>
 
               
 
<div id="mediaspace"></div>
 
               
 
<script type="text/javascript">
 
var cnt = document.getElementById("mediaspace");
 
var src = "wmvplayer.xaml";
 
var cfg = {height:"250", width:"370", file:"http://www.longtailvideo.com/jw/upload/silverlight.w mv"};
 
var ply = new jeroenwijering.Player(cnt,src,cfg);
 
</script>
