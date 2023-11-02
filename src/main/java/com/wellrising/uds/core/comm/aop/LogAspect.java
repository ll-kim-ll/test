package com.wellrising.uds.core.comm.aop;

import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class LogAspect {
	private static final Logger log = LoggerFactory.getLogger(LogAspect.class);
	/**
	 * 컨트롤러의 모든 get 메소드에 로그를 기록 한다.
	 * @param pjp
	 * @return
	 * @throws Throwable
	 */


	public void afterReturningLogging(JoinPoint pjp, Object returnValue) throws Throwable {
		Date start_tm = new Date();
//		RequestMapping mapping = controller.getAnnotation(RequestMapping.class);
		log.debug("start - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());
		Object result = returnValue;//(Object)pjp.proceed();
		log.debug("finished - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		Map<String, String[]> paramMap = request.getParameterMap();
		String params = "";
		if (paramMap.isEmpty() == false) {
//          params = " [" + paramMapToString(paramMap) + "]";
		}

//        String url = getMethodRequestFullURL(pjp);
		log.debug("url : " + request.getRequestURL());
//        usApiLog.info(result.getEndpoint(), pjp.getArgs().toString(), start_tm, result.getMessage());
	}

	//	public void getLogging(ProceedingJoinPoint pjp) throws Throwable {
	public void getBeforeLogging(JoinPoint pjp) throws Throwable {
		Date start_tm = new Date();
//		RequestMapping mapping = controller.getAnnotation(RequestMapping.class);
        log.debug("start - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());
        Object result = null;//(Object)pjp.proceed();
        log.debug("finished - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

        Map<String, String[]> paramMap = request.getParameterMap();
        String params = "";
        if (paramMap.isEmpty() == false) {
//          params = " [" + paramMapToString(paramMap) + "]";
        }

//        String url = getMethodRequestFullURL(pjp);
        log.debug("url : " + request.getRequestURL());
//        usApiLog.info(result.getEndpoint(), pjp.getArgs().toString(), start_tm, result.getMessage());
	}

	public void getAfterReturningLogging(JoinPoint pjp, Object returnValue) throws Throwable {

		Object result = returnValue;
/*
		Date start_tm = new Date();
//		RequestMapping mapping = controller.getAnnotation(RequestMapping.class);
		log.debug("start - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());
		Object result = null;//(Object)pjp.proceed();
		log.debug("finished - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		Map<String, String[]> paramMap = request.getParameterMap();
		String params = "";
		if (paramMap.isEmpty() == false) {
//          params = " [" + paramMapToString(paramMap) + "]";
		}

//        String url = getMethodRequestFullURL(pjp);
		log.debug("url : " + request.getRequestURL());
//        usApiLog.info(result.getEndpoint(), pjp.getArgs().toString(), start_tm, result.getMessage());
*/
	}

//	public void postLogging(ProceedingJoinPoint pjp) throws Throwable {
	public void postBeforeLogging(JoinPoint pjp) throws Throwable {
		Date start_tm = new Date();
		MethodSignature sig = (MethodSignature) pjp.getSignature();
		Method method = sig.getMethod();
		PostMapping req = method.getAnnotation(PostMapping.class);

        log.debug("start - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());
//		ResponseEntity<Void> result = (ResponseEntity<Void>)pjp.proceed();
		Object result = null; //(Object)pjp.proceed();
        log.debug("finished - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

        Map<String, String[]> paramMap = request.getParameterMap();
        String params = "";
        if (paramMap.isEmpty() == false) {
//          params = " [" + paramMapToString(paramMap) + "]";
        }

//        String url = getMethodRequestFullURL(pjp);
        log.debug("url : " + request.getRequestURL());
//        usApiLog.info(result.getEndpoint(), pjp.getArgs().toString(), start_tm, result.getMessage());
	}

	public void postAfterReturningLogging(JoinPoint pjp, Object returnValue) throws Throwable {
		Object result = returnValue;
/*
		Date start_tm = new Date();
		MethodSignature sig = (MethodSignature) pjp.getSignature();
		Method method = sig.getMethod();
		PostMapping req = method.getAnnotation(PostMapping.class);

		log.debug("start - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());
//		ResponseEntity<Void> result = (ResponseEntity<Void>)pjp.proceed();
		Object result = null; //(Object)pjp.proceed();
		log.debug("finished - " + pjp.getSignature().getDeclaringTypeName() + " / " + pjp.getSignature().getName());

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		Map<String, String[]> paramMap = request.getParameterMap();
		String params = "";
		if (paramMap.isEmpty() == false) {
//          params = " [" + paramMapToString(paramMap) + "]";
		}

//        String url = getMethodRequestFullURL(pjp);
		log.debug("url : " + request.getRequestURL());
//        usApiLog.info(result.getEndpoint(), pjp.getArgs().toString(), start_tm, result.getMessage());
*/
	}
}
