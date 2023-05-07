package Saurye.System;

public class HeresyImplementInvokeException extends RuntimeException {
    public HeresyImplementInvokeException(){
        super();
    }

    public HeresyImplementInvokeException( String s ){
        super(s);
    }

    public HeresyImplementInvokeException( String message, Throwable rootCause ) {
        super(message, rootCause);
    }

    public HeresyImplementInvokeException( Throwable rootCause ) {
        super(rootCause);
    }

    public Throwable getRootCause() {
        return this.getCause();
    }
}
