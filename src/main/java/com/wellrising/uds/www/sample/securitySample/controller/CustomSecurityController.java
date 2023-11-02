package com.wellrising.uds.www.sample.securitySample.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.wellrising.uds.core.comm.util.user.WRUserDetailsHelper;

@Controller
public class CustomSecurityController {
	private static final Logger log = LoggerFactory.getLogger(CustomSecurityController.class);

	// 로그인 성공(Admin)
	@GetMapping("/admin.do")
	public String admin(Authentication auth, Model model) throws Exception {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");





		return "security/admin";
	}

	// 로그인 성공(Member)
	@GetMapping("/member.do")
	public String member(Authentication auth, Model model) throws Exception {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
		return "security/member";
	}
	// 로그인 성공(User)
	@GetMapping("/user.do")
	public String user(Authentication auth, Model model) throws Exception {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
		return "security/all";
	}

	// url 접근 제한 오류 페이지
	@GetMapping("/accessDenied.do")
	public String accessDenied(Authentication auth, Model model) throws Exception {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
		return "security/accessDenied";
	}

	// 사용자 정보 얻기
	@RequestMapping("/session1.do")
	public void currentUserName(HttpServletRequest request) throws Exception {
		log.debug((String) request.getSession().getAttribute("userId"));
	}
	// 사용자 정보 얻기
	@RequestMapping("/session2.do")
	public void currentUserName(HttpSession session) throws Exception {
		log.debug((String) session.getAttribute("userId"));
	}

	@RequestMapping("/username1.do")
	public void currentUserName1() throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();
		String password = userDetails.getPassword();

		log.debug(username);
		log.debug(password);
	}

	@RequestMapping("/username2.do")
	public void currentUserName2(Principal principal) throws Exception {
		log.debug(principal.getName());
	}

	@RequestMapping("/username3.do")
	public void currentUserName3(Authentication authentication) throws Exception {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		log.debug(userDetails.getUsername());
	}

	@RequestMapping("/isAuthenticated1.do")
    public static Boolean isAuthenticated1() {
        return WRUserDetailsHelper.isAuthenticated();
    }

	@RequestMapping("/isAuthenticated2.do")
	public static Boolean isAuthenticated2() {
		if (RequestContextHolder.getRequestAttributes() == null) {
			return false;
		} else {
			if (RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION) == null) {
				return false;
			} else {
				return true;
			}
		}
	}


}
