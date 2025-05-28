# 🔧 Build Local de LoggiFly

Ce guide explique comment builder et exécuter LoggiFly à partir du code source local plutôt que d'utiliser l'image du registry distant.

## 📋 Prérequis

- Docker et Docker Compose installés
- Code source de LoggiFly cloné localement

## 🚀 Utilisation

### 1. Préparation de la configuration

Créez le répertoire de configuration :
```bash
mkdir -p ./loggifly/config
```

**Option A : Utiliser le template de configuration**
```bash
# Copier le template et l'éditer
cp config_template.yaml ./loggifly/config/config.yaml
# Puis éditez le fichier selon vos besoins
```

**Option B : Utiliser les variables d'environnement**
Éditez le fichier `docker-compose-local.yaml` et décommentez/configurez les variables d'environnement selon vos besoins.

### 2. Build et démarrage

```bash
# Builder l'image à partir du code source local
docker-compose -f docker-compose-local.yaml build

# Démarrer le conteneur
docker-compose -f docker-compose-local.yaml up -d --build --force-recreate --remove-orphans --pull always

# Voir les logs
docker-compose -f docker-compose-local.yaml logs -f
```

### 3. Commandes utiles

```bash
# Arrêter le conteneur
docker-compose -f docker-compose-local.yaml down

# Rebuild après modification du code
docker-compose -f docker-compose-local.yaml build --no-cache

# Redémarrer après rebuild
docker-compose -f docker-compose-local.yaml up -d --force-recreate

# Voir les logs en temps réel
docker-compose -f docker-compose-local.yaml logs -f loggifly
```

## 🔄 Développement

Pour le développement actif, vous pouvez :

1. **Modifier le code** dans le répertoire `app/`
2. **Rebuilder l'image** : `docker-compose -f docker-compose-local.yaml build`
3. **Redémarrer le conteneur** : `docker-compose -f docker-compose-local.yaml up -d --force-recreate`

## 📝 Configuration

### Variables d'environnement disponibles

Vous pouvez configurer LoggiFly via les variables d'environnement dans le fichier `docker-compose-local.yaml` :

```yaml
environment:
  # Configuration Ntfy
  - NTFY_URL=https://ntfy.sh
  - NTFY_TOPIC=loggifly-local
  - NTFY_TOKEN=your_token_here

  # Conteneurs à surveiller
  - CONTAINERS=container1,container2,container3

  # Mots-clés globaux
  - GLOBAL_KEYWORDS=error,warning,critical,failed
  - GLOBAL_KEYWORDS_WITH_ATTACHMENT=fatal,panic,traceback

  # Surveillance de tous les conteneurs
  - MONITOR_ALL_CONTAINERS=true

  # Configuration des logs
  - LOG_LEVEL=DEBUG
  - ATTACHMENT_LINES=50
  - NOTIFICATION_COOLDOWN=10
```

### Fichier de configuration YAML

Pour une configuration plus avancée (regex, action_keywords, etc.), utilisez un fichier `config.yaml` :

```bash
# Créer votre configuration
cp config_template.yaml ./loggifly/config/config.yaml
# Éditer selon vos besoins
nano ./loggifly/config/config.yaml
```

## 🐛 Dépannage

### Problèmes de build
```bash
# Nettoyer et rebuilder complètement
docker-compose -f docker-compose-local.yaml down
docker system prune -f
docker-compose -f docker-compose-local.yaml build --no-cache
```

### Problèmes de permissions Docker
```bash
# Vérifier que l'utilisateur peut accéder au socket Docker
sudo usermod -aG docker $USER
# Puis redémarrer la session
```

### Logs de débogage
```bash
# Activer les logs de debug
# Dans docker-compose-local.yaml, ajoutez :
# - LOG_LEVEL=DEBUG
```

## 🔗 Différences avec la version registry

- **Image** : Buildée localement au lieu d'être téléchargée
- **Nom du conteneur** : `loggifly-local` au lieu de `loggifly`
- **Développement** : Permet de tester les modifications du code immédiatement
- **Performance** : Pas de téléchargement d'image, mais temps de build initial

## 📚 Ressources

- [Documentation principale](README.md)
- [Template de configuration](config_template.yaml)
- [Exemple de configuration](config_example.yaml)
