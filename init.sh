#!/bin/sh 
DEMO="Mortgage Demo"
AUTHORS="Red Hat"
PROJECT="git@github.com:jbossdemocentral/rhpam7-mortgage-demo.git"
PRODUCT="Red Hat Process Automation Manager"
JBOSS_HOME=./target/jboss-eap-7.3
SERVER_DIR=$JBOSS_HOME/standalone/deployments
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_BIN=$JBOSS_HOME/bin
SRC_DIR=./installs
SUPPORT_DIR=./support
PRJ_DIR=./projects
VERSION_EAP=7.3.0
VERSION=7.8.0
EAP=jboss-eap-$VERSION_EAP.zip
RHPAM=rhpam-$VERSION-business-central-eap7-deployable.zip
RHPAM_KIE_SERVER=rhpam-$VERSION-kie-server-ee8.zip
RHPAM_ADDONS=rhpam-$VERSION-add-ons.zip
RHPAM_CASE=rhpam-$VERSION-case-mgmt-showcase-eap7-deployable.zip

# project details.
PROJECT_GIT_DIR=$SUPPORT_DIR/rhpam7-temp-git-dir
PROJECT_GIT_REPO="https://github.com/jbossdemocentral/rhpam7-mortgage-demo-repo.git"
PROJECT_GIT_REPO_NAME=rhpam7-mortgage-demo-repo.git
NIOGIT_PROJECT_GIT_REPO="MySpace/$PROJECT_GIT_REPO_NAME"

# wipe screen.
clear 

echo
echo "###################################################################"
echo "##                                                               ##"   
echo "##  Setting up the                                               ##"
echo "##                                                               ##"   
echo "##             ####  ##### ####     #   #  ###  #####            ##"
echo "##             #   # #     #   #    #   # #   #   #              ##"
echo "##             ####  ###   #   #    ##### #####   #              ##"
echo "##             #  #  #     #   #    #   # #   #   #              ##"
echo "##             #   # ##### ####     #   # #   #   #              ##"
echo "##                                                               ##"
echo "##           ####  ####   ###   #### #####  ####  ####           ##"
echo "##           #   # #   # #   # #     #     #     #               ##"
echo "##           ####  ####  #   # #     ###    ###   ###            ##"
echo "##           #     #  #  #   # #     #         #     #           ##"
echo "##           #     #   #  ###   #### ##### ####  ####            ##"
echo "##                                                               ##"
echo "##   ###  #   # #####  ###  #   #  ###  ##### #####  ###  #   #  ##"
echo "##  #   # #   #   #   #   # ## ## #   #   #     #   #   # ##  #  ##"
echo "##  ##### #   #   #   #   # # # # #####   #     #   #   # # # #  ##"
echo "##  #   # #   #   #   #   # #   # #   #   #     #   #   # #  ##  ##"
echo "##  #   # #####   #    ###  #   # #   #   #   #####  ###  #   #  ##"
echo "##                                                               ##"
echo "##           #   #  ###  #   #  ###  ##### ##### ####            ##"
echo "##           ## ## #   # ##  # #   # #     #     #   #           ##"
echo "##           # # # ##### # # # ##### #  ## ###   ####            ##"
echo "##           #   # #   # #  ## #   # #   # #     #  #            ##"
echo "##           #   # #   # #   # #   # ##### ##### #   #           ##"
echo "##                                                               ##"   
echo "##  brought to you by, ${AUTHORS}                                   ##"
echo "##                                                               ##"   
echo "##  ${PROJECT}     ##"
echo "##                                                               ##"   
echo "###################################################################"
echo

# make some checks first before proceeding.	
if [ -r $SUPPORT_DIR ] || [ -L $SUPPORT_DIR ]; then
        echo "Support dir is presented..."
        echo
else
        echo "$SUPPORT_DIR wasn't found. Please make sure to run this script inside the demo directory."
        echo
        exit
fi

if [ -r $SRC_DIR/$EAP ] || [ -L $SRC_DIR/$EAP ]; then
	echo "Product EAP sources are present..."
	echo
else
	echo "Need to download $EAP package from https://developers.redhat.com/products/eap/download"
	echo "and place it in the $SRC_DIR directory to proceed..."
	echo
	exit
fi

if [ -r $SRC_DIR/$RHPAM ] || [ -L $SRC_DIR/$RHPAM ]; then
	echo "Product Red Hat Process Automation Manager sources are present..."
	echo
else
	echo "Need to download $RHPAM package from https://developers.redhat.com/products/rhpam/download"
	echo "and place it in the $SRC_DIR directory to proceed..."
	echo
	exit
fi

if [ -r $SRC_DIR/$RHPAM_KIE_SERVER ] || [ -L $SRC_DIR/$RHPAM_KIE_SERVER ]; then
	echo "Product Red Hat Process Automation Manager KIE Server sources are present..."
	echo
else
	echo "Need to download $RHPAM_KIE_SERVER package from https://developers.redhat.com/products/rhpam/download"
	echo "and place it in the $SRC_DIR directory to proceed..."
	echo
	exit
fi

if [ -r $SRC_DIR/$RHPAM_ADDONS ] || [ -L $SRC_DIR/$RHPAM_ADDONS ]; then
	echo "Product Red Hat Process Automation Manager Case Management sources are present..."
	echo
else
	echo "Need to download $RHPAM_ADDONS package from https://developers.redhat.com/products/rhpam/download"
	echo "and place it in the $SRC_DIR directory to proceed..."
	echo
	exit
fi

# Remove the old JBoss instance, if it exists.
if [ -x $JBOSS_HOME ]; then
		echo "  - removing existing JBoss product..."
		echo
		rm -rf $JBOSS_HOME
fi

# Installation.
echo "JBoss EAP installation running now..."
echo
mkdir -p ./target
unzip -qo $SRC_DIR/$EAP -d target

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred during JBoss EAP installation!"
	exit
fi

echo "Red Hat Process Automation Manager installation running now..."
echo
unzip -qo $SRC_DIR/$RHPAM -d target

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred during Red Hat Process Manager installation!"
	exit
fi

echo "Red Hat Process Automation Manager Kie Server installation running now..."
echo
unzip -qo $SRC_DIR/$RHPAM_KIE_SERVER  -d $JBOSS_HOME/standalone/deployments 

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred during Red Hat Process Manager Kie Server installation!"
	exit
fi

# Set deployment Kie Server.
touch $JBOSS_HOME/standalone/deployments/kie-server.war.dodeploy

echo "Red Hat Process Automation Manager Case Management installation running now..."
echo
unzip -qo $SRC_DIR/$RHPAM_ADDONS $RHPAM_CASE -d $SRC_DIR
unzip -qo $SRC_DIR/$RHPAM_CASE -d target
rm $SRC_DIR/$RHPAM_CASE

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred during Red Hat Process Manager Case Management installation!"
	exit
fi

# Set deployment Case Management.
touch $JBOSS_HOME/standalone/deployments/rhpam-case-mgmt-showcase.war.dodeploy

echo "  - enabling demo accounts role setup..."
echo
echo "  - adding user 'pamAdmin' with password 'redhatpam1!'..."
echo
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u pamAdmin -p redhatpam1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all,broker,Administrators --silent

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred adding user pamAdmin!"
	exit
fi

echo "  - adding user 'kieserver' with password 'kieserver1!'..."
echo
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u kieserver -p kieserver1! -ro kie-server --silent

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred adding user kieserver!"
	exit
fi

echo "  - adding user 'caseUser' with password 'redhatpam1!'..."
echo
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u caseUser -p redhatpam1! -ro user --silent

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred adding user caseUser!"
	exit
fi

echo "  - adding user 'caseManager' with password 'redhatpam1!'..."
echo
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u caseManager -p redhatpam1! -ro user,manager --silent

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred adding user caseManager!"
	exit
fi

echo "  - adding user 'caseSupplier' with password 'redhatpam1!'..."
echo
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u caseSupplier -p redhatpam1! -ro user,supplier --silent

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred adding user caseSuplier!"
	exit
fi

echo "  - setting up standalone.xml configuration adjustments..."
echo
cp $SUPPORT_DIR/standalone-full.xml $SERVER_CONF/standalone.xml

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred setting up standalone.xml!"
	exit
fi

echo "  - setup email task notification users..."
echo
cp $SUPPORT_DIR/userinfo.properties $SERVER_DIR/business-central.war/WEB-INF/classes/

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred setting up email users!"
	exit
fi

echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred on making standalone.sh executable!"
	exit
fi

echo "  - setting up demo project..."
echo
echo "  - copying internal provided repository instead...."
echo
rm -rf $SERVER_BIN/.niogit && \
mkdir -p $SERVER_BIN/.niogit && \
cp -r $SUPPORT_DIR/rhpam7-demo-niogit/* $SERVER_BIN/.niogit
	
if [ $? -ne 0 ]; then
	echo
	echo "Error occurred setting up internal provided project repository!"
	exit
fi

echo "  - trying to pull the project's repository from: $PROJECT_GIT_REPO"
echo
rm -rf ./target/temp
git clone $PROJECT_GIT_REPO ./target/temp/$PROJECT_GIT_REPO_NAME

if [ $? -ne 0 ]; then
	echo
	echo "Error occurred trying to pull the project's remote repository!"
	echo "Note: project repository not reachable, so continuing with internal repository!"
	echo

else
		
	echo
	echo "  - making bare clone of project git repo: $PROJECT_GIT_DIR/$PROJECT_GIT_REPO_NAME ..."
	echo
	rm -rf $PROJECT_GIT_DIR/$PROJECT_GIT_REPO_NAME && \
	mkdir -p $PROJECT_GIT_DIR && \
	git clone --bare target/temp/$PROJECT_GIT_REPO_NAME $PROJECT_GIT_DIR/$PROJECT_GIT_REPO_NAME && \
  rm -rf ./target/temp
		
	if [ $? -ne 0 ]; then
		echo
		echo "Error occurred trying to make bare clone of project repository!"
		exit
	fi
		
  # cleanup temp directory.
	echo
	echo "  - copy the repo to the installation directory..."
	echo
	rm -rf $SERVER_BIN/.niogit/MySpace/*.git && \
	cp -R $PROJECT_GIT_DIR/$PROJECT_GIT_REPO_NAME $SERVER_BIN/.niogit/$NIOGIT_PROJECT_GIT_REPO

	if [ $? -ne 0 ]; then
		echo
		echo "Error occurred trying to copy repo to installation directory!"
		exit
	fi

	rm -rf $PROJECT_GIT_DIR
fi
  
echo
echo "=============================================================="
echo "=                                                            ="
echo "=  $PRODUCT $VERSION setup complete.  ="
echo "=                                                            ="
echo "=  Start $PRODUCT with:            ="
echo "=                                                            ="
echo "=           $SERVER_BIN/standalone.sh         ="
echo "=                                                            ="
echo "=  Log in to Red Hat Process Automation Manager to start     ="
echo "=  working with the mortage demo project:                    ="
echo "=                                                            ="
echo "=  http://localhost:8080/business-central                    ="
echo "=                                                            ="
echo "=    Log in: [ u:pamAdmin / p:redhatpam1! ]                  ="
echo "=                                                            ="
echo "=  See Readme.md for details on running demo project.        ="
echo "=                                                            ="
echo "=============================================================="
echo

