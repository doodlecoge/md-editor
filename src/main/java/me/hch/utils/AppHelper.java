package me.hch.utils;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * Created by huaichao on 10/27/14.
 */
public class AppHelper {
    public static String getUsername() {
        UserDetails userDetails = (UserDetails)
                SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userDetails.getUsername();
    }
}
