package me.hch.security;

import me.hch.dao.UserDao;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Collection;

/**
 * Created by huaichao on 10/27/14.
 */
public class MyUserDetailsService implements UserDetailsService {
    @Autowired
    private UserDao userDao;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        me.hch.model.User user = userDao.getUser(s);
        if (user == null) return null;

        Collection<? extends GrantedAuthority> authorities =
                AuthorityUtils.createAuthorityList("ROLE_USERa");

        return new User(user.getUsername(), user.getPassword(), authorities);
    }
}
