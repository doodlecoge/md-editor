package me.hch.dao;

import me.hch.MdException;
import me.hch.MdRuntimeException;
import me.hch.model.Content;
import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by hch on 2014/7/25.
 */
@Repository
public class ContentDao extends TheDao {
    public Content getContent(int fileId) {
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

    public void saveContent(int fileId, String content) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(Content.class);
        criteria.add(Restrictions.eq("fileId", fileId));
        Content cont = null;
        try {
            Object obj = criteria.uniqueResult();

            if (obj == null) {
                cont = new Content();
                cont.setFileId(fileId);
            } else {
                cont = (Content) obj;
            }

            cont.setContent(content);

            session.beginTransaction();
            session.saveOrUpdate(cont);
            session.getTransaction().commit();
        } catch (Exception e) {
            throw new MdRuntimeException(
                    "saving content failed, id: " + fileId, e);
        } finally {
            if (session != null) session.close();
        }
    }
}
