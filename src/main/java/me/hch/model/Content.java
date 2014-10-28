package me.hch.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by hch on 2014/7/25.
 */
@Entity
@Table(name = "contents")
public class Content {
    @Id
    @Column(name = "file_id")
    private int fileId;

    @Column
    private String content;


    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}