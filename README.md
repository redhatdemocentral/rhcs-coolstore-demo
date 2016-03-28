App Dev Cloud with JBoss Cool Store Demo 
==========================================
This demo is to install JBoss Cool Store in the Cloud based on leveraging the Red Hat Container Development Kit (CDK) and the
provided OpenShift Enterprise (OSE) image. It delivers a fully functioning JBoss Cool Store containerized on OSE.

The Cool Store is a retail web store demo where you will find rules, decision tables, events, and a ruleflow 
that is leveraged by a web application. The web application is a WAR built using the JBoss BRMS
generated project as a dependency, providing an example project showing how developers can focus on the 
application code while the business analysts can focus on rules, events, and ruleflows in the 
JBoss BRMS product web based dashboard.

This demo is self contained, it uses a custom maven settings to deploy all built JBoss BRMS knowledge artifacts
into an external maven repository (not your local repository), in /tmp/maven-repo.


Install on Red Hat CDK OpenShift Enterprise image
-------------------------------------------------
1. First complete the installation and start the OpenShift image supplied in the [cdk-install-demo](https://github.com/eschabell/cdk-install-demo).

2. Install [OpenShift Client Tools](https://developers.openshift.com/managing-your-applications/client-tools.html) if you have not done so previously.

3. [Download and unzip this demo.](https://github.com/eschabell/rhcs-coolstore-demo/archive/master.zip)

4. Add products to installs directory.

5. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges.

6. Login to Cool Store to start exploring a retail web shopping project:

    [http://rhcs-coolstore-demo.10.1.2.2.xip.io/business-central](http://rhcs-coolstore-demo.10.1.2.2.xip.io/business-central)
    ( u:erics / p:jbossbrms1! )

    [http://rhcs-coolstore-demo.10.1.2.2.xip.io/brms-coolstore-demo](http://rhcs-coolstore-demo.10.1.2.2.xip.io/brms-coolstore-demo)


Note before running demo:
-------------------------
The web application (shopping cart) is built during demo installation with a provided coolstore project jar version 2.0.0. When you 
open the project you will find the version is also set to 2.0.0. You can run the web application as is, but if you build and deploy
a new version of 2.0.0 to your maven repository it will find duplicate rules. To demo you deploy a new version of the coolstore
project by bumping the version number on each build and deploy, noting the KieScanner picking up the new version within 10 seconds 
of a new deployment. For example, initially start project, bump the version to 3.0.0, build and deploy, open web application and
watch KieScanner in server logs pick up the 3.0.0 version. Now change a shipping rule value in decision table, save, bump project
version to 4.0.0, build and deploy, watch for KieScanner picking up new 4.0.0 version, now web application on next run will use new
shipping values.


Tip & Trick
-----------
This is a good way to look at what is being created during the installation:

    ```
    $ oc get all

    NAME                        TYPE                                           FROM       LATEST
    rhcs-coolstore-demo         Docker                                         Binary     1

    NAME                        TYPE                                           FROM             STATUS     STARTED         DURATION
    rhcs-coolstore-demo-1       Docker                                         Binary@56ed14a   Running    2 minutes ago   2m11s
    
    NAME                        DOCKER REPO                                    TAGS                  UPDATED
    developer                   eschabell/developer                     1.0,jdk8-uid,latest   10 minutes ago
    rhcs-coolstore-demo         172.30.211.34:5000/rhcs-coolstore-demo/rhcs-coolstore-demo

    NAME                             READY                                     STATUS     RESTARTS   AGE
    rhcs-coolstore-demo-1-build   1/1                                       Running    0          2m


Supporting Articles
-------------------
- [Ultimate Cloud Guide to Retail in the Cloud with JBoss Cool Store](http://www.schabell.org/2016/03/ultimate-cloud-guide-retail-cloud-jboss-coolstore.html)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - JBoss BRMS 6.2.0-BZ-1299002, JBoss EAP 6.4.4 with Cool Store installed on Red Hat CDK using OpenShift Enterprise image. 

![OSE pod](https://github.com/eschabell/rhcs-coolstore-demo/blob/master/docs/demo-images/rhcs-coolstore-pod.png?raw=true)

![OSE build](https://github.com/eschabell/rhcs-coolstore-demo/blob/master/docs/demo-images/rhcs-coolstore-build.png?raw=true)

![JBoss BRMS](https://github.com/eschabell/rhcs-coolstore-demo/blob/master/docs/demo-images/jboss-brms.png?raw=true)

![Decision Table](https://github.com/eschabell/rhcs-coolstore-demo/blob/master/docs/demo-images/coolstore-decision-table.png?raw=true)

