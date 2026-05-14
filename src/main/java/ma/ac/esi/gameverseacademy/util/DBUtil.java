package ma.ac.esi.gameverseacademy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL =
            "jdbc:mariadb://localhost:3306/gameverseacademy"; //jdbc est un protocole java pour les bdd et mariadb type de la bdd
    private static final String USER = "root"; //id de connexion a mariadb
    private static final String PASSWORD = "";
// un bloc static qui s'execute une seule fois au demarrage et charge le driver MariaDB en memoire sans lui Java ne sait pas comment parler avec mariadb
    static {
        try {
            // Chargement du driver MariaDB
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MariaDB JDBC Driver not found", e);
        }
    }

    // static pour pouvoir l'appeler sans creer l'objet DBUtil, et appeler par tous repository ayant besoin de la BDD
    // la methode appartient a la classe pas a l'objet et on l'appelle sans creer d'instance
    //dans tout le reste du projet on l'appelle sans cree un new DBUtil
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.err.println("Erreur lors de la connexion à la base de données MariaDB !");
            e.printStackTrace();
        }
        return null;
    }
}

