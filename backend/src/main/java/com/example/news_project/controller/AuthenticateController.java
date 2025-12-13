package com.example.news_project.controller;

import com.example.news_project.dto.auth.AuthenticateRequest;
import com.example.news_project.dto.auth.AuthenticateResponse;
import com.example.news_project.dto.user.UserResponse;
import com.example.news_project.repository.UserRepository;
import com.example.news_project.security.JwtService;
import com.example.news_project.security.UserPrincipal;
import com.example.news_project.service.AuthService;
import com.example.news_project.service.UserService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("api/auth")
public class AuthenticateController {

    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final AuthService authService;
    private final UserService userService;


    public AuthenticateController(UserRepository userRepository, AuthenticationManager authenticationManager, JwtService jwtService, AuthService authService, UserService userService) {
        this.userRepository = userRepository;
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
        this.authService = authService;
        this.userService = userService;
    }

    @PostMapping("/register")
    public ResponseEntity<UserResponse> register(@Valid @RequestBody AuthenticateRequest req) {

        return ResponseEntity.ok(authService.register(req));
    }

    @PostMapping("login")
    public ResponseEntity<AuthenticateResponse> login(@RequestBody AuthenticateRequest req) {
        try{
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(req.getEmail(), req.getPassword())
            );

            UserPrincipal principal = (UserPrincipal) authentication.getPrincipal();
            String token = jwtService.generate(req.getEmail(), Map.of(
                            "id", principal.getId(),
                            "role", principal.getRole()
                    )
            );

            UserResponse ur = userService.getById(principal.getId());

            AuthenticateResponse rsp = new AuthenticateResponse(token, ur);
            return ResponseEntity.ok(rsp);
        }
        catch (BadCredentialsException e) {
            throw new IllegalArgumentException("Invalid credentials");
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<Map<String, Boolean>> logout() {
        return ResponseEntity.ok(Map.of("success", true));
    }
}
