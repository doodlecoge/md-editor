package me.hch.dao;

import me.hch.model.Content;
import me.hch.model.File;
import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by hch on 2014/7/25.
 */
@Repository
public class ContentDao extends TheDao {
    public Content getContent(String fileId) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(Content.class);
        criteria.add(Restrictions.eq("fileId", fileId));
        try {
            return (Content) criteria.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }
}
