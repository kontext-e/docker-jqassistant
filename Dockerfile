FROM ubuntu:16.04

LABEL maintainer "j.nerche@kontext-e.de"
LABEL version="1.3.3"
LABEL description="jQAssistant 1.3.0 with Kontext E Plugin suite 1.3.3"

RUN apt-get update

RUN apt-get -y install joe
RUN apt-get -y install less
RUN apt-get -y install wget
RUN apt-get -y install unzip

# for some unknown reason JDK install does not work without a second update
RUN apt-get update

RUN apt-get -y install openjdk-8-jre

RUN wget https://jqassistant.org/wp-content/uploads/2017/06/jqassistant-commandline-1.3.0.zip -O jqassistant.zip
RUN unzip -d jqassistant jqassistant.zip

ARG KE_PLUGIN_VERSION="1.3.3"
ARG KE_PLUGINS="pmd plantuml plaintext linecount javaparser jacoco git findbugs checkstyle asciidoc"

RUN for i in $KE_PLUGINS; do wget http://search.maven.org/remotecontent?filepath=de/kontext-e/jqassistant/plugin/jqassistant.plugin.$i/$KE_PLUGIN_VERSION/jqassistant.plugin.$i-$KE_PLUGIN_VERSION.jar -O jqassistant/plugins/jqassistant.plugin.$i-$KE_PLUGIN_VERSION.jar;done
RUN wget http://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/4.8.0.201706111038-r/org.eclipse.jgit-4.8.0.201706111038-r.jar -O jqassistant/plugins/org.eclipse.jgit-4.8.0.201706111038-r.jar
RUN wget http://search.maven.org/remotecontent?filepath=com/github/javaparser/javaparser-core/3.5.9/javaparser-core-3.5.9.jar -O jqassistant/plugins/javaparser-core-3.5.9.jar
RUN wget http://search.maven.org/remotecontent?filepath=net/sourceforge/plantuml/plantuml/8057/plantuml-8057.jar -O jqassistant/plugins/plantuml-8057.jar

VOLUME ["/project"]

ENV SCAN_OPTIONS -reset
ENV SCAN_DIRS /project
ENV SCAN 1

ENV AVAILABLE_SCOPES 0
ENV AVAILABLE_SCOPES_OPTIONS ""

ENV AVAILABLE_RULES 0
ENV AVAILABLE_RULES_OPTIONS ""

ENV EFFECTIVE_RULES 0
ENV EFFECTIVE_RULES_OPTIONS ""

ENV ANALYZE_OPTIONS ""
ENV ANALYZE 1

ENV REPORT_OPTIONS ""
ENV REPORT 0

ENV SERVER_OPTIONS ""
ENV START_SERVER 1

CMD cd /project \
	&& ls \
	&& if [ $AVAILABLE_SCOPES -gt 0 ]; then /jqassistant/bin/jqassistant.sh available-scopes $AVAILABLE_SCOPES_OPTIONS; fi \
	&& if [ $AVAILABLE_RULES -gt 0 ]; then /jqassistant/bin/jqassistant.sh available-rules $AVAILABLE_RULES_OPTIONS; fi \
	&& if [ $EFFECTIVE_RULES -gt 0 ]; then /jqassistant/bin/jqassistant.sh effective-rules $EFFECTIVE_RULES_OPTIONS; fi \
	&& if [ $SCAN -gt 0 ]; then /jqassistant/bin/jqassistant.sh scan $SCAN_OPTIONS -f $SCAN_DIRS; fi \
	&& if [ $ANALYZE -gt 0 ]; then /jqassistant/bin/jqassistant.sh analyze $ANALYZE_OPTIONS; fi \
	&& if [ $REPORT -gt 0 ]; then /jqassistant/bin/jqassistant.sh report $REPORT_OPTIONS; fi \
	&& if [ $START_SERVER -gt 0 ]; then /jqassistant/bin/jqassistant.sh server -serverAddress `hostname -i` $SERVER_OPTIONS; fi
	
