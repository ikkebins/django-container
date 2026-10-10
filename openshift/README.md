# OpenShift / OKD

Die Kubernetes-Manifeste unter `../k8s/` sind ein Ausgangspunkt, benötigen aber für OpenShift eine Anpassung:
- Entferne `runAsUser` und `runAsGroup`, da OpenShift typischerweise eine zugewiesene UID verwendet.
- Image muss unter einer zufälligen UID laufen können.
- Exponiere den Service über eine OpenShift Route.
- PostgreSQL ist in diesem Starter extern.

Anwenden nach Image-Anpassung:
```bash
oc new-project webapp
oc create secret generic webapp-db --from-literal=POSTGRES_PASSWORD='DEIN-STARKES-PASSWORT'
oc apply -f k8s/deployment.yaml
oc apply -f k8s/service.yaml
oc expose service/webapp
oc get route webapp
```

Hinweis: Das generische Kubernetes-Deployment enthält `runAsUser: 10001`; passe es gemäß obigem Hinweis vor dem Anwenden unter OpenShift an.
