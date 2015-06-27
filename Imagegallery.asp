<script type="text/javascript">

$(function() {

    // 放大镜
    var options =
    {
        zoomWidth: 620,
        zoomHeight: 340,
        showEffect:'show',
        hideEffect:'fadeout',
        fadeoutSpeed: 'slow',
        title :false
    }
    $(".jqzoom").jqzoom(options);

    // 图片左右滚动
    $('#image_list').jcarousel();

    // 点击小图更换大图
    $('#image_list img:only-child').click(function(){
        $('#current_img').attr('src', this.src);
        // 大图的命名方式为 小图 + 下划线
        $('#current_img').parent().attr('href', this.alt);
    });
});
</script>

<div id="pro_view">
		<div id="pro_infor">
			<div id="image_box">
				<a href="images-lay-out/images/1_.jpg" class="jqzoom" title=""><img src="images-lay-out/images/1.jpg"  alt="" id="current_img"></a>
			</div>
			<div id="pro_baseinfo">
            <marquee direction="left"> 
<% 



 set imgrs= server.CreateObject("adodb.recordset")
 Randomize
 imgsql = "select  top 5  *  from 27 order by rnd(-(id+" & rnd() & "))"
 
  
 imgrs.open imgsql,conn,1,1
 do while not imgrs.eof 
%>
				<a href="images-lay-out/27Old/<%=imgrs("OldName")%>" target="_blank"><img style="width:300px; height:250px" src="images-lay-out/27Old/<%=imgrs("OldName")%>" alt="images-lay-out/27Rename/<%=imgrs("NewName")%>" /></a>
<%
imgrs.movenext
loop
%>
</marquee>
			</div>
		</div>
	
		<ul id="image_list" class="jcarousel-skin-tango">

<%
imgrs.movefirst
 do while not imgrs.eof 
%>
			<li><img src="images-lay-out/27Old/<%=imgrs("OldName")%>" alt="images-lay-out/27Rename/<%=imgrs("NewName")%>" /></li>
<%
imgrs.movenext
loop
%>
		</ul>
	</div>
          