This is jQAssistant Distribution with Kontext E Plugin Suite in a Docker image.

In general it works like the [jQAssistant command line distribution](http://buschmais.github.io/jqassistant/doc/1.6.0/#_command_line).

## Tags

* 1.3.3
* 1.4.2
* 1.5.1
* 1.6.1

## Volume
There is one VOLUME ["/project"]

## Installed Plugins
There are the standard jQAssistant plugins plus the Kontext E plugin suite (containing asciidoc, checkstyle, findbugs, git, jacoco, javaparser, linecount, plaintext, plantuml, pmd) available.

## Examples

### Just list available scopes

	docker run jensnerche/jqassistant  available-scopes

### Import only project's Git meta data

	docker run -v /home/user/src/some_project:/project jensnerche/jqassistant scan -f .git

### DukeCon Server from https://github.com/DirkMahler/dukecon_server.git commit 5556360:

	docker run -v /home/user/src/dukecon_server:/project jensnerche/jqassistant scan -f java:classpath::api/target/classes java:classpath::api/target/test-classes java:classpath::impl/target/classes java:classpath::impl/target/test-classes .git src/docs/asciidoc

That like a typical multi-module Maven project. Scanned stuff:

* compiled classes (you always need to add "java:classpath::" scope for classes)
* Git meta data
* Architecture documentation, containing Asciidoc description and PlantUML diagram


### Run the server to explore the scanned data

	docker run -it -v /home/user/src/dukecon_server:/project -p 7474:7474 jensnerche/jqassistant server -serverAddress 0.0.0.0

Note that unlike in the jQAssistant commandline distribution you have to make the server bind to all addresses, otherwise the port forwarding would not work.
