<!--#include file="UpLoad_Class.asp"-->
<%
dim upload
set upload = new AnUpLoad
upload.Exe = "*"
upload.MaxSize = 200 * 1024 * 1024 '2M
upload.GetData()
if upload.ErrorID>0 then 
	response.Write upload.Description
else
	dim file,savpath
	savepath = server.MapPath("../upload/images")
	for each frm in upload.forms("-1")
		response.Write frm & "=" & upload.forms(frm) & "<br />"
	next
	set file = upload.files("file1")
	if not(file is nothing) then
		result = file.saveToFile(savepath,0,true)
		if result then
		'response.Write "File" & file.LocalName & "Uploaded, Location" & server.MapPath(savepath & "/" & file.filename) & "File Size:" & file.size & "Byte"
        response.Write file.LocalName
        else
		response.Write "error"
		end if
	end if
end if
set upload = nothing
%>

