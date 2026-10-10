def application(environ, start_response):
    body = b"""<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Webapp Starter</title>
<style>
:root { color-scheme: light; }
* { box-sizing: border-box; }
body { margin:0; font:16px/1.6 system-ui, sans-serif; background:#f4f6fb;
       color:#182230; min-height:100vh; display:grid; place-items:center; }
main { max-width:620px; margin:24px; padding:clamp(28px,6vw,48px);
       background:white; border:1px solid #e6eaf0; border-radius:22px;
       box-shadow:0 18px 60px #18223012; }
.kicker { color:#315ee7; font-size:.8rem; font-weight:700;
          letter-spacing:.12em; text-transform:uppercase; }
h1 { line-height:1.1; letter-spacing:-.04em; font-size:clamp(2rem,6vw,3.2rem); }
p { color:#526174; }
code { background:#edf2f7; padding:3px 6px; border-radius:5px; }
</style>
</head>
<body>
<main>
<div class="kicker">Starter Runtime</div>
<h1>Deine Webanwendung</h1>
<p>Das Container-Grundgeruest ist bereit.</p>
<p>Lege dein Django-Projekt unter <code>/app</code> ab, um diese
Platzhalterseite zu ersetzen.</p>
</main>
</body>
</html>"""
    start_response("200 OK", [
        ("Content-Type", "text/html; charset=utf-8"),
        ("Content-Length", str(len(body))),
        ("Cache-Control", "no-store"),
    ])
    return [body]
