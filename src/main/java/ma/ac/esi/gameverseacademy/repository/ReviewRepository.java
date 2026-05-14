package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.Review;
import ma.ac.esi.gameverseacademy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepository {

    //Lire toutes les reviews d'un mod 
    public List<Review> findByModId(int modId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE mod_id = ? ORDER BY created_at DESC";//recupere toutes les reviews d'un mod, les plus recentes en premier
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, modId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // ── Lire une review par ID ───────────────────────────────────
    public Review findById(int id) {
        String sql = "SELECT * FROM reviews WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // ── Créer une review ─────────────────────────────────────────
    public boolean insert(Review r) {
        String sql = "INSERT INTO reviews (mod_id, user_email, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, r.getModId());
            stmt.setString(2, r.getUserEmail());
            stmt.setInt(3, r.getRating());
            stmt.setString(4, r.getComment());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // ── Modifier une review ──────────────────────────────────────
    public boolean update(Review r) {
        String sql = "UPDATE reviews SET rating=?, comment=? WHERE id=? AND user_email=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, r.getRating());
            stmt.setString(2, r.getComment());
            stmt.setInt(3, r.getId());
            stmt.setString(4, r.getUserEmail());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // ── Supprimer une review ─────────────────────────────────────
    public boolean delete(int id, String userEmail) {
        String sql = "DELETE FROM reviews WHERE id=? AND user_email=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.setString(2, userEmail);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private Review mapRow(ResultSet rs) throws SQLException {
        return new Review(
            rs.getInt("id"),
            rs.getInt("mod_id"),
            rs.getString("user_email"),
            rs.getInt("rating"),
            rs.getString("comment"),
            rs.getTimestamp("created_at")
        );
    }
}