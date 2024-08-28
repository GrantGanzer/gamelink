package com.grant.gamelink.mvc.repos;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.grant.gamelink.mvc.models.Invitation;

@Repository
public interface InvitationRepo extends CrudRepository<Invitation, Long> {
	List<Invitation> findAll();

	List<Invitation> findById(int id);

}
