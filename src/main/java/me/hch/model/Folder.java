package me.hch.model;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

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
    private int parentId;


    @OneToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinColumn(name = "parent_id", referencedColumnName = "folder_id")
    private List<Folder> subFolders = new ArrayList<Folder>(0);


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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<Folder> getSubFolders() {
        return subFolders;
    }

    public void setSubFolders(List<Folder> subFolders) {
        this.subFolders = subFolders;
    }
}
