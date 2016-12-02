# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block, Eric D. Schabell

# Environment Variables 
ENV BRMS_HOME /opt/jboss/brms/jboss-eap-6.4
ENV BRMS_VERSION_MAJOR 6
ENV BRMS_VERSION_MINOR 3
ENV BRMS_VERSION_MICRO 0
ENV BRMS_VERSION_PATCH GA

ENV EAP_VERSION_MAJOR 6
ENV EAP_VERSION_MINOR 4
ENV EAP_VERSION_MICRO 0
ENV EAP_VERSION_PATCH 7

# ADD Installation and Management Files
COPY support/installation-brms support/installation-eap support/installation-brms.variables support/installation-eap.variables installs/jboss-brms-$BRMS_VERSION_MAJOR.$BRMS_VERSION_MINOR.$BRMS_VERSION_MICRO.$BRMS_VERSION_PATCH-installer.jar installs/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar installs/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_PATCH-patch.zip support/fix-permissions support/start.sh /opt/jboss/

USER root

# Prepare and run installer and cleanup installation components
RUN sed -i "s:<installpath>.*</installpath>:<installpath>$BRMS_HOME</installpath>:" /opt/jboss/installation-eap \
    && sed -i "s:<installpath>.*</installpath>:<installpath>$BRMS_HOME</installpath>:" /opt/jboss/installation-brms \
	&& java -jar /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar  /opt/jboss/installation-eap -variablefile /opt/jboss/installation-eap.variables \
    && $BRMS_HOME/bin/jboss-cli.sh --command="patch apply /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_PATCH-patch.zip --override-all" \
    && java -jar /opt/jboss/jboss-brms-$BRMS_VERSION_MAJOR.$BRMS_VERSION_MINOR.$BRMS_VERSION_MICRO.$BRMS_VERSION_PATCH-installer.jar  /opt/jboss/installation-brms -variablefile /opt/jboss/installation-brms.variables \
    && chown -R 1001:root $BRMS_HOME \
    && /opt/jboss/fix-permissions $BRMS_HOME \
    && rm -rf /opt/jboss/jboss-brms-$BRMS_VERSION_MAJOR.$BRMS_VERSION_MINOR.$BRMS_VERSION_MICRO.$BRMS_VERSION_PATCH-installer.jar /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_PATCH-patch.zip /opt/jboss/installation-brms /opt/jboss/installation-brms.variables /opt/jboss/installation-eap /opt/jboss/installation-eap.variables $BRMS_HOME/standalone/configuration/standalone_xml_history/

# Copy demo and support files
COPY support/brms-demo-niogit $BRMS_HOME/bin/.niogit
COPY projects /opt/jboss/brms-projects
COPY support/libs /opt/jboss/brms-projects/libs
COPY support/userinfo.properties $BRMS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/
COPY support/application-roles.properties support/standalone.xml $BRMS_HOME/standalone/configuration/
COPY support/settings.xml /opt/jboss/.m2/

# Run Demo Maven build and cleanup
RUN mvn install:install-file -Dfile=/opt/jboss/brms-projects/libs/coolstore-2.0.0.jar -DgroupId=com.redhat -DartifactId=coolstore -Dversion=2.0.0 -Dpackaging=jar \
  && mvn clean install -f /opt/jboss/brms-projects/brms-coolstore-demo/pom.xml \
  && cp /opt/jboss/brms-projects/brms-coolstore-demo/target/brms-coolstore-demo.war $BRMS_HOME/standalone/deployments/ \
  && /opt/jboss/fix-permissions $BRMS_HOME/bin/.niogit \
  && /opt/jboss/fix-permissions $BRMS_HOME/standalone/configuration/application-roles.properties \
  && /opt/jboss/fix-permissions $BRMS_HOME/standalone/configuration/standalone.xml \
  && /opt/jboss/fix-permissions $BRMS_HOME/standalone/deployments/brms-coolstore-demo.war \
  && /opt/jboss/fix-permissions $BRMS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/userinfo.properties \
  && /opt/jboss/fix-permissions /etc/passwd \
  && /opt/jboss/fix-permissions /etc/group \
  && rm -rf ~/.m2/repository /opt/jboss/brms-projects \
  && chmod +x /opt/jboss/start.sh \
  && mkdir -p /opt/jboss/.m2/repository \
  && /opt/jboss/fix-permissions /opt/jboss/.m2

# Run as JBoss 
USER 1000

# Expose Ports
EXPOSE 9990 9999 8080

# Default Command
CMD ["/bin/bash"]

# Helper script
ENTRYPOINT ["/opt/jboss/start.sh"]
