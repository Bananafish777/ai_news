package com.example.news_project.security;

import com.example.news_project.model.User;
import com.example.news_project.repository.UserRepository;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException{
        User u = userRepository.findByEmailAndIsDeletedFalse(email).orElseThrow(() -> new UsernameNotFoundException("user not found"));

        List<GrantedAuthority> auths = List.of(new SimpleGrantedAuthority("ROLE_" + u.getRole().name().toUpperCase()));

        return new UserPrincipal(u.getId(), u.getEmail(), u.getPasswordHash(), auths);
    }

}
