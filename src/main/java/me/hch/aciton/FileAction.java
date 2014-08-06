package me.hch.aciton;

import me.hch.dao.ContentDao;
import me.hch.dao.FileDao;
import me.hch.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by huaiwang on 7/18/14.
 */
@Controller
@RequestMapping("/file")
public class FileAction {
    public static final String username = "huaichao";

    @Autowired
    private FileDao fileDao;
    @Autowired
    ContentDao contentDao;

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        List<File> files = fileDao.getFiles(username);

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
        List<File> files = fileDao.getChildren(username, pid);

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

    @ResponseBody
    @RequestMapping(method = RequestMethod.POST)
    public ActionResult add(@RequestParam(required = false) String name,
                            @RequestParam File.FileType type,
                            @RequestParam int pid) {
        File file = fileDao.createFile(name, pid, type, username);
        if (type == File.FileType.F) {
            contentDao.createEmptyContent(file.getId());
        }
        ActionResult result = new ActionResult();
        result.setData(file.toJson());

        return result;
    }


    @ResponseBody
    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public ActionResult add(@RequestParam String name,
                            @PathVariable int id) {
        fileDao.renameFile(id, name);
        return ActionResult.SUCCESS;
    }
}
