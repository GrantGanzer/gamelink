package com.grant.gamelink.mvc.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.grant.gamelink.mvc.models.Invitation;
import com.grant.gamelink.mvc.models.LoginUser;
import com.grant.gamelink.mvc.models.Reply;
import com.grant.gamelink.mvc.models.User;
import com.grant.gamelink.mvc.services.InvitationService;
import com.grant.gamelink.mvc.services.ReplyService;
import com.grant.gamelink.mvc.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {

	@Autowired
	UserService userservice;

	@Autowired
	InvitationService invitationservice;

	@Autowired
	ReplyService replyservice;

	@GetMapping("/")
	public String registration(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "Login.jsp";
	}

	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {
		userservice.register(newUser, result);
		if (result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "Login.jsp";
		}
		session.setAttribute("userId", newUser.getId());
		return "redirect:/invitations";
	}

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {
		User user = userservice.login(newLogin, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "Login.jsp";
		}
		session.setAttribute("userId", user.getId());
		session.setAttribute("user", user);
		return "redirect:/invitations";
	}

	@GetMapping("/invitations")
	public String invitations(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			User user = userservice.findUser(userId);
			List<Invitation> invitations = invitationservice.allInvitations();
			model.addAttribute("user", user);
			model.addAttribute("invitations", invitations);
			return "Dashboard.jsp";
		}
	}

	@GetMapping("/invitations/new")
	public String newinvitation(Model model, HttpSession session, @ModelAttribute("Invitation") Invitation invitation) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			return "NewInvitation.jsp";
		}
	}

	@PostMapping("/invitations/new")
	public String saveinvitation(@Valid @ModelAttribute("Invitation") Invitation invitation, BindingResult result,
			Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (result.hasErrors()) {
			return "NewInvitation.jsp";
		} else {
			User user = (User) userservice.findUser(userId);
			invitation.setAdminuser(user);
			invitationservice.createInvitation(invitation);
			return "redirect:/invitations";
		}
	}

	@GetMapping("/invitations/edit/{iid}")
	public String editinvitation(Model model, HttpSession session, @ModelAttribute("Invitation") Invitation invitation,
			@PathVariable("iid") Long iid) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			Long currUserId = userservice.findUser(userId).getId();
			Long invitationUserid = invitationservice.findInvitation(iid).getAdminuser().getId();
			if (invitationUserid == null) {
				return "redirect:/invitations";
			} else if (invitationUserid != currUserId) {
				return "redirect:/invitations";
			} else {
				Invitation s = invitationservice.findInvitation(iid);
				model.addAttribute("invitationedits", s);
				model.addAttribute("invitation", s);
				return "EditInvitation.jsp";
			}
		}
	}

	@PutMapping("/invitations/edit/{iid}")
	public String update(@Valid @ModelAttribute("Invitation") Invitation invitation, BindingResult result, Model model,
			@PathVariable("iid") Long iid, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			if (result.hasErrors()) {
				Invitation b = invitationservice.findInvitation(iid);
				model.addAttribute("invitation", b);
				model.addAttribute("invitationedits", invitation);
				model.addAttribute("iid", iid);
				return "EditInvitation.jsp";
			} else {
				User user = (User) userservice.findUser(userId);
				invitation.setAdminuser(user);
				invitationservice.updateInvitation(invitation, iid);
				return "redirect:/invitations";
			}
		}
	}

	@GetMapping("/invitations/delete/{iid}")
	public String delete(@PathVariable("iid") Long iid, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			Long currUserid = userservice.findUser(userId).getId();
			Long invitationuserid = invitationservice.findInvitation(iid).getAdminuser().getId();
			if (currUserid != invitationuserid) {
				return "redirect:/invitations";
			} else {
				invitationservice.deleteInvitation(iid);
				return "redirect:/invitations";
			}
		}

	}

	@GetMapping("/invitations/{iid}")
	public String details(Model model, @PathVariable("iid") Long iid, HttpSession session,
			@ModelAttribute("Reply") Reply reply) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			User user = userservice.findUser(userId);
			Invitation invitation = invitationservice.findInvitation(iid);
			Boolean replied = false;
			Boolean confirmed = false;
			if (invitation == null) {
				return "redirect:/invitations";
			} else {
				List<Reply> replylist = invitation.getReplies();
				for (Reply r : replylist) {
					if (r.getUser() == user) {
						replied = true;
						if (r.getConfirmed() == true) {
							confirmed = true;
						}
					}
				}
				model.addAttribute("invitation", invitation);
				model.addAttribute("user", user);
				model.addAttribute("replied", replied);
				model.addAttribute("confirmed", confirmed);
				model.addAttribute("replylist", replylist);
				return "InvitationDetails.jsp";

			}
		}
	}

	@GetMapping("/invitations/replies/{iid}")
	public String guestlist(Model model, @PathVariable("iid") Long iid, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			User user = userservice.findUser(userId);
			Invitation invitation = invitationservice.findInvitation(iid);
			if (invitation == null) {
				return "redirect:/invitations";
			} else {
				Long invitationuserid = invitation.getAdminuser().getId();
				if (invitationuserid != user.getId()) {
					return "redirect:/invitations";
				} else {
					List<User> replies = invitation.getRsvps();
					List<User> finalReplies = invitation.getFinalrsvps();
					model.addAttribute("invitation", invitation);
					model.addAttribute("user", user);
					model.addAttribute("replies", replies);
					model.addAttribute("finalReplies", finalReplies);
					return "ReplyList.jsp";
				}
			}
		}
	}

	@GetMapping("/invitations/reply/{iid}/{uid}")
	public String rsvp(@PathVariable("uid") Long uid, @PathVariable("iid") Long iid, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		Long currUserid = userservice.findUser(userId).getId();
		Invitation thisInvitation = invitationservice.findInvitation(iid);
		User thisUser = userservice.findUser(uid);
		if (userId == null) {
			return "redirect:/";
		} else if (thisInvitation == null || thisUser == null) {
			return "redirect:/invitations";
		} else if (currUserid != thisUser.getId()) {
			return "redirect:/invitations";
		} else if (currUserid == thisInvitation.getAdminuser().getId()) {
			return "redirect:/invitations";
		} else {
			List<User> replies = thisInvitation.getRsvps();
			List<User> repliesFInal = thisInvitation.getFinalrsvps();
			if (replies.contains(thisUser) || repliesFInal.contains(thisUser)) {
				return "redirect:/invitations/{iid}";
			} else {
				thisInvitation.getRsvps().add(thisUser);
				invitationservice.updateInvitation(thisInvitation, iid);
				return "redirect:/invitations";
			}
		}
	}

	@PostMapping("/invitations/reply/{iid}/{uid}")
	public String savereply(@PathVariable("iid") Long iid, @Valid @ModelAttribute("Reply") Reply reply,
			BindingResult result, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (result.hasErrors()) {
			return "redirect:/invitations";
		} else {
			User user = (User) userservice.findUser(userId);
			Invitation invitation = invitationservice.findInvitation(iid);
			reply.setUser(user);
			reply.setInvitation(invitation);
			replyservice.createReply(reply);
			return "redirect:/invitations";
		}
	}

	@PutMapping("/invitations/reply/confirm/{rid}/{iid}")
	public String confirm(@Valid @ModelAttribute("Reply") Reply reply, BindingResult result, Model model,
			@PathVariable("rid") Long rid, @PathVariable("iid") Long iid, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			System.out.print("here");
			replyservice.updateReply(reply, rid);
			return "redirect:/invitations/{iid}";
		}
	}

	@GetMapping("/invitations/confirm/{iid}/{uid}")
	public String confrim(@PathVariable("uid") Long uid, @PathVariable("iid") Long iid, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		Long currUserId = userservice.findUser(userId).getId();
		Invitation thisInvitation = invitationservice.findInvitation(iid);
		User thisUser = userservice.findUser(uid);
		Long invitationadminid = thisInvitation.getAdminuser().getId();
		if (userId == null) {
			return "redirect:/";
		} else if (thisUser.getId() == invitationadminid) {
			return "redirect:/invitations";
		} else if (currUserId != invitationadminid) {
			return "redirect:/invitations";
		} else if (thisInvitation == null || thisUser == null) {
			return "redirect:/invitations";
		} else {
			List<User> finalReplies = thisInvitation.getFinalrsvps();
			if (finalReplies.contains(thisUser)) {
				return "redirect:/invitations/replies/{iid}";
			} else {
				thisInvitation.getFinalrsvps().add(thisUser);
				thisInvitation.getRsvps().remove(thisUser);
				invitationservice.updateInvitation(thisInvitation, iid);
				return "redirect:/invitations/replies/{iid}";
			}
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}