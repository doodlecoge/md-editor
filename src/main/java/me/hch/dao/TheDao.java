package me.hch.dao;

import me.hch.model.User;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hch on 2014/7/13.
 */
@Repository
public class TheDao {
    @Autowired
    @Qualifier(value = "mysql_sf")
    protected SessionFactory sessionFactory;

    public User getUser(String username) {
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(User.class);
        criteria.add(Restrictions.eq("username", username));
        try {
            List list = criteria.list();
            if (list == null) return null;
            return (User) list.get(0);
        } catch (Exception e) {
            // todo: use log4j to track exceptions
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }


}
