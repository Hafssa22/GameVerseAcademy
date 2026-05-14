package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.Profile;
import ma.ac.esi.gameverseacademy.util.DBUtil;

import java.sql.*;

public class ProfileRepository {

    //Lire le profil par email, on cherche le profil d'un user par son mail et retourne null si aucun profil trouve
    public Profile findByEmail(String email) {
        String sql = "SELECT * FROM profiles WHERE user_email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Créer un profil cette methode est appelee quand l'utilisateur n'a pas encore de profil 
    public boolean insert(Profile p) {
        String sql = "INSERT INTO profiles (user_email, username, bio, avatar_url, location, website) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getUserEmail());
            stmt.setString(2, p.getUsername());
            stmt.setString(3, p.getBio());
            stmt.setString(4, p.getAvatarUrl());
            stmt.setString(5, p.getLocation());
            stmt.setString(6, p.getWebsite());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Modifier un profil
    public boolean update(Profile p) {
        String sql = "UPDATE profiles SET username=?, bio=?, avatar_url=?, location=?, website=? " +
                     "WHERE user_email=?"; // on filtre sur l'utilisateur connecte
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getUsername());
            stmt.setString(2, p.getBio());
            stmt.setString(3, p.getAvatarUrl());
            stmt.setString(4, p.getLocation());
            stmt.setString(5, p.getWebsite());
            stmt.setString(6, p.getUserEmail());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Supprimer un profil
    public boolean delete(String email) {
        String sql = "DELETE FROM profiles WHERE user_email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Mapper ResultSet → Profile, methode utilitaire privee
    //permet de convertir une ligne ResultSet en objet Profile
    //Evite la duplication de code dans findByEmail
    private Profile mapRow(ResultSet rs) throws SQLException {
        return new Profile(
            rs.getInt("id"),
            rs.getString("user_email"),
            rs.getString("username"),
            rs.getString("bio"),
            rs.getString("avatar_url"),
            rs.getString("location"),
            rs.getString("website"),
            rs.getTimestamp("created_at")
        );
    }
}