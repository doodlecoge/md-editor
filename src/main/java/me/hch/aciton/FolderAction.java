package me.hch.aciton;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import me.hch.dao.FolderDao;
import me.hch.dao.TheDao;
import me.hch.model.Folder;
import me.hch.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by huaiwang on 7/18/14.
 */
@Controller
@RequestMapping("/folder")
public class FolderAction {
    private static final String ptn =
            "{\"id\":\"{id}\",\"name\":\"{name}\",\"pid\":\"{pid}\"}";

    @Autowired
    private TheDao theDao;

    @Autowired
    private FolderDao folderDao;

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        List<Folder> folders = folderDao.getFolders("huaichao");

        if (folders == null) return "[]";

        StringBuilder json = new StringBuilder();
        json.append("[");
        boolean flag = false;
        for (Folder folder : folders) {
            if (flag) {
                json.append(",");
                flag = true;
            }
            json.append(folder.toJson());
        }
        json.append("]");
        return json.toString();
    }


    @ResponseBody
    @RequestMapping(value = "/{pid}")
    public String getSubfolders(@PathVariable int pid) {
        List<Folder> folders = folderDao.getSubfolders("huaichao", pid);

        if (folders == null) return "[]";

        StringBuilder json = new StringBuilder();
        json.append("[");
        boolean flag = false;
        for (Folder folder : folders) {
            if (flag) {
                json.append(",");
                flag = true;
            }
            json.append(folder.toJson());
        }
        json.append("]");
        return json.toString();
    }
}
