#!/bin/sh

CONFIG_DIR=/config
CONFIG_TEMPLATE=$CONFIG_DIR/config_template.yaml
CONFIG_FILE=$CONFIG_DIR/config.yaml
LOCAL_TEMPLATE=/app/config_template.yaml
LOCAL_DEBUG_CONFIG=/app/config-debug.yaml

if [ -d "$CONFIG_DIR" ]; then
    #echo "/config exists."
    if [ ! -f "$CONFIG_FILE" ]; then
        if [ ! -f "$CONFIG_TEMPLATE" ]; then
            echo "Loading config template from local file..."
            if [ -f "$LOCAL_TEMPLATE" ]; then
                cp "$LOCAL_TEMPLATE" "$CONFIG_TEMPLATE"
                echo "Config template copied from local file to $CONFIG_TEMPLATE"
            else
                echo "Warning: Local config template not found at $LOCAL_TEMPLATE"
                echo "Falling back to downloading from GitHub..."
                CONFIG_URL=https://raw.githubusercontent.com/clemcer/loggifly/refs/heads/main/config_template.yaml
                python3 -c "import urllib.request; urllib.request.urlretrieve('$CONFIG_URL', '$CONFIG_TEMPLATE')"
            fi
        fi

        # Créer un config.yaml par défaut pour le développement local
        echo "No config.yaml found. Creating default debug configuration..."
        if [ -f "$LOCAL_DEBUG_CONFIG" ]; then
            cp "$LOCAL_DEBUG_CONFIG" "$CONFIG_FILE"
            echo "Debug configuration copied to $CONFIG_FILE"
        else
            echo "Creating minimal debug configuration..."
            cat > "$CONFIG_FILE" << 'EOF'
# Configuration automatique pour le développement local
containers: {}

global_keywords:
  keywords:
    - error
    - warning
    - failed
  keywords_with_attachment:
    - critical
    - fatal

notifications:
  debug:
    enabled: true

settings:
  log_level: DEBUG
  monitor_all_containers: true
  attachment_lines: 10
  notification_cooldown: 2
EOF
            echo "Minimal debug configuration created at $CONFIG_FILE"
        fi
    # else
    #     echo "config.yaml already exists."
    fi
else
    echo "/config does not exist, skipping config template download."
fi

exec python /app/app.py
