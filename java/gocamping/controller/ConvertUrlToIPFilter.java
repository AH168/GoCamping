package gocamping.controller;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class ConvertUrlToIPFilter
 */
@WebFilter(
		urlPatterns = { "/*" }, 
		initParams = { 
				@WebInitParam(name = "target", value = "localhost|instructor")
		})

public class ConvertUrlToIPFilter extends HttpFilter implements Filter {	
	private static final long serialVersionUID = 1L;
	
	private Pattern targetPattern = Pattern.compile("localhost|instructor");
	private String ipAddr;
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest)request;
		HttpServletResponse httpRes = (HttpServletResponse)response;
		
		String url = httpReq.getRequestURL().toString();		
		if(targetPattern.matcher(url).find()) {
			url = url.replaceFirst(targetPattern.pattern(), ipAddr);
			//System.out.println(url); //for test
			httpRes.sendRedirect(url);
			return;
		}else {		
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	@Override
	public void init() throws ServletException {
		String target = this.getInitParameter("target");
		Pattern targetPattern;
		if(target!=null && target.length()>0) {			
			try {
				targetPattern = Pattern.compile(target);
			}catch(PatternSyntaxException e) {
				this.getServletContext().log("hostName格式錯誤: " + target);
			}			
		}
		
		try {
			this.ipAddr = java.net.InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			this.getServletContext().log("ipAddr讀取錯誤: ",e);
		}
	}
}
