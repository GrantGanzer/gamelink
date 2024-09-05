package com.grant.gamelink.mvc.repos;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.grant.gamelink.mvc.models.Reply;

@Repository
public interface ReplyRepo extends CrudRepository<Reply, Long> {
	List<Reply> findAll();

	List<Reply> findById(int id);

}
