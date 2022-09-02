package gocamping.controller;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpFilter;

/**
 * Servlet Filter implementation class CharsetFilter
 */
@WebFilter(urlPatterns={ "*.jsp", "*.do" }, 
			initParams = @WebInitParam(name = "charset", value = "UTF-8"),
			dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.ERROR} )
public class CharsetFilter extends HttpFilter implements Filter {       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public CharsetFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {

	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 前置處理
        request.setCharacterEncoding(charset);
        request.getParameterNames();//鎖定request的編碼
       
        response.setCharacterEncoding(charset);
        response.getWriter();//鎖定response的編碼 

        // 交棒給後續元件
        chain.doFilter(request, response);       

        // 後續處理
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		super.init(fConfig);
		String charset = this.getInitParameter("charset");
		if(charset!=null) {
			this.charset = charset;
		}
	}

	private String charset = "UTF-8";
}
