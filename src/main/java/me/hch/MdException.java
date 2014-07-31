package me.hch;

/**
 * Created by huaiwang on 07/31/2014.
 */
public class MdException extends Exception {
    public MdException() {
        super();
    }

    public MdException(String message) {
        super(message);
    }

    public MdException(String message, Throwable cause) {
        super(message, cause);
    }

    public MdException(Throwable cause) {
        super(cause);
    }
}
