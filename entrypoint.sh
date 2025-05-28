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

        # Create a default config.yaml for local development
        echo "No config.yaml found, creating default configuration..."
        cp /app/config_template.yaml /config/config.yaml
        echo "Default config.yaml created in /config/"
        echo "Please edit /config/config.yaml to configure your monitoring settings."
    # else
    #     echo "config.yaml already exists."
    fi
else
    echo "/config does not exist, skipping config template download."
fi

exec python /app/app.py
