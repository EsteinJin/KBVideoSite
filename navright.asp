<div style="display: block; height: 0; font-size:0; clear: both; visibility:hidden;"></div>
<br />
 <form class="search" method="post" action="search.asp" style=" padding-left:2px; margin-top:2px;">
		
        <select name="kind" style="width:60px;" >
			
            <option selected="selected" value="1">Title</option>
			<option value="2">Keyword</option>
			<option value="3">Potrion </option>
		</select>

		<input type="text" name="keyword" id="txtHint" style="width:90px; height:19px;"  />
<input id="MySearchBtn" type="submit" value="search"  name="send" style=" height:19px;" />
	</form>
    
    
<FORM method="GET" action="http://www.google.com/search" target="_blank">
  <table>
    <tr>
      <td>Search Google<br>
        <input type="hidden" name="domains" value="www.google.com">
        <INPUT TYPE="text" name="q" size="23" maxlength="255" value="" style="background-image: url(images/google2.jpg); background-repeat: no-repeat; background-position: 100% 0%;">
        <input type="hidden" name="hl" value="en">
        <INPUT type="submit" name="sa" VALUE=" go! ">
      </td>
    </tr>
  </table>
  <br>
</FORM>
<form name="microsoft" action="http://support.microsoft.com/search/?adv=&query=" method="get" target="_blank">
  <table>
    <tr>
      <td>Search Microsoft Knowledge Base<br>
        <input type="text" name="query" size="23" style="background-image: url(images/microsoft2.jpg); background-repeat: no-repeat; background-position: 100% 0%;">
        <input type="submit" value=" go! ">
    </tr>
    </td>
    
  </table>
  <br>
</form>
<br />
<div style="background: none; padding-left: 3px;">
  <table border="0" cellspacing="0" cellpadding="5" width="200">
    <tr style="background: #e8e8e8;">
      <td colspan="2"><select class="quick_links" onChange="window.open(this.options[this.selectedIndex].value,'_blank')">
          <option value="">--- Quick links ---</option>
<%
dim Friendrs, Friendsql
set Friendrs=server.createobject("adodb.recordset")
Friendsql="select * from FriendLink"
Friendrs.open Friendsql,conn,1,1
do while not Friendrs.eof 
%>
          <option value="<%=Friendrs("LinkAddress")%>"><%=Friendrs("LinkName")%></option>
<%
Friendrs.movenext 
loop

%>

        </select>
        
      </td>
    </tr>
    <tr style="background: #e8e8e8;">
      <td colspan="2"><br>
        <select class="quick_links" name="account_sel" onChange="window.open(this.options[this.selectedIndex].value,'_blank')">
          <option>- Customer Tools-</option>
          <%
dim Ctoolrs,Ctoolsql
set Ctoolrs=server.createobject("adodb.recordset")
Ctoolsql= "select * from ToolsName where ToolsCategory='Customer'"
Ctoolrs.open Ctoolsql,conn,1,1
if not Ctoolrs.eof then
do while not Ctoolrs.eof 

%>
          <option name="account_sel" style="background-color:yellow;" value="<%=Ctoolrs("ToolsLink")%>" class="style_bg"><%=Ctoolrs("ToolsName")%></option>
          <%
Ctoolrs.movenext
loop
end if 
	Ctoolrs.close
	set Ctoolrs = nothing

%>
        </select>
        </form>
      </td>
    </tr>
    <tr style="background: #e8e8e8;">
      <td><br><select class="quick_links" name="account_sel" onChange="window.open(this.options[this.selectedIndex].value,'_blank')">
          <option>- Agent Tools-</option>
          <%
dim Atoolrs,Atoolsql
set Atoolrs=server.createobject("adodb.recordset")
Atoolsql= "select * from ToolsName where ToolsCategory='ATOS'"
Atoolrs.open Atoolsql,conn,1,1
if not Atoolrs.eof then
do while not Atoolrs.eof 
%>
          <option name="account_sel" style="background-color:yellow;" value="<%=Atoolrs("ToolsLink")%>" class="style_bg"><%=Atoolrs("ToolsName")%></option>
          <%
Atoolrs.movenext
loop
end if 
Atoolrs.close
set Atoolrs = nothing

%>
        </select>
        </form>
        </td>
    </tr>
  </table><br>
  <table>
<%
	dim voters,votesql,votetitle,xrs,xsql,votesid
	'recordset是需要建立的，不是单纯变量，而是对象
	set voters = server.createobject("adodb.recordset")
	votesql = "select * from CMS_Vote where CMS_Level=1"
	voters.open votesql,conn,1,1
	
	if not voters.eof then
		votesid = voters("CMS_ID")
		votetitle = voters("CMS_VoteName")
	else
		votetitle = "error!"
	end if
	
	voters.close
	set voters = nothing
	
	set xrs = server.createobject("adodb.recordset")
	xsql = "select * from CMS_Vote where CMS_VoteSid="&votesid
	xrs.open xsql,conn,1,1
%>  

  <form method="post" action="vote.asp">
	<dl class="vote">
		<dt><%=votetitle%></dt>
		<%
			do while not xrs.eof
		%>
		<dd><input type="radio" name="vote" value="<%=xrs("CMS_VoteName")%>" /> <%=xrs("CMS_VoteName")%></dd>
		<%
				xrs.movenext
			loop
	xrs.close
	set xrs = nothing
		%>
		<dd><input type="submit" value="Vote" /> <input type="button" onClick="javascript:window.open('votex.asp','votex','width=500,height=500')" value="Check" /></dd>
	</dl>
	</form>
  </table>
  <table border="0" cellspacing="2" cellpadding="2" width="200">
    <tr style="background: #e8e8e8;">
      <td><a href="#" onClick="showhide('phalph'); return(false);"><img src="image/arrow.gif" hspace="5" border="0" />Phonetic alphabet</a> </td>
    </tr>
  </table>
  <div  id="phalph" style="display:none;">
    <table border="0" cellspacing="1" cellpadding="3" width="200">
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td width="10"><strong>A</strong></td>
        <td>Alpha</td>
        <td width="10"><strong>N</strong></td>
        <td>November</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>B</strong></td>
        <td>Bravo</td>
        <td><strong>O</strong></td>
        <td>Oscar</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>C</strong></td>
        <td>Charlie</td>
        <td><strong>P</strong></td>
        <td>Papa</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>D</strong></td>
        <td>Delta</td>
        <td><strong>Q</strong></td>
        <td>Quebec</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>E</strong></td>
        <td>Echo</td>
        <td><strong>R</strong></td>
        <td>Romeo</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>F</strong></td>
        <td>Foxtrot</td>
        <td><strong>S</strong></td>
        <td>Sierra</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>G</strong></td>
        <td>Golf</td>
        <td><strong>T</strong></td>
        <td>Tango</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>H</strong></td>
        <td>Hotel</td>
        <td><strong>U</strong></td>
        <td>Uniform</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>I</strong></td>
        <td>India</td>
        <td><strong>V</strong></td>
        <td>Victor</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>J</strong></td>
        <td>Juliet</td>
        <td><strong>W</strong></td>
        <td>Whiskey</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>

        <td><strong>K</strong></td>
        <td>Kilo</td>
        <td><strong>X</strong></td>
        <td>X-Ray</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>L</strong></td>
        <td>Lima</td>
        <td><strong>Y</strong></td>
        <td>Yankee</td>
      </tr>
      <tr style="background-color: #dedede" onmouseover='this.style.background = "#AAAAAA"' onmouseout='this.style.background = "#dedede"'>
        <td><strong>M</strong></td>
        <td>Mike</td>
        <td><strong>Z</strong></td>
        <td>Zulu</td>
      </tr>
      
    </table>
  </div>
</div>
</td>
</tr>
</table>