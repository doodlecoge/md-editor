package me.hch.model;

import javax.persistence.*;
import java.util.List;

/**
 * Created by hch on 2014/7/13.
 */
@Entity
@Table(name = "users")
public class User {
    @Id
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "display_name")
    private String displayName;

    @JoinColumn(name = "username", referencedColumnName = "username")
    @OneToMany(targetEntity = File.class, fetch = FetchType.EAGER)
    private List<File> files;


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public List<File> getFiles() {
        return files;
    }

    public void setFiles(List<File> files) {
        this.files = files;
    }
}
