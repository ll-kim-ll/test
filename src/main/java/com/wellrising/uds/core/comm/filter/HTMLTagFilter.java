package com.wellrising.uds.core.comm.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HTMLTagFilter implements Filter {
	private static final Logger log = LoggerFactory.getLogger(HTMLTagFilter.class);

    private FilterConfig config;
    private ArrayList<String> urlList;

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String url = req.getServletPath();
        boolean allowedRequest = false;

        for(String excUrl : urlList){
            if(excUrl.contains("*.do")){
                String tmpUrl = excUrl.split("\\*.do")[0];
                if(url.contains(tmpUrl)){
                    allowedRequest = true;
                }
            }else{
                if(url.equals(excUrl)){
                    allowedRequest = true;
                }
            }
        }

        if (!allowedRequest) {
            chain.doFilter(new HTMLTagFilterRequestWrapper((HttpServletRequest) request), response);
        } else {
            chain.doFilter(req, (HttpServletResponse) response);
        }
    }

    public void init(FilterConfig config) throws ServletException {
    	log.debug("HTMLTagFilter init() 시작 ------------------------------------");
        String urls = config.getInitParameter("excludePatterns");
        StringTokenizer token = new StringTokenizer(urls, ",");

        urlList = new ArrayList<String>();

        while (token.hasMoreTokens()) {
            String url = token.nextToken();
            urlList.add(url);
        }

        this.config = config;
    }

    public void destroy() {

    }
}