#!/bin/sh 
DEMO="Cloud JBoss Cool Store Demo"
AUTHORS="Andrew Block, Eric D. Schabell"
PROJECT="git@github.com:redhatdemocentral/rhcs-coolstore-demo.git"
SRC_DIR=./installs
OPENSHIFT_USER=openshift-dev
OPENSHIFT_PWD=devel
BRMS=jboss-brms-6.3.0.GA-installer.jar
EAP=jboss-eap-6.4.0-installer.jar
EAP_PATCH=jboss-eap-6.4.7-patch.zip

# wipe screen.
clear 

echo
echo "#####################################################################"
echo "##                                                                 ##"   
echo "##  Setting up the ${DEMO}                     ##"
echo "##                                                                 ##"   
echo "##                                                                 ##"   
echo "##   ####  ###   ###  #      #### #####  ###   ###  #####          ##"
echo "##  #     #   # #   # #     #       #   #   # #   # #              ##"
echo "##  #     #   # #   # #      ###    #   #   # ####  ###            ##"
echo "##  #     #   # #   # #         #   #   #   # #  #  #              ##"
echo "##   ####  ###   ###  ##### ####    #    ###  #   # #####          ##"
echo "##                                                                 ##"   
echo "##                       ###   #### #####                          ##"
echo "##                  #   #   # #     #                              ##"
echo "##                 ###  #   #  ###  ###                            ##"
echo "##                  #   #   #     # #                              ##"
echo "##                       ###  ####  #####                          ##"
echo "##                                                                 ##"   
echo "##  brought to you by,                                             ##"   
echo "##             ${AUTHORS}                      ##"
echo "##                                                                 ##"   
echo "##  ${PROJECT}       ##"
echo "##                                                                 ##"   
echo "#####################################################################"
echo

# make some checks first before proceeding.	
command -v oc -v >/dev/null 2>&1 || { echo >&2 "OpenShift command line tooling is required but not installed yet... download here: https://access.redhat.com/downloads/content/290"; exit 1; }

if [ -r $SRC_DIR/$EAP ] || [ -L $SRC_DIR/$EAP ]; then
	echo Product sources are present...
	echo
else
	echo Need to download $EAP package from the Customer Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

if [ -r $SRC_DIR/$EAP_PATCH ] || [ -L $SRC_DIR/$EAP_PATCH ]; then
	echo Product patches are present...
	echo
else
	echo Need to download $EAP_PATCH package from the Customer Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

if [ -r $SRC_DIR/$BRMS ] || [ -L $SRC_DIR/$BRMS ]; then
	echo JBoss product sources are present...
	echo
else
	echo Need to download $BRMS package from the Customer Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	exit
fi

echo "OpenShift commandline tooling is installed..."
echo 
echo "Logging in to OpenShift as $OPENSHIFT_USER..."
echo
oc login 10.1.2.2:8443 --password=$OPENSHIFT_PWD --username=$OPENSHIFT_USER


if [ $? -ne 0 ]; then
	echo
	echo Error occurred during 'oc login' command!
	exit
fi

echo
echo "Creating a new project..."
echo
oc new-project rhcs-coolstore-demo 

echo
echo "Setting up a new build..."
echo
oc new-build "jbossdemocentral/developer" --name=rhcs-coolstore-demo --binary=true

if [ $? -ne 0 ]; then
	echo
	echo Error occurred during 'oc new-build' command!
	exit
fi

# need to wait a bit for new build to finish with developer image.
sleep 3  

echo
echo "Importing developer image..."
echo
oc import-image developer

if [ $? -ne 0 ]; then
	echo
	echo Error occurred during 'oc import-image' command!
	exit
fi

echo
echo "Starting a build, this takes some time to upload all of the product sources for build..."
echo
oc start-build rhcs-coolstore-demo --from-dir=. --follow=true --wait=true

if [ $? -ne 0 ]; then
	echo
	echo Error occurred during 'oc start-build' command!
	exit
fi

echo
echo "Creating a new application..."
echo
oc new-app rhcs-coolstore-demo

if [ $? -ne 0 ]; then
	echo
	echo Error occurred during 'oc new-app' command!
	exit
fi

echo
echo "Creating an externally facing route by exposing a service..."
echo
oc expose service rhcs-coolstore-demo --hostname=rhcs-coolstore-demo.10.1.2.2.xip.io

if [ $? -ne 0 ]; then
	echo
	echo Error occurred during 'oc expose service' command!
	exit
fi

echo
echo "======================================================================"
echo "=                                                                    ="
echo "=  Login to start exploring the Cool Store project:                  ="
echo "=                                                                    ="
echo "=    http://rhcs-coolstore-demo.10.1.2.2.xip.io/business-central     ="
echo "=                                                                    ="
echo "=    [ u:erics / p:jbossbrms1! ]                                     ="
echo "=                                                                    ="
echo "=                                                                    ="
echo "=  Access the Cool Store web shopping cart at:                       ="
echo "=                                                                    ="
echo "=    http://rhcs-coolstore-demo.10.1.2.2.xip.io/brms-coolstore-demo  ="
echo "=                                                                    ="
echo "=  Note: it takes a few minutes to expose the service...             ="
echo "=                                                                    ="
echo "======================================================================"

