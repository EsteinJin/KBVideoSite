<%@codepage = 65001%>
<!--#include file="include/function.asp"-->
<!--#include file="conn.asp"-->
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
		name = rs("CMS_NavName")
	end if
	
	call close_rs%>

<!--#include file="navleft.asp"-->
<td valign="top"><table border="0" width="100%" height="100%" cellspacing="5" cellpadding="0">
        <tr>
          <td valign="top">


</head>

<body>
            <div id="win">
              <CENTER>
              <DIV 
                  id=win-header>Articles List</DIV>
              <DIV id=win-body>
                <TABLE class=search2 border=0 cellSpacing=1 cellPadding=2 
                  width="100%">
                  <TBODY>
                    <TR>
                      <TD class=result-header width=15>No</TD>
                      <TD class=result-header width=135 >----<%=name%>--<a style="font-size:10px; color:red; font-weight:bold; background:#00FF99" href="listplayer.asp?showId=<%=showid%>&height=460&width=830&modal=true&KeepThis=true" class="thickbox" >Play All</a></TD>
                      <TD class=result-header>File Name</TD>
                      <TD class=result-header>Operation</TD> 

                      
                      
                    </TR>
                    <%
			dim color,bold,rmp,pic
			set rs = server.createobject("adodb.recordset")
            sql = "select  * from CMS_Movie where  CMS_Sort="&showid&" order by CMS_Date desc"
			rs.open sql,conn,1,1
			if not rs.eof then
			rs.pagesize=2
			page=cint(request.querystring("page"))
			if isnumeric(request.querystring("page")) then
		if request.querystring("page") = "" or cint(request.querystring("page"))<1 then
			rs.absolutepage = 1
			
		elseif cint(request.querystring("page"))>rs.pagecount then
			rs.absolutepage = rs.pagecount
		else
			rs.absolutepage = request.querystring("page")
		end if
	else
		rs.absolutepage = 1
	end if			
			
					
			for i=1 to rs.pagesize
			if rs.eof then exit for			
			
			
				title = rs("CMS_Title")
				
				cms_info=rs("CMS_Info")
				filename=rs("CMS_MovieLink")
				if len(cms_info)>50 then
					cms_info = left(cms_info,50)
					cms_info = cms_info & "..."
				end if 
				
			
			%>
                    <TR style="BACKGROUND-COLOR: #e9e9e9" class=result-title 
                    onmouseover='this.style.background = "#AAAAAA"' 
                    onmouseout='this.style.background = "#E9E9E9"'>
                      <TD align=middle><%=i%>.</TD>
                      <TD align=middle>
<a href="upload/images/<%=rs("CMS_PosterImage")%>"  class="thickbox"><img src="upload/images/<%=rs("CMS_PosterImage")%>" style="width:90px; height:90px;" /></a>                      
                      
                      </TD>
                      <TD><B><A class=site-nav 
                        href="">
                        <%
						if instr(filename,".rmvb")>0 then 
						%>
                        
                        <U><a style="font-size:12px;" href="flvplayer.asp?showId=<%=rs("CMS_ID")%>&height=600&width=1000&modal=true&KeepThis=true" class="thickbox" title="<%=rs("CMS_Title")%>"><%=title%></a></U></A></B></TD>
                     <%
					 else 
					 %>
                        <U><a style="font-size:12px;" href="flvplayer.asp?showId=<%=rs("CMS_ID")%>&height=360&width=630&modal=true&KeepThis=true" class="thickbox" title="<%=rs("CMS_Title")%>"><%=title%></a></U></A></B></TD>
                        <%
						end if
						%>
                     

<TD><a href="http://192.168.0.101/flvcode/upload/<%=rs("CMS_MovieLink")%>">Download</a></TD>

                      
                    </TR>
                    <TR style="BACKGROUND-COLOR: #e9e9e9">
                      <TD style="BACKGROUND-COLOR: #fff">&nbsp;</TD>
                      <TD colSpan=6><%=rs("CMS_Info")%></TD>
                      <%
				rs.movenext
			next	
end if 			
		%>


  

                    </TR>
                  </TBODY>
                </TABLE>
                <TABLE border=0 cellSpacing=0 cellPadding=0 width=500>
                  <TBODY>
                    <TR>
                      <TD width=100 align=right>&nbsp;&nbsp;</TD>
                       <TD align=right>Total:<span style="color:red;"><%=rs.pagecount%></span>Page</TD><TD align=middle>Total :<span style="color:red;"><%=rs.recordCount%></span>&nbsp;&nbsp;Records</TD>   
                      <%
					  if page<=1 then
					  %>
                      
                      <TD align=middle>Main | Previous</TD>
                      <%
					  else 
					  %>
                      <TD align=middle><a href="list.asp?ShowId=<%=showid%>&page=1">[Main]</a> <a href="list.asp?ShowId=<%=showid%>&page=<%=(page-1)%>">[Previous]</a></TD>
                      <%
					  end if 
					  if page>=rs.pagecount then 
					  %>
                      <TD align=middle>Next | End</TD>                      
                      <%
					  else
					  %>
                      <TD align=middle><a href="list.asp?ShowId=<%=showid%>&page=<%=page+1%>">[Next]</a> <a href="list.asp?ShowId=<%=showid%>&page=<%=rs.pagecount%>">[End]</a></TD>                      
                      
                      <%
					  end if 
					  %>
                      <TD width=50 
                  align=left>&nbsp;&nbsp;</TD>
                    </TR>
                  </TBODY>
                </TABLE>
                </CENTER>
              </DIV>
            </DIV>
            <CENTER>
            </div>
          </td>
        </tr>
        <tr>
          <td class="siemens_footer"><hr width="100%">
            &copy;&nbsp;&nbsp;2012&nbsp;|&nbsp;For Internal Use Only </td>
        </tr>
      </table></td>
    <td valign="top" class="color1">
    <div style="padding-top: 10px; padding-left: 7px;">
    <div style="border: 1px solid #757575; width: 300px;">
      <div style="font-weight: bold; color: #FFFFFF; background: #757575; padding: 2px 0 2px 2px;">
        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="color: #ffffff; font-weight: bold;">
          <tr>
            <td>Major incidents: 0</td>
            <td width="30" align="right">&nbsp;</td>
          </tr>
        </table>
        
      </div>
      <div id="win-body"></div>
    </div>

    <!--#include file="navright.asp"-->
 
</body>
</html>
