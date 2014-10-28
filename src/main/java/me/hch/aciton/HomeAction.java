package me.hch.aciton;

import me.hch.dao.FileDao;
import me.hch.dao.TheDao;
import me.hch.model.File;
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
    @Autowired
    private FileDao fileDao;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(ModelMap map) {
        List<File> files = fileDao.getFiles(0, 0);
        map.put("files", files);
        return "index";
    }
}
