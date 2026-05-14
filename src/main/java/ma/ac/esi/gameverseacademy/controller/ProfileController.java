package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Profile;
import ma.ac.esi.gameverseacademy.service.ProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ProfileService profileService = new ProfileService();

    // ── GET : afficher le profil ─────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        String email = (String) session.getAttribute("user");
        Profile profile = profileService.getProfile(email);

        // Si aucun profil → on en crée un vide pour le formulaire
        if (profile == null) {
            profile = new Profile();
            profile.setUserEmail(email);
        }

        request.setAttribute("profile", profile);
        request.setAttribute("email", email);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
               .forward(request, response);
    }

    // ── POST : créer ou modifier ou supprimer ────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        String email  = (String) session.getAttribute("user");
        String action = request.getParameter("action"); // save | delete

        if ("delete".equals(action)) {
            profileService.deleteProfile(email);
            request.setAttribute("message", "Profil supprimé avec succès.");
            request.setAttribute("profile", new Profile());

        } else {
            // save = créer ou modifier
            Profile p = new Profile();
            p.setUserEmail(email);
            p.setUsername(request.getParameter("username"));
            p.setBio(request.getParameter("bio"));
            p.setAvatarUrl(request.getParameter("avatarUrl"));
            p.setLocation(request.getParameter("location"));
            p.setWebsite(request.getParameter("website"));

            Profile existing = profileService.getProfile(email);
            boolean ok;
            if (existing == null) {
                ok = profileService.createProfile(p);
            } else {
                ok = profileService.updateProfile(p);
            }

            if (ok) {
                request.setAttribute("message", "Profil enregistré avec succès !");
                request.setAttribute("profile", profileService.getProfile(email));
            } else {
                request.setAttribute("error", "Erreur lors de l'enregistrement.");
                request.setAttribute("profile", p);
            }
        }

        request.setAttribute("email", email);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
               .forward(request, response);
    }
}