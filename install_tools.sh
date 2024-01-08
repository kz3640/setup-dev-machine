#!/bin/bash

# Define packages and taps to install
declare -a formulae=("hashicorp/tap/terraform" "kind" "grype" "melange" "apko" "dive")
declare -a casks=("visual-studio-code" "slack" "google-chrome" "1password")
declare -a taps=("hashicorp/tap")

# Docker Variables
DOCKER_URL="https://desktop.docker.com/mac/stable/arm64/Docker.dmg"
DMG_FILE="Docker.dmg"
VOLUME_PATH="/Volumes/Docker"
APPLICATIONS_DIR="/Applications"

# Function to install Docker
# Note, using 'brew cask' to install docker doesn't work so well.
# It'll continuously prompt each time for creds to create / remove links.
install_docker() {
    echo "Initiating Docker Desktop installation..."

    # Download Docker for Apple Silicon
    echo "Downloading Docker..."
    curl -L $DOCKER_URL -o $DMG_FILE

    # Attach the DMG
    echo "Attaching DMG..."
    hdiutil attach $DMG_FILE -nobrowse

    # Copy Docker.app to the Applications directory
    echo "Copying Docker.app to the Applications folder..."
    cp -R "$VOLUME_PATH/Docker.app" $APPLICATIONS_DIR

    # Eject the volume
    echo "Ejecting Docker volume..."
    hdiutil detach $VOLUME_PATH

    # Remove the DMG file
    echo "Cleaning up..."
    rm $DMG_FILE

    echo "Docker has been installed. Please open Docker from the Applications folder to complete setup."
}

# Check for XCode Command Line Tools and install if not found
if ! xcode-select -p &>/dev/null; then
    echo "XCode Command Line Tools not found. Installing..."
    xcode-select --install
else
    echo "XCode Command Line Tools already installed."
fi

# Check for Homebrew and install if not found
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed."
    echo "Updating Homebrew..."
    brew update
fi

# Add necessary taps
for tap in "${taps[@]}"; do
    brew tap "$tap"
done

# Install or reinstall each formula
for package in "${formulae[@]}"; do
    if brew list --formula | grep -q "^${package%%/*}$"; then
        echo "$package is already installed. Attempting to reinstall..."
        brew reinstall "$package"
    else
        echo "Installing $package..."
        brew install "$package"
    fi
done

# Install or reinstall each cask
for app in "${casks[@]}"; do
    if brew list --cask | grep -q "^${app%%/*}$"; then
        echo "$app is already installed. Attempting to reinstall..."
        brew reinstall --cask "$app"
    else
        echo "Installing $app..."
        brew install --cask "$app"
    fi
done

# Invoke the Docker installation function
install_docker

echo "All tools including Docker installed or reinstalled successfully!"
