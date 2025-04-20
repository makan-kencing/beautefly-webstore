package com.lavacorp.beautefly.util.response.exception;

import com.lavacorp.beautefly.util.response.ResponseStatus;
import jakarta.ws.rs.WebApplicationException;

public class UnprocessableEntityException extends WebApplicationException {
    public UnprocessableEntityException(String message) {
        super(message, ResponseStatus.UNPROCESSABLE_ENTITY.getStatusCode());
    }
}
