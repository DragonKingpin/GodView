package Saurye.System;

import javax.servlet.*;
import java.io.IOException;

public class PredatorFilter implements Filter {
    public PredatorFilter() {
    }

    public void destroy() {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String encoding = filterConfig.getServletContext().getInitParameter("encoding");
        //Debug.trace( encoding );
        request.setCharacterEncoding(encoding);
        chain.doFilter(request, response);
    }

    private FilterConfig filterConfig = null;

    public void init(FilterConfig fConfig) throws ServletException {
        this.filterConfig = fConfig;
    }
}
