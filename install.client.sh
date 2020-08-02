#!/bin/bash

export INSTALL_ORACLE_VERSION="_19_3"
export INSTALL_ORACLE_BASE=${HOME}/Applications/Oracle

if [ ! -d /Users/${USER}/Desktop/swdepot/Oracle/clients ] ; then
   echo "ERROR: Directory /Users/${USER}/Desktop/swdepot/Oracle/clients not found ! "
   exit 1
else
   echo "INFO: Moving to the software depot target location"
   cd /Users/$USER/Desktop/swdepot/Oracle/clients
fi


echo "INFO: Installing software to ${INSTALL_ORACLE_BASE} "

if [ -d instantclient${INSTALL_ORACLE_VERSION} ] ; then
   rm -rf instantclient${INSTALL_ORACLE_VERSION} 
fi

echo "Installation for ${INSTALL_ORACLE_VERSION} starting "

for FILE in `ls -1 *.zip`
do
  if [ -f ${FILE} ] ; then
     echo "Running : unzip ${FILE} "
     unzip ${FILE} 2>/dev/null
  fi
done

echo "INFO: Fixing directory permission issues"
echo "Running : chmod u+w instantclient${INSTALL_ORACLE_VERSION}/* "
chmod u+w instantclient${INSTALL_ORACLE_VERSION}/*

echo "INFO: Fixing com.apple.quarantine permission issues." 
echo "Running : xattr -r -d -s com.apple.quarantine instantclient${INSTALL_ORACLE_VERSIO} "
xattr -r -d -s com.apple.quarantine instantclient${INSTALL_ORACLE_VERSION}

if [ -d instantclient${INSTALL_ORACLE_VERSION} ] ; then
   if [ ! -d ${INSTALL_ORACLE_BASE} ] ; then
      mkdir -p ${INSTALL_ORACLE_BASE}
   else
      if [ -d ${INSTALL_ORACLE_BASE}/instantclient${INSTALL_ORACLE_VERSION} ] ; then 
         rm -rf ${INSTALL_ORACLE_BASE}/instantclient${INSTALL_ORACLE_VERSION}
      fi
   fi
   mv instantclient${INSTALL_ORACLE_VERSION} ${INSTALL_ORACLE_BASE}/.
fi

echo "

export ORACLE_BASE=${INSTALL_ORACLE_BASE} 
export ORACLE_HOME=${INSTALL_ORACLE_BASE}/instantclient${INSTALL_ORACLE_VERSION}
export ORACLE_UNQNAME=none
export ORACLE_SID=none
export TNS_ADMIN=${INSTALL_ORACLE_BASE}/instantclient${INSTALL_ORACLE_VERSION}/network/admin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${INSTALL_ORACLE_BASE}/instantclient${INSTALL_ORACLE_VERSION}
export CLASSPATH=${CLASSPATH}:${INSTALL_ORACLE_BASE}/instantclient${INSTALL_ORACLE_VERSION}

PATH=:.:${PATH}:${INSTALL_ORACLE_BASE}/instantclient${INSTALL_ORACLE_VERSION}

"> ${HOME}/oracle.client
