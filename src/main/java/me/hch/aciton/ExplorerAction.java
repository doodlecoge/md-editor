package me.hch.aciton;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by huaichao on 10/12/14.
 */
@Controller
@RequestMapping("/explorer")
public class ExplorerAction {
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "explorer";
    }
}
