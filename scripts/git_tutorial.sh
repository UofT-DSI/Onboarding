#!/bin/bash
# Welcome message
echo "************************************************"
echo "Welcome to the Interactive Git Tutorial for Students!"
echo "This tutorial will guide you through basic Git commands in a logical sequence."
echo "Follow the instructions and type the commands as prompted."
echo "************************************************"
sleep 3

# Ask for the user's GitHub username, email, and full name
read -p "Enter your GitHub username: " github_username
read -p "Enter your full name: " user_full_name
read -p "Enter the email address you used for your GitHub account: " user_email
echo -e "\nThank you :)\n"
sleep 2

# Function to ask the user to execute a command
ask_command() {
   local correct_command="$1"
   local explanation="$2"
   local user_command

   echo "--------------------------------------"
   echo "The command we're learning:"
   echo -e "' $correct_command '\n"
   sleep 1
   echo -e "$explanation\n"
   sleep 5
   echo "Try it for yourself, run the command below:"
   echo -e "--------------------------------------\n"

   while true; do
       read -p "$ " user_command
       if [ "$user_command" = "$correct_command" ]; then
           echo -e "\n--------------------------------------"
           echo "> Running your function..."
           sleep 2
           # Capture output and errors
           command_output=$(eval "$correct_command" 2>&1)
           
           # Display the result
           echo -e "\n****************\n*** Correct! ***\n****************\n \nHere is the output of your command:"
           echo -e "--------------------------------------\n"
           echo -e "$command_output"
           echo -e "\n--------------------------------------\n"
           sleep 3
           echo -e "Moving to the next step... \n"
           break
       else
           echo -e "\n--------------------------------------"
           echo "> Running your function..."
           sleep 2
           echo "Incorrect command, please try again. :("
           echo -e "--------------------------------------\n"
       fi
   done
}
echo "Before we start, let's see if you already have git installed."
sleep 1
echo "Checking..."
sleep 2

# Check if Git is already installed
if git --version &> /dev/null
then
   echo "Git is already installed so you don't need to install it!"
else
   echo "It looks like git isn't installed but no worries, we will go through the steps to install it."
   sleep 2
   # Identify the operating system and install Git if needed
   OS=$(uname -s)
   case "$OS" in
       Linux)
           ask_command "sudo apt install git" "If you're on Ubuntu (or a Debian-based system), this command installs Git. For other Linux distributions, use the appropriate package manager."
           ;;
       Darwin)
           ask_command "brew install git" "If you're on macOS, this command installs Git using Homebrew."
           ;;
       *)
           echo "Unsupported Operating System. Please install Git manually."
           exit 1
           ;;
   esac
fi

# Tutorial commands
# Steps to create a new directory and file
echo -e "Let's start by creating a new directory for our Git project and navigate into it.\n"
sleep 2
ask_command "git init" "This command initializes a new Git repository."
ask_command "git config --global user.name \"$user_full_name\"" "Set your Git user name to your full name."
ask_command "git config --global user.email \"$user_email\"" "Set your Git email to your email address."
ask_command "echo 'Hello Git' > hello.txt" "This command creates a new file named 'hello.txt' with 'Hello Git' as its content."
ask_command "git add ." "This command stages all changes in the directory for the next commit."
ask_command "git commit -m 'My First Commit'" "This commits the staged changes with a message 'My First Commit'."
ask_command "git status" "This command shows the status of changes as untracked, modified, or staged."
ask_command "git log" "This command displays the commit history."

# Create a Remote Repository:
echo -e "Now you have to do something outside of this terminal.\n"
sleep 2
echo -e "Please visit github.com (or in your future jobs as a Data Scientist, any version control hosting service).\n"
sleep 2
echo -e "Sign in to github.com..."
sleep 2
echo -e "Visit https://github.com/new to create a new repository"
sleep 2
echo -e "follow along the page and fill in the necessary information:\n\t- repo name: testGitRepo\n\t- choose private repo\n\t- click the \"add a README.md\" button."
sleep 2
echo -e "Click the 'Create repository' button."
sleep 2
echo -e "When you're done, come back to this terminal."

while true; do
   read -p "Are you ready? (yes/no) " confirm_prompt
   if [ "$confirm_prompt" = "yes" ]; then
       echo -e "\nGreat!\nCan you please type out the newly created repo's URL?\n You can get the URL by clicking on the green \"Code\" button, under the Local Tab, in the HTTPS section, there should be a URL there for you to copy. It should be in the following format: https://github.com/johnsmith/testRepo.git"
       break
   else
       echo -e "\nI'll wait, don't worry, take your time :)"
   fi
done
read -p "Repo URL: " repo_url

# Continuation of the Tutorial
ask_command "git remote -v" "This command will show the URLs for your remote repositories, allowing you to confirm that the new remote has been added successfully."
ask_command "git remote add origin $repo_url" "This command adds a new remote repository."
ask_command "git pull" "This command will pull down any new potential changes that would exist on our remote repo. In this tutorial, since it is a brand new repo, other than a README file, there shouldn't be anything else. But it is a good practice to always git pull before you git push so that you never face merging issues."
ask_command "git branch --set-upstream-to=origin/main main" "So if you look at the output of the above command, it didn't do what we wanted. Sometimes in shell scripting, you will run into errors that you need to investigate further. It turns out the above command doesn't work since we haven't set up a connection between a local branch to a remote branch. This command links your local main branch to the main branch of the remote repository named origin, enabling direct pulls and pushes to synchronize changes between these branches. This setup simplifies Git commands by providing default remote tracking for your local branch."
ask_command "git pull" "Now that we have addressed its issue, we will try again..."
ask_command "git config pull.rebase false" "Ran into another complaint but this time Git gave us a better hint. The command 'git config pull.rebase false' configures Git to use the merging strategy instead of rebase when performing a 'git pull'. This means that when you pull changes from a remote branch, Git will create a merge commit to combine the histories, preserving the chronological order of commits without rewriting history."
ask_command "git pull" "Now that we have addressed its issue, we will try again..."
ask_command "git pull origin main --allow-unrelated-histories" "The error message fatal: refusing to merge unrelated histories is a mystery. As Data Scientists when we run into an ambiguous error, the number one recommendation is to look it up online as chances are, you are not the first person to run into this issue. After research, we know that this error occurs in Git when you try to git pull from a remote branch that does not share a common commit history with your local branch. This typically happens when a repository has been initialized independently at both ends (local and remote) and then later connected."
ask_command "git push -u origin main" "Now that we have fixed the branch situation above, we will go ahead and try and submit our changes. This command would push the commits to the main branch of the remote repository."
ask_command "git rm hello.txt" "This command removes 'hello.txt' from the working directory and stages the deletion."
ask_command "echo 'This is a new file' > newfile.txt" "This command creates a new file named 'newfile.txt' with some sample text."
ask_command "ls" "This command shows the files that are created in the folder you're in. In the list, you should be able to see the newly created file."
ask_command "mv newfile.txt renamedfile.txt" "This command moves or renames a file."
ask_command "ls" "Similar to before this command shows the files that are created in the folder you're in. In the list, you should be able to see the newly renamed file."
ask_command "git remote -v" "The 'git remote -v' command output shows that your local Git repository is linked to a remote repository on GitHub named 'origin', with the same URL set for both fetching and pushing changes."
ask_command "git status" "This command shows the status of changes as untracked, modified, or staged. We have already done this once, but let's see what happens this time."
ask_command "git branch" "This command lists, creates, or deletes branches."
ask_command "git add *" "This command stages all changes in the directory for the next commit. The '*' is a way to say everything. It can be dangerous so only try it when you are 100% certain. It is always advised to be intentional with what you add and pay attention to what is being added."
ask_command "git status" "This command shows the status of changes as untracked, modified, or staged. We have already done this once, but let's see what happens this time."
ask_command "git restore --staged renamedfile.txt" "As I mentioned before, everything has been staged, but we just realized we didn't want that, we wanted renamedfile.txt to NOT get staged. The command 'git restore --staged renamedfile.txt' is used to unstage the file 'renamedfile.txt' from the staging area in Git, while keeping any changes you've made to it in your working directory. In other words, this command reverses the 'git add' operation for 'renamedfile.txt', making it no longer ready for commit, but retains any modifications you've made to the file since the last commit."
ask_command "git commit -m 'Second commit'" "This commits the staged changes with a new message."
ask_command "git log" "This command displays the commit history. If you look closely, our new commit is there."
ask_command "git push" "This command would push the commits to the main branch of the remote repository."

# Goodbye message
echo "************************************************"
echo "Congratulations! You've completed the Interactive Git Tutorial."
echo "Keep practicing to improve your Git skills. To redo this tutorial simply go to github.com, to your newly created repo and delete the repo from the settings so that this tutorial can help you set up a brand new one from the ground up again."
echo "Goodbye!"
echo "************************************************"