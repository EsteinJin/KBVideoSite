<%
	dim conn
	set conn = server.createobject("adodb.connection")  
	conn.connectionstring="Provider = Microsoft.Jet.OLEDB.4.0;Data Source="&server.mapPath("../db/Video.mdb") 
	conn.open 
	
	
	sub close_conn 
		conn.close
		set conn = nothing
	end sub
	
	sub close_rs 
		rs.close
		set rs = nothing
	end sub

	
%>
