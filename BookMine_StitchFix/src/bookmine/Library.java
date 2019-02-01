package bookmine;
import java.util.ArrayList;

public class Library {
	
	private ArrayList<String> read;
	private ArrayList<String> favorite;

	public ArrayList<String> getRead() {
		return read;
	}
	public void setRead(ArrayList<String> read) {
		this.read = read;
	}
	public ArrayList<String> getFavorite() {
		return favorite;
	}
	public void setFavorite(ArrayList<String> favorite) {
		this.favorite = favorite;
	}
}
