package me.hch.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

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


    public int getFolderId() {
        return folderId;
    }

    public void setFolderId(int folderId) {
        this.folderId = folderId;
    }

    public String getFolderName() {
        return folderName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }
}
