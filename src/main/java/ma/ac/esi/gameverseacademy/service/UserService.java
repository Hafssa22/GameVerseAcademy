package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.User;
import ma.ac.esi.gameverseacademy.repository.UserRepository;

public class UserService {
	
	
	private final UserRepository userRepository;// ne peut etre changer apres creation
// constructeur pour creer une instance de UserRepository
	public UserService() {
		super();
		this.userRepository = new UserRepository();
	}
// le controller appele le service et le service appelle le repo
	public boolean finUserByCredentials(String login, String password)
	{
		return userRepository.userExists(login, password);
		
	}


	// methode d'authentification, le service delegue au repository, pourquoi cette couche pour separer le logique metier de l'acces aux donnees 
	public boolean authenticateUser(String login, String password) {
	    return userRepository.userExists(login, password);
	}
	
	public User findUserByLogin(String login) {
	    return userRepository.findByLogin(login);
	}

}
