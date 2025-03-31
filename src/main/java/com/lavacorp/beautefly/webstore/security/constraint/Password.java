package com.lavacorp.beautefly.webstore.security.constraint;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.constraints.Pattern;
import org.hibernate.validator.constraints.Length;

import java.lang.annotation.Documented;
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

//  Rules taken from https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html#implement-proper-password-strength-controls
@Length(min = 8, max = 256, message = "atleast 8 to 256 characters")
@Pattern(regexp = "[a-z]", message = "atleast 1 lowercase character")
@Pattern(regexp = "[A-Z]", message = "atleast 1 uppercase character")

@Target({ FIELD, METHOD, PARAMETER, ANNOTATION_TYPE, TYPE_USE})
@Retention(RUNTIME)
@Documented
@Constraint(validatedBy = {})
@Repeatable(Password.List.class)
public @interface Password {
    String message() default "Not a valid password format";

    Class<?>[] groups() default { };

    Class<? extends Payload>[] payload() default {};

    @Target({ FIELD, METHOD, PARAMETER, ANNOTATION_TYPE, TYPE_USE})
    @Retention(RUNTIME)
    @Documented
    @interface List {
        Password[] value();
    }
}
