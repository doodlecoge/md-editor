package me.hch.aciton;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import me.hch.dao.TheDao;
import me.hch.model.Folder;
import me.hch.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by huaiwang on 7/18/14.
 */
@Controller
@RequestMapping("/folder")
public class FolderAction {
    @Autowired
    private TheDao theDao;

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET)
    public String index(String userId) {
        StringBuilder json = new StringBuilder();

        List<Folder> folders = theDao.getTopFolders("huaichao");

        for (Folder folder : folders) {
            json.append(folder.getFolderName()).append(",");
        }

        return json.toString();
    }
}
