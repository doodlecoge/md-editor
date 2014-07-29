package me.hch.aciton;

/**
 * Created by huaiwang on 07/29/2014.
 */
public class ActionResult {
    private boolean error = false;
    private String message;
    private String data;
    public static final ActionResult SUCCESS;
    public static final ActionResult FAIL;

    static {
        SUCCESS = new ActionResult();
        FAIL = new ActionResult();
        FAIL.setError(true);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("{\"error\":");
        sb.append(error);

        if (message != null) {
            sb.append(",\"message\":\"");
            sb.append(message.replace("\"", "\\\""));
            sb.append("\"");
        }

        if (data != null) {
            sb.append(",\"data\":\"");
            sb.append(data.replace("\"", "\\\""));
            sb.append("\"");
        }

        sb.append("}");

        return sb.toString();
    }

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
