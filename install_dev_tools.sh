#!/bin/bash

echo "Starting installation of development tools..."

apt_updated=false

update_packages() {
    if [ "$apt_updated" = false ]; then
        echo "Updating package list..."
        sudo apt update
        apt_updated=true
    fi
}

if command -v docker >/dev/null 2>&1; then
    echo "Docker is already installed."
else
    echo "Installing Docker..."
    update_packages
    sudo apt install -y docker.io
fi

if docker compose version >/dev/null 2>&1 || docker-compose --version >/dev/null 2>&1; then
    echo "Docker Compose is already installed."
else
    echo "Installing Docker Compose..."
    update_packages

    if apt-cache show docker-compose-v2 >/dev/null 2>&1; then
        sudo apt install -y docker-compose-v2
    elif apt-cache show docker-compose-plugin >/dev/null 2>&1; then
        sudo apt install -y docker-compose-plugin
    elif apt-cache show docker-compose >/dev/null 2>&1; then
        sudo apt install -y docker-compose
    else
        echo "Error: Docker Compose package not found."
        exit 1
    fi
fi

if command -v python3 >/dev/null 2>&1; then
    echo "Python is already installed."
else
    echo "Installing Python..."
    update_packages
    sudo apt install -y python3
fi

if ! python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3,9) else 1)'; then
    echo "Python 3.9 or newer is required."
    exit 1
fi

if python3 -m pip --version >/dev/null 2>&1; then
    echo "pip is already installed."
else
    echo "Installing pip..."
    update_packages
    sudo apt install -y python3-pip
fi

if python3 -m django --version >/dev/null 2>&1; then
    echo "Django is already installed."
else
    echo "Installing Django..."
    python3 -m pip install --user --break-system-packages django
fi

echo
echo "Verifying installation..."

docker --version

if docker compose version >/dev/null 2>&1; then
    docker compose version
else
    docker-compose --version
fi

python3 --version
python3 -m pip --version
python3 -m django --version

echo
echo "Installation completed successfully!"
