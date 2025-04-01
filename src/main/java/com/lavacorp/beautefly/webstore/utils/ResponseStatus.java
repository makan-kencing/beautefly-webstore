package com.lavacorp.beautefly.webstore.utils;

import static jakarta.ws.rs.core.Response.Status.Family.CLIENT_ERROR;
import static jakarta.ws.rs.core.Response.Status.Family.INFORMATIONAL;
import static jakarta.ws.rs.core.Response.Status.Family.OTHER;
import static jakarta.ws.rs.core.Response.Status.Family.REDIRECTION;
import static jakarta.ws.rs.core.Response.Status.Family.SERVER_ERROR;
import static jakarta.ws.rs.core.Response.Status.Family.SUCCESSFUL;

import jakarta.ws.rs.core.Response.Status.Family;
import jakarta.ws.rs.core.Response.StatusType;


// https://gitlab.com/headcrashing/webdav-jaxrs/-/blob/master/src/main/java/net/java/dev/webdav/jaxrs/ResponseStatus.java
public enum ResponseStatus implements StatusType {
    /**
     * 207 Multi-Status
     *
     * @see <a href="http://www.webdav.org/specs/rfc4918.html#STATUS_207">Chapter 11.1 "207 Multi-Status" of RFC 4918
     *      "HTTP Extensions for Web Distributed Authoring and Versioning (WebDAV)"</a>
     */
    MULTI_STATUS(207, "Multi-Status"),

    /**
     * 422 Unprocessable Entity
     *
     * @see <a href="http://www.webdav.org/specs/rfc4918.html#STATUS_422">Chapter 11.2 "422 Unprocessable Entity" of RFC 4918
     *      "HTTP Extensions for Web Distributed Authoring and Versioning (WebDAV)"</a>
     */
    UNPROCESSABLE_ENTITY(422, "Unprocessable Entity"),

    /**
     * 423 Locked
     *
     * @see <a href="http://www.webdav.org/specs/rfc4918.html#STATUS_423">Chapter 11.3 "423 Locked" of RFC 4918
     *      "HTTP Extensions for Web Distributed Authoring and Versioning (WebDAV)"</a>
     */
    LOCKED(423, "Locked"),

    /**
     * 424 Failed Dependency
     *
     * @see <a href="http://www.webdav.org/specs/rfc4918.html#STATUS_424">Chapter 11.4 "424 Failed Dependency" of RFC 4918
     *      "HTTP Extensions for Web Distributed Authoring and Versioning (WebDAV)"</a>
     */
    FAILED_DEPENDENCY(424, "Failed Dependency"),

    /**
     * 507 Insufficient Storage
     *
     * @see <a href="http://www.webdav.org/specs/rfc4918.html#STATUS_507">Chapter 11.5 "507 Insufficient Storage" of RFC 4918
     *      "HTTP Extensions for Web Distributed Authoring and Versioning (WebDAV)"</a>
     */
    INSUFFICIENT_STORAGE(507, "Insufficient Storage");

    private final int statusCode;

    private final String reasonPhrase;

    ResponseStatus(final int statusCode, final String reasonPhrase) {
        this.statusCode = statusCode;
        this.reasonPhrase = reasonPhrase;
    }

    @Override
    public final int getStatusCode() {
        return this.statusCode;
    }

    @Override
    public final Family getFamily() {
        return switch (this.statusCode / 100) {
            case 1 -> INFORMATIONAL;
            case 2 -> SUCCESSFUL;
            case 3 -> REDIRECTION;
            case 4 -> CLIENT_ERROR;
            case 5 -> SERVER_ERROR;
            default -> OTHER;
        };
    }

    /**
     * @deprecated Since 1.1. Use {@link #getReasonPhrase()} instead to get the reason phrase. Future releases will return the name of the enum constant instead
     *             of the reason phrase (see {@link java.lang.Enum#toString()}).
     */
    @Deprecated
    @Override
    public final String toString() {
        return this.reasonPhrase;
    }

    @Override
    public final String getReasonPhrase() {
        return this.reasonPhrase;
    }

}


