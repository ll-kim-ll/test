/*import * from './import1.js';
import {default} from './import1.js';
import {WFWModule1, WFWModule2} from './import1.js';
import {WFWModule3, WFWModule4} from './import2.js';
*/
import {WFWModule1, WFWModule2} from './import1.js';
import {WFWModule3, WFWModule4} from './import2.js';

function WRModule() {}

WRModule.prototype.WFWModule1 = new WFWModule1();
WRModule.prototype.WFWModule2 = new WFWModule2();
WRModule.prototype.WFWModule3 = new WFWModule3();
WRModule.prototype.WFWModule4 = new WFWModule4();

var TEST = new WRModule();

console.log("default");

$(document).ready(function() {
	console.log("======================================================");
	console.log("======================  export  ======================");
	console.log("======================================================");

	TEST.WFWModule1.init();
	TEST.WFWModule2.init();
	TEST.WFWModule3.init();
	TEST.WFWModule4.init();

});
