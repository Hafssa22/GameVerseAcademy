<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Soumettre un Mod — GameVerse Academy</title>

<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Syne:wght@400;600&display=swap" rel="stylesheet">

<style>

:root {
    --bg-deep:#0B0F1A;
    --bg-card:#111827;
    --accent:#4A90D9;
    --accent2:#00D4FF;
    --gold:#F5C542;
    --text:#E2E8F0;
    --muted:#94A3B8;
    --border:rgba(74,144,217,.18);
}

*{box-sizing:border-box;margin:0;padding:0;}

body{
    font-family:'Syne',sans-serif;
    background:var(--bg-deep);
    color:var(--text);
    min-height:100vh;
}

/* background mesh */
body::before{
content:'';
position:fixed;
inset:0;
background:
radial-gradient(ellipse 70% 50% at 10% 20%, rgba(74,144,217,.12) 0%, transparent 65%),
radial-gradient(ellipse 60% 60% at 90% 80%, rgba(0,212,255,.08) 0%, transparent 60%);
z-index:0;
}

/* NAVBAR */
nav{
position:sticky;
top:0;
z-index:100;
display:flex;
align-items:center;
gap:24px;
padding:0 40px;
height:62px;
background:rgba(11,15,26,.82);
backdrop-filter:blur(18px);
border-bottom:1px solid var(--border);
}

.nav-logo{
font-family:'Orbitron',sans-serif;
font-size:18px;
font-weight:700;
color:var(--accent2);
text-decoration:none;
}

.nav-logo span{color:var(--gold);}

.nav-links{
margin-left:auto;
display:flex;
gap:6px;
}

.nav-links a{
color:var(--muted);
text-decoration:none;
font-size:13px;
font-weight:600;
padding:6px 14px;
border-radius:8px;
transition:.2s;
}

.nav-links a:hover{
background:rgba(74,144,217,.15);
color:var(--text);
}

/* PAGE WRAPPER */

.page{
position:relative;
z-index:1;
max-width:700px;
margin:auto;
padding:60px 20px;
}

/* FORM CARD */

.form-card{
background:var(--bg-card);
border:1px solid var(--border);
border-radius:18px;
padding:36px 40px;
box-shadow:0 8px 40px rgba(0,0,0,.45);
animation:fadeUp .5s ease;
}

.form-card h1{
font-family:'Orbitron',sans-serif;
margin-bottom:28px;
font-size:26px;
background:linear-gradient(90deg,#4A90D9,#00D4FF);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
}

/* INPUTS */

.form-group{
margin-bottom:20px;
}

label{
display:block;
font-size:13px;
margin-bottom:6px;
color:var(--muted);
}

input, textarea, select{
width:100%;
padding:10px 12px;
border-radius:8px;
border:1px solid var(--border);
background:#0f1625;
color:var(--text);
font-family:'Syne',sans-serif;
font-size:14px;
}

textarea{
resize:none;
height:100px;
}

/* BUTTON */

button{
margin-top:10px;
background:linear-gradient(135deg,#4A90D9,#00a8cc);
border:none;
padding:10px 18px;
border-radius:10px;
color:white;
font-size:14px;
font-weight:600;
cursor:pointer;
transition:.2s;
}

button:hover{
opacity:.85;
transform:scale(1.03);
}

/* SUCCESS / ERROR */

.message{
margin-bottom:15px;
padding:10px;
border-radius:8px;
font-size:13px;
}

.success{
background:#0f3d2c;
color:#7fffd4;
}

.error{
background:#3d1212;
color:#ff7f7f;
}

@keyframes fadeUp{
from{opacity:0;transform:translateY(20px);}
to{opacity:1;transform:translateY(0);}
}

</style>
</head>

<body>

<nav>
<a class="nav-logo" href="home.html">Game<span>Verse</span> Academy</a>

<div class="nav-links">
<a href="home.html">Accueil</a>
<a href="mods">Mods</a>
<a href="ModSubmitController">Soumettre</a>
</div>
</nav>


<div class="page">

<div class="form-card">

<h1>Soumettre un Mod</h1>

<% if(request.getAttribute("message")!=null){ %>
<div class="message success">
<%= request.getAttribute("message") %>
</div>
<% } %>

<% if(request.getAttribute("error")!=null){ %>
<div class="message error">
<%= request.getAttribute("error") %>
</div>
<% } %>

<form action="<%=request.getContextPath()%>/ModSubmitController" method="post">

<div class="form-group">
<label>Titre du Mod</label>
<input type="text" name="title" required>
</div>

<div class="form-group">
<label>Catégorie</label>
<select name="category">
<option>Gameplay</option>
<option>Graphique</option>
<option>Interface</option>
<option>Audio</option>
</select>
</div>

<div class="form-group">
<label>Auteur</label>
<input type="text" name="author" required>
</div>

<div class="form-group">
<label>Description</label>
<textarea name="description"></textarea>
</div>

<button type="submit">Soumettre le mod</button>

</form>

</div>
</div>

</body>
</html>