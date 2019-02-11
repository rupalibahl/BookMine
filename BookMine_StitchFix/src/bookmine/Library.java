package bookmine;
import java.util.ArrayList;

public class Library {
	
	private ArrayList<String> read;
	private ArrayList<String> favorite;
	
	public Library()
	{
		read = new ArrayList<String>();
		favorite = new ArrayList<String>();
	}

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
