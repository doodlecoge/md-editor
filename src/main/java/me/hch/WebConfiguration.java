package me.hch;

import me.hch.aciton.ActionResultMessageConvertor;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import java.util.List;

/**
 * Created by huaiwang on 07/29/2014.
 */
@Configuration
//@EnableWebMvc
//@ComponentScan
public class WebConfiguration extends WebMvcConfigurerAdapter {
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        converters.add(new ActionResultMessageConvertor(MediaType.ALL));
    }
}
