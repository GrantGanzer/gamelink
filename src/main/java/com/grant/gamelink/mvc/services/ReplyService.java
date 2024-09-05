package com.grant.gamelink.mvc.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.grant.gamelink.mvc.models.Reply;
import com.grant.gamelink.mvc.repos.ReplyRepo;

@Service
public class ReplyService {

	private final ReplyRepo replyRepo;

	public ReplyService(ReplyRepo replyRepo) {
		this.replyRepo = replyRepo;
	}

	public List<Reply> allReplys() {
		return replyRepo.findAll();
	}

	public Reply findReply(Long id) {
		Optional<Reply> optionalreply = replyRepo.findById(id);
		if (optionalreply.isPresent()) {
			return optionalreply.get();
		} else {
			return null;
		}
	}

	public void deleteReply(Long id) {

		replyRepo.deleteById(id);
	}

	public Reply createReply(Reply t) {
		return replyRepo.save(t);
	}

	public Reply updateReply(Reply t, Long replyId) {
		Optional<Reply> optionalReply = replyRepo.findById(replyId);
		if (optionalReply.isPresent()) {
			Reply reply = optionalReply.get();
			reply.setConfirmed(t.getConfirmed());
			return replyRepo.save(reply);
		} else {
			return null;
		}
	}
}
