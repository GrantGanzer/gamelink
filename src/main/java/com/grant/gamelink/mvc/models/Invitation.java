package com.grant.gamelink.mvc.models;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "invitations")

public class Invitation {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Size(min = 1, max = 255, message = "A show name is required.")
	private String gameName;

	@NotNull
	@Size(min = 1, max = 255, message = "your availability is required.")
	private String availablity;
	@NotNull
	@Size(min = 1, max = 255, message = "your platform is required.")
	private String platform;
	@NotNull
	@Size(min = 1, max = 255, message = "your gamertag is required.")
	private String gamertag;
	@NotNull
	@Size(min = 1, max = 5000, message = "A description is required.")
	private String description;

	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date created_at;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updated_at;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private User adminuser;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "replies", joinColumns = @JoinColumn(name = "invitation_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> replies;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "replylistfinal", joinColumns = @JoinColumn(name = "invitation_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> repliesFinal;

	public Invitation() {

	}

	public Invitation(String gameName, String gamertag, String platform, String description, String venue,
			String address, String showdate, Date created_at, Date updated_at, User adminuser,
			List<User> replies, List<User> repliesFinal) {
		this.gameName = gameName;
		this.gamertag = gamertag;
		this.platform = platform;
		this.description = description;
		this.created_at = created_at;
		this.updated_at = updated_at;
		this.adminuser = adminuser;
		this.replies = replies;
		this.repliesFinal = repliesFinal;

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGameName() {
		return gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public String getAvailablity() {
		return availablity;
	}

	public void setAvailablity(String availablity) {
		this.availablity = availablity;
	}

	public String getPlatform() {
		return platform;
	}

	public void setPlatform(String platform) {
		this.platform = platform;
	}

	public String getGamertag() {
		return gamertag;
	}

	public void setGamertag(String gamertag) {
		this.gamertag = gamertag;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public Date getUpdated_at() {
		return updated_at;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public User getAdminuser() {
		return adminuser;
	}

	public void setAdminuser(User adminuser) {
		this.adminuser = adminuser;
	}

	public List<User> getReplies() {
		return replies;
	}

	public void setReplies(List<User> replies) {
		this.replies = replies;
	}

	public List<User> getRepliesfinal() {
		return repliesFinal;
	}

	public void setRepliesfinal(List<User> repliesFinal) {
		this.repliesFinal = repliesFinal;
	}

	@PrePersist
	protected void onCreate() {
		this.created_at = new Date();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updated_at = new Date();
	}

}