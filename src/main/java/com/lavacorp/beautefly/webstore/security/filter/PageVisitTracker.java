package com.lavacorp.beautefly.webstore.security.filter;

import jakarta.annotation.Nullable;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.collections4.queue.CircularFifoQueue;

import java.io.IOException;
import java.net.URI;
import java.util.Arrays;
import java.util.Optional;
import java.util.Queue;
import java.util.function.Predicate;
import java.util.regex.Pattern;

@Log4j2
public class PageVisitTracker implements Filter {
    public static String SESSION_ATTRIBUTE_NAME = "visits";

    public Pattern[] ignorePatterns = new Pattern[0];
    public int queueSize = 3;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        var queueSize = filterConfig.getInitParameter("queueSize");
        if (queueSize != null)
            this.queueSize = Integer.parseUnsignedInt(queueSize);

        var ignorePatterns = filterConfig.getInitParameter("ignorePatterns");
        if (ignorePatterns != null)
            this.ignorePatterns = ignorePatterns.lines()
                    .map(String::strip)
                    .map(Pattern::compile)
                    .toArray(Pattern[]::new);
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var httpReq = (HttpServletRequest) req;
        var session = httpReq.getSession();

        var queue = getQueue(session);
        if (queue == null) {
            queue = new CircularFifoQueue<>(queueSize);
            session.setAttribute(SESSION_ATTRIBUTE_NAME, queue);
        }

        logUrl(queue, httpReq);

        chain.doFilter(req, resp);
    }

    private void logUrl(Queue<URI> queue, HttpServletRequest req) {
        String uri = req.getRequestURI();
        if (isIgnored(uri))
            return;

        String queryString = req.getQueryString();
        if (queryString != null)
            uri += queryString;

        if (queue.peek() != null)
            if (uri.equals(queue.peek().toString()))
                return;

        queue.add(URI.create(uri));
        log.debug("Session: {}, visited {}.", req.getSession().getId(), uri);
    }

    private boolean isIgnored(String uri) {
        return Arrays.stream(ignorePatterns)
                .anyMatch(p -> p.matcher(uri).matches());
    }

    @SuppressWarnings("unchecked")
    public static @Nullable Queue<URI> getQueue(HttpSession session) {
        if (session.getAttribute(SESSION_ATTRIBUTE_NAME) instanceof Queue<?> queue)
            if (queue.peek() instanceof URI)
                return (Queue<URI>) queue;
        return null;
    }

    public static Optional<URI> getFirst(HttpSession session, Predicate<URI> predicate) {
        var urls = getQueue(session);
        if (urls == null)
            return Optional.empty();

        return urls.stream()
                .filter(predicate)
                .findFirst();
    }

    public static Optional<URI> getFirst(HttpSession session) {
        return getFirst(session, ignored -> true);
    }
}
