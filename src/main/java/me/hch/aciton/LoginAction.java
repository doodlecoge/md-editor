package me.hch.aciton;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by huaichao on 10/27/14.
 */
@Controller
@RequestMapping("/login_page")
public class LoginAction {
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "login";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String post(@RequestParam String username, @RequestParam String password) {
        return username + ", " + password;
    }
}
