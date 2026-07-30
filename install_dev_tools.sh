#!/bin/bash

echo "Starting installation of development tools..."

if command -v docker >/dev/null 2>&1; then
    echo "Docker is already installed."
else
    echo "Installing Docker..."
    sudo apt update
    sudo apt install -y docker.io
fi


if docker compose version >/dev/null 2>&1; then
    echo "Docker Compose is already installed."
else
    echo "Installing Docker Compose..."
    sudo apt install -y docker-compose-plugin
fi


if command -v python3 >/dev/null 2>&1; then
    echo "Python is already installed."
else
    echo "Installing Python..."
    sudo apt install -y python3 
fi


if command -v pip3 >/dev/null 2>&1; then
    echo "pip is already installed."
else
    echo "Installing pip..."
    sudo apt install -y python3-pip
fi

if python3 -m pip show django >/dev/null 2>&1; then
    echo "Django is already installed."
else
    echo "Installing Django..."
    python3 -m pip install django
fi

echo "Installation completed!"


