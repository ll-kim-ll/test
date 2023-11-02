var console = window.console || {log:function(){}};

function WFWModule(logmode) {
	console.log("WFWModule => wellrisinglib.js");
	this._log_mode=logmode||0;	// 0 debug mode
};



/**
 * 라이브러리 초기화
 * @param ctx - 컨텍스트 루트
 * @param contentDiv - 로딩 컨텐츠 디비전 아이디 (default:content)
 */
WFWModule.prototype.init = function(ctx, contentDiv) {
	this._console = window.console || {log:function(){}};
	this._context_root=ctx||'';
	this._contentDiv=contentDiv||'content';
	this.ajax._parent=this;
	this.ajax._context_root=this._context_root;
	this.ajax.log=this.log;
	this.util._parent=this;
	this.util._contentDiv=contentDiv;
	this.util.log=this.log;

	this.log(0, 'initilized main.js');

	this.makePage();
};

/**
 * 로그 출력
 */
WFWModule.prototype.log = function(level, msg) {
	if(msg==undefined) {
		msg=leve;
		level=0;
	}
	if(this._log_mode<=level) {
		console.log(msg);
	}
};

/**
 * 라이브러리 버전을 가져온다.
 * @returns {String} - 버전 스트링 (Major
 */
WFWModule.prototype.getVersion = function() {
	return '0.9d';
};

/**
 * 버전을
 * @returns {String}
 */
WFWModule.prototype.getUpdate = function() {
	return '2015-10-19';
};

/**
 * getContextPath
 * @returns {String}
 */
WFWModule.prototype.getContextPath = function() {
    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
}

/**
 * context 주소의 절대 주소를 가져 온다.
 * @param ctx - 변환할 URL
 * @returns {String} - context root가 포함된 주소.
 */
WFWModule.prototype.getUrl = function(ctx) {
	if(typeof ctx== "string" && ctx.length>1) {
		if(ctx[0]!='/') ctx='/'+ctx;
	}
	return this._context_root+ctx;
};

WFWModule.prototype.eventInit = function() {
//	$("a").off("click");
	$("a").on("click", {module:this}, function(e) {
		var module=e.data.module;
		module.log(e.target);
		var item=null;
		if($(e.target).is("a")==false) {
			item=$(e.target).closest("a");
		}
		else item=$(e.target);
		var role=item.data("role")||"";
		if(role!="") {
			if(role=="paging") {
				this.log(0, 'this routine was deprecated');
				if($(item).closest("ul").hasClass('popupPagination')) {
					if(popupInstance!=null) {
						popupInstance.pagingProcess(item.closest('.pagination').attr('id'), item.data("page"));
					}
					else {
						module.log('popup instance not found in popupPagination called');
					}
				}
				else {
					if(pagingProcess!=null) {
						pagingProcess(item.closest('.pagination').attr('id'), item.data("page"));
					}
				}
			}
			else {
				if(role.match(/.*\.do$/g)) {
					var params = [
		              'height='+screen.height,
		              'width='+screen.width,
		              'fullscreen=yes'
		          ].join(',');

		          var popup = window.open(module._context_root+role, 'popup_window', params);
		          popup.moveTo(0,0);
		          return;
				}
				module.log('call url : '+role+".do");
				module.log('root dhtmlx count : '+$('.dhtmlxcalendar_dhx_skyblue').length);
//				if(destroyModule!=undefined && destroyModule!=null) destroyModule(context_root);
//				destroyModule=null;
				$('.dhtmlxcalendar_dhx_skyblue').remove();
				module.callPage(role+".do");
			}
		}
		else {
			var toggle=item.data("toggle")||"";
			if(toggle!="") {
				if(toggle=="modal") {
					var target=item.data("target")||"";
					$('#'+target).modal({show:true});
				}
			}
		}
	});
};

WFWModule.prototype.callPage = function(url, arg) {
//	var uri = encodeURIComponent(url);
//	document.location.hash=uri;
	var params=[];
	if(arg!=undefined && arg!=null && arg.length>0) {
		for(var i=0; i<arg.length; i++) {
			params[params.length]=arg[i].name+'='+encodeURIComponent(arg[i].value);
		}
	}

	if(params.length>0) {
//		$('#callPage').attr("action", this._context_root+'/main/mainPage.do');
//		$('#callPage>input[name="url"]').val(url);
//		$('#callPage>input[name="params"]').val(encodeURIComponent(params.join('&')));
//		$('#callPage').submit();
		location.href=this._context_root+url+"?"+params.join('&');
	}
	else {
//		$('#callPage').attr("action", this._context_root+'/main/mainPage.do');
//		$('#callPage>input[name="url"]').val(url);
//		$('#callPage>input[name="params"]').val("");
//		$('#callPage').submit();
		location.href=this._context_root+url;
	}
};

WFWModule.prototype.makeSelect = function() {
		$("select[data-code-api]").each(function() {
			var selector = $(this);
			var api = $(this).data('code-api');
			var code = $(this).data('code');
			var codeNm = $(this).data('code-nm');
			var textNm = $(this).data('text-nm');
			$.getJSON(api, "", function(data) {
				if(data.code!=200) {
					alert("code api "+api+" loading error : "+data.message);
					return;
				}
				var list = data.list;
				for(var k in list) {
					var r = list[k];
					selector.append("<option value='"+r[codeNm]+"'>"+r[textNm]+"</option>")
				}
			});
		});
	}


WFWModule.prototype.makeDiv = function(div) {
	var module=this;
	div.find("a").on("click", {module:this}, function(e) {
		var module=e.data.module;
		module.log(e.target);
		var item=null;
		if($(e.target).is("a")==false) {
			item=$(e.target).closest("a");
		}
		else item=$(e.target);
		var role=item.data("role")||"";
		if(role!="") {
			module.log('call url : '+role+".do");
			module.log('root dhtmlx count : '+$('.dhtmlxcalendar_dhx_skyblue').length);
//				if(destroyModule!=undefined && destroyModule!=null) destroyModule(context_root);
//				destroyModule=null;
			$('.dhtmlxcalendar_dhx_skyblue').remove();
			module.callPage(role+".do");
		}
	});
	div.children().find('input').each(function() {
		var role=$(this).data('role')||"";
		switch(role) {
		case 'auto': // 자동 완성
			var url=$(this).data('url')||"";
			$(this).autocomplete({
				_module: module,
				source: function(request, response ) {
					if($(this).attr("disabled")!="disabled")
			        $.ajax({
			            url: this.options._module._context_root+url,
						type: 'POST',
						dataType: 'json',
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			            data: {
			            	queryStr: request.term
			            },
			            success: function( data ) {
			              response( data );
			            }
			          });
			        },
			        minLength: 1,
			        select: function( event, ui ) {
			          console.log( ui.item ?
			            "Selected: " + ui.item.label :
			            "Nothing selected, input was " + this.value);
			        },
			        open: function() {
			          $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			        },
			        close: function() {
			          $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			        }
		     });
			break;
		}
	});
	var module=this;
	div.children().find('select').each(function() {
		var role=$(this).data('role')||"";
		switch(role) {
		case 'combo':
			var url=$(this).data('url')||"";
			var parent_filter=$(this).data('parent-filter')||"";
			var filter=$(this).data('filter')||"";
			var opt=$(this).data('opt')||"";
			var data=null;
			if(parent_filter!="") {
				var f=$('#'+parent_filter);
				var combo=$(this);
				f.change(function() {
					combo.empty();
				});
			}
			$(this).empty();
        	var default_val=$(this).data('default');
			if(filter!="") {
				var f=$('#'+filter);
				var combo=$(this);
				var filterChange=function(e) {
					var data={filter: $(e.target).val()};
					if(parent_filter!="") {
						data=$.extend(data, {parentFilter:$('#'+parent_filter).val()});
					}
					if(opt!="") {
						data=$.extend(data, {opt:opt});
					}
					$.ajax({
			            url: module._context_root+url,
			            combo: combo,
						type: 'POST',
						dataType: 'json',
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			            data: data,
			            success: function( data ) {
			            	var default_val=$(this.combo).data('default');
			            	var prompt = $(this.combo).data('prompt')||"";
			            	$(this.combo).empty();
			            	if(prompt!="") {
				            	var prompt_val = $(this.combo).data('prompt-val')||"";
			            		$(this.combo).append('<option value="'+prompt_val+'">'+prompt+'</option>');
			            	}
			            	for(var i=0; i<data.length; i++) {
//			            		if(data[i].code==default_val) $(this.combo).append('<option value="'+data[i].code+'" selected="selected">'+data[i].value+'</option>');
//			            		else $(this.combo).append('<option value="'+data[i].code+'">'+data[i].value+'</option>');
			            		$(this.combo).append('<option value="'+data[i].code+'">'+data[i].value+'</option>');
			            	}
			            	$(this.combo).val(default_val);
			            	$(this.combo).trigger("change");
			            }
			          });
				};
				f.change(filterChange);
/*
				combo.empty();
	        	if(default_val!="") {
	        		$(combo).append('<option value="'+default_val+'" selected="selected">'+default_val+'</option>');
	        	}
				filterChange({target:f[0]});
*/
			}
			else {
				if(opt!="") {
					data=$.extend(data, {opt:opt});
				}
	        	if(default_val!="") {
	        		$(this).append('<option value="'+default_val+'" selected="selected">'+default_val+'</option>');
	        	}
				$.ajax({
		            url: module._context_root+url,
		            combo: this,
					type: 'POST',
					dataType: 'json',
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            data: data,
		            success: function( data ) {
		            	var default_val=$(this.combo).data('default');
		            	var prompt = $(this.combo).data('prompt')||"";
		            	$(this.combo).empty();
		            	if(prompt!="") {
			            	var prompt_val = $(this.combo).data('prompt-val')||"";
		            		$(this.combo).append('<option value="'+prompt_val+'">'+prompt+'</option>');
		            	}
		            	for(var i=0; i<data.length; i++) {
		            		if(data[i].code==default_val) $(this.combo).append('<option value="'+data[i].code+'" selected="selected">'+data[i].value+'</option>');
		            		else $(this.combo).append('<option value="'+data[i].code+'">'+data[i].value+'</option>');
		            	}
		            	$(this.combo).val(default_val);
		            	$(this.combo).trigger("change");
		            }
		          });
			}
			break;
		}
	});
	div.find('button.popupButton').each(function() {
		$(this).children('.frmwrk').remove();
		$(this).prepend('<span class="frmwrk glyphicon glyphicon-search"></span>&nbsp;');
	});
};

WFWModule.prototype.makePage = function() {
	var module=this;
	WFWAjax.prototype.setCsrfToken();
	this.makeDiv($('#'+this._contentDiv));
	/* 셀렉트 박스만 그림 */
	//makeSelect();
};


function WFWMUtilDate() {};

WFWMUtilDate.prototype.strToDate = function(dStr) {
	var regiDate = dStr.replace(/-/g,'/');;
	return new Date(Date.parse(regiDate));
};

WFWMUtilDate.prototype.getDate = function(d) {
	if(d==null) d=new Date();
	var s =
		this.leftPad(d.getFullYear(), '0', 4) + '-' +
		this.leftPad(d.getMonth() + 1, '0', 2) + '-' +
		this.leftPad(d.getDate(), '0', 2);

	return s;
};

WFWMUtilDate.prototype.getDateTime = function(d) {
	if(d==null) d=new Date();
	var s =
		this.leftPad(d.getFullYear(), '0', 4) + '-' +
		this.leftPad(d.getMonth() + 1, '0', 2) + '-' +
		this.leftPad(d.getDate(), '0', 2)+' ' +
		this.leftPad(d.getHours(), '0', 2)+':' +
		this.leftPad(d.getMinutes(), '0', 2);

	return s;
};

/**
 * 날짜 해의 주 갯수를 리턴 한다.
 * @returns
 */
WFWMUtilDate.prototype.getWeeksYear = function() {
	var date = new Date(this.getFullYear(), 0, 1);
	if(date.getDay()>3) {
		date.setDate(date.getDate()+(7-date.getDay()));
	}
	else {
		date.setDate(date.getDate()-date.getDay());
	}
	var eDate = new Date(this.getFullYear()+1, 0, 1);
	return 1+Math.round((eDate.getTime()-date.getTime())/7/86400000);
};

/**
 * 현재 주를 리턴 한다.
 * @returns 현재 주수 (Number)
 */
WFWMUtilDate.prototype.getWeek = function() {
	var sdate = new Date(this.getFullYear(), 0, 1);
	var date = new Date(this.getTime());
	if(sdate.getDay()>3) {
		sdate.setDate(sdate.getDate()+(7-sdate.getDay()));
	}
	else {
		sdate.setDate(sdate.getDate()-sdate.getDay());
	}
//	date.setDate(date.getDate() + 3 - (date.getDay() + 6) % 7);
	return 1+Math.floor((date.getTime()-sdate.getTime())/86400000/7);
};

WFWModule.prototype.utildate = new WFWMUtilDate();



function WFWMUtil() {};

WFWMUtil.prototype.hashCode = function(s) {
	for(var h=0,i=0;i<s.length;h&=h){h=31*h+s.charCodeAt(i++);}return h;
};

/**
 * 엑셀 다운로드
 * @param tbl_id
 * @param filename
 */
WFWMUtil.prototype.downXls = function(tbl_id, filename) {
	var link = document.createElement('a');
	link.download = filename;
	link.href = 'data:,'+$('#'+tbl_id).html();
	link.click();
	$(link).remove();
};

/**
 * 페이지를 프린트 한다.
 * @param tbl_id
 * @param filename
 */
WFWMUtil.prototype.printPage = function(filename) {
	$('#'+this._contentDiv).print();
};

WFWMUtil.prototype.leftPad = function(n, c, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
		for (var i = 0; i < digits - n.length; i++)
		zero += c;
	}
	return zero + n;
};

WFWMUtil.prototype.fillFixedTbl = function(id, data, rowName) {
	var tbl=$('#'+id);
	var hdList = [];
	var rn=rowName;
	var rindex=0;
	$(tbl).children('colgroup').find('col').each(function() {
		var col = $(this).data('col')||"";
		if(col!="") {
			hdList[hdList.length]={
					column: col,
					index: rindex++
			};
		}
	});
	if(data.length==0) {
		var tbody=$(tbl).children('tbody');
		tbody.empty();
		tbody.append('<tr><td colspan="'+rindex+'">조회된 값이 없습니다.</td></tr>');
		return;
	}
	$.each(data, function(key, val) {
		var rowId = val[rn];
		var row = $(tbl).children('tbody').find('tr[data-row-id="'+rowId+'"]');
		if(row.length!=0) {
			for(var i=0; i<hdList.length; i++) {
				var head=hdList[i];
				var t=val[head.column]||"";
				row.find('td:eq('+head.index+')').text(t);
			}
		}
	});
};

/* Table Col Span */
WFWMUtil.prototype.fillTblData = function(id, data) {
	var tbl=$('#'+id);
	var hdList = [];
	var rindex=0;
	var keyValues = $(tbl).data('hidden-value')||"";
	$(tbl).children('colgroup').find('col').each(function() {
		var col = $(this).data('col')||"";
		if(col!="") {
			hdList[hdList.length]={
					column: col,
					index: rindex++,
					colspan: $(this).attr('colspan')||""
			};
		}
		else {
			hdList[hdList.length]={
					column: 'none',
					index: rindex++,
					colspan: $(this).attr('colspan')||""
					};
		}
	});
	var tbody = $(tbl).children('tbody');
	tbody.empty();
	if(data.length==0) {
		tbody.append('<tr><td colspan="'+rindex+'">조회된 값이 없습니다.</td></tr>');
		return;
	}
	$.each(data, function(key, val) {
		var rowtxt="<tr";
		if(keyValues!="") {
			$.each(keyValues.split(","), function() {
				var v=val[this]||"";
				if(v!="") {
					rowtxt = rowtxt+" data-"+this+"='"+v+"'";
				}
			});
		}
		rowtxt=rowtxt+">";
		tbody.append(rowtxt+'</tr>');
		var tr=tbody.children('tr:last');
		for(var i=0; i<hdList.length; i++) {
			var head=hdList[i];
			var v = val[head.column];
			var t=v||'&nbsp;';
			if(typeof v=="number") t=v||"0";

			if(head.column!='none') {
				if(head.colspan!='1') {
					tr.append('<td data-col="'+head.column+'" colspan="'+head.colspan+'">'+t+'</td>');
				}
				else {
					tr.append('<td data-col="'+head.column+'">'+t+'</td>');
				}
			}
			else {
				if(head.colspan!='1') {
					tr.append('<td colspan="'+head.colspan+'">'+t+'</td>');
				}
				else {
					tr.append('<td></td>');
				}
			}
		}
	});
};

/* Table Row Span */
WFWMUtil.prototype.rowTxtSpan = function(id, colIds) {
	var cols=colIds.split(',');
	var tbl=$('#'+id);
	var hdList = {};
	var cindex=0;
	$(tbl).children('colgroup').find('col').each(function() {
		var col = $(this).data('col')||"";
		if(col!="") {
			for(k in cols) {
				if(col==cols[k]) {
					hdList[col]={
							cid:cindex,
							colspan: $(this).attr('colspan'),
							k: "",
							last: null,
							count:0
					};
				}
			}
		}
		cindex++;
	});
	var tbody = $(tbl).children('tbody');
	tbody.children('tr').each(function() {
		for(var k in hdList) {
			var hd=hdList[k];
			var td=$(this).find('td[data-col="'+k+'"]');
			var k=td.text();
			if(hd.last==null) {
				hd.last=td;
			}
			else {
				if(hd.k!=k) {
					if(hd.count>0) {
						hd.last.attr('rowspan', hd.count+1);
					}
					hd.last=td;
					hd.count=0;
				}
				else {
					hd.count++;
					td.remove();
				}
			}
			hd.k=k;
		}
	});
	for(var k in hdList) {
		var hd=hdList[k];
		if(hd.count>0) {
			hd.last.attr('rowspan', hd.count+1);
		}
	}
};

WFWMUtil.prototype.validateForm = function(form, validateData) {
			var focusField=null;
			var f=$('#'+form);
			f.find('input,select,textarea').each(function() {
				_clearValidateItem(this);
			});
			for(var k in validateData) {
				var msg=validateData[k];
				var v=f.find('#'+k, 'input[name="'+k+'"]');
				if(v.length>0) {
					_setValidateItem(v[0], 'error', msg);
					if(focusField==null) focusField=v[0];
				}
			}
			if(focusField!=null) focusField.focus();
		};

WFWMUtil.prototype.clearValidateItem = function(f) {
	_clearValidateItem(f);
};

WFWMUtil.prototype.setValidateItem = function(f) {
	_setValidateItem(f, type, msg);
};

WFWModule.prototype.util = new WFWMUtil();


function WFWAjax() {};


WFWAjax.prototype.setCsrfToken = function() {
	try {
		var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
		var csrfHeader = $("meta[name='_csrf_header']").attr("content");
		var csrfToken = $("meta[name='_csrf']").attr("content");

		if(csrfParameter && csrfHeader && csrfToken) {
			// ajax가 호출 되는 전역
			$.ajaxSetup({
				beforeSend: function(xhr, settings) {
					if (!/^(GET|HEAD|OPTIONS)$/i.test(settings.type) && !this.crossDomain) {
						xhr.setRequestHeader(csrfHeader, csrfToken)
					}
				}
			});
			// form 자동 생성 부분 wellrisinglib.js 라이브러리 setCsrfToken() 처리

			$("form").each(function() {
/*
				var input = $("<input/>").attr({type:"hidden", name:csrfParameter, value:csrfToken});
				$(this).append(input);
*/
				$(this).append($('<input/>',{type:'hidden', name:csrfParameter, value:csrfToken}));
			});
		}
	} catch(e) {
		console.log(e);
	}
};

WFWAjax.prototype.getFormObject = function(form_id) {
	var formObj={};
	$('#'+form_id).find('input,select').each(function() {
		var nm=$(this).attr('name')||$(this).attr('id')||"";
		if(nm!="") {
			formObj[nm]=$(this).val();
		}
	});
	return formObj;
};

WFWAjax.prototype.getFormArray = function(form_id) {
	var formArray=[];
	var formIdx=0;
	$('#'+form_id).find('input,select').each(function() {
		var nm=$(this).attr('name')||$(this).attr('id')||"";
		if(nm!="") {
			formArray[formArray.length] = {name:nm, value:$(this).val()};
		}
	});
	return formArray;
};

WFWAjax.prototype.doAction = function(addr, args, callback, params) {
	$.ajax({
		url: this._context_root+addr,
		type: 'POST',
		dataType: 'json',
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data: args,
		params: params,
		_callback: callback
		}).done(function(data) {
			if(this._callback!=undefined && this._callback!=null) this._callback(data);
	});
};

WFWAjax.prototype.loadJson = function(url, param, callback) {
	$.ajax({
		url: this._context_root+url,
		type: 'POST',
		async: true,
		dataType: 'json',
		global: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data: param,
		_callback: callback
		}).done(function(data) {
			if(this._callback!=undefined && this._callback!=null) this._callback(data);
		});
};

WFWAjax.prototype.doPopup = function(popup_id, url, args, retfunc) {
	var retFuncVar=retfunc;
	var pid=popup_id;
	var context_root=this._context_root;
	var module=this;
	$("body").append('<div id="_popupDiv" class="modal" style="display:none;"></div>');

	$('#_popupDiv').load(this._context_root+url, args, function(response, status, xhr) {
		if ( status == "error" ) {
		    var msg = "팝업 로딩하는데 오류가 발생 했습니다.: ";
		    alert(msg);
		}
		else if(status=="success") {
			if(popupInstance!=undefined && popupInstance!=null) {
				popupInstance._log_mode=module._log_mode;
				popupInstance._contentDiv='_popupDiv';
				popupInstance.setContextRoot(context_root);
				popupInstance.setPopupId(pid);
				popupInstance.ajax._parent=popupInstance;
				popupInstance.util._parent=popupInstance;
				popupInstance.log=module.log;
//				popupInstance.gis._parent=popupInstance;

				loadPopupComplete=null;
				if(retFuncVar!=undefined) {
					retFuncVar(response);
				}
				$('#_popupDiv').modal();
				popupInstance.loadComplete();
			}
		}
	});
};

WFWAjax.prototype.loadTblData = function(url, param, tbl_id, paging_id, paging_func) {
	return $.ajax({
		url: this._context_root+url,
		type: 'POST',
		async: true,
		dataType: 'json',
		global: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data: param,
		_tblId: tbl_id,
		_paging_id: paging_id,
		_paging_func: paging_func,
		_module: this._parent
		}).done(function(result) {
			var keyValues = $('#'+this._tblId).data('hidden-value')||"";
			var thead = $('#'+this._tblId+' thead');
			var tbody = $('#'+this._tblId+' tbody');
			var tfoot = $('#'+this._tblId+' tfoot');
			var colCount=0;

			thead.find('tr:eq(0)').children().each(function() {
				var cs=Number($(this).attr('colSpan'))||1;
				colCount+=cs;
			});

			tbody.empty();
			if(result.data.length==0) {
				tbody.append('<tr><td colspan="'+colCount+'" style="text-align:center;">등록된 자료가 없습니다.</td></tr>');
			}
			else {
				var colIds = thead.find('th');

				for(var i=0; i<result.data.length; i++) {
					var rowtxt="<tr";
					if(keyValues!="") {
						$.each(keyValues.split(","), function() {
							var v=result.data[i][this]||"";
							if(v!="") {
								rowtxt = rowtxt+" data-"+this+"='"+v+"'";
							}
						});
					}
					rowtxt=rowtxt+">";

					for(var j=0; j<colIds.length; j++) {
						var val = result.data[i][$(colIds[j]).data('col')];
						var txt=val||'&nbsp;';
						if(typeof val=="number") txt=val||"0";

						var dataClass = $(colIds[j]).data('class')||"";

						if(dataClass != undefined && dataClass != null && dataClass != ""){
							rowtxt=rowtxt+'<td class="'+dataClass+'" data-col="'+$(colIds[j]).data('col')+'">'+txt+'</td>';
						}
						else{
							rowtxt=rowtxt+'<td data-col="'+$(colIds[j]).data('col')+'">'+txt+'</td>';
						}
					}
					rowtxt+='</tr>';
					tbody.append(rowtxt);
				}
			}
			if(result.summary!=undefined && result.summary!=null) {
				tfoot.find('td').each(function(td) {
					var id = $(this).data('col')||"";
					if(id!="") $(this).empty();
				});
				tfoot.find('td').each(function(td) {
					var id = $(this).data('col')||"";
					if(result.summary[id]!=undefined) {
						$(this).text(result.summary[id]);
					}
					else{
						$(this).empty();
						$(this).text("계");
					}
				});
			}
			else {
				tfoot.find('td').each(function(td) {
					var id = $(this).data('col')||"";
					if(id!="") $(this).text("0");
				});
			}
			if(this._paging_id!=undefined) {
				var paging=$('#'+this._paging_id);
				paging.empty();
				if(result.count > 0){
					var prevPage=(Number(result.paging.firstPageNoOnPageList)-1)||1;
					var nextPage=(Number(result.paging.lastPageNoOnPageList)+1);
					if(Number(result.paging.lastPageNo)<nextPage) nextPage=Number(result.paging.lastPageNo);
					paging.append('<li class="first-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="1" aria-label="First"><span aria-hidden="true">&laquo;&laquo;</span></a></li>');
//					if(result.paging.firstPageNoOnPageList!=result.paging.firstPageNo) {
						paging.append('<li class="prev-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+prevPage+'" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');
//					}
					for(var i=result.paging.firstPageNoOnPageList; i<=result.paging.lastPageNoOnPageList; i++) {
						if(i==result.paging.currentPageNo) {
							paging.append('<li class="active"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+i+'">'+i+'</a></li>');
						}
						else {
							paging.append('<li><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+i+'">'+i+'</a></li>');
						}
					}
//					if(result.paging.lastPageNoOnPageList!=result.paging.lastPageNo) {
						paging.append('<li class="next-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+nextPage+'" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
//					}
					paging.append('<li class="last-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+result.paging.lastPageNo+'" aria-label="Last"><span aria-hidden="true">&raquo;&raquo;</span></a></li>');
					if(this._module._contentDiv=='_popupDiv') {
						// 팝업이면
						paging.find('a').on('click', function() {
							popupInstance.pagingProcess($(this).data('target'), $(this).data("page"));
						});
					}
					else {
						paging.find('a').on('click', function() {
							pagingProcess($(this).data('target'), $(this).data("page"));
						});
					}
				}
			}
			if(this._paging_func!=undefined && this._paging_func!=null) this._paging_func(result);
		});
};

// 마우스 오버
WFWAjax.prototype.loadTblDataMultiRow = function(url, param, tbl_id, paging_id, paging_func) {
	return $.ajax({
		url: this._context_root+url,
		type: 'POST',
		async: true,
		dataType: 'json',
		global: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data: param,
		_tblId: tbl_id,
		_paging_id: paging_id,
		_paging_func: paging_func,
		_module: this._parent
		}).done(function(result) {
			var keyValues = $('#'+this._tblId).data('hidden-value')||"";
			var thead = $('#'+this._tblId+' thead');
			var tbody = $('#'+this._tblId+' tbody');
			var tfoot = $('#'+this._tblId+' tfoot');
			var colCount=0;

			thead.find('tr:eq(0)').children().each(function() {
				var cs=Number($(this).attr('colSpan'))||1;
				colCount+=cs;
			});

			tbody.empty();
			if(result.data.length==0) {
				tbody.append('<tr><td colspan="'+colCount+'" style="text-align:center;">등록된 자료가 없습니다.</td></tr>');
			}
			else {
				var rowIds = thead.find('tr');

				for(var i=0; i<result.data.length; i++) {
					var rowclass = "";
					if(i == 0 || i%2 == 0){
						var rowclass = "row-odd"
					}

					for(var j=0; j<rowIds.length; j++) {
						var rowtxt="<tr";
						if(keyValues!="") {
							$.each(keyValues.split(","), function() {
								var v=result.data[i][this]||"";
								if(v!="") {
									rowtxt = rowtxt+" data-"+this+"='"+v+"'"+"class='"+rowclass+"'";
								}
							});
						}
						rowtxt=rowtxt+">";
						var colIds = rowIds.eq(j).find('th');

						for(var k=0; k<colIds.length; k++) {
							var val = result.data[i][$(colIds[k]).data('col')];
							var txt=val||'&nbsp;';
							if(typeof val=="number") txt=val||"0";

							var dataClass = $(colIds[k]).data('class')||"";

							if(dataClass != undefined && dataClass != null && dataClass != ""){
								rowtxt=rowtxt+'<td class="'+dataClass+'" data-col="'+$(colIds[k]).data('col')+'">'+txt+'</td>';
							}
							else{
								rowtxt=rowtxt+'<td data-col="'+$(colIds[k]).data('col')+'">'+txt+'</td>';
							}
						}
						rowtxt+='</tr>';
						tbody.append(rowtxt);
					}
				}
			}
			if(result.summary!=undefined && result.summary!=null) {
				tfoot.find('td').each(function(td) {
					var id = $(this).data('col')||"";
					if(id!="") $(this).empty();
				});
				tfoot.find('td').each(function(td) {
					var id = $(this).data('col')||"";
					if(result.summary[id]!=undefined) {
						$(this).text(result.summary[id]);
					}
					else{
						$(this).empty();
						$(this).text("계");
					}
				});
			}
			else {
				tfoot.find('td').each(function(td) {
					var id = $(this).data('col')||"";
					if(id!="") $(this).text("0");
				});
			}
			if(this._paging_id!=undefined) {
				var paging=$('#'+this._paging_id);
				paging.empty();
				if(result.count > 0){
					var prevPage=(Number(result.paging.firstPageNoOnPageList)-1)||1;
					var nextPage=(Number(result.paging.lastPageNoOnPageList)+1);
					if(Number(result.paging.lastPageNo)<nextPage) nextPage=Number(result.paging.lastPageNo);
					paging.append('<li class="first-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="1" aria-label="First"><span aria-hidden="true">&laquo;&laquo;</span></a></li>');
//					if(result.paging.firstPageNoOnPageList!=result.paging.firstPageNo) {
						paging.append('<li class="prev-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+prevPage+'" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');
//					}
					for(var i=result.paging.firstPageNoOnPageList; i<=result.paging.lastPageNoOnPageList; i++) {
						if(i==result.paging.currentPageNo) {
							paging.append('<li class="active"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+i+'">'+i+'</a></li>');
						}
						else {
							paging.append('<li><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+i+'">'+i+'</a></li>');
						}
					}
//					if(result.paging.lastPageNoOnPageList!=result.paging.lastPageNo) {
						paging.append('<li class="next-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+nextPage+'" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
//					}
					paging.append('<li class="last-page"><a href="#" data-role="paging" data-target="'+tbl_id+'" data-page="'+result.paging.lastPageNo+'" aria-label="Last"><span aria-hidden="true">&raquo;&raquo;</span></a></li>');
					if(this._module._contentDiv=='_popupDiv') {
						// 팝업이면
						paging.find('a').on('click', function() {
							popupInstance.pagingProcess($(this).data('target'), $(this).data("page"));
						});
					}
					else {
						paging.find('a').on('click', function() {
							pagingProcess($(this).data('target'), $(this).data("page"));
						});
					}
				}
			}
			if(this._paging_func!=undefined && this._paging_func!=null) this._paging_func(result);
		});
};

WFWAjax.prototype.doActionMultipart = function(addr, args, callback) {
	$.ajax({
		url: this._context_root+addr,
		enctype: 'multipart/form-data',
		type: 'POST',
		cache: false,
		contentType: false,
		processData: false,
		data: args,
		_callback: callback
		}).done(function(data) {
			if(this._callback!=undefined && this._callback!=null) this._callback(data);
	});
};


WFWModule.prototype.ajax = new WFWAjax();

/* 테이블 이벤트 */
function WFWTable() {};

/**
 * 테이블 클릭
 * @param tbl_id - 테이블 아이디
 * @param pType - 파라미터 타입 array/json
 * @param callback - 콜백 함수


**/
WFWTable.prototype.tableClick = function(tbl_id, pType, callback) {
	// 테이블 클릭 이벤트
	$("#"+tbl_id+" > tbody").on("click", "td", function(e){
		if($(e.target).attr("colspan") != undefined && $(e.target).attr("colspan") != null && $(e.target).attr("colspan") != ""){
			return false;
		}
		var aParams =[];
		var jParams ={};
		var table = $(this).closest('table');

		var sel_row=$(e.target).parent('tr');
		$.each(sel_row.data(), function(k,v){
			console.log(k+"-"+v);
			aParams[aParams.length] = {"name":k, "value":v};
			jParams[k] = v;
		});

		if(callback!=undefined && callback!=null){
			if(pType == "array"){
				callback(aParams);
			}
			else if(pType == "json"){
				callback(jParams);
			}
		}
	});
};

/**
 * 테이블 데이터 바인드
 * @param tbl_id - 테이블 아이디
 * @param form_id - 데이터폼 아이디
 * @param callback - 콜백 함수
**/
WFWTable.prototype.tableDataBind = function(tbl_id, form_id, callback) {
	// 테이블 클릭 이벤트
	$("#"+tbl_id+" > tbody").on("click", "td", function(e){
		if($(e.target).attr("colspan") != undefined && $(e.target).attr("colspan") != null && $(e.target).attr("colspan") != ""){
			return false;
		}
		var sel_row = $(e.target).parent('tr');
		var td = sel_row.find('td');

//		var inputs = $('#mainForm').find(':input'); // 모든 버튼 까지 모든 속성을 가지고 온다.
		var input = $("#"+form_id).find('input');
		var select = $('#'+form_id).find('select');

		input.each(function() {
			var col = $(this).attr("name");

			td.each(function(){
				if($(this).data("col") == col){
					$("#"+col).val($(this).text());
				}
			})
		});

		select.each(function() {
			var col = $(this).attr("name");
			td.each(function(){
				if($(this).data("col") == col){
					$("#"+col).val($(this).text()).prop("selected", true);
				}
			})
		});

		if(callback!=undefined && callback!=null){
			callback();
		}


	});


};

WFWModule.prototype.table = new WFWTable();
