package me.hch.aciton;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by huaiwang on 6/25/14.
 */
@Controller
@RequestMapping("/")
public class HomeAction {
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "home";
    }
}
