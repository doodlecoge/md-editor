package me.hch.aciton;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import me.hch.dao.ContentDao;
import me.hch.dao.FileDao;
import me.hch.model.Content;
import me.hch.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


/**
 * Created by hch on 2014/7/25.
 */
@Controller
@RequestMapping("/content")
public class ContentAction {
    @Autowired
    private ContentDao contentDao;

    @Autowired
    private FileDao fileDao;

    @ResponseBody
    @RequestMapping(value = "/{fid}")
    public String getContent(@PathVariable int fid) {
        JsonObject jobj = new JsonObject();

        String code = "status_code";
        String text = "response_text";

        File file = fileDao.getFile(fid);
        if (file != null && file.getType() == File.FileType.D) {
            jobj.addProperty(code, HttpStatus.BAD_REQUEST.value());
        }

        Content content = contentDao.getContent(fid);

        if (content == null) {
            jobj.addProperty(code, HttpStatus.NOT_FOUND.value());
        } else {
            jobj.addProperty(code, HttpStatus.OK.value());
            jobj.addProperty(text, content.getContent());
        }

        return jobj.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/{fid}", method = RequestMethod.POST)
    public ActionResult saveContent(@PathVariable int fid,
                                    @RequestParam String content) {
        contentDao.saveContent(fid, content);
        return ActionResult.SUCCESS;
    }
}
