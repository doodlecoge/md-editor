package me.hch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

/**
 * Created by huaichao on 10/26/14.
 */
//@Configuration
//@EnableWebSecurity
//@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
//        http.authorizeRequests()
//                .antMatchers("/css/**").permitAll()
//                .antMatchers("/js/**").permitAll()
//                .antMatchers("/fonts/**").permitAll()
//                .antMatchers("/img/**").permitAll()
//                .antMatchers("/").permitAll()
//                .antMatchers("/file").access("hasRole('USER') and post")
//                .antMatchers("/content").access("hasRole('USER')")
//                .antMatchers("/**").hasRole("USER")
//        ;

//        http.authorizeRequests();
        // custom login page
//        http.formLogin().loginPage("/login").permitAll();
//        http.logout().permitAll();

        // do not validate csrf token
//        http.csrf().disable();
    }
}
