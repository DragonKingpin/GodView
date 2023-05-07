package Saurye.System.Prototype;

import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface JasperModifier {
    boolean value() default true;
}
