package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.ModService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/mods")
public class ModController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
// on verifie si l'user est encore connecte, getSession(false) cad ne cree pas de nouvelle session
        HttpSession session = request.getSession(false);
        // si pas de session on redirige vers la page login c'est ce qu'on appelle la protection des pages privees
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;// permet d'arreter l'execution immediatement
        }

        ModService modService = new ModService();

        String keyword  = request.getParameter("search");
        String category = request.getParameter("category");

        List<Mod> mods;

        // Priorité : recherche > filtre catégorie > tout afficher
        if (keyword != null && !keyword.trim().isEmpty()) {
            mods = modService.searchMods(keyword);
        } else if (category != null && !category.trim().isEmpty()) {
            mods = modService.getModsByCategory(category);
        } else {
            mods = modService.getAllMods();
        }
// setAttribute passe les donnees a la JSP
        request.setAttribute("mods",     mods);
        request.setAttribute("category", category);
        request.setAttribute("search",   keyword);
        request.setAttribute("count",    mods.size());

        request.getRequestDispatcher("/mods.jsp")
               .forward(request, response);
    }
}