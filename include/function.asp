<%


	sub errorHistoryBack(info)
		response.write "<script>alert('"&info&"');history.back();</script>"
		response.end
	end sub
	

	sub sussLoctionHref(info,url) 
		response.write "<script>alert('"&info&"');location.href='"&url&"'</script>"
		response.end
	end sub
	
    sub ConfirmDel()
	    
	end sub
	
	
	
%>