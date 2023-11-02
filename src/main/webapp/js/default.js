var context_root="";

function WRModule() {}

WRModule.prototype = new WFWModule(0);
WRModule.prototype.Auto = new WFWAutoLib();
var WR = new WRModule();

console.log("default");

$(document).ready(function() {
//		WR.init(body);
	console.log("default document ready => default.js");

	context_root=$('#context_root').val();
	WR.init(context_root, "wrapper_full");
	WR.Auto.init();

});
