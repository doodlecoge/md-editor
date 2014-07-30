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
@Table(name = "files", schema = "md")
public class File {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "id")
    private int id;

    @Column
    private String name;

    @Column
    private String username;

    @Column
    private Integer pid;

    @Column
    @Enumerated(value = EnumType.STRING)
    private FileType type;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public FileType getType() {
        return type;
    }

    public void setType(FileType type) {
        this.type = type;
    }

    public String toJson() {
        StringBuilder json = new StringBuilder();
        json.append("{\"id\":\"");
        json.append(id);
        json.append("\",\"name\":\"");
        json.append(name);
        json.append("\",\"pid\":\"");
        json.append(pid == null ? 0 : pid);
        json.append("\",\"type\":\"");
        json.append(type.name());
        json.append("\"}");
        return json.toString();
    }

    public static enum FileType {
        F, //file
        D, //director
    }
}
