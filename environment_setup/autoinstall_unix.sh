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
                sudo apt install git -y
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

# Check if Git Credential Manager (git-credential-manager) is installed
if git-credential-manager --version &> /dev/null
then
    echo "Git Credential Manager is already installed"
else
    # Identify the operating system
    OS=$(uname -s)

    # Installation commands for different OS
    case "$OS" in
        Linux)
            # Determine the Linux distribution (Debian/Ubuntu, Fedora, RHEL, CentOS)
            if [ -f /etc/debian_version ]; then
                # Debian/Ubuntu
                wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.4.1/gcm-linux_amd64.2.4.1.deb -O ~/gcm.deb
                sudo apt install ./gcm.deb -y
                rm ~/gcm.deb
            elif [ -f /etc/redhat-release ]; then
                # Fedora, RHEL, CentOS
                curl -L https://aka.ms/gcm/linux-install-source.sh | sh
            fi

            git-credential-manager configure
            git config --global credential.credentialStore secretservice
            
            ;;
        Darwin)
            # macOS
            # Check if Homebrew is installed
            if which brew &> /dev/null; then
                brew install --cask git-credential-manager
                git-credential-manager configure
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

# Check if Anaconda Distribution is already installed
if conda --version &> /dev/null
then
    echo "Anaconda Python Distribution is already installed"
else
    # Identify the operating system
    OS=$(uname -s)

    # Installation commands for different OS
    case "$OS" in
        Linux)
            # Determine the Linux distribution (Debian/Ubuntu, Fedora, RHEL, CentOS)
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
            bash ~/miniconda.sh -b -p $HOME/miniconda
            rm ~/miniconda.sh

            eval "$($HOME/miniconda/bin/conda shell.bash hook)"
            source ~/.bashrc
            ;;
        Darwin)
            # macOS
            url https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o ~/miniconda.sh
            bash ~/miniconda.sh -b -p $HOME/miniconda
            rm ~/miniconda.sh

            eval "$($HOME/miniconda/bin/conda shell.bash hook)"
            source ~/.bashrc
            ;;
        *)
            echo "Unsupported Operating System"
            exit 1
            ;;
    esac
fi

conda install -y matplotlib numpy pandas scipy scikit-learn seaborn jupyter pyyaml plotly conda-forge::python-kaleido requests openpyxl nbformat pytest


###################################
# Check if VS Code is already installed
if code --version &> /dev/null
then
    echo "VSCode is already installed"
else
    # Identify the operating system
    OS=$(uname -s)

    # Installation commands for different OS
    case "$OS" in
        Linux)
            # Determine the Linux distribution (Debian/Ubuntu, Fedora, RHEL, CentOS)
            if [ -f /etc/debian_version ]; then
                # Debian/Ubuntu
                sudo apt install software-properties-common apt-transport-https wget -y
                wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
                sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
                sudo apt update
                sudo apt install code -y
            elif [ -f /etc/redhat-release ]; then
                # Fedora, RHEL, CentOS
                sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
                sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
                if [ -f /etc/dnf/dnf.conf ]; then
                    sudo dnf check-update
                    sudo dnf install code
                else
                    sudo yum check-update
                    sudo yum install code
                fi
            fi
            ;;
        Darwin)
            # macOS
            echo "Please install VSCode from https://code.visualstudio.com/download"
            ;;
        *)
            echo "Unsupported Operating System"
            exit 1
            ;;
    esac
fi

if code --version &> /dev/null
then
    code --install-extension ms-python.python
    code --install-extension ms-toolsai.jupyter
    code --install-extension mhutchie.git-graph
fi

# check if we're running in wsl
if [[ $(grep Microsoft /proc/version) ]]; then
    # use git credentials from windows
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
fi

echo "############### Setup complete! ###############"
