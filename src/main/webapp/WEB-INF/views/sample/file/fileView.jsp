<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="false" %>
<html>
<head>
	<style>
		/* 멀티 이미지 미리보기 */
        #imgs_wrap {
            width: 600px;
            margin-top: 50px;
        }
        #imgs_wrap img {
            max-width: 200px;
        }

		/* 멀티 이미지 미리보기(드래그 앤 드롭_이미지 순서변경) */
        .inputFile,#preview,#preview li{
		    float:left
		}
		.inputFile{
		    margin-bottom: 10px;
		}
		.addImgBtn{
		    width: 80px !important;
		    height: 80px !important;
		    line-height: 71px !important;
		    background-color: #fff !important;
		    color: #b7b7b7 !important;
		    border: 2px solid #b7b7b7;
		    font-size: 35px !important;
		    padding: 0 !important;
		}

		#preview{
		    margin-left: 20px;
		    width: 650px;
		}
		#preview li{
		    margin-left: 10px;
		    margin-bottom: 10px;
		    position: relative;
		    border: 1px solid #ececec;
		    cursor:move
		}
		.delBtn{
		    position: absolute;
		    top: 0;
		    right: 0;
		    font-size: 13px;
		    background-color: #000;
		    color: #fff;
		    width: 18px;
		    height: 18px;
		    line-height: 16px;
		    display: inline-block;
		    text-align: center;
		    cursor: pointer;
		}

		/* 멀티 이미지 미리보기(드래그 앤 드롭_파일 업로드) */
	    .drop-zone {
	        width: 800px;
	        height: 200px;
	        background-color: azure
	    }

	    .drop-zone-dragenter, .drop-zone-dragover {
	        border: 10px solid blue;
	    }
	</style>

	<sec:csrfMetaTags />
<!-- 드래그 앤 드롭 참고 사이트 https://inpa.tistory.com/270 -->
	<script>
		window.onload = function() {
			$(document).ready(function() {
				$("#btnFile").on("click", function(){
					selectFileInfs();
				});

				/* 단일 이미지 미리보기 */
/*
				$("#input-image").on("change", function(e){
					readImage(e.target)
				});
 */
				$('#input-image').change(function(e){
				    setImageFromFile(this, "preview-image");
				});

 				/* 멀티 이미지 미리보기 */
		        $(document).ready(function() {
		            $("#input_imgs").on("change", handleImgsFilesSelect);
		        });

 				/* 멀티 이미지 미리보기(드래그 앤 드롭_이미지 순서변경) */
				//드래그 앤 드롭
				$("#preview").sortable();

				//이미지 등록
				$("#addImgs").change(function(e){
					dragAndDropImgsFilesSelect(e);
				});

				$("#preview").on("click", ".delBtn", function(e){
					delImg(this);
					//$(this).parent('li').remove()
				});

 				/* 멀티 이미지 미리보기(드래그 앤 드롭_파일 업로드) */
	            $("#dFile").on("change", function(e) {
	                showFiles(e.target.files);
	            });

	            // 드래그한 파일이 최초로 진입했을 때
	            $(".drop-zone").on({"dragenter":function(e) {
		                e.stopPropagation();
		                e.preventDefault();

		                toggleClass("dragenter");
	            	},
		            // 드래그한 파일이 dropZone 영역을 벗어났을 때
	            	"dragleave":function(e) {
		                e.stopPropagation();
		                e.preventDefault();

		                toggleClass("dragleave");
	            	},
		            // 드래그한 파일이 dropZone 영역에 머물러 있을 때
		            "dragover":function(e) {
		                e.stopPropagation();
		                e.preventDefault();

		                toggleClass("dragover");

		            },
		            // 드래그한 파일이 드랍되었을 때
		            "drop":function(e) {
		                e.preventDefault();
		                toggleClass("drop");
		                var files = e.originalEvent.dataTransfer && e.originalEvent.dataTransfer.files
		                console.log(files);

		                if (files != null) {
		                    if (files.length < 1) {
		                        alert("폴더 업로드 불가");
		                        return;
		                    }
		                    selectFile(files);
		                } else {
		                    alert("ERROR");
		                }

		            }
	            });
			});
		}

		/* 단일 이미지 미리보기 */
/*
		function readImage(input) {
		    // 인풋 태그에 파일이 있는 경우
		    if(input.files && input.files[0]) {
		        // 이미지 파일인지 검사 (생략)
		        // FileReader 인스턴스 생성
		        const reader = new FileReader()
		        // 이미지가 로드가 된 경우
		        reader.onload = e => {
		            const previewImage = document.getElementById("preview-image")
		            previewImage.src = e.target.result
		        }
		        // reader가 이미지 읽도록 하기
		        reader.readAsDataURL(input.files[0])
		    }
		}
*/
	    function setImageFromFile(input, expression) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function (e) {
	                $("#"+expression).attr('src', e.target.result);
	            }
	            reader.readAsDataURL(input.files[0]);
	        }
	    }


		/* 멀티 이미지 미리보기 */
        function handleImgsFilesSelect(e) {
        	var sel_files = [];
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);

            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("확장자는 이미지 확장자만 가능합니다.");
                    return;
                }

                sel_files.push(f);

                var reader = new FileReader();
                reader.onload = function(e) {
                    var img_html = "<img src=\"" + e.target.result + "\" />";
                    $("#imgs_wrap").append(img_html);
                }
                reader.readAsDataURL(f);
            });
        }

        /* 멀티 이미지 미리보기(드래그 앤 드롭_이미지 순서변경) */
        function dragAndDropImgsFilesSelect(e){
            var files = e.target.files;
            var arr = Array.prototype.slice.call(files);

            //업로드 가능 파일인지 체크
            for(var i=0; i<files.length; i++){
                if(!checkExtension(files[i].name,files[i].size)){
                    return false;
                }
            }
            preview(arr);
		}

        function checkExtension(fileName,fileSize){
            var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            var maxSize = 20971520;  //20MB

            if(fileSize >= maxSize){
                alert('이미지 크기가 초과되었습니다.');
                $("#addImgs").val("");  //파일 초기화
                return false;
            }

            if(regex.test(fileName)){
                alert('확장자명을 확인해주세요.');
                $("#addImgs").val("");  //파일 초기화
                return false;
            }
            return true;
        }

        function preview(arr){
            arr.forEach(function(f){
                //파일명이 길면 파일명...으로 처리
                /*
                var fileName = f.name;
                if(fileName.length > 10){
                    fileName = fileName.substring(0,7)+"...";
                }
                */

                //div에 이미지 추가
                var str = '<li class="ui-state-default">';
                //str += '<span>'+fileName+'</span><br>';

                //이미지 파일 미리보기
                if(f.type.match('image.*')){
                    //파일을 읽기 위한 FileReader객체 생성
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        str += '<img src="'+e.target.result+'" title="'+f.name+'" width=80 height=80>';
//                        str += '<span class="delBtn" onClick="delImg(this)">x</span>';
                        str += '<span class="delBtn">x</span>';
                        str += '</li>';
                        $(str).appendTo('#preview');
                    }
                    reader.readAsDataURL(f);
                }else{
                    //이미지 파일 아닐 경우 대체 이미지
                    /*
                    str += '<img src="/resources/img/fileImg.png" title="'+f.name+'" width=60 height=60 />';
                    $(str).appendTo('#preview');
                    */
                }
            })
        }

        //이미지 삭제
        function delImg(delBtn){
            $(delBtn).parent('li').remove()
        }


        /* 멀티 이미지 미리보기(드래그 앤 드롭_파일 업로드) */
        var toggleClass = function(className) {
            console.log("current event: " + className)
            var list = ["dragenter", "dragleave", "dragover", "drop"]
            for (var i = 0; i < list.length; i++) {
                if (className === list[i]) {
                	$(".drop-zone").addClass("drop-zone-" + list[i])

                } else {
                	$(".drop-zone").removeClass("drop-zone-" + list[i])
                }
            }
        }

        var showFiles = function(files) {
            text = ""
            for(var i = 0, len = files.length; i < len; i++) {
                text += "<p>" + files[i].name + "</p>"
            }
            $(".drop-zone").html(text);
        }

        var selectFile = function(files) {
            // input file 영역에 드랍된 파일들로 대체
            console.log("selectFile")
            showFiles(files)
        }

		/* 스크립트 첨부파일 조회 로딩 */
		function selectFileInfs(){
			var url = "<c:url value='/util/file/selectFileInfs.do' />";
			var params ={"atchFileId":"FILE_FW_00045"};

			$.post(url,params)
				.done(function(data) {
			    	console.log("조회 되었습니다.");
			    	scriptFileLoad(data);
			  	})
			  	.fail(function(jqXHR) {
				    alert("조회 오류" );
				})
				.always(function(jqXHR) {
				});

		}

		/* 스크립트 첨부파일 화면 설정 */
		function scriptFileLoad(data){
			var text = ""
			console.log(data.updateFlag);
			console.log(data.fileListCnt);
			console.log(data.fileList);
			if(data.fileList.length > 0){
				for(var tmp of data.fileList){
					text += "<div>";

					if(data.updateFlag == "N"){
						text += "<a href=javascript:fn_downFile('"+tmp.atchFileId+"','"+tmp.fileSn+"')>";
						text += tmp.orignlFileNm+"&nbsp;["+tmp.fileSize+"&nbsp;byte]";
						text += "</a>"
						text += '<img src="<c:url value="/images/button/btn_del.png" />" class="cursor btnFileDel" data-atchFileId='+tmp.atchFileId+' data-fileSn='+tmp.fileSn+' onClick="javascript:deleteFileInfs(this);" alt="<spring:message code="title.fileDelete" />" >'
					}
					else{
						text += "<a href=javascript:fn_downFile('"+tmp.atchFileId+"','"+tmp.fileSn+"')>";
						text += tmp.orignlFileNm+"&nbsp;["+tmp.fileSize+"&nbsp;byte]";
						text += "</a>"
					}
					text += "</div>";
				}
			}
			else{
				text = "<div>첨부파일 없음.</div>"
			}
			$("#filrList").html(text);
		}

		/* 스크립트 첨부파일 삭제 */
		function deleteFileInfs(img){
			console.log($(img).attr("data-atchFileId"));
			console.log($(img).attr("data-fileSn"));


			var url = "<c:url value='/util/file/deleteFileInfs.do'/>";
			var param = {"atchFileId":$(img).attr("data-atchFileId"), "fileSn":$(img).attr("data-fileSn")};

			$.post(url, param)
				.done(function( data ) {
			    	alert("첨부파일이 삭제 되었습니다.");
			    	$(img).parent("div").remove();
			  	})
			  	.fail(function(jqXHR) {
				    alert("삭제 오류 발생" );
				})
				.always(function(jqXHR) {
				});
		}

	</script>


	<title>Home</title>
</head>
<body>
	<div>
		<c:import url="/menu.do"></c:import>
	</div>

	<h1>첩부파일 다운로드(스크립트)</h1>
	<button type="button" id="btnFile" class="btn btn-primary btn-sm" >다운로드</button>
	<div id=filrList>
		<div>
			첨부파일 조회
		</div>
	</div>
	<h1>첩부파일 다운로드(JSTL)</h1>

	<div>
		<c:import url="/util/file/fileInfs.do" charEncoding="utf-8">
<%--
			<c:param name="param_atchFileId" value="${result.atchFileId}" />
 --%>
			<c:param name="atchFileId" value="FILE_FW_00045" />
		</c:import>
	</div>
	<hr>
	<h1>이미지 미리보기</h1>
	<div class="image-container">
	    <img style="width: 200px;height: 200px;" id="preview-image" src="">
	    <input type="file" id="input-image">
	</div>
	<hr>
	<h1>멀티 이미지 미리보기</h1>
	<div id='image_preview'>
		<h3>이미지 미리보기</h3>
		<input type='file' id='input_imgs' multiple='multiple'/>
		<div id='imgs_wrap' data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'>
		</div>
	</div>
	<h1>멀티 이미지 미리보기(드래그 앤 드롭_이미지 순서변경)</h1>
	<div class="filebox clearfix">
	    <div class="inputFile">
	        <label for="addImgs" class="addImgBtn">+</label>
	        <input type="file" id="addImgs" class="upload-hidden" accept=".jpg, .png, .gif" multiple>
	    </div>
	    <ul id="preview" class="sortable"></ul>
	</div>
	<hr>
	<h1>멀티 이미지 뷰(드래그 앤 드롭_파일 업로드)</h1>
	<div class="filebox clearfix">
        <input type="file" id="dFile" multiple>
        <div class="drop-zone">
           	 또는 파일을 여기로 드래그하세요.
        </div>
	</div>
	<hr>
	<h1>이미지 출력	</h1>
	<div>
		<c:import url="/util/file/imageFileInfs.do" charEncoding="utf-8">
<%--
			<c:param name="param_atchFileId" value="${result.atchFileId}" />
 --%>
			<c:param name="atchFileId" value="FILE_FW_00044" />
		</c:import>
	</div>
	<hr>
	</body>
</html>
