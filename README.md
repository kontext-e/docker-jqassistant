This is jQAssistant 1.3.0 Distribution with Kontext E Plugin Suite 1.3.3 in a Docker image.

## Volume
There is one VOLUME ["/project"]

## Environment Variables
And several environment variables to configure the jQAssistant run:
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

Set SCAN, ANALYZE or START_SERVER to 0 if you want to skip this part.

## Installed Plugins
There are the standard jQAssistant plugins plus the Kontext E plugin suite version 1.2.0 (containing asciidoc, checkstyle, findbugs, git, jacoco, linecount, plantuml, pmd) available.

## Examples

docker run -it -v /home/user/src/some_project:/project --env SCAN_DIRS="src doc/architecture" -p 7474:7474  jensnerche/jqassistant

docker run --env SCAN=0 --env ANALYZE=0 --env START_SERVER=0 --env AVAILABLE_SCOPES=1  jensnerche/jqassistant

DukeCon Server from https://github.com/DirkMahler/dukecon_server.git commit 5556360:
	docker run -it -v /home/jn/src/dukecon_server:/project --env SCAN_DIRS="java:classpath::api/target/classes java:classpath::api/target/test-classes java:classpath::impl/target/classes java:classpath::impl/target/test-classes .git src/docs/asciidoc" -p 7474:7474 jensnerche/jqassistant
