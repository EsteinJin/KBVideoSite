function check() {
	if (document.login.adminname.value == "") {		
		alert ("请输入您登陆的用户名!");
		document.login.adminname.focus();		
		return false;
	}
	if (document.login.adminname.value.length < 2) {
		alert("用户名不能少于2位!");
		document.login.adminname.focus();
		return false;
	}
	if (document.login.adminpass.value == ""){
		alert ("请输入您的登陆密码！");	
		document.login.adminpass.focus();
		return false;
	}
	if (document.login.adminpass.value.length < 6){
		alert ("密码不能少于6位！");	
		document.login.adminpass.focus();
		return false;
	}
	if (document.login.yzm.value.length != 4){
		alert ("验证码必须是4位！");	
		document.login.yzm.focus();
		return false;
	}
	//is是，NaN  N表示Not,a,Number
	if (isNaN(document.login.yzm.value)) {
		alert ("验证码必须是数字！");	
		document.login.yzm.focus();
		return false;
	}
	return true;
}
