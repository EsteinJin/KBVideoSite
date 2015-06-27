<%


%>

<title>Online KB Movies</title>
<link href="styles/grey.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="shortcut icon" href="images/favicon.ico" >
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style/grey.css" />
<script type="text/javascript" src="Script/jquery-latest.js"></script>
<script type="text/javascript" src="swfobject.js"></script>
<script type="text/javascript" src="Script/thickbox.js"></script>
<script src="images-lay-out/js/jquery.js" type="text/javascript"></script>
<script src="images-lay-out/js/jqzoom.pack.1.0.1.js" type="text/javascript"></script>
<script src="images-lay-out/js/jquery.jcarousel.pack.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="images-lay-out/js/jquery.jcarousel.css" />
<link rel="stylesheet" type="text/css" href="images-lay-out/skins/tango/skin.css" />
<link rel="stylesheet" type="text/css" href="images-lay-out/css/jqzoom.css" />
<style type = "text/css">
* {margin:0; padding:0;}
body {font-size:12px;}
ul {list-style:none;}
#pro_view {margin:12px;width:780px;}
#pro_infor {height:260px;}
#image_box {float:left;width:350px;height:251px;}
#image_box img {border:1px solid #ccc;width:335px;height:251px;}
#pro_baseinfo {float:left; width:430px;height:251px;}
#image_list {clear:both;height:50px;}
#image_list img {width:50px;height:38px; border:1px solid #ccc; padding:2px;cursor:pointer;}
</style>

<link rel="stylesheet" href="Common/thickbox.css" type="text/css" media="screen" />

<script language="JavaScript" type="text/JavaScript">
function change_view(obj_name)
                {
				
                   var aa=document.getElementById(obj_name);
                   if(aa.style.display=="")
                         {
                            aa.style.display="none";
                         }
                   else
                         {
                            aa.style.display="";
                         }
                }


</script>
<link rel="stylesheet" href="Common/thickbox.css" type="text/css" media="screen" />

</head><body>

<table border="0" margin="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
<tr>
  <td width="144" height="90" rowspan="2" class="keyvisual"><img src="image/logo.png" border="0" width="144" height="90" vspace="0" hspace="0" alt=""><img src="image/atos_logo.gif" style="" /></td>
  <td width="612" height="54"><table border="0" cellspacing="0" cellpadding="0" width="100%">
      <tr>
        <td></td>
        <td align="right"><div id="padding-right">&nbsp;</div></td>
      </tr>
    </table></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td height="36" class="color1" align="right">&nbsp;</td>
  <td class="color2"><div id="padding-left">
  </td>
</tr>
<tr>
  <td height="54" class="color1key"> Wellcome!</td>
  <td class="color2"><!-- top menu BEGIN -->
    <table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15">&nbsp;</td>
        <td><b> <a href="index.asp" class="site-nav">Home</a> &nbsp;|&nbsp;<a href="/index.asp " target="_blank" class="site-nav">MAN Portal</a>&nbsp;|&nbsp;<a href="/ATOSCTU/index.asp " target="_blank" class="site-nav">Application Portal</a> </td>
      </tr>
    </table></td>
  <td class="color3"></td>
</tr>
<tr>
  <td valign="top" class="color2" width="144" align="left"><div style="padding-top: 10px; padding-bottom: 5px; padding-left: 3px;"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Collaps & Expand</b></div>
    <div id="menuleft" class="leftmenucontainer">
      <%
			dim rs,sql
			set rs = server.createobject("adodb.recordset")
			sql = "select  * from CMS_Nav where CMS_Sid=0 order by CMS_Sort asc"
			rs.open sql,conn,1,1
			'ѭ����Ŀ
			'do while not rs.eof
			for i= 1 to rs.recordcount
			CMS_id=rs("CMS_ID")
		%>
      <ul >
        <li onClick="change_view('a<%=i%>')"><a href="#"><%=rs("CMS_NavName")%></a></li>
      </ul>
      <div id="leftmenu2"  >
        <ul id="a<%=i%>" style="display:none;"  >
          <%

		set rs3=server.createobject("adodb.recordset")
		newsql="select * from CMS_Nav where CMS_Sid="&CMS_id
		rs3.open newsql,conn,1,1
		for j=1 to rs3.recordcount
		'do while not rs3.eof 
		%>
          <li><a href="list.asp?ShowId=<%=rs3("CMS_ID")%>">--<%=rs3("CMS_NavName")%></a></li>
          <%
rs3.movenext
next
%>
        </ul>
      </div>
      <%
				rs.movenext
	next
		%>
    </div></td>
  </td>
