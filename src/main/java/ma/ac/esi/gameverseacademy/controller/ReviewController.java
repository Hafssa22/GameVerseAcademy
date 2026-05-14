package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Review;
import ma.ac.esi.gameverseacademy.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ReviewController")
public class ReviewController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ReviewService reviewService = new ReviewService();

    // ── GET : afficher les reviews d'un mod ──────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        String modIdParam = request.getParameter("modId");// modId vient de l'URL : /ReviewController?modId=5
        String editParam  = request.getParameter("editId");

        if (modIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/mods");
            return;
        }

        int modId = Integer.parseInt(modIdParam);
        List<Review> reviews = reviewService.getReviewsForMod(modId);

        request.setAttribute("reviews", reviews);
        request.setAttribute("modId",   modId);

        // Si on clique "modifier", on pré-remplit le formulaire
        if (editParam != null) {
            Review toEdit = reviewService.getReviewById(Integer.parseInt(editParam));
            request.setAttribute("toEdit", toEdit);
        }

        request.getRequestDispatcher("/WEB-INF/views/reviews.jsp")
               .forward(request, response);
    }

    // ── POST : ajouter, modifier ou supprimer ────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        String email  = (String) session.getAttribute("user");
        String action = request.getParameter("action");
        int    modId  = Integer.parseInt(request.getParameter("modId"));

        if ("delete".equals(action)) {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            reviewService.deleteReview(reviewId, email);

        } else if ("update".equals(action)) {
            Review r = new Review();
            r.setId(Integer.parseInt(request.getParameter("reviewId")));
            r.setModId(modId);
            r.setUserEmail(email);
            r.setRating(Integer.parseInt(request.getParameter("rating")));
            r.setComment(request.getParameter("comment"));
            reviewService.updateReview(r);

        } else {
            // action = add
            Review r = new Review();
            r.setModId(modId);
            r.setUserEmail(email);
            r.setRating(Integer.parseInt(request.getParameter("rating")));
            r.setComment(request.getParameter("comment"));
            reviewService.addReview(r);
        }

        response.sendRedirect(request.getContextPath()
                + "/ReviewController?modId=" + modId);
    }
}