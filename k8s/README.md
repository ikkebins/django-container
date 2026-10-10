# Kubernetes-Manifeste

Diese Manifeste stellen die Web-App bereit. PostgreSQL wird absichtlich als externer Dienst angenommen.

Vor dem Anwenden:
1. Image in eine Registry bauen und pushen.
2. `image:` in `deployment.yaml` ersetzen.
3. Secret mit echtem Passwort erstellen.
4. Optional Ingress passend zum Cluster konfigurieren.

Beispiel:
```bash
kubectl create namespace webapp
kubectl -n webapp create secret generic webapp-db \
  --from-literal=POSTGRES_PASSWORD='DEIN-STARKES-PASSWORT'
kubectl apply -n webapp -f k8s/
```

Die Anwendung erwartet einen externen PostgreSQL-Dienst. Setze `POSTGRES_HOST` im Deployment entsprechend.
