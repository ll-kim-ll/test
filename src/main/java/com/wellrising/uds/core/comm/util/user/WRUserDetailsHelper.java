package com.wellrising.uds.core.comm.util.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.wellrising.uds.util.WRObjectUtil;
import com.wellrising.uds.util.file.controller.WRFileMngController;

/**
 * WRUserDetails Helper 클래스
 *
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon         최초 생성
 *   2011.07.01	 서준식          interface 생성후 상세 로직의 분리
 * </pre>
 */

public class WRUserDetailsHelper {
	private static final Logger log = LoggerFactory.getLogger(WRFileMngController.class);
    /**
     * 인증된 사용자객체를 VO형식으로 가져온다.
     *
     * @return 사용자 ValueObject
     */
    public static Object getAuthenticatedUser() {
        Authentication authentication = getAuthentication();
        if (authentication == null) return null;

        if (authentication.getPrincipal() instanceof UserDetails) {
        	UserDetails details = (UserDetails) authentication.getPrincipal();

        	log.debug("## WRUserDetailsHelper.getAuthenticatedUser : AuthenticatedUser is {}", details.getUsername());

	        return details;
        } else {
        	return authentication.getPrincipal();
        }
    }

    /**
     * 인증된 사용자의 권한 정보를 가져온다.
     * 예) [ROLE_ADMIN, ROLE_USER,
     * ROLE_A, ROLE_B, ROLE_RESTRICTED,
     * IS_AUTHENTICATED_FULLY,
     * IS_AUTHENTICATED_REMEMBERED,
     * IS_AUTHENTICATED_ANONYMOUSLY]
     *
     * @return 사용자 권한정보 목록
     */
    public static List<String> getAuthorities() {
        List<String> listAuth = new ArrayList<String>();

        Authentication authentication = getAuthentication();
        if (authentication == null) return null;

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        Iterator<? extends GrantedAuthority> iter = authorities.iterator();

		while (iter.hasNext()) {
        	GrantedAuthority auth = iter.next();
        	listAuth.add(auth.getAuthority());

        	log.debug("## WRUserDetailsHelper.getAuthorities : Authority is {}", auth.getAuthority());

        }

        return listAuth;
    }

    protected static Authentication getAuthentication() {
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();

        if (WRObjectUtil.isNull(authentication)) {
            log.debug("## authentication object is null!!");
            return null;
        }
        return authentication;
    }

    /**
     * 인증된 사용자 여부를 체크한다.
     *
     * @return 인증된 사용자 여부(TRUE / FALSE)
     */
    public static Boolean isAuthenticated() {
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();

        if (WRObjectUtil.isNull(authentication)) {
        	log.debug("## authentication object is null!!");
            return Boolean.FALSE;
        }

        String username = authentication.getName();
        if (username.equals("anonymousUser")) {		// 기존 2.0.8의 경우 'roleAnonymous'
        	log.debug("## username is {}", username);
            return Boolean.FALSE;
        }

        Object principal = authentication.getPrincipal();

        return (Boolean.valueOf(!WRObjectUtil.isNull(principal)));
    }
}
