<!--#include file="conn.asp"--> 
<!--#include file="../include/function.asp"-->
<% 
dim showid
	showid = request.querystring("ShowId")
	if showid = "" or not isnumeric(showid) then
		call errorHistoryBack("error Occured!")
	end if
strC = "<rss version=""2.0"" xmlns:media=""http://search.yahoo.com/mrss/"">" & vbcrlf 
strC = strC&"<channel>" & vbcrlf    

set rs = server.CreateObject("adodb.recordset") 
sql = "select * from CMS_Movie  where CMS_Sort="&showid&" order by CMS_Title" 
rs.open sql,conn,1,1 
do while not rs.eof 
	strC = strC&"<item>" & vbcrlf
	strC = strC&"<title>"&rs("CMS_Title")&"</title>" & vbcrlf	    
	strC = strC&"<link></link>" & vbcrlf	
	strC = strC&"<description>"&rs("CMS_Title")&"</description>" & vbcrlf		 
	strC = strC&"<media:credit role=""author"">ShangXue.Jin</media:credit>" & vbcrlf	
	strC = strC&"<media:content url=""/flvcode/upload/movies/"&rs("CMS_MovieLink")&""" />" & vbcrlf	
	strC = strC&"</item>" & vbcrlf    	
rs.movenext 
loop 
strC = strC&"</channel>" & vbcrlf    
strC = strC&" </rss>" & vbcrlf    
'response.Write strC
set navrs= server.CreateObject("adodb.recordset") 
navsql="select * from CMS_Nav where CMS_Sort="&showid
navrs.open navsql,conn,1,1
if not navrs.eof then 
filename=navrs("CMS_NavName")
end if 
filePath="/jw/upload/"&filename&".xml"
call saveXml(strC,filePath) 
response.Write "OK"

Function saveXml(Text,FileName)    
dim xmldoc,path 
set xmldoc= server.CreateObject("MSXML.DOMDocument") 
path = Server.MapPath(FileName) 
xmldoc.LoadXML(Text) 
xmldoc.save(path) 
set xmldoc= nothing 
End Function 


%>