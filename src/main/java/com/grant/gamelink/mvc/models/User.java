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
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")

public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotEmpty(message = "First name is required!")
	@Size(min = 1, max = 30, message = "First name must be between 1 and 30 characters")
	private String firstName;

	@NotEmpty(message = "Last Name is required!")
	@Size(min = 1, max = 30, message = "Last name must be between 1 and 30 characters")
	private String lastName;

	@NotEmpty(message = "Email is required!")
	@Email(message = "Please enter a valid email!")
	private String email;

	@NotEmpty(message = "Password is required!")
	@Size(min = 8, max = 128, message = "Password must be between 8 and 128 characters")
	private String password;

	@Transient
	@NotEmpty(message = "Confirm Password is required!")
	@Size(min = 8, max = 128, message = "Confirm Password must be between 8 and 128 characters")
	private String confirm;

	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date created_at;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updated_at;

	@OneToMany(mappedBy = "adminuser", fetch = FetchType.LAZY)
	private List<Invitation> adminshows;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "guestlist", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "show_id"))
	private List<Invitation> shows;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "guestlistfinal", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "show_id"))
	private List<Invitation> finalshows;

	public User() {
	}

	public User(String firstName, String lastName, String email, String password, String confirm, Date created_at,
			Date updated_at, List<Invitation> shows, List<Invitation> finalshows, List<Invitation> adminshows) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.confirm = confirm;
		this.created_at = created_at;
		this.updated_at = updated_at;
		this.shows = shows;
		this.finalshows = finalshows;
		this.adminshows = adminshows;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public Date getUpdated_at() {
		return updated_at;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Invitation> getShows() {
		return shows;
	}

	public void setShows(List<Invitation> shows) {
		this.shows = shows;
	}

	public List<Invitation> getFinalshows() {
		return finalshows;
	}

	public void setFinalshows(List<Invitation> finalshows) {
		this.finalshows = finalshows;
	}

	public List<Invitation> getAdminshows() {
		return adminshows;
	}

	public void setAdminshows(List<Invitation> adminshows) {
		this.adminshows = adminshows;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
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
