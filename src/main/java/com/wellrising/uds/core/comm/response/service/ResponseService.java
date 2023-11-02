package com.wellrising.uds.core.comm.response.service;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.comm.response.CommonListResult;
import com.wellrising.uds.core.comm.response.CommonMapResult;
import com.wellrising.uds.core.comm.response.CommonResult;

@Service
public class ResponseService {

	@Autowired
    private MessageSource messageSource;

    public enum CommonResponse {
        SUCCESS(200, "success")
        ,CREATED(201, "ceated")
    	,NOT_FOUND(404, "notfound")
    	,FAILURE(-2, "failed")
    	,VALIDATE(400, "validate.error");

        int code;
        String msg;

        CommonResponse(int code, String msg) {
            this.code = code;
            this.msg = msg;
        }

        public int getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }
    }
    // 성공 결과만 처리하는 메소드
    public CommonResult getSuccessResult() {
    	CommonResult result = new CommonResult();
        setSuccessResult(result);
        return result;
    }

    // 단일건 결과를 처리하는 메소드
    public <T> CommonMapResult<T> getMapResult(T data) {
    	CommonMapResult<T> result = new CommonMapResult<>();
    	setSuccessResult(result);
    	result.setData(data);
        return result;
    }

    // 단일건 결과를 처리하는 메소드
    public <T> CommonMapResult<T> getMapResult(int code, String message, T data) {
    	CommonMapResult<T> result = new CommonMapResult<>();
    	result.setCode(code);
    	result.setMessage(message);
    	result.setData(data);
    	return result;
    }

    // 다중건 결과를 처리하는 메소드
    public <T> CommonListResult<T> getListResult(List<T> list) {
    	CommonListResult<T> result = new CommonListResult<>();
        result.setList(list);
        setSuccessResult(result);
        return result;
    }

    // 다중건 결과를 처리하는 메소드
    public <T> CommonListResult<T> getListResult(int code, String message, List<T> list) {
    	CommonListResult<T> result = new CommonListResult<>();
    	result.setCode(code);
    	result.setMessage(message);
    	result.setList(list);
    	return result;
    }

    // 페이징 결과를 처리하는 메소드
 /*
    public <T> CommonResultPage<T> getPageResult(Page<T> list) {
    	CommonResultList<T> result = new CommonResultList<>();
    	result.setPage(list);
    	setSuccessResult(result);
    	return result;
    }
*/

    // 실패 결과만 처리하는 메소드
    public CommonResult getFailResult(CommonResponse respCode) {
    	CommonResult result = new CommonResult();
        result.setSuccess(false);
        result.setCode(respCode.getCode());
        String msg = messageSource.getMessage(respCode.getMsg(), null, Locale.KOREAN);
        result.setMessage(msg);
        return result;
    }
    // 실패 결과만 처리하는 메소드
    public CommonResult getFailResult(int code, String msgCode) {
    	CommonResult result = new CommonResult();
    	result.setSuccess(false);
    	result.setCode(code);
    	String msg = messageSource.getMessage(msgCode, null, Locale.KOREAN);
    	result.setMessage(msg);
    	return result;
    }



    // 결과 모델에 요청 성공 데이터를 세팅해주는 메소드
    private void setSuccessResult(CommonResult result) {
        result.setSuccess(true);
        result.setCode(CommonResponse.SUCCESS.getCode());
        String msg = messageSource.getMessage(CommonResponse.SUCCESS.getMsg(), null, Locale.KOREAN);
        result.setMessage(msg);
    }

}
