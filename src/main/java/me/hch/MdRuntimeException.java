package me.hch;

/**
 * Created by huaiwang on 07/31/2014.
 */
public class MdRuntimeException extends RuntimeException {
    public MdRuntimeException() {
        super();
    }

    public MdRuntimeException(String message) {
        super(message);
    }

    public MdRuntimeException(String message, Throwable cause) {
        super(message, cause);
    }

    public MdRuntimeException(Throwable cause) {
        super(cause);
    }
}
