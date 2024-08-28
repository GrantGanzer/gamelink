package com.grant.gamelink.mvc.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.grant.gamelink.mvc.models.LoginUser;
import com.grant.gamelink.mvc.models.User;
import com.grant.gamelink.mvc.repos.UserRepo;

@Service
public class UserService {
	@Autowired
	private UserRepo userRepo;

	public User register(User newUser, BindingResult result) {
		Optional<User> potentialUser = userRepo.findByEmail(newUser.getEmail());
		if (potentialUser.isPresent()) {
			result.rejectValue("email", "Matches", "The account already exists. Please log in!");
		}
		if (!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("confirm", "Matches", "The passwords dont match!");
		}
		if (result.hasErrors()) {
			return null;
		}
		String hash = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		newUser.setPassword(hash);
		return userRepo.save(newUser);
	}

	public User login(LoginUser newLoggedUser, BindingResult result) {
		Optional<User> potentialUser = userRepo.findByEmail(newLoggedUser.getEmail());
		if (!potentialUser.isPresent()) {
			result.rejectValue("email", "Matches", "Email not found... Please register");
			return null;
		}
		User user = potentialUser.get();
		if (!BCrypt.checkpw(newLoggedUser.getPassword(), user.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid Password!");
		}
		if (result.hasErrors()) {
			return null;
		} else {
			return user;
		}
	}

	public User findUser(Long id) {
		Optional<User> optionalUser = userRepo.findById(id);
		if (optionalUser.isPresent()) {
			return optionalUser.get();
		} else {
			return null;
		}
	}
}
