package me.hch.aciton;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import me.hch.dao.ContentDao;
import me.hch.dao.FileDao;
import me.hch.model.Content;
import me.hch.model.File;
import me.hch.utils.AppHelper;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by huaiwang on 7/18/14.
 */
@Controller
@RequestMapping("/file")
public class FileAction {
    @Autowired
    private FileDao fileDao;
    @Autowired
    ContentDao contentDao;

    //    @PreAuthorize("hasRole('USER')")
    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "/{pid}",
            produces = "application/json; charset=utf-8")
    public String getSubfolders(@PathVariable int pid) {
        File curFile = fileDao.getFile(pid);

        String login_username = AppHelper.getUsername();
        if (curFile != null && !curFile.getUsername().equals(login_username))
            return new ActionResult(true, "not permitted", null).toString();

        // if it is a file not folder, return file content
        if (curFile != null && curFile.getType() == File.FileType.F) {
            Content content = contentDao.getContent(pid);
            String c = content == null ? "" : content.getContent();
            JsonObject jobj = new JsonObject();
            jobj.addProperty("content", c);
            String b = jobj.toString();
            return b;
        }

        JsonArray jarrFiles = new JsonArray();
        List<File> files = fileDao.getChildren(login_username, pid);
        for (File file : files) {
            jarrFiles.add(file.toGson());
        }

        JsonArray jarrPaths = new JsonArray();
        List<File> paths = _getPath(pid);
        for (File path : paths) {
            jarrPaths.add(path.toGson());
        }

        JsonObject jobj = new JsonObject();
        jobj.add("files", jarrFiles);
        jobj.add("paths", jarrPaths);

        return jobj.toString();
    }


    @ResponseBody
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ActionResult delete(@PathVariable int id) {
        File file = fileDao.getFile(id);
        String login_username = AppHelper.getUsername();
        if (login_username != null && login_username.equals(file.getUsername())) {
            fileDao.deleteFile(id);
        }
        return ActionResult.SUCCESS;
    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.POST)
    public ActionResult add(@RequestParam(required = false) String name,
                            @RequestParam File.FileType type,
                            @RequestParam int pid) {
        File file = fileDao.createFile(name, pid, type, AppHelper.getUsername());
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

    @ResponseBody
    @RequestMapping("/{id}/path")
    private String getPath(@PathVariable int id) {
        JsonArray jarr = new JsonArray();
        List<File> files = _getPath(id);
        for (File file : files) {
            jarr.add(file.toGson());
        }
        return jarr.toString();
    }

    private List<File> _getPath(int id) {
        List<File> files = new ArrayList<File>();
        if (id == 0) return files;
        Integer fid = id;
        while (fid != null) {
            File file = fileDao.getFile(fid);
            files.add(0, file);
            fid = file.getPid();
        }
        return files;
    }
}
