package ma.ac.esi.gameverseacademy.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import ma.ac.esi.gameverseacademy.service.UserService;

@WebServlet("/LoginController") // annotation pour mapper l'URL a cette classe Servlet
public class LoginController extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	// request contient tous ce que le client envoie et response ce qu'on renvoie au client
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/index.html").forward(request, response);
    }// getRequestDispatcher prepare une redirection, et forward transfert cote serveur vers index.html sans toucher a l'url ds le nav contrairement a sendRedirect
    
    @Override
    // quand l'utilisateur soumet le formulaire, la data post n'est pas visible dans l'url more securisee que get 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("email");
        String password = request.getParameter("password");
        // getParameter recupere les valeurs du formulaire HTML
        
        UserService userService = new UserService();// creer une instance du service
        // on verifie si l'user existe ou nn si oui on le connect vers mods (had l merra on change l'url) sinn on le redirige vers erreur
        if (userService.authenticateUser(login, password)) {
            HttpSession session = request.getSession(); // un objet qui maintient l'etat de l'user
            session.setAttribute("user", login);// on stocke l'email ds la session pour qu'il soit accessible par tous les pages suivantes par: session.getAttribute("user")
            response.sendRedirect(request.getContextPath() + "/mods");
        } else {
            response.sendRedirect(request.getContextPath() + "/error.html");
        }// sendRedirect permet de faire une redirection cote client cad le nav fait une nouvelle requete get vers la page et donc l'url change
    }
}