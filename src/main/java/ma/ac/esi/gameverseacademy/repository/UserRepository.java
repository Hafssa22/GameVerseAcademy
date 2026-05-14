package ma.ac.esi.gameverseacademy.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ma.ac.esi.gameverseacademy.model.User;
import ma.ac.esi.gameverseacademy.util.DBUtil;

public class UserRepository {
	
	public boolean userExists( String email, String password)
	{
		
		String sql="SELECT * from users where email=? and password =?";
		
		Connection connection= DBUtil.getConnection();// on reccupere une connexion a la base de donnees
		PreparedStatement statement;
		
		try {
			statement = connection.prepareStatement(sql);
			
			statement.setString(1, email); // on remplace le premier elt par mail et le 2eme par password sachant que les indices commence a 1 pas 0
			statement.setString(2, password);
			ResultSet resultset= statement.executeQuery();// tableau de resultats retournes par la bdd
			if (resultset.next())
				return true; // si une ligne existe l'utilisateur existe
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	
	public User findByLogin(String login) {
	    String sql = "SELECT * FROM users WHERE login = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, login);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                User user = new User(login, login);
	                user.setLogin(rs.getString("login"));
	                user.setEmail(rs.getString("email"));
	                user.setPassword(rs.getString("password")); // déjà hashé en BDD
	                // ajoute les autres champs selon ta table
	                return user;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}

}
