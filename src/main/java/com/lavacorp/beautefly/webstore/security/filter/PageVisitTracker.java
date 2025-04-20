package com.lavacorp.beautefly.webstore.security.filter;

import jakarta.annotation.Nullable;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.collections4.queue.CircularFifoQueue;

import java.io.IOException;
import java.net.URI;
import java.util.Queue;

public class PageVisitTracker implements Filter {
    public static String SESSION_ATTRIBUTE_NAME = "last-visits";
    public static int LAST_N_VISIT = 3;

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var httpReq = (HttpServletRequest) req ;
        var session = httpReq.getSession();

        var queue = getQueue(session);
        if (queue == null) {
            queue = new CircularFifoQueue<>(LAST_N_VISIT);
            session.setAttribute(SESSION_ATTRIBUTE_NAME, queue);
        }

        String uriString = httpReq.getRequestURI();
        String queryString = httpReq.getQueryString();
        if (queryString != null)
            uriString += queryString;

        URI uri = URI.create(uriString);
        if (!uri.equals(queue.peek()))
            queue.add(uri);

        chain.doFilter(req, resp);
    }

    @SuppressWarnings("unchecked")
    public static @Nullable Queue<URI> getQueue(HttpSession session) {
        if (session.getAttribute(SESSION_ATTRIBUTE_NAME) instanceof Queue<?> queue)
            if (queue.peek() instanceof URI)
                return (Queue<URI>) queue;
        return null;
    }

    public static @Nullable URI getLastUrl(HttpSession session) {
        var urls = getQueue(session);
        if (urls == null)
            return null;

        return urls.stream()
                .skip(1)
                .findFirst()
                .orElse(null);
    }
}
