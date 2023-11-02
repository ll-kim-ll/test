function WFWAutoLib() {
	console.log("WFWAutoLib => wellrisingAutoLib.js");
};


/**
 * 라이브러리 초기화
 * @param ctx - 컨텍스트 루트
 * @param contentDiv - 로딩 컨텐츠 디비전 아이디 (default:content)
 */
WFWAutoLib.prototype.init = function() {
	this.table();
	this.tableMultiRow();
};

WFWAutoLib.prototype.table = function(){
	/* 테이블 리스트 클릭 */
	$("table").on('click',function(e) {
		if ($(e.target).is('td')) {
			var sel_row = $(e.target).parent('tr');
			var all_row = $(e.target).parent('tr').parent('tbody').find('tr');

			all_row.each(function(){
				$(this).removeClass("trClick")
			});

			sel_row.addClass("trClick");
		}
	});
}

/* 테이블 리스트 클릭 */
WFWAutoLib.prototype.tableMultiRow = function(){
	$("table").on('click',function(e) {
		if ($(e.target).is('td')) {
			var sel_row = $(e.target).parent('tr');
			var all_row = $(e.target).parent('tr').parent('tbody').find('tr');

			all_row.each(function(){
				$(this).removeClass("trClick")
			});

			var sel_row_index = sel_row.index();
			if(sel_row_index != 0 && sel_row_index%2 == 1){
				sel_row.addClass("trClick");
				$(e.target).parent('tr').parent('tbody').find('tr:eq('+(sel_row_index-1)+')').addClass("trClick");
			}
			else{
				sel_row.addClass("trClick");
				$(e.target).parent('tr').parent('tbody').find('tr:eq('+(sel_row_index+1)+')').addClass("trClick");
			}
		}
	});


    //$("#testId").mouseover( function () {
	$("table").on( "mouseover", function (e) {
		if ($(e.target).is('td')) {
			var sel_row = $(e.target).parent('tr');
			var all_row = $(e.target).parent('tr').parent('tbody').find('tr');

			all_row.each(function(){
				$(this).removeClass("trClick-hover")
			});

			if(sel_row.attr('class') != "trClick"){
				var sel_row_index = sel_row.index();
				if(sel_row_index != 0 && sel_row_index%2 == 1){
					sel_row.addClass("trClick-hover");
					$(e.target).parent('tr').parent('tbody').find('tr:eq('+(sel_row_index-1)+')').addClass("trClick-hover");
				}
				else{
					sel_row.addClass("trClick-hover");
					$(e.target).parent('tr').parent('tbody').find('tr:eq('+(sel_row_index+1)+')').addClass("trClick-hover");
				}
			}
		}
    });
}


