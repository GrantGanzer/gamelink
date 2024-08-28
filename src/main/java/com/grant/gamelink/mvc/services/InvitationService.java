package com.grant.gamelink.mvc.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.grant.gamelink.mvc.models.Invitation;
import com.grant.gamelink.mvc.repos.InvitationRepo;

@Service
public class InvitationService {

	private final InvitationRepo invitationRepo;

	public InvitationService(InvitationRepo invitationRepo) {
		this.invitationRepo = invitationRepo;
	}

	public List<Invitation> allInvitations() {
		return invitationRepo.findAll();
	}

	public Invitation findInvitation(Long id) {
		Optional<Invitation> optionalinvitation = invitationRepo.findById(id);
		if (optionalinvitation.isPresent()) {
			return optionalinvitation.get();
		} else {
			return null;
		}
	}

	public void deleteInvitation(Long id) {

		invitationRepo.deleteById(id);
	}

	public Invitation createInvitation(Invitation t) {
		return invitationRepo.save(t);
	}

	public Invitation updateInvitation(Invitation t, Long invitationId) {
		Optional<Invitation> optionalInvitation = invitationRepo.findById(invitationId);
		if (optionalInvitation.isPresent()) {
			Invitation invitation = optionalInvitation.get();
			invitation.setGameName(t.getGameName());
			invitation.setAvailablity(t.getAvailablity());
			invitation.setPlatform(t.getPlatform());
			invitation.setGamertag(t.getGamertag());
			invitation.setDescription(t.getDescription());
			invitation.setAdminuser(t.getAdminuser());
			invitation.setReplies(t.getReplies());
			invitation.setRepliesfinal(t.getRepliesfinal());
			return invitationRepo.save(invitation);
		} else {
			return null;
		}
	}
}
