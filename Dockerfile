FROM openjdk:8-jre-alpine

LABEL maintainer "j.nerche@kontext-e.de"
LABEL version="1.7.0"
LABEL description="jQAssistant 1.7.0 with Kontext E Plugin suite 1.7.0"

ARG KE_PLUGIN_VERSION="1.7.0"
ARG KE_PLUGINS="spotbugs pmd plantuml plaintext linecount javaparser jacoco git excel checkstyle asciidoc"

RUN apk add --no-cache wget unzip \
 && wget https://jqassistant.org/wp-content/uploads/2019/10/jqassistant-commandline-neo4jv3-1.7.0-distribution.zip -O jqassistant.zip \
 && unzip -d jqassistant_tmp jqassistant.zip \
 && mv jqassistant_tmp/jqassistant-* ./jqassistant \
 && for i in $KE_PLUGINS; do wget http://search.maven.org/remotecontent?filepath=de/kontext-e/jqassistant/plugin/jqassistant.plugin.$i/$KE_PLUGIN_VERSION/jqassistant.plugin.$i-$KE_PLUGIN_VERSION.jar -O jqassistant/plugins/jqassistant.plugin.$i-$KE_PLUGIN_VERSION.jar;done \
 && wget https://search.maven.org/remotecontent?filepath=org/jqassistant/contrib/plugin/jqassistant-dashboard-plugin/1.7.0/jqassistant-dashboard-plugin-1.7.0.jar -O jqassistant/plugins/jqassistant-dashboard-plugin-1.7.0.jar \
 && wget http://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/4.8.0.201706111038-r/org.eclipse.jgit-4.8.0.201706111038-r.jar -O jqassistant/plugins/org.eclipse.jgit-4.8.0.201706111038-r.jar \
 && wget https://search.maven.org/remotecontent?filepath=com/github/javaparser/javaparser-core/3.6.25/javaparser-core-3.6.25.jar -O jqassistant/plugins/javaparser-core-3.6.25.jar \
 && wget https://search.maven.org/remotecontent?filepath=org/apache/poi/poi/4.1.0/poi-4.1.0.jar -O jqassistant/plugins/poi-4.1.0.jar \
 && wget https://search.maven.org/remotecontent?filepath=org/apache/poi/poi-ooxml/4.1.0/poi-ooxml-4.1.0.jar -O jqassistant/plugins/poi-ooxml-4.1.0.jar
# && wget https://search.maven.org/remotecontent?filepath=net/sourceforge/plantuml/plantuml/1.2018.12/plantuml-1.2018.12.jar -O jqassistant/plugins/plantuml-1.2018.12.jar

EXPOSE 7473
EXPOSE 7474
EXPOSE 7687

VOLUME ["/project"]
WORKDIR /project

ENTRYPOINT ["/jqassistant/bin/jqassistant.sh"]

CMD ["--help"]
