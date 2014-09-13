package me.hch.aciton;

import com.google.gson.JsonObject;

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
        JsonObject jobj = new JsonObject();
        jobj.addProperty("error", error);
        jobj.addProperty("message", message);
        jobj.addProperty("data", data);
        return jobj.toString();
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
