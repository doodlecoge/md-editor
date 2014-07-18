package me.hch.aciton;

import me.hch.dao.TheDao;
import me.hch.model.Folder;
import me.hch.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * Created by huaiwang on 6/25/14.
 */
@Controller
@RequestMapping("/")
public class HomeAction {
    @Autowired
    private TheDao theDao;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap map) {
        User user = theDao.getUser("huaichao");
        System.out.println(user);

        return "home";
    }
}
