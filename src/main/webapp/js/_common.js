$(document).ready(function(){
	
	//상단스크롤시
	$(window).scroll(function() { 
		if ($(document).scrollTop() > 0) {
			$("#head").addClass("head-down");
		} else { 
			$("#head").removeClass("head-down"); 
		}
	});
	
	//퀵메뉴스크롤시
	$(window).scroll(function() { 
		if ($(document).scrollTop() > 186) {
			$(".quick-menu-box").addClass("quick-down");
		} else { 
			$(".quick-menu-box").removeClass("quick-down"); 
		}
	});
	//퀵메뉴탑링크-스크롤시나타남
	$( window ).scroll( function() {
		if ( $( this ).scrollTop() > 186 ) {
			$( '.quick-btn-top' ).fadeIn();
		} else {
			$( '.quick-btn-top' ).fadeOut();
		}
	});
	//퀵메뉴탑링크-클릭시애니메이션
	$( '.quick-btn-top' ).click( function() {
		$( 'html, body' ).animate( { scrollTop : 0 }, 372 );
		return false;
	});
	  
	//상단메뉴
	$('#head .gnb').focusin(function(){
		$(this).addClass('gnb-on');
		$('#head').addClass('head-top');
	});
	$('#head .gnb').focusout(function(){
		$('#head').removeClass('head-top');
		$(this).removeClass('gnb-on');
	});
	$('#head .gnb').mouseover(function(){
		$(this).addClass('gnb-on');
		$('#head').addClass('head-top');
	});
	$('#head .gnb').mouseout(function(){
		$('#head').removeClass('head-top');
		$(this).removeClass('gnb-on');
	});
	
	//탭네비게이션
	var tab_list = $('.tab-menu-box');
	var tab_list_i = tab_list.find('>ul>li');
	tab_list_i.find('.tab-content').hide();
	tab_list.find('>ul>li[class=on]').find('>.tab-content').show();
	tab_list.css('height', tab_list.find('>ul>li.on>.tab-content').height()+50);
	function listTabMenuToggle(event){
		var t = $(this);
		tab_list_i.find('>.tab-content').hide();
		t.next('.tab-content').show();
		tab_list_i.removeClass('on');
		t.parent('li').addClass('on');
		tab_list.css('height', t.next('.tab-content').height()+50);
		return false;
	}
	tab_list_i.find('>a[href=#]').click(listTabMenuToggle).focus(listTabMenuToggle);
	
	//탭네비게이션 type2
    $(".tabcont").hide();
    $(".tabcont:first").show();
    $("ul.tabs li").click(function () {
	   $(".tabs li").removeClass("on");
	   $(this).addClass("on");
	   $(".tabcont").hide();
	   var onTab = $(this).attr("rel");
	   $("." + onTab).fadeIn();
    });
	
	//스마트검색
	$('.btn-smart-sch').click(function(){
		$('.smart-sch-box').toggleClass('smart-on');
	}); 
	
	//메뉴아코디언
	$(".ad-menu-tit").click(function(){
		if (!($(this).hasClass("menu-up"))) {
			$(".menu-up").toggleClass("menu-down");
		}
		$(this).toggleClass("menu-up");
		$(this).next(".ad-menu-content").slideToggle('fast');
	}); 
	
	//메뉴아코디언 type2
	$(".ad-menu-tit2").click(function() {
		if (!($(this).hasClass("menu-up"))) {
			$(".menu-up").toggleClass("menu-down menu-up");
		}
		$(this).toggleClass("menu-down menu-up");
		$(".menu-up").siblings(".ad-menu-content2").slideDown('fast');
		$(".menu-down").siblings(".ad-menu-content2").slideUp('fast');
	});
	
	//토글버튼
	/*
	$('.btn-toggle').click(function(){
		$('.btn-toggle').toggleClass('on');
		$('.toggle-cont-box').toggleClass('block');
	}); 	
   	*/
	$('.btn-toggle').click(function() {
		$(this).toggleClass('on');
		$(this).parent().parent().siblings('.toggle-cont-box').toggleClass('block');
	});
});