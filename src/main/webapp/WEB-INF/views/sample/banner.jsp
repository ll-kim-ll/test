<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate var="dateTxt" value="${ now }" pattern="yyyyMMddHHmm" />
<fmt:parseNumber var="now" type="number" value="${dateTxt}" />
<!-- 언제까지 공개할지 날짜 세팅 -->
<c:if test="${ now <= 202206242359 }">
<!--  메인 상단 팝업베너 START -->
   <!-- #1 배너 스타일 -->
   <style>
      /**************** 메인 팝업 베너 시작 *****************/
      /* #banner_box { width:100%; background-color:#efefef; color:#f1f1f1; overflow:hidden;}*/
      .popContents { width:1200px; position:relative; margin:0 auto; padding:0; overflow:hidden; text-align:center;}
      .popClose { position:absolute; left: 0px; width:100%; top: 10px; text-align:right; font-size:9pt; padding-bottom:10px;}
      /* .btnClose { display:inline-block; background:url(../images/banner/btn-close.png) no-repeat 50% 50%; width:16px; height:16px; text-indent:-99999px; overflow:hidden; color:rgba(255,255,255,0); position:relative; bottom:-2px; } */
      #chkday { color:#5a5a5a;}
      label[for=chkday] { cursor:pointer; color:black; padding-right:0px;}
      /* #banner_box.top-banner-bg { background:#4a32c7 url(/images/banner/banner-bg.jpg) no-repeat 50% 50%; background-color:#4a32c7;}
      #banner_box.top-banner-bg .popClose label[for=educhkday] { color:#fff;}
      #banner_box.top-banner-bg .popClose .btnClose { background-image:url(/images/banner/btn-close-w.png);}
      #banner_box label { color: #fff;}*/
      /**************** //메인 팝업 베너 끝 *****************/
   </style>
   <!-- #2 배너 html -->
   <div id="banner_box" class="top-banner-bg">
      <div class="slider">
         <c:if test="${cookie.chkday1.value eq done}">
              <div class="header_popup_wrap h_p_bg02"">
                 <div class="header_popup_inner">
                    <a href="http://idw2022.org" target="_blank">
                      <div class="h_p_info" style="width: 1200px; height: 140px;">
                      	<img src="<c:url value='/images/111.png' />" />
                      </div>
                     </a>
                     <div class="h_p_button">
                         <label><input type="checkbox" id="chkday1">일주일동안 열지 않기</label>
                         <button type="button" class="h_p_close btnClose">닫기</button>
                     </div>
                 </div>
               </div>
            </c:if>
            <c:if test="${cookie.chkday2.value eq done}">
               <div class="header_popup_wrap h_p_bg03">
                 <div class="header_popup_inner">
                     <div class="h_p_info" style="width: 1200px; height: 140px;">
                     	<img src="<c:url value='/images/222.png' />" />
                     </div>
                     <div class="h_p_button">
                         <label><input type="checkbox" id="chkday2">일주일동안 열지 않기</label>
                         <button type="button" class="h_p_close btnClose">닫기</button>
                     </div>
                 </div>
                </div>
               <div class="header_popup_wrap h_p_bg03">
                 <div class="header_popup_inner">
                     <div class="h_p_info" style="width: 1200px; height: 140px;">
                     	<img src="<c:url value='/images/111.png' />" />
                     </div>
                     <div class="h_p_button">
                         <label><input type="checkbox" id="chkday2">일주일동안 열지 않기</label>
                         <button type="button" class="h_p_close btnClose">닫기</button>
                     </div>
                 </div>
                </div>
             </c:if>
		</div>

      <div class="slide-btn-box" style="">
         <button class="slick-prev" aria-label="Prev" type="button">Prev</button>
         <button class="slick-next" aria-label="Next" type="button">Next</button>
         <span class="banner-paging" style="font-family:Montserrat; font-size:13px; font-weight:300 !important; color:#fff; position: absolute; left: -33px; top: 4.5px;"></span>
         <button type="button" class="pbtn">슬라이드버튼</button>
      </div>

   </div>
   <button type="button" class="addImg">추가</button>
   <!-- #3 배너 스크립트 -->
   <script>
   //쿠키저장 함수
   function setCookie( name, value, expiredays ) {
      var todayDate = new Date();
      todayDate.setDate( todayDate.getDate() + expiredays );
      document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
   }

   $(document).ready(function(){
	   // 이미지 추가
	   $(".addImg").click(function(){
		   var html = '<div class="h_p_info" style="width: 1200px; height: 140px;">';
		   html += '<img src="<c:url value='/images/111.png' />" /></div>'

		   $("#banner_box").append(html);
	   });

      //닫기 이벤트
      $("#banner_box .btnClose").click(function(){
    	 var checkId = $(this).prev().children('input:eq(0)').attr("id");
         //오늘만 보기 체크박스의 체크 여부를 확인 해서 체크되어 있으면 쿠키를 생성한다.
         if($("#"+checkId).is(':checked')){
            setCookie(checkId, "done" , 7 );
         }
         //팝업창을 위로 애니메이트 시킨다. 혹은 slideUp()
         var removeIndex = $("#banner_box .btnClose").index(this);
//         $(".slider").children("div .header_popup_wrap:eq("+removeIndex+")").empty();
		if(removeIndex == 0){
	         $('#banner_box').slideUp(500);
		}
		else{
			$('.slider').slick('slickRemove', removeIndex-1);
		}
      });
   });

   //slick slider 적용 자동 슬라이드
   $('.slider').slick({
     autoplay: true,
     autoplaySpeed: 7500,
     prevArrow: 'none',
     nextArrow: 'none'
   });
   </script>
   <!--  메인 상단 팝업베너 END -->
</c:if>