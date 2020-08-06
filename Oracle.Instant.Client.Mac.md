
# Installing Oracle Instant Client on a Mac 


## 1.- Create a directory to store the Oracle software 

I use the "Terminal" utility to access the console 

````bash

mkdir -p /Users/${USER}/Desktop/swdepot/Oracle/clients
cd /Users/${USER}/Desktop/swdepot/Oracle/clients
# make sure you can get to that directory

````

## 2.- Download Software 

Download the Oracle Instant Client for Mac Version 19.3.0.0.0 (64-bit)

[Instant Client Downloads for macOS (Intel x86)](https://www.oracle.com/database/technologies/instant-client/macos-intel-x86-downloads.html)

Download the following packages:

- Basic Package
- SQL*Plus Package
- Tools Package
- SDK Package
- JDBC Supplement Package
- ODBC Package

and put them on the ````/Users/${USER}/Desktop/swdepot/Oracle/clients```` directory.

Next, download the ````install.client.sh```` script from this repository and put it on the ```` /Users/${USER}/Desktop/swdepot/Oracle/clients```` directory (same location).


## 3.- Installation script

Note the entries for "INSTALL_ORACLE_VERSION" and "INSTALL_ORACLE_BASE" in the ````install.client.sh```` script.

The target installation for the Oracle client would be:

 ````/Users/${USER}/Applications/Oracle/instantclient_19_3```` 

You can modify the "**INSTALL_ORACLE_BASE**" location, but leave the "INSTALL_ORACLE_VERSION" as it.



## 4.- Update your .bash_profile script

Add the following lines to your script. If you don ot have one, use the example:

````
  if [ -f ${HOME}/oracle.client ] ; then
    source ${HOME}/oracle.client 
  fi
````

### Example .bash_profile script

````bash
#!/bin/bash

alias ll='ls -all'
alias dir='ls -all'
alias bdf='df -Ph | grep -iv time'

if [ -f ${HOME}/oracle.client ] ; then
   source ${HOME}/oracle.client
fi

export GH=/Users/${USER}/Documents/GitHub

export PS1="\u@\h\w $ "

````


