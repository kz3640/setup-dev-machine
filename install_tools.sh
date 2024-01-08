#!/bin/bash

# Define packages and taps to install
declare -a formulae=("hashicorp/tap/terraform" "kind" "grype" "melange" "apko" "dive")
declare -a casks=("visual-studio-code" "slack" "google-chrome" "1password")
declare -a taps=("hashicorp/tap")

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

# Create a combined list of formulae and casks for the message
combined_tools=("${formulae[@]}" "${casks[@]}")
formatted_list=$(IFS=, ; echo "${combined_tools[*]}")

echo "The script will attempt to install the following tools: ${formatted_list//,/, }"
read -p "Do you want to continue? (y/n) " answer
if [[ "$answer" != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

# Install or reinstall each formula
# If an app was installed via brew cask, but deleted manually, the
# re-install will catch that.
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

echo "All tools installed or reinstalled successfully!"
