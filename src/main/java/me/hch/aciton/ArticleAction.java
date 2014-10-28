package me.hch.aciton;

import me.hch.dao.ContentDao;
import me.hch.dao.FileDao;
import me.hch.model.Content;
import me.hch.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by huaichao on 10/28/14.
 */
@Controller
public class ArticleAction {
    @Autowired
    private ContentDao contentDao;
    @Autowired
    private FileDao fileDao;

    @RequestMapping("/a/{id}")
    public String article(@PathVariable int id, ModelMap map) {
        Content content = contentDao.getContent(id);
        File file = fileDao.getFile(id);
        map.put("content", content);
        map.put("file", file);
        return "article";
    }
}
