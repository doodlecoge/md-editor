package me.hch.dao;

import me.hch.utils.ContextUtils;
import me.hch.MdRuntimeException;
import me.hch.model.Content;
import me.hch.model.File;
import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.access.BeanFactoryLocator;
import org.springframework.beans.factory.access.BeanFactoryReference;
import org.springframework.beans.factory.access.SingletonBeanFactoryLocator;
import org.springframework.stereotype.Repository;

/**
 * Created by hch on 2014/7/25.
 */
@Repository
public class ContentDao extends TheDao {
    public Content getContent(int fileId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            Criteria criteria = session.createCriteria(Content.class);
            criteria.add(Restrictions.eq("fileId", fileId));
            return (Content) criteria.list().get(0);
        } catch (Exception e) {
            throw new MdRuntimeException(
                    "get content failed, file id: " + fileId, e);
        } finally {
            if (session != null) session.close();
        }
    }

    public void saveContent(int fileId, String content) {
        File file = getFile(fileId);
        if (file == null || file.getType() == File.FileType.D) {
            throw new MdRuntimeException(
                    "no such file or it is a folder: " + fileId);
        }

        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(Content.class);
        criteria.add(Restrictions.eq("fileId", fileId));
        Content cont;
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


    private File getFile(int fid) {
        FileDao fileDao = ContextUtils.getContext().getBean(FileDao.class);
        return fileDao.getFile(fid);
    }


    public void createEmptyContent(int fileId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            Criteria criteria = session.createCriteria(Content.class);
            criteria.add(Restrictions.eq("fileId", fileId));
            Object obj = criteria.uniqueResult();
            if (obj != null) return;

            Content cont = new Content();
            cont.setFileId(fileId);

            session.beginTransaction();
            session.saveOrUpdate(cont);
            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null) session.getTransaction().rollback();
            throw new MdRuntimeException(
                    "saving content failed, id: " + fileId, e);
        } finally {
            if (session != null) session.close();
        }
    }

//    private File getFile(String fid) {
//        BeanFactoryLocator bfl = SingletonBeanFactoryLocator.getInstance();
//        BeanFactoryReference bfr = bfl.useBeanFactory(FileDao.class.toString());
//        bfr.getFactory().getBean("someService");
//    }
}
