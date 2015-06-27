<%@codepage = 65001%>
<!--#include file="include/function.asp"-->
<!--#include file="conn.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<!--#include file="navleft.asp"-->
        

  <td valign="top"><table border="0" width="100%" height="100%" cellspacing="5" cellpadding="0">
      <tr>
        <td valign="top"><img src="image/header-grey.jpg" border="0" width="600" height="100" vspace="0" hspace="0" alt=""><br>
          <br>
          <div id="win">
          <div id="win-header">Video List</div>
          <div id="win-body">
          <p>
<TABLE class=search2 border=0 cellSpacing=1 cellPadding=2 
                  width="100%">
		<tr><th>Title</th><th>Tag</th><th>KeyWord</th><th>Created By</th></tr>

<%
dim color,bold,rmp,pic
			set rs = server.createobject("adodb.recordset")
            sql = "select   * from CMS_Movie order by CMS_Date desc"
			rs.open sql,conn,1,1
			if not rs.eof then
			
			for i= 1 to 10 
%>

		 <TR style="BACKGROUND-COLOR: #e9e9e9" class=result-title 
                    onmouseover='this.style.background = "#AAAAAA"' 
                    onmouseout='this.style.background = "#E9E9E9"'>
        
        <td class="name"><a style="font-size:12px;" href="flvplayer.asp?showId=<%=rs("CMS_ID")%>&height=360&width=630&modal=true&KeepThis=true" class="thickbox" title=""><%=rs("CMS_Title")%></a>  </td><td><%=rs("CMS_Tag")%></td><td><%=rs("CMS_Keyword")%></td><td><%=rs("CMS_Name")%></td></tr>
		<%
	rs.movenext
next
end if 
		%>

                    </TR>
                  </TBODY>
                </TABLE>
                <TABLE border=0 cellSpacing=0 cellPadding=0 width=250>
                  <TBODY>          
          </p>
    <br>
 

    </div>
    </div>
    <!-- latest article & latest news BEGIN -->
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="300" valign="top" ><!-- latest article BEGIN -->
        </td>
        <td valign="top"></td>
      </tr>
    </table>
    </div>
    </td>
  </tr>
  <tr>
    <td class="siemens_footer"><hr width="100%">
      &copy;&nbsp;&nbsp;2012&nbsp;|&nbsp;For Internal Use Only </td>
  </tr>
</table>
</td>
<td valign="top" class="color1">
<div style="padding-top: 10px; padding-left: 7px;">
<div style="border: 1px solid #757575; width: 300px;">
  <div style="font-weight: bold; color: #FFFFFF; background: #757575; padding: 2px 0 2px 2px;">
    <table border="0" cellspacing="0" cellpadding="0" width="100%" style="color: #ffffff; font-weight: bold;">
      <tr>
        <td></td>
        <td width="30" align="right">&nbsp;</td>
      </tr>
    </table>
  </div>
  <div id="win-body"></div>
</div>
<!--#include file="navright.asp"-->



</body>
</html>
</body>
</html>