package bookmine;

import java.util.ArrayList;

import bookmine.Library;

public class Users {
	
	private String username;
	private String password;
	private String imageURL;
	private ArrayList<String> followers;
	private ArrayList<String> following;
	private Library library;
	
	public Users()
	{
		followers = new ArrayList<String>();
		following = new ArrayList<String>();
		library = new Library();
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	public ArrayList<String> getFollowers() {
		return followers;
	}
	public void setFollowers(ArrayList<String> followers) {
		this.followers = followers;
	}
	public ArrayList<String> getFollowing() {
		return following;
	}
	public void setFollowing(ArrayList<String> following) {
		this.following = following;
	}
	public Library getLibrary() {
		return library;
	}
	public void setLibrary(Library library) {
		this.library = library;
	}
}
