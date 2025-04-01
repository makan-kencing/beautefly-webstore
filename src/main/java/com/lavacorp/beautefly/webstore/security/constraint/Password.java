package com.lavacorp.beautefly.webstore.security.constraint;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.lang.annotation.Documented;
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

//  Rules taken from https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html#implement-proper-password-strength-controls
@Size(min = 8, message = "at least 8 characters")
@Size(max = 256, message = "max 256 characters")
@Pattern(regexp = ".*[a-z].*", message = "atleast 1 lowercase")
@Pattern(regexp = ".*[A-Z].*", message = "atleast 1 uppercase")

@Target({FIELD, METHOD, PARAMETER, ANNOTATION_TYPE, TYPE_USE})
@Retention(RUNTIME)
@Documented
@Constraint(validatedBy = {})
@Repeatable(Password.List.class)
public @interface Password {
    String message() default "Not a valid password format";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    @Target({FIELD, METHOD, PARAMETER, ANNOTATION_TYPE, TYPE_USE})
    @Retention(RUNTIME)
    @Documented
    @interface List {
        Password[] value();
    }
}
