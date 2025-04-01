package com.lavacorp.beautefly.webstore.utils.provider;

import com.lavacorp.beautefly.webstore.utils.ResponseStatus;
import com.lavacorp.beautefly.webstore.utils.dto.ValidationError;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

import java.util.List;

@Provider
public class ConstraintViolationExceptionMapper implements ExceptionMapper<ConstraintViolationException> {
    @Override
    public Response toResponse(ConstraintViolationException e) {
        List<ValidationError> errors = e.getConstraintViolations()
                .stream()
                .map(this::toValidationError)
                .toList();

        return Response.status(ResponseStatus.UNPROCESSABLE_ENTITY)
                .entity(errors)
                .type(MediaType.APPLICATION_JSON)
                .build();
    }

    private ValidationError toValidationError(ConstraintViolation<?> constraintViolation) {
        return new ValidationError(
                constraintViolation.getPropertyPath().toString(),
                constraintViolation.getMessage()
        );
    }
}
