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
1. First complete the installation and start the OpenShift image supplied in the [cdk-install-demo](https://github.com/redhatdemocentral/cdk-install-demo).

2. Install [OpenShift Client Tools](https://developers.openshift.com/managing-your-applications/client-tools.html) if you have not done so previously.

3. [Download and unzip this demo.](https://github.com/redhatdemocentral/rhcs-coolstore-demo/archive/master.zip)

4. Add products to installs directory.

5. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges.

6. Login to Cool Store to start exploring a retail web shopping project:

    [http://rhcs-coolstore-demo.10.1.2.2.xip.io/business-central](http://rhcs-coolstore-demo.10.1.2.2.xip.io/business-central)
    ( u:erics / p:jbossbrms1! )

    [http://rhcs-coolstore-demo.10.1.2.2.xip.io/brms-coolstore-demo](http://rhcs-coolstore-demo.10.1.2.2.xip.io/brms-coolstore-demo)


Note before running demo:
-------------------------
Should your local network DNS not handle the resolution of the above address, giving you page not found errors, you can apply the
following to your local hosts file:

```
$ sudo vi /etc/hosts

# add host for CDK demo resolution.
10.1.2.2   rhcs-coolstore-demo.10.1.2.2.xip.io    rhcs-coolstore-demo.10.1.2.2.xip.io
```


Supporting Articles
-------------------
- [Ultimate Cloud Guide to Retail in the Cloud with JBoss Cool Store](http://www.schabell.org/2016/03/ultimate-cloud-guide-retail-cloud-jboss-coolstore.html)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.2 - JBoss BRMS 6.3.0 and JBoss EAP 6.4.7 with Cool Store installed on Red Hat CDK 2.1. 

- v1.1 - JBoss BRMS 6.2.0.GA-redhat-1-bz-1334704 and JBoss EAP 6.4.4 with Cool Store installed on Red Hat CDK 2.1. 

- v1.0 - JBoss BRMS 6.2.0-BZ-1299002, JBoss EAP 6.4.4 with Cool Store installed on Red Hat CDK using OpenShift Enterprise image. 

![OSE pod](https://github.com/redhatdemocentral/rhcs-coolstore-demo/blob/master/docs/demo-images/rhcs-coolstore-pod.png?raw=true)

![OSE build](https://github.com/redhatdemocentral/rhcs-coolstore-demo/blob/master/docs/demo-images/rhcs-coolstore-build.png?raw=true)

![JBoss Store](https://github.com/redhatdemocentral/rhcs-coolstore-demo/blob/master/docs/demo-images/coolstore-shoppingcart-0.png?raw=true)

![JBoss BRMS](https://github.com/redhatdemocentral/rhcs-coolstore-demo/blob/master/docs/demo-images/jboss-brms.png?raw=true)

![Decision Table](https://github.com/redhatdemocentral/rhcs-coolstore-demo/blob/master/docs/demo-images/coolstore-decision-table.png?raw=true)

