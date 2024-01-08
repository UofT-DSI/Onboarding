#!/bin/bash

# Enable debug mode to show each command being executed
set -x

# This script checks for the installation of Git and attempts to install it
# based on the detected operating system. It then guides the user to set up
# Git configuration.

# Check if Git is already installed
if git --version &> /dev/null
then
    echo "Git is already installed"
    echo "Proceeding to Git configuration..."
else
    # Identify the operating system
    OS=$(uname -s)

    # Installation commands for different OS
    case "$OS" in
        Linux)
            # Determine the Linux distribution (Debian/Ubuntu, Fedora, RHEL, CentOS)
            if [ -f /etc/debian_version ]; then
                # Debian/Ubuntu
                sudo apt install git
            elif [ -f /etc/redhat-release ]; then
                # Fedora, RHEL, CentOS
                if [ -f /etc/dnf/dnf.conf ]; then
                    sudo dnf install git
                else
                    sudo yum install git
                fi
            fi
            ;;
        Darwin)
            # macOS
            # Check if Homebrew is installed
            if which brew &> /dev/null; then
                brew install git
            else
                echo "Homebrew is not installed. Please install Homebrew or download Git from https://sourceforge.net/projects/git-osx-installer/"
            fi
            ;;
        *)
            echo "Unsupported Operating System"
            exit 1
            ;;
    esac
fi
