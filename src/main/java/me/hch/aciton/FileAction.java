package me.hch.aciton;

import me.hch.dao.FileDao;
import me.hch.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by huaiwang on 7/18/14.
 */
@Controller
@RequestMapping("/file")
public class FileAction {
    @Autowired
    private FileDao fileDao;

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        List<File> files = fileDao.getFiles("huaichao");

        if (files == null) return "[]";

        StringBuilder json = new StringBuilder();
        json.append("[");
        boolean flag = false;
        for (File file : files) {
            if (flag) json.append(",");
            else flag = true;

            json.append(file.toJson());
        }
        json.append("]");
        return json.toString();
    }


    @ResponseBody
    @RequestMapping(value = "/{pid}")
    public String getSubfolders(@PathVariable int pid) {
        List<File> files = fileDao.getChildren("huaichao", pid);

        if (files == null) return "[]";

        StringBuilder json = new StringBuilder();
        json.append("[");
        boolean flag = false;
        for (File file : files) {
            if (flag) json.append(",");
            else flag = true;
            json.append(file.toJson());
        }
        json.append("]");
        return json.toString();
    }


    @ResponseBody
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ActionResult delete(@PathVariable int id) {
        fileDao.deleteFile(id);
        return ActionResult.SUCCESS;
    }
}
