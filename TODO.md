# TODO

- [x] configuration simple: monitor_all_containers
- [x] configuration avancée: avec exclusion des containers de service
- [x] logger les alertes dans la console loggifly
- [x] si pas de fichier de config local, ne pas le télécharger depuis le remote mais depuis le local
- [x] docker-compose-local.yaml

- [x] configuration visée à terme:

\# Monitoring global des conteneurs
monitor_all_containers: true

\# Or advanced configuration
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
