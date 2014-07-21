package me.hch.dao;

import me.hch.model.Folder;
import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hch on 2014/7/19.
 */
@Repository
public class FolderDao extends TheDao {
    public List<Folder> getTopFolders(String username) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(Folder.class);
        criteria.add(Restrictions.eq("username", username));
        criteria.add(Restrictions.isNull("parentId"));
        try {
            return criteria.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    public List<Folder> getFolders(String username) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(Folder.class);
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

    public List<Folder> getSubfolders(String username, int parentId) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(Folder.class);
        criteria.add(Restrictions.eq("username", username));
        if (parentId == 0)
            criteria.add(Restrictions.isNull("parentId"));
        else
            criteria.add(Restrictions.eq("parentId", parentId));
        try {
            return criteria.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }
}
