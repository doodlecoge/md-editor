package me.hch.dao;

import me.hch.model.File;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hch on 2014/7/19.
 */
@Repository
public class FileDao extends TheDao {
    private static final Logger log = LoggerFactory.getLogger(FileDao.class);

    public List<File> getFiles(String username) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(File.class);
        criteria.add(Restrictions.eq("username", username));
        try {
            return criteria.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    public List<File> getChildren(String username, int parentId) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(File.class);
        criteria.add(Restrictions.eq("username", username));
        if (parentId == 0)
            criteria.add(Restrictions.isNull("pid"));
        else
            criteria.add(Restrictions.eq("pid", parentId));
        try {
            return criteria.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    public File getFile(int fileId) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(File.class);
        criteria.add(Restrictions.eq("id", fileId));

        try {
            return (File) criteria.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    public void deleteFile(int id) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            Object obj = session.load(File.class, id);
            if (obj != null) {
                session.beginTransaction();
                session.delete(obj);
                session.getTransaction().commit();
            } else log.error("file:" + id + ",not found.");
        } catch (HibernateException e) {
            log.error("delete file:" + id + " failed.", e);
        } finally {
            if (session != null) session.close();
        }
    }

    public File createFile(String name, int pid, File.FileType type,
                           String username) {
        if (name == null) {
            name = getTmpName(username, type);
        }

        File file = new File();
        file.setName(name);
        file.setType(type);
        file.setPid(pid);
        file.setUsername(username);

        Session session = null;

        try {
            session = sessionFactory.openSession();
            session.beginTransaction();
            session.save(file);
            session.getTransaction().commit();
            return file;
        } catch (HibernateException e) {
            log.error("create file failed.", e);
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    private String getTmpName(String username, File.FileType type) {
        Session session = null;
        String ptn = null;
        if (type == File.FileType.D) ptn = "New Folder";
        else ptn = "New File";

        try {
            session = sessionFactory.openSession();
            Criteria criteria = session.createCriteria(File.class);
            criteria.add(Restrictions.eq("username", username));
            criteria.add(Restrictions.like("name", ptn + "%"));
            List list = criteria.list();
            if (list == null) return ptn + " 1";
            else return ptn + " " + (list.size() + 1);
        } catch (HibernateException e) {
            log.error("create file failed.", e);
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    public void renameFile(int id, String name) {
        Session session = null;

        try {
            session = sessionFactory.openSession();
            Object obj = session.load(File.class, id);
            if (obj != null) {
                File file = (File) obj;
                file.setName(name);
                session.beginTransaction();
                session.save(file);
                session.getTransaction().commit();
            }
        } catch (HibernateException e) {
            log.error("rename file failed.", e);
        } finally {
            if (session != null) session.close();
        }
    }
}
