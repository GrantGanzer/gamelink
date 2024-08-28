package com.grant.gamelink.mvc.repos;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.grant.gamelink.mvc.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long> {

	Optional<User> findByEmail(String email);

	Optional<User> findById(Integer id);

}