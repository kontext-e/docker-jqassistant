FROM openjdk:8-jre-alpine

LABEL maintainer "j.nerche@kontext-e.de"
LABEL version="1.4.2"
LABEL description="jQAssistant 1.4.0 with Kontext E Plugin suite 1.4.2"

ARG KE_PLUGIN_VERSION="1.4.2"
ARG KE_PLUGINS="pmd plantuml plaintext linecount javaparser jacoco git findbugs checkstyle asciidoc"

RUN apk add --no-cache wget unzip \
 && wget https://jqassistant.org/wp-content/uploads/2018/06/jqassistant-commandline-neo4jv3-1.4.0-distribution.zip -O jqassistant.zip \
 && unzip -d jqassistant_tmp jqassistant.zip \
 && mv jqassistant_tmp/jqassistant-* ./jqassistant \
 && for i in $KE_PLUGINS; do wget http://search.maven.org/remotecontent?filepath=de/kontext-e/jqassistant/plugin/jqassistant.plugin.$i/$KE_PLUGIN_VERSION/jqassistant.plugin.$i-$KE_PLUGIN_VERSION.jar -O jqassistant/plugins/jqassistant.plugin.$i-$KE_PLUGIN_VERSION.jar;done \
 && wget http://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/4.8.0.201706111038-r/org.eclipse.jgit-4.8.0.201706111038-r.jar -O jqassistant/plugins/org.eclipse.jgit-4.8.0.201706111038-r.jar \
 && wget http://search.maven.org/remotecontent?filepath=com/github/javaparser/javaparser-core/3.5.9/javaparser-core-3.5.9.jar -O jqassistant/plugins/javaparser-core-3.5.9.jar \
 && wget http://search.maven.org/remotecontent?filepath=net/sourceforge/plantuml/plantuml/8057/plantuml-8057.jar -O jqassistant/plugins/plantuml-8057.jar

EXPOSE 7473
EXPOSE 7474
EXPOSE 7687

VOLUME ["/project"]
WORKDIR /project

ENTRYPOINT ["/jqassistant/bin/jqassistant.sh"]

CMD ["--help"]
