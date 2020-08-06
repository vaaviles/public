
# Adding an SSH key to your GitHub account

Document will outline the steps to generate an ssh key on your Linux machine and then add a key to 
your GitHub account. 

----------

**Step 1:** Start fresh only if you have never generated keys

````bash
    rm -rf  ~/.ssh
````

**Step 2:** Check for existing SSH keys
````bash
    ls -al ~/.ssh
````

*
Do you see any files named id_rsa and id_rsa.pub?
If yes go to Step 3
If no, you need to generate them
*

**Step 3:** Generate a new SSH key
````bash
    ssh-keygen -t rsa -b 4096 -C "email@domain.com"
````

Add your SSH key to the ssh-agent
````bash
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
````
    
**Step 4:** Add the SSH key to your GIT account.
Follow instruction on this [Adding a new SSH key to your GitHub account](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account) document

Go to your GIT project -> Settings -> SSH keys
Then past the content of your command below


````bash
    cat ~/.ssh/id_rsa.pub
    # Example:
    ssh-rsa U7SLKJ3LSKD23..<more strings>...1KDJ2DUSLKJLSKDJSDxww== email@domain.com

````

**Step 5: **Clone the project

````bash
    git clone git@github.com:<GITHUB_USER_NAME>/<GITHUB_REPOSITORY_NAME>.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa"    
````

