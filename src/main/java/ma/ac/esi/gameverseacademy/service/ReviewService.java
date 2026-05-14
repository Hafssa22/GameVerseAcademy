package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Review;
import ma.ac.esi.gameverseacademy.repository.ReviewRepository;

import java.util.List;

public class ReviewService {

    private final ReviewRepository repo = new ReviewRepository();

    public List<Review> getReviewsForMod(int modId) {
        return repo.findByModId(modId);
    }

    public Review getReviewById(int id) {
        return repo.findById(id);
    }
// on doit valider que la note est entre 1 et 5 ainsi que le commentaire est non vide
    public boolean addReview(Review r) {
        if (r.getRating() < 1 || r.getRating() > 5) return false;
        if (r.getComment() == null || r.getComment().trim().isEmpty()) return false;
        return repo.insert(r);
    }

    public boolean updateReview(Review r) {
        if (r.getRating() < 1 || r.getRating() > 5) return false;
        return repo.update(r);
    }

    public boolean deleteReview(int id, String userEmail) {
        return repo.delete(id, userEmail);
    }
}