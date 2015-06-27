// JavaScript Document

function trim(str)
{
     return str.replace(/(^\s*)(\s*$)/g,"");
}


function IsTime()
{
var str = trim(document.getElementById("str").value)
if(str.length==0)
{
alert("Time Can't be null!")
document.getElementById("str").focus();
}
else 
{
//
if(str<10)
{
var str="00"+":"+"0"+str+":"+"00";
}
else if(str>=10)
{
var str="00"+":"+str+":"+"00";
}

}

if(str.length!=0)
{
reg=/^((20|21|22|23|[0-1]\d)\:[0-5][0-9])(\:[0-5][0-9])?$/;
if(!reg.test(str)){    
            alert("Incorrect Time Format!");   
			document.getElementById("str").focus();
}
else if(str=="00:00:00")  
{
 alert("Can't be 0 Sec！");
 document.getElementById("str").focus();
} 


document.getElementById("str").value=str;
}
}