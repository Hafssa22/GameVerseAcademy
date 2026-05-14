<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ma.ac.esi.gameverseacademy.model.Profile" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Mon Profil — GameVerse Academy</title>
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Syne:wght@400;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<style>
:root {
    --bg-deep:#0B0F1A; --bg-card:#111827; --bg-card2:#1a2235;
    --accent:#4A90D9;  --accent2:#00D4FF; --gold:#F5C542;
    --text:#E2E8F0;    --muted:#94A3B8;   --border:rgba(74,144,217,.18);
}
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Syne',sans-serif;background:var(--bg-deep);color:var(--text);min-height:100vh;}
body::before{content:'';position:fixed;inset:0;z-index:0;
    background:radial-gradient(ellipse 70% 50% at 10% 20%,rgba(74,144,217,.12) 0%,transparent 65%),
               radial-gradient(ellipse 60% 60% at 90% 80%,rgba(0,212,255,.08) 0%,transparent 60%);}
nav{position:sticky;top:0;z-index:100;display:flex;align-items:center;gap:24px;
    padding:0 40px;height:62px;background:rgba(11,15,26,.82);
    backdrop-filter:blur(18px);border-bottom:1px solid var(--border);}
.nav-logo{font-family:'Orbitron',sans-serif;font-size:18px;font-weight:700;
    color:var(--accent2);text-decoration:none;}
.nav-logo span{color:var(--gold);}
.nav-links{margin-left:auto;display:flex;gap:6px;}
.nav-links a{color:var(--muted);text-decoration:none;font-size:13px;font-weight:600;
    padding:6px 14px;border-radius:8px;transition:.2s;}
.nav-links a:hover{background:rgba(74,144,217,.15);color:var(--text);}
.page{position:relative;z-index:1;max-width:720px;margin:auto;padding:60px 20px;}

/* Banner + avatar */
.profile-card{background:var(--bg-card);border:1px solid var(--border);
    border-radius:20px;overflow:hidden;box-shadow:0 8px 40px rgba(0,0,0,.45);}
.profile-banner{height:120px;
    background:linear-gradient(135deg,#1a3a6e 0%,#0e2244 60%,#0B0F1A 100%);
    position:relative;}
.profile-avatar{position:absolute;bottom:-44px;left:32px;width:88px;height:88px;
    border-radius:50%;background:linear-gradient(135deg,var(--accent),var(--accent2));
    display:flex;align-items:center;justify-content:center;font-size:34px;
    font-family:'Orbitron',sans-serif;font-weight:700;color:#fff;
    border:4px solid var(--bg-card);box-shadow:0 4px 20px rgba(74,144,217,.4);}
.profile-body{padding:64px 32px 32px;}
.profile-email{font-size:13px;color:var(--muted);margin-bottom:24px;}

/* Messages */
.msg{padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:18px;}
.msg.ok{background:#0f3d2c;color:#7fffd4;}
.msg.err{background:#3d1212;color:#ff7f7f;}

/* Form */
.form-group{margin-bottom:18px;}
label{display:block;font-size:12px;color:var(--muted);margin-bottom:6px;font-weight:600;letter-spacing:.5px;}
input,textarea{width:100%;padding:10px 12px;border-radius:8px;border:1px solid var(--border);
    background:#0f1625;color:var(--text);font-family:'Syne',sans-serif;font-size:14px;}
textarea{resize:none;height:90px;}
input:focus,textarea:focus{outline:none;border-color:var(--accent);}

/* Buttons */
.btn-row{display:flex;gap:12px;flex-wrap:wrap;margin-top:24px;}
.btn-save{background:linear-gradient(135deg,#4A90D9,#00a8cc);border:none;
    padding:10px 24px;border-radius:10px;color:#fff;font-family:'Syne',sans-serif;
    font-size:14px;font-weight:700;cursor:pointer;transition:.2s;}
.btn-save:hover{opacity:.85;transform:scale(1.03);}
.btn-delete{background:transparent;border:1px solid #e05;
    padding:10px 24px;border-radius:10px;color:#e05;font-family:'Syne',sans-serif;
    font-size:14px;font-weight:700;cursor:pointer;transition:.2s;}
.btn-delete:hover{background:#e05;color:#fff;}
.btn-back{color:var(--muted);text-decoration:none;font-size:13px;
    display:inline-flex;align-items:center;gap:6px;margin-top:20px;transition:.2s;}
.btn-back:hover{color:var(--text);}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
.profile-card{animation:fadeUp .5s ease;}
</style>
</head>
<body>
<!--on recupere les objets passes par ProfileController-->
<%
    Profile profile = (Profile) request.getAttribute("profile");
    String  email   = (String)  request.getAttribute("email");
    if (email == null) email = "";
    String initial  = email.length() > 0 ? email.substring(0,1).toUpperCase() : "?";//prend 1ere lettre de l'email en majuscule et l'affiche dans l'avatar, email vide ?
%>
<nav>
    <a class="nav-logo" href="<%= request.getContextPath() %>/mods">Game<span>Verse</span> Academy</a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/mods">Mods</a>
        <a href="<%= request.getContextPath() %>/ModSubmitController">Soumettre</a>
    </div>
</nav>

<div class="page">
<div class="profile-card">

    <div class="profile-banner">
        <div class="profile-avatar"><%= initial %></div><!--  affiche la premiere lettre de l'email en majuscule-->
    </div>

    <div class="profile-body">
        <p class="profile-email"><i class="bi bi-envelope"></i> <%= email %></p>

        <!-- Messages -->
        <% if (request.getAttribute("message") != null) { %>
            <div class="msg ok"><i class="bi bi-check-circle"></i> <%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="msg err"><i class="bi bi-exclamation-circle"></i> <%= request.getAttribute("error") %></div>
        <% } %>

        <!-- Formulaire Save: un champs cacher, l'user ne le voit pas, il envoie une action save au controller pour qu'il sache quoi faire -->
        <form action="<%= request.getContextPath() %>/ProfileController" method="post">
            <input type="hidden" name="action" value="save">

            <div class="form-group">
                <label>NOM D'UTILISATEUR</label>
                <input type="text" name="username" placeholder="Ex: GameMaster42"
                    value="<%= profile != null && profile.getUsername() != null ? profile.getUsername() : "" %>" required>
            </div>

            <div class="form-group">
                <label>BIO</label>
                <textarea name="bio" placeholder="Parle-nous de toi..."><%= profile != null && profile.getBio() != null ? profile.getBio() : "" %></textarea>
            </div>

            <div class="form-group">
                <label>LOCALISATION</label>
                <input type="text" name="location" placeholder="Ex: Rabat, Maroc"
                    value="<%= profile != null && profile.getLocation() != null ? profile.getLocation() : "" %>">
            </div>

            <div class="form-group">
                <label>SITE WEB</label>
                <input type="text" name="website" placeholder="https://..."
                    value="<%= profile != null && profile.getWebsite() != null ? profile.getWebsite() : "" %>">
            </div>

            <div class="form-group">
                <label>URL AVATAR</label>
                <input type="text" name="avatarUrl" placeholder="https://..."
                    value="<%= profile != null && profile.getAvatarUrl() != null ? profile.getAvatarUrl() : "" %>">
            </div>

            <div class="btn-row">
                <button type="submit" class="btn-save">
                    <i class="bi bi-save"></i> Enregistrer
                </button>
            </div>
        </form>

        <!-- Formulaire Delete séparé -->
        <% if (profile != null && profile.getId() != 0) { %>
        <form action="<%= request.getContextPath() %>/ProfileController" method="post"
              onsubmit="return confirm('Supprimer définitivement votre profil ?')">
            <input type="hidden" name="action" value="delete">
            <div class="btn-row">
                <button type="submit" class="btn-delete">
                    <i class="bi bi-trash"></i> Supprimer le profil
                </button>
            </div>
        </form>
        <% } %>

        <a href="<%= request.getContextPath() %>/mods" class="btn-back">
            <i class="bi bi-arrow-left"></i> Retour aux mods
        </a>
    </div>
</div>
</div>
</body>
</html>