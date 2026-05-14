package ma.ac.esi.gameverseacademy.main;

import ma.ac.esi.gameverseacademy.controller.LoginController;
import ma.ac.esi.gameverseacademy.controller.ReviewController;
import ma.ac.esi.gameverseacademy.controller.ModController;
import ma.ac.esi.gameverseacademy.controller.LogoutController;
import ma.ac.esi.gameverseacademy.controller.ModSubmitController;
import ma.ac.esi.gameverseacademy.controller.ProfileController;
import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import java.io.File;


public class Main {
    public static void main(String[] args) throws Exception {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(9090);
        tomcat.getConnector();

        String webappDir = new File("src/main/webapp").getAbsolutePath();
        Context ctx = tomcat.addWebapp("/gameverseacademy", webappDir);
        ctx.setParentClassLoader(Main.class.getClassLoader());

        // Enregistrement de tous les servlets
        Tomcat.addServlet(ctx, "LoginController", new LoginController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/LoginController", "LoginController");

        Tomcat.addServlet(ctx, "ModController", new ModController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/mods", "ModController");

        Tomcat.addServlet(ctx, "LogoutController", new LogoutController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/LogoutController", "LogoutController");

        Tomcat.addServlet(ctx, "ModSubmitController", new ModSubmitController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ModSubmitController", "ModSubmitController");

        Tomcat.addServlet(ctx, "ProfileController", new ProfileController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ProfileController", "ProfileController");

        Tomcat.addServlet(ctx, "ReviewController", new ReviewController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ReviewController", "ReviewController");
        
        tomcat.start();
        System.out.println(">>> http://localhost:9091/gameverseacademy/LoginController");

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            try { tomcat.stop(); tomcat.destroy(); }
            catch (Exception e) { e.printStackTrace(); }
        }));

        tomcat.getServer().await();
       
    }
}