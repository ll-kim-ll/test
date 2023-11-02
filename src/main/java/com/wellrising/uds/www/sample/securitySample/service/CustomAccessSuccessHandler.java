package com.wellrising.uds.www.sample.securitySample.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class CustomAccessSuccessHandler implements AuthenticationSuccessHandler{
	private static final Logger log = LoggerFactory.getLogger(CustomAccessSuccessHandler.class);

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        log.warn("로그인 성공");

        // IP, 세션 ID
        WebAuthenticationDetails web = (WebAuthenticationDetails) authentication.getDetails();
        log.debug("IP : " + web.getRemoteAddress());
        log.debug("Session ID : " + web.getSessionId());

        // 인증 ID
        log.debug("name : " + authentication.getName());
        request.getSession().setAttribute("userId", authentication.getName());

        // 권한 리스트
        List<GrantedAuthority> authList = (List<GrantedAuthority>) authentication.getAuthorities();
        System.out.print("권한 : ");
        for(int i = 0; i< authList.size(); i++) {
        	System.out.print(authList.get(i).getAuthority() + " ");
        }

        // 권한 리스트
        List<String> roleNames = new ArrayList<>();

        authentication.getAuthorities().forEach(authority ->{
            roleNames.add(authority.getAuthority());
        });


		/* 로그인 버튼 눌러 접속했을 경우의 데이터 get */
		String prevPage = (String) request.getSession().getAttribute("prevPage");

		if (prevPage != null) {
			request.getSession().removeAttribute("prevPage");
		}

//        세션에 저장된 Attribute이기 때문에, 아래와 같이 세션에서 바로 객체를 가져와 사용할 수도 있습니다.
/*
        SavedRequest save = (SavedRequest) request.getSession()
				.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		if (save != null) {
			String uri = save.getRedirectUrl();
			System.out.println(uri);
		}
*/
		// Security가 요청을 가로챈 경우 사용자가 원래 요청했던 URI 정보를 저장한 객체
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		/*
		String uri = request.getHeader("Referer");
		if (!uri.contains("/loginView")) {
			request.getSession().setAttribute("prevPage",
					request.getHeader("Referer"));
		}
		*/

		String uri = request.getContextPath();

        if(roleNames.contains("ROLE_ADMIN")) {
        	uri += "/admin.do";
        }
        else if(roleNames.contains("ROLE_MEMBER")) {
        	uri += "/member.do";
        }
        else if(roleNames.contains("ROLE_USER")) {
        	uri += "/user.do";
        }


		// 있을 경우 URI 등 정보를 가져와서 사용
		if (savedRequest != null) {
			uri = savedRequest.getRedirectUrl();

			// 세션에 저장된 객체를 다 사용한 뒤에는 지워줘서 메모리 누수 방지
			requestCache.removeRequest(request, response);

			System.out.println(uri);
		// ""가 아니라면 직접 로그인 페이지로 접속한 것
		} else if (prevPage != null && !prevPage.equals("")) {
			uri = prevPage;
		}

		// 세션 Attribute 확인
		Enumeration<String> list = request.getSession().getAttributeNames();
		while (list.hasMoreElements()) {
			System.out.println(list.nextElement());
		}

		response.sendRedirect(uri);


// 권한별 링크 변경
/*
        log.debug("로그인 이름" + roleNames);

        if(roleNames.contains("ROLE_ADMIN")) {
            response.sendRedirect("/admin.do");
            return;
        }

        if(roleNames.contains("ROLE_MEMBER")) {
            response.sendRedirect("/member.do");
            return;
        }
        response.sendRedirect("/user.do");
*/
    }
}