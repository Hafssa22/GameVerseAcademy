package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Profile;
import ma.ac.esi.gameverseacademy.repository.ProfileRepository;

public class ProfileService {

    private final ProfileRepository repo = new ProfileRepository();

    public Profile getProfile(String email) {
        return repo.findByEmail(email);
    }
// on doit valider le username
    public boolean createProfile(Profile p) {
        if (p.getUsername() == null || p.getUsername().trim().isEmpty()) return false;
        return repo.insert(p);
    }

    public boolean updateProfile(Profile p) {
        if (p.getUsername() == null || p.getUsername().trim().isEmpty()) return false;
        return repo.update(p);
    }

    public boolean deleteProfile(String email) {
        return repo.delete(email);
    }
}