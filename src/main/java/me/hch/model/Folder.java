package me.hch.model;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by hch on 2014/7/13.
 */
@Entity
@Table(name = "folders", schema = "md")
public class Folder {
    @Id
    @Column(name = "folder_id")
    private int folderId;

    @Column(name = "folder_name")
    private String folderName;

    @Column
    private String username;

    @Column(name = "parent_id")
    private Integer parentId;


    public String getFolderName() {
        return folderName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public int getFolderId() {
        return folderId;
    }

    public void setFolderId(int folderId) {
        this.folderId = folderId;
    }


    public String toJson() {
        StringBuilder json = new StringBuilder();
        json.append("{\"id\":\"");
        json.append(folderId);
        json.append("\",\"name\":\"");
        json.append(folderName);
        json.append("\",\"pid\":\"");
        json.append(parentId == null ? 0 : parentId);
        json.append("\"}");
        return json.toString();
    }
}
