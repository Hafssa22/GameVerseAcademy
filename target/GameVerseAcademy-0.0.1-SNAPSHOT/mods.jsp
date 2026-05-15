<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Mod" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>GameVerse Academy — Mods</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Syne:wght@400;600&display=swap" rel="stylesheet">
    <style>
    
.user-info {
    text-decoration: none;
    color: var(--text);
    transition: color .2s;
}
.user-info:hover { color: var(--accent); }

.logout-btn {
    background: rgba(74,144,217,.2);
    border: 1px solid var(--accent);
    color: var(--text);
    font-family: 'Syne', sans-serif;
    font-size: 13px;
    font-weight: 600;
    padding: 6px 14px;
    border-radius: 8px;
    cursor: pointer;
    transition: all .2s;
}

.logout-btn:hover {
    background: var(--accent);
    color: #fff;
}

        :root {
            --bg-deep:    #0B0F1A;
            --bg-card:    #111827;
            --bg-card2:   #1a2235;
            --accent:     #4A90D9;
            --accent2:    5#00D4FF;
            --gold:       #F5C542;
            --text:       #E2E8F0;
            --muted:      #94A3B8;
            --border:     rgba(74,144,217,0.18);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Syne', sans-serif;
            background: var(--bg-deep);
            color: var(--text);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* ── Background mesh ── */
        body::before {
            content: '';
            position: fixed; inset: 0; z-index: 0;
            background:
                radial-gradient(ellipse 70% 50% at 10% 20%, rgba(74,144,217,.12) 0%, transparent 65%),
                radial-gradient(ellipse 60% 60% at 90% 80%, rgba(0,212,255,.08) 0%, transparent 60%);
            pointer-events: none;
        }

        /* ── Nav ── */
        nav {
            position: sticky; top: 0; z-index: 100;
            display: flex; align-items: center; gap: 24px;
            padding: 0 40px;
            height: 62px;
            background: rgba(11,15,26,.82);
            backdrop-filter: blur(18px);
            border-bottom: 1px solid var(--border);
        }

        .nav-logo {
            font-family: 'Orbitron', sans-serif;
            font-size: 18px;
            font-weight: 700;
            color: var(--accent2);
            text-decoration: none;
            letter-spacing: 1px;
            flex-shrink: 0;
        }

        .nav-logo span { color: var(--gold); }

        .nav-links {
            display: flex; gap: 6px;
            margin-left: auto;
        }

        .nav-links a {
            color: var(--muted);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: .5px;
            padding: 6px 14px;
            border-radius: 8px;
            transition: all .2s;
        }

        .nav-links a:hover, .nav-links a.active {
            color: var(--text);
            background: rgba(74,144,217,.15);
        }

        /* ── Page wrapper ── */
        .page {
            position: relative; z-index: 1;
            max-width: 1240px;
            margin: 0 auto;
            padding: 48px 28px 80px;
        }

        /* ── Header row ── */
        .page-header {
            display: flex; align-items: flex-end; gap: 20px;
            margin-bottom: 36px;
            flex-wrap: wrap;
        }

        .page-header h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: clamp(22px, 3vw, 32px);
            font-weight: 700;
            background: linear-gradient(90deg, #4A90D9, #00D4FF);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-header .sub {
            font-size: 13px;
            color: var(--muted);
            margin-left: auto;
        }

        /* ── Filter tabs ── */
        .tabs {
            display: flex; gap: 8px; flex-wrap: wrap;
            margin-bottom: 32px;
        }

        .tab {
            padding: 7px 18px;
            border-radius: 20px;
            font-size: 13px; font-weight: 600;
            cursor: pointer;
            border: 1px solid transparent;
            transition: all .2s;
            background: var(--bg-card2);
            color: var(--muted);
        }

        .tab.active, .tab:hover {
            background: var(--accent);
            color: #fff;
            border-color: var(--accent);
        }

        /* ── Cards grid ── */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 28px;
        }

        /* ── Individual card ── */
        .card {
            background: var(--bg-card);
            border-radius: 18px;
            overflow: hidden;
            border: 1px solid var(--border);
            box-shadow: 0 8px 32px rgba(0,0,0,.45);
            transition: transform .28s ease, box-shadow .28s ease;
            display: flex; flex-direction: column;
            animation: fadeUp .5s ease both;
        }

        .card:nth-child(1) { animation-delay: .05s; }
        .card:nth-child(2) { animation-delay: .12s; }
        .card:nth-child(3) { animation-delay: .19s; }
        .card:nth-child(4) { animation-delay: .26s; }
        .card:nth-child(5) { animation-delay: .33s; }
        .card:nth-child(6) { animation-delay: .40s; }

        @keyframes fadeUp {
            from { opacity:0; transform:translateY(24px); }
            to   { opacity:1; transform:translateY(0); }
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 16px 48px rgba(74,144,217,.22);
            border-color: rgba(74,144,217,.4);
        }

        /* ── Thumbnail ── */
        .card-thumb {
            position: relative;
            height: 190px;
            overflow: hidden;
        }

        .card-thumb img {
            width: 100%; height: 100%;
            object-fit: cover;
            transition: transform .4s ease;
        }

        .card:hover .card-thumb img { transform: scale(1.06); }

        .card-thumb .badge {
            position: absolute; top: 12px; left: 12px;
            background: rgba(74,144,217,.85);
            backdrop-filter: blur(6px);
            font-size: 11px; font-weight: 700;
            letter-spacing: .6px; text-transform: uppercase;
            color: #fff;
            padding: 4px 10px;
            border-radius: 20px;
        }

        /* ── Content ── */
        .card-content {
            padding: 18px 20px;
            flex: 1;
            display: flex; flex-direction: column; gap: 8px;
        }

        .card-content h3 {
            font-family: 'Orbitron', sans-serif;
            font-size: 15px;
            font-weight: 700;
            color: #fff;
            line-height: 1.35;
        }

        .card-meta {
            display: flex; align-items: center; gap: 8px;
            flex-wrap: wrap;
        }

        .card-meta .author {
            font-size: 12px; color: var(--muted);
        }

        .card-meta .dot { color: var(--border); }

        .card-meta .platform {
            font-size: 11px;
            color: var(--accent2);
            background: rgba(0,212,255,.08);
            padding: 2px 8px;
            border-radius: 10px;
            border: 1px solid rgba(0,212,255,.2);
        }

        .card-desc {
            font-size: 13px;
            color: #9aafc7;
            line-height: 1.6;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* ── Footer ── */
        .card-footer {
            display: flex; align-items: center;
            justify-content: space-between;
            padding: 12px 20px 18px;
            border-top: 1px solid rgba(255,255,255,.05);
            gap: 10px;
        }

        .dl-count {
            font-size: 13px;
            color: var(--muted);
            display: flex; align-items: center; gap: 5px;
        }

        .dl-count svg { opacity: .7; }

        .btn-voir {
            background: linear-gradient(135deg, #4A90D9, #00a8cc);
            border: none;
            padding: 8px 18px;
            border-radius: 10px;
            color: #fff;
            font-family: 'Syne', sans-serif;
            font-size: 13px; font-weight: 700;
            cursor: pointer;
            letter-spacing: .4px;
            transition: opacity .2s, transform .15s;
        }

        .btn-voir:hover { opacity: .85; transform: scale(1.04); }

        /* ── Empty state ── */
        .empty {
            text-align: center;
            padding: 80px 20px;
            color: var(--muted);
        }
        .empty h2 { font-family:'Orbitron',sans-serif; font-size:20px; margin-bottom:10px; }

        /* ── Responsive ── */
        @media (max-width: 600px) {
            nav { padding: 0 16px; }
            .page { padding: 28px 14px 60px; }
            .cards-container { grid-template-columns: 1fr; }
        }
        
        
        /* ── Search bar ── */
.search-form {
    margin-bottom: 24px;
}

.search-bar {
    display: flex;
    align-items: center;
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 6px 6px 6px 16px;
    gap: 10px;
    transition: border-color .2s, box-shadow .2s;
}

.search-bar:focus-within {
    border-color: var(--accent);
    box-shadow: 0 0 0 3px rgba(74,144,217,.15);
}

.search-icon {
    color: var(--muted);
    font-size: 16px;
    flex-shrink: 0;
}

.search-input {
    flex: 1;
    background: transparent;
    border: none;
    outline: none;
    color: var(--text);
    font-family: 'Syne', sans-serif;
    font-size: 14px;
    padding: 6px 0;
}

.search-input::placeholder {
    color: var(--muted);
}

.search-btn {
    background: linear-gradient(135deg, #4A90D9, #00a8cc);
    border: none;
    padding: 8px 20px;
    border-radius: 10px;
    color: #fff;
    font-family: 'Syne', sans-serif;
    font-size: 13px;
    font-weight: 700;
    cursor: pointer;
    transition: .2s;
    flex-shrink: 0;
}

.search-btn:hover {
    opacity: .85;
    transform: scale(1.03);
}

.search-clear {
    color: var(--muted);
    font-size: 14px;
    padding: 6px 10px;
    border-radius: 8px;
    text-decoration: none;
    transition: .2s;
    flex-shrink: 0;
}

.search-clear:hover {
    color: #ff6b6b;
    background: rgba(255,107,107,.1);
}

/* ── Search result message ── */
.search-result-msg {
    background: rgba(74,144,217,.08);
    border: 1px solid rgba(74,144,217,.2);
    border-radius: 10px;
    padding: 10px 16px;
    font-size: 13px;
    color: var(--muted);
    margin-bottom: 20px;
}

.search-result-msg strong {
    color: var(--accent2);
}
    </style>
</head>
<body>

<!-- ════ Navigation ════ -->
<nav>
    <a class="nav-logo" href="#">Game<span>Verse</span> Academy</a>
    <div class="nav-links">
        <a href="home.html">Accueil</a>
        <a href="mods">Mods</a>
        <a href="ModSubmitController">Soumettre</a>
    </div>

    <a href="<%= request.getContextPath() %>/ProfileController" class="user-info">
    <i class="bi bi-person-circle"></i>
    <span>
        <%= session.getAttribute("user") != null
            ? session.getAttribute("user") : "Visiteur" %>
    </span>
</a>

    <form action="<%= request.getContextPath() %>/LogoutController" method="post">
        <button type="submit" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i> Déconnexion
        </button>
    </form>
</nav>

<!-- ════ Page ════ -->
<div class="page">

    <div class="page-header">
        <h1>Bibliothèque de Mods</h1>
        <span class="sub">Tous les mods disponibles</span>
    </div>
    
     <!-- ══ Barre de recherche ══ -->
    <form action="<%= request.getContextPath() %>/mods" method="get" class="search-form">
        <div class="search-bar">
            <i class="bi bi-search search-icon"></i>
            <input
                type="text"
                name="search"
                class="search-input"
                placeholder="Rechercher par titre, catégorie, auteur..."
                value="<%= request.getAttribute("search") != null ? request.getAttribute("search") : "" %>"
                autocomplete="off"
            >
            <button type="submit" class="search-btn">Rechercher</button>
            <% if (request.getAttribute("search") != null &&
                   !request.getAttribute("search").toString().isEmpty()) { %>
            <a href="<%= request.getContextPath() %>/mods" class="search-clear">
                <i class="bi bi-x-lg"></i>
            </a>
            <% } %>
        </div>
    </form>

    <!-- Message résultat de recherche -->
    <% if (request.getAttribute("search") != null &&
           !request.getAttribute("search").toString().isEmpty()) { %>
    <div class="search-result-msg">
        Résultats pour : <strong>"<%= request.getAttribute("search") %>"</strong>
        — <%= request.getAttribute("count") %> mod(s) trouvé(s)
    </div>
    <% } %>
    
    <!-- ══ Cards Grid ══ -->
    <div class="cards-container">

    <%
        /* ── Image mapping helper ── */
        java.util.Map<String,String> imgMap = new java.util.LinkedHashMap<>();
        imgMap.put("elder scrolls",  "assets/images/elder-scrolls-skyrim.jpg");
        imgMap.put("skyrim",         "assets/images/elder-scrolls-skyrim.jpg");
        imgMap.put("fallout",        "assets/images/Fallout_4.jpg");
        imgMap.put("grand theft",    "assets/images/grandThief.jpg");
        imgMap.put("gta",            "assets/images/grandThief.jpg");
        imgMap.put("mario",          "assets/images/superMario.jpg");

        String defaultImg = "assets/images/elder-scrolls-skyrim.jpg";

        @SuppressWarnings("unchecked")
        List<Mod> mods = (List<Mod>) request.getAttribute("mods");
        if (mods != null && !mods.isEmpty()) {
            for (Mod mod : mods) {

                /* Choose image by matching title keywords */
                String img = defaultImg;
                String titleLower = mod.getTitle() == null ? "" : mod.getTitle().toLowerCase();
                for (java.util.Map.Entry<String,String> e : imgMap.entrySet()) {
                    if (titleLower.contains(e.getKey())) { img = e.getValue(); break; }
                }
    %>

        <div class="card">

            <div class="card-thumb">
                <img src="<%= img %>" alt="<%= mod.getTitle() %>">
                <span class="badge"><%= mod.getCategory() != null ? mod.getCategory() : "Mod" %></span>
            </div>

            <div class="card-content">
                <h3><%= mod.getTitle() %></h3>

                <div class="card-meta">
                    <span class="author">By <%= mod.getAuthor() %></span>
                    <span class="dot">•</span>
                    <span class="platform">PC</span>
                </div>

                <p class="card-desc"><%= mod.getDescription() %></p>
            </div>

            <div class="card-footer">
                <span class="dl-count">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round">
                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                        <polyline points="7 10 12 15 17 10"/>
                        <line x1="12" y1="15" x2="12" y2="3"/>
                    </svg>
                    <%= mod.getDownloads() %> téléchargements
                </span>
                <a href="<%= request.getContextPath() %>/ReviewController?modId=<%= mod.getId() %>">
                <button class="btn-voir">Voir reviews</button>
                </a>
            </div>

        </div>

    <%
            } /* end for */
        } else { /* empty state */
    %>
        <div class="empty" style="grid-column:1/-1">
            <h2>Aucun mod trouvé</h2>
            <p>Il n'y a pas encore de mods disponibles.</p>
        </div>
    <%
        }
    %>

    </div>
</div>

</body>
</html>
