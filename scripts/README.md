# Git Installation Scripts

This repository contains two scripts for checking and installing Git on your system: one for Unix-like systems (Bash script) and one for Windows (Batch script). Additionally, there's a tutorial script for learning Git basics.

## Contents
- `git_installation.sh`: Bash script for Unix-like systems (Linux, macOS).
- `git_installation.bat`: Batch script for Windows.
- `git_tutorial.sh`: Tutorial script for learning Git.

## Using the Bash Script (`git_installation.sh`)

### Prerequisites
- A Unix-like operating system (Linux or macOS).
- Terminal access.

### Steps
1. **Download the Script**:
   Download `git_installation.sh` to your desired directory.

2. **Open Terminal**:
   Open a terminal window.

3. **Navigate to the Script**:
   Use the `cd` command to navigate to the directory where you downloaded the script.

```
cd /path/to/directory
```


4. **Make the Script Executable** (if necessary):
Before running the script, you may need to make it executable. Run the following command:


```
chmod +x git_installation.sh
```


5. **Run the Script**:
Execute the script by typing:

```
./git_installation.sh
```


## Using the Batch Script (`git_installation.bat`)

### Prerequisites
- Windows operating system.
- Command Prompt or PowerShell access.

### Steps
1. **Download the Script**:
Download `git_installation.bat` to your desired directory.

2. **Open Command Prompt or PowerShell**:
Search for Command Prompt or PowerShell in the Windows search bar and open it.

3. **Navigate to the Script**:
Change the directory to where you downloaded the script. For example:

```
cd \path\to\directory
```


4. **Run the Script**:
Type the script's name and press Enter to run it:

```
git_installation.bat
```


## Setting Up and Using the Git Tutorial Script

### Prerequisites
- A Unix-like operating system (Linux or macOS).
- Terminal access.
- `git_tutorial.sh` script.

### Steps
1. **Create a New Folder**:
Create a new folder named `testGitRepo`.

```
mkdir testGitRepo
```


2. **Move the Script**:
Move `git_tutorial.sh` into the `testGitRepo` folder.

```
mv /path/to/git_tutorial.sh /path/to/testGitRepo/
```


3. **Navigate to the Folder**:
Change your directory to `testGitRepo`.

```
cd /path/to/testGitRepo
```


4. **Set Script Permissions**:
Make `git_tutorial.sh` executable.

```
chmod +x git_tutorial.sh
```


5. **Run the Tutorial Script**:
Start the tutorial by executing the script.

```
./git_tutorial.sh
```


## Note
- The Bash script identifies your operating system and attempts to install Git if it's not already installed.
- The Batch script checks if Git is installed on Windows and provides a download link if it's not.
