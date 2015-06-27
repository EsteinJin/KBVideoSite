function check() {
	if (document.add.title.value.length < 4 || document.add.title.value.length > 100) {		
		alert ("标题不小于4位，或者大于100位");
		document.add.title.focus();		
		return false;
	}
	
	if (document.add.name.value == "") {
		alert("发布人不得为空")	;
		document.add.name.focus();
		return false;
	}
	
	if (document.add.info.value.length < 10 || document.add.info.value.length > 200) {		
		alert ("内容简介不得小于10位，大于200位");
		document.add.info.focus();		
		return false;
	}
	

	
	return true;
}