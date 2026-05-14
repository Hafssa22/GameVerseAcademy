package ma.ac.esi.gameverseacademy.model;

public class User {
	// les champs des colonnes de la table users en BDD, private ==> encapsulation et acces unique via getters/setters
	private String email;
	private String password;
	
	// constructeur: creer un objet User avec email et password
	public User(String email, String password) {
		super();
		this.email = email;
		this.password = password;
	}
	// getter: pour lire la valeur et setters pour la modifier ==> principe d'encapsulation en POO
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
	
	@Override
	public String toString() {
		return "User [email=" + email + ", password=" + password + "]";
	}
	public void setLogin(String string) {
		// TODO Auto-generated method stub
		
	}
	
	public void getLogin() {
		// TODO Auto-generated method stub
	}
	
}
