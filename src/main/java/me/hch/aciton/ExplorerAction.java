package me.hch.aciton;

import me.hch.dao.ContentDao;
import me.hch.dao.FileDao;
import me.hch.model.Content;
import me.hch.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * Created by huaichao on 10/12/14.
 */
@Controller
@RequestMapping("/explorer")
public class ExplorerAction {
    @Autowired
    private FileDao fileDao;
    @Autowired
    ContentDao contentDao;

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "explorer";
    }

    @RequestMapping("/{fid}")
    public String showFile(String fid, ModelMap map) {
        int id = Integer.valueOf(fid);
        File file = fileDao.getFile(id);
        if (file != null || file.getType() == File.FileType.F) {
            Content content = contentDao.getContent(id);
            map.put("content", content);
            return "explore_file";
        } else {
            List<File> subFiles = fileDao.getChildren("huaichao", id);
            map.put("files", subFiles);
            return "explore_folder";
        }
    }
}
