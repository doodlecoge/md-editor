package me.hch.aciton;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpInputMessage;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.MediaType;
import org.springframework.http.converter.AbstractHttpMessageConverter;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * Created by huaiwang on 07/29/2014.
 */
public class ActionResultMessageConvertor extends
        AbstractHttpMessageConverter<ActionResult> {
    public ActionResultMessageConvertor() {
        super();
    }

    public ActionResultMessageConvertor(MediaType supportedMediaType) {
        super(supportedMediaType);
    }

    public ActionResultMessageConvertor(MediaType... supportedMediaTypes) {
        super(supportedMediaTypes);
    }

    @Override
    protected boolean supports(Class<?> aClass) {
        return ActionResult.class.equals(aClass);
    }

    @Override
    protected ActionResult readInternal(
            Class<? extends ActionResult> aClass,
            HttpInputMessage httpInputMessage
    ) throws IOException, HttpMessageNotReadableException {
        return null;
    }

    @Override
    protected void writeInternal(
            ActionResult actionResult,
            HttpOutputMessage httpOutputMessage
    ) throws IOException, HttpMessageNotWritableException {
        OutputStream os = httpOutputMessage.getBody();
        os.write(actionResult.toString().getBytes());
        os.close();
    }
}
