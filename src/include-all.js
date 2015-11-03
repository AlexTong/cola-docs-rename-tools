function includeAll(root) {
	var cacheBuster = "";

	function writeScriptlet(file) {
		document.write("<script language=\"JavaScript\" type=\"text/javascript\" charset=\"utf-8\" src=\"" + root + file + cacheBuster + "\"></script>");
	}

	function writeStyleSheet(file) {
		document.write("<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" href=\"" + root + file + cacheBuster + "\" />");
	}

	writeStyleSheet("caf-ui/3rd.css");
	writeStyleSheet("caf-ui/caf.css");

	writeScriptlet("jquery-2.1.3.js");
	writeScriptlet("caf-ui/3rd.js");
	writeScriptlet("caf-ui/caf.js");
}

includeAll(location.protocol + "//" + location.host + "/resources/");