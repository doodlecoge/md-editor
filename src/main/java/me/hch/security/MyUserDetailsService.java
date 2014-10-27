package me.hch.security;

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
    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Collection<? extends GrantedAuthority> authorities =
                AuthorityUtils.createAuthorityList("USER", "ADMIN", "ROLE_USER");
        return new User("a", "b", authorities);
    }
}
