ARG VERSION_PROTOCOLLIB=4.8.0
ARG VERSION_VIAVERSION=4.3.1
ARG VERSION_DISCORDSRV=1.25.1

FROM eclipse-temurin:8-jdk

WORKDIR /minecraft
EXPOSE 25560

RUN apt-get update && apt-get install -y unzip

# SPIGOT
COPY lib/spigot-1.15.1.jar ./spigot.jar

# PLUGINS
COPY target/LoupGarou.jar ./plugins/LoupGarou.jar
ADD https://github.com/dmulloy2/ProtocolLib/releases/download/${VERSION_PROTOCOLLIB}/ProtocolLib.jar ./plugins/ProtocolLib.jar
ADD https://github.com/ViaVersion/ViaVersion/releases/download/${VERSION_VIAVERSION}/ViaVersion-${VERSION_VIAVERSION}.jar ./plugins/ViaVersion.jar
ADD https://github.com/DiscordSRV/DiscordSRV/releases/download/v${VERSION_DISCORDSRV}/DiscordSRV-Build-${VERSION_DISCORDSRV}.jar ./plugins/DiscordSRV.jar

# MAPS
COPY maps/* ./
RUN unzip ./lg_\*.zip


CMD [ "java", "-Xmx1G", "-Xms1G", "-jar", "./spigot.jar", "nogui" ]
