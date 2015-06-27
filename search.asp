<%@codepage = 936%>
<!--#include file="include/function.asp"-->
<!--#include file="conn.asp"-->
<%
	dim kind,keyword
	if request.form("send") = "" then
	 kind=request.QueryString("kind")
	 keyword=request.QueryString("keyword")
	else 
	kind = request.form("kind")
	keyword = trim(request.form("keyword"))
	end if
			

	

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<!--#include file="navleft.asp"-->
    <TD vAlign=top><TABLE border=0 cellSpacing=5 cellPadding=0 width="100%" height="100%">
      <TBODY>
        <TR>
          <TD vAlign=top>
          <TABLE border=0 cellSpacing=0 cellPadding=0 width=600>
          <TBODY>

            <H3>Search results</H3>
    <%
	dim i,title,keyword2,tag,info,errorstr,j

			if keyword = "" then
				errorHistoryBack("Input your Keyword!")
			end if
			
			set rs = server.createobject("adodb.recordset")
			if kind = 1 then
				sql = "select * from CMS_Movie where CMS_Title like '%"&keyword&"%'"
			elseif kind = 2 then
				sql = "select * from CMS_Movie where CMS_Keyword like '%"&keyword&"%'"
			elseif kind = 3 then
				sql = "select * from CMS_Movie where CMS_Title like '%"&keyword&"%' or CMS_Keyword like '%"&keyword&"%' or CMS_Content like '%"&keyword&"%' or CMS_Tag like '%"&keyword&"%'"
			end if

			rs.open sql,conn,1,1
			i = 1
			if rs.eof then
				errorstr = "No Record Found!"
				else 
				rs.pagesize=6
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
			end if			
			for j=1 to rs.pagesize
			if rs.eof then exit for					

				
				title = rs("CMS_Title")
				keyword2 = rs("CMS_Keyword")
				info = rs("CMS_Info")
				tag = rs("CMS_tag")
				CMSID=rs("CMS_ID")
				
				if kind = 3 then
					title = replace(title,keyword,"<span style='color:red'>"&keyword&"</span>")
					keyword2 = replace(keyword2,keyword,"<span style='color:red'>"&keyword&"</span>")
					info = replace(info,keyword,"<span style='color:red'>"&keyword&"</span>")
					tag = replace(tag,keyword,"<span style='color:red'>"&keyword&"</span>")
				elseif kind = 2 then
					keyword2 = replace(keyword2,keyword,"<span style='color:red'>"&keyword&"</span>")
				elseif kind =1 then
					title = replace(title,keyword,"<span style='color:red'>"&keyword&"</span>")
				end if
		
	%>
                    <TR>
                      <TD class=result-header width=15>No</TD>
                      <TD class=result-header width=15>&nbsp;</TD>
                      <TD class=result-header>Article title</TD>
                      <TD class=result-header>Search Tag</TD>
                      <TD class=result-header>Search KeyWord</TD>
                      <TD class=result-header>Author</TD>
                      <TD class=result-header>Post Date</TD>
                    </TR>
                    <TR style="BACKGROUND-COLOR: #e9e9e9" class=result-title 
                    onmouseover='this.style.background = "#99CCFF"' 
                    onmouseout='this.style.background = "#E9E9E9"'>
                      <TD align=middle></TD>
                      <TD bgColor=#66ff8c align=middle><IMG 
                        title="Asset type: Article" border=0 
                        src="search_files/new2.gif"></TD>
                      <TD><a style="font-size:12px;" href="flvplayer.asp?showId=<%=rs("CMS_ID")%>&height=360&width=630&modal=true&KeepThis=true" class="thickbox" title="<%=rs("CMS_Title")%>"><%=title%></a></TD>
                      <TD><%=tag%></TD>
                      <TD><%=keyword2%></TD>
                      <TD><%=rs("CMS_Name")%></TD>
                      <TD><%=rs("CMS_Date")%></TD>
                    </TR>

		<%
		i = i+1
				rs.movenext
			next	
		%>
        <p style="text-align:center; margin-top:10px; color:red"><%=errorstr%></p>
        <span>Page:</span>
            <%
	for i = 1 to rs.pagecount
		response.write "<a href='search.asp?kind="&kind&"&keyword="&keyword&"&page="&i&"'>" & i & "</a> | "
	next
%>
                  </TBODY>
                </TABLE>


              </div>
              
              </td>
              
              </tr>
              
              <tr>
                <td class="siemens_footer"><hr width="100%">
                  &copy;&nbsp;&nbsp;2012&nbsp;|&nbsp;For Internal Use Only </td>
              </tr>
            </table>
          </td>
          <td valign="top" class="color1"><div style="padding-top: 10px; padding-left: 7px;">
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
