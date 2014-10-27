package me.hch.dao;

import me.hch.model.User;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by huaichao on 10/27/14.
 */
@Repository
public class UserDao {
    @Autowired
    @Qualifier(value = "h2Sf")
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
            return null;
        } finally {
            if (session != null) session.close();
        }
    }


}
