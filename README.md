# Webapp Starter: Django + Gunicorn + PostgreSQL

Ein bewusst kleines Laufzeit-Image für eine spätere Django-Webanwendung. Ohne Anwendung wird eine moderne Platzhalterseite ausgeliefert. Sobald `manage.py` unter `/app` vorhanden ist, startet Gunicorn `config.wsgi:application`.

## Struktur

- `Dockerfile` – Laufzeit-Image, intern Port **8080**
- `entrypoint.sh` – startet Projekt oder Platzhalter
- `placeholder.py` – lauffähige Platzhalterseite
- `compose.yaml` – lokaler Webcontainer plus PostgreSQL
- `k8s/` – Kubernetes Deployment, Service und optionaler Ingress
- `openshift/` – Hinweise zur Anpassung für OKD/OpenShift
- `app/` – Mount-Punkt für dein Django-Projekt

## Lokal starten

```bash
cp .env.example .env
# Passwort in .env ändern
docker compose up --build -d
```

Dann `http://localhost` öffnen. Das Image lauscht intern auf 8080, Compose veröffentlicht Host-Port 80.

## Eigene App einhängen

Lege dein Django-Projekt in `app/`, sodass mindestens `app/manage.py` und `app/config/wsgi.py` vorhanden sind. Der Mount ist in Compose read-only (`./app:/app:ro`); ändere ihn auf `./app:/app`, wenn du im Container schreiben musst. Für produktive Images die Anwendung besser beim Build ins Image übernehmen, statt Quellcode als Volume einzuhängen.

Wenn dein Django-Modul anders heißt, setze `DJANGO_WSGI_MODULE`, zum Beispiel `myproject.wsgi:application`.

## PostgreSQL

Compose stellt `db` als PostgreSQL-Dienst bereit. Die App liest `POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_DB`, `POSTGRES_USER` und `POSTGRES_PASSWORD`. Das eigentliche Django-Projekt muss diese Werte in `settings.py` konfigurieren.

## OpenShift-Sicherheit

Das Image legt keinen festen `USER` fest und verwendet keine privilegierten Ports. Teste es vor Produktion mit der Sicherheitsrichtlinie deines Clusters. Die `/app`-Mount-Strategie ist für Entwicklung; Produktions-Deployments sollten ein unveränderliches Image verwenden.

## Noch nicht enthalten

Dies ist keine fertige Django-Projektvorlage: kein `settings.py`, keine Migrationen, keine Authentifizierung, keine CSV/PDF-Funktionen und kein Upload-Speicher. Diese Bestandteile kommen in die spätere App.
