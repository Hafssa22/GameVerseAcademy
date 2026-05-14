<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Review" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Reviews — GameVerse Academy</title>
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Syne:wght@400;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<style>
:root{--bg-deep:#0B0F1A;--bg-card:#111827;--bg-card2:#1a2235;
    --accent:#4A90D9;--accent2:#00D4FF;--gold:#F5C542;
    --text:#E2E8F0;--muted:#94A3B8;--border:rgba(74,144,217,.18);}
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
.page{position:relative;z-index:1;max-width:800px;margin:auto;padding:60px 20px;}
h1{font-family:'Orbitron',sans-serif;font-size:26px;
    background:linear-gradient(90deg,#4A90D9,#00D4FF);
    -webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:32px;}

/* Form card */
.form-card{background:var(--bg-card);border:1px solid var(--border);
    border-radius:16px;padding:28px 32px;margin-bottom:36px;}
.form-card h2{font-family:'Orbitron',sans-serif;font-size:16px;color:var(--accent2);margin-bottom:20px;}
.form-group{margin-bottom:16px;}
label{display:block;font-size:12px;color:var(--muted);margin-bottom:6px;font-weight:600;}
input,textarea,select{width:100%;padding:10px 12px;border-radius:8px;
    border:1px solid var(--border);background:#0f1625;color:var(--text);
    font-family:'Syne',sans-serif;font-size:14px;}
textarea{resize:none;height:80px;}
.btn-submit{background:linear-gradient(135deg,#4A90D9,#00a8cc);border:none;
    padding:10px 22px;border-radius:10px;color:#fff;font-family:'Syne',sans-serif;
    font-size:14px;font-weight:700;cursor:pointer;transition:.2s;margin-top:8px;}
.btn-submit:hover{opacity:.85;transform:scale(1.03);}

/* Stars display */
.stars{color:var(--gold);font-size:16px;letter-spacing:2px;}

/* Review cards */
.review-card{background:var(--bg-card);border:1px solid var(--border);
    border-radius:14px;padding:20px 24px;margin-bottom:16px;
    animation:fadeUp .4s ease both;}
@keyframes fadeUp{from{opacity:0;transform:translateY(16px);}to{opacity:1;transform:translateY(0);}}
.review-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:10px;}
.review-author{font-size:13px;color:var(--accent2);font-weight:600;}
.review-date{font-size:11px;color:var(--muted);}
.review-comment{font-size:14px;color:var(--text);line-height:1.6;}
.action-row{display:flex;gap:8px;margin-top:12px;}
.btn-edit{background:transparent;border:1px solid var(--accent);color:var(--accent);
    padding:5px 14px;border-radius:8px;font-size:12px;cursor:pointer;transition:.2s;}
.btn-edit:hover{background:var(--accent);color:#fff;}
.btn-del{background:transparent;border:1px solid #e05;color:#e05;
    padding:5px 14px;border-radius:8px;font-size:12px;cursor:pointer;transition:.2s;}
.btn-del:hover{background:#e05;color:#fff;}
.back-link{display:inline-flex;align-items:center;gap:6px;color:var(--muted);
    text-decoration:none;font-size:13px;margin-top:20px;transition:.2s;}
.back-link:hover{color:var(--text);}
.empty{text-align:center;padding:40px;color:var(--muted);}
</style>
</head>
<body>
<%
    String email  = (String) session.getAttribute("user");
    int    modId  = (Integer) request.getAttribute("modId");
    @SuppressWarnings("unchecked")
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    Review toEdit = (Review) request.getAttribute("toEdit");
%>
<nav>
    <a class="nav-logo" href="<%= request.getContextPath() %>/mods">Game<span>Verse</span> Academy</a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/mods">Mods</a>
        <a href="<%= request.getContextPath() %>/ModSubmitController">Soumettre</a>
        <a href="<%= request.getContextPath() %>/ProfileController">Profil</a>
    </div>
</nav>

<div class="page">
<h1><i class="bi bi-star-half"></i> Reviews du Mod #<%= modId %></h1>

<!-- ══ Formulaire Ajouter / Modifier ══ -->
<div class="form-card">
    <h2><%= toEdit != null ? "✏️ Modifier ma review" : "➕ Ajouter une review" %></h2>
    <form action="<%= request.getContextPath() %>/ReviewController" method="post">

        <input type="hidden" name="modId"  value="<%= modId %>">
        <input type="hidden" name="action" value="<%= toEdit != null ? "update" : "add" %>">
        <% if (toEdit != null) { %>
        <input type="hidden" name="reviewId" value="<%= toEdit.getId() %>">
        <% } %>

        <div class="form-group">
            <label>NOTE (1 à 5)</label>
            <select name="rating">
                <% for (int i = 1; i <= 5; i++) {
                    boolean sel = toEdit != null && toEdit.getRating() == i; %>
                <option value="<%= i %>" <%= sel ? "selected" : "" %>><%= i %> ★</option>
                <% } %>
            </select>
        </div>

        <div class="form-group">
            <label>COMMENTAIRE</label>
            <textarea name="comment" required><%= toEdit != null && toEdit.getComment() != null ? toEdit.getComment() : "" %></textarea>
        </div>

        <button type="submit" class="btn-submit">
            <i class="bi bi-send"></i>
            <%= toEdit != null ? "Mettre à jour" : "Publier la review" %>
        </button>
    </form>
</div>

<!-- ══ Liste des reviews ══ -->
<% if (reviews == null || reviews.isEmpty()) { %>
    <div class="empty">Aucune review pour ce mod. Soyez le premier !</div>
<% } else {
    for (Review r : reviews) {
        String stars = "★".repeat(r.getRating()) + "☆".repeat(5 - r.getRating());
        boolean isOwner = r.getUserEmail().equals(email);
%>
    <div class="review-card">
        <div class="review-header">
            <span class="review-author"><i class="bi bi-person-circle"></i> <%= r.getUserEmail() %></span>
            <span class="review-date"><%= r.getCreatedAt() != null ? r.getCreatedAt().toString().substring(0,10) : "" %></span>
        </div>
        <div class="stars"><%= stars %></div>
        <p class="review-comment"><%= r.getComment() %></p>

        <% if (isOwner) { %>
        <div class="action-row">
            <!-- Modifier -->
            <a href="<%= request.getContextPath() %>/ReviewController?modId=<%= modId %>&editId=<%= r.getId() %>">
                <button class="btn-edit"><i class="bi bi-pencil"></i> Modifier</button>
            </a>
            <!-- Supprimer -->
            <form action="<%= request.getContextPath() %>/ReviewController" method="post"
                  onsubmit="return confirm('Supprimer cette review ?')">
                <input type="hidden" name="action"   value="delete">
                <input type="hidden" name="modId"    value="<%= modId %>">
                <input type="hidden" name="reviewId" value="<%= r.getId() %>">
                <button type="submit" class="btn-del"><i class="bi bi-trash"></i> Supprimer</button>
            </form>
        </div>
        <% } %>
    </div>
<% } } %>

<a href="<%= request.getContextPath() %>/mods" class="back-link">
    <i class="bi bi-arrow-left"></i> Retour aux mods
</a>
</div>
</body>
</html>