package me.hch.aciton;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by huaiwang on 08/25/2014.
 */
@Controller
@RequestMapping("/editor")
public class EditorAction {
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "editor";
    }
}
