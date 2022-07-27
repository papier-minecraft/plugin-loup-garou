FROM eclipse-temurin:8-jdk

WORKDIR /minecraft


# SPIGOT
ARG SPIGOT_VERSION
COPY lib/spigot-${SPIGOT_VERSION}.jar ./spigot.jar

# PLUGINS
ARG VERSION_PROTOCOLLIB=4.8.0
ADD https://github.com/dmulloy2/ProtocolLib/releases/download/${VERSION_PROTOCOLLIB}/ProtocolLib.jar ./plugins/ProtocolLib.jar

ARG VERSION_VIAVERSION=4.3.1
ADD https://github.com/ViaVersion/ViaVersion/releases/download/${VERSION_VIAVERSION}/ViaVersion-${VERSION_VIAVERSION}.jar ./plugins/ViaVersion.jar

ARG VERSION_DISCORDSRV=1.25.1
ADD https://github.com/DiscordSRV/DiscordSRV/releases/download/v${VERSION_DISCORDSRV}/DiscordSRV-Build-${VERSION_DISCORDSRV}.jar ./plugins/DiscordSRV.jar

ARG VERSION
COPY target/LoupGarou-${VERSION}.jar ./plugins/LoupGarou.jar

# If EULA not accepted, exit else add eula.txt
ARG EULA=false
RUN if [ "${EULA}" = "false" ]; then exit 1; else echo eula=true > eula.txt; fi

# MAPS
COPY conf/server.properties ./server.properties
COPY conf/maps ./lg_village
COPY conf/plugins/LoupGarou ./plugins/LoupGarou

EXPOSE 25560

CMD [ "java", "-Xmx1G", "-Xms1G", "-jar", "./spigot.jar", "nogui" ]
