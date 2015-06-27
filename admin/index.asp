<%
if session("Admin")="" then
response.Redirect("admin_login.asp")
else
response.Redirect("admin_index.asp")
end if 
%>