# TODO

- configuration simple: monitor_all_containers
- configuration avancée: avec exclusion des containers de service
- cli pour tester le comportement
- logger les alertes dans la console loggifly
- si pas de fichier de config local, ne pas le télécharger depuis le remote mais depuis le local
- docker-compose-local.yaml

configuration visée à terme:

\# Monitoring global des conteneurs
monitor_all_containers: true

\# Ou configuration avancée
container_discovery:
  enabled: true
  include_patterns:
    - "web-*"
    - "api-*"
  exclude_patterns:
    - "*-test"
    - "temp-*"
  required_labels:
    - "monitoring=enabled"
  exclude_labels:
    - "monitoring=disabled"
  exclude_system_containers: true
