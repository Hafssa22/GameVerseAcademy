package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.repository.ModRepository;

import java.util.List;

public class ModService {

    private ModRepository modRepository = new ModRepository();

    //Retourne tous les mods
    public List<Mod> getAllMods() {
        return modRepository.getAllMods();
    }

    // ── Retourne un mod par son ID ───────────────────────────────
    public Mod getModById(int id) {
        return modRepository.getModById(id);
    }

    // ── Retourne les mods filtrés par catégorie 
    public List<Mod> getModsByCategory(String category) {
        List<Mod> all      = modRepository.getAllMods();
        List<Mod> filtered = new java.util.ArrayList<>();
        for (Mod mod : all) {
            if (mod.getCategory() != null &&
                mod.getCategory().equalsIgnoreCase(category)) { // equalsIgnoreCase: ignore majuscules/minuscules
                filtered.add(mod);
            }
        }
        return filtered;
    }
    
//validation de titre si le titre est vide il refuse l'insertion
    public boolean submitMod(Mod mod) {

        if (mod.getTitle() == null || mod.getTitle().trim().isEmpty()) {
            return false;
        }

        return modRepository.insertMod(mod);
    }
    
    public List<Mod> searchMods(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllMods();
        }
        return modRepository.searchMods(keyword.trim());
    }//on valide avant d'envoyer au Repo si keyword vide -> retourne tous les mods et trim() enleve les espaces avant et apres
}
