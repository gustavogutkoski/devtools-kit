FROM sonatype/nexus3:3.68.1

EXPOSE 8081

VOLUME /nexus-data

ENV INSTALL4J_ADD_VM_PARAMS="-Xms1200m -Xmx1200m -XX:+UseG1GC -XX:+UseStringDeduplication"

CMD ["sh", "-c", "exec ${NEXUS_HOME}/bin/nexus run"]
