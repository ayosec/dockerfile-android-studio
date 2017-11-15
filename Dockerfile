FROM debian:sid

ARG UID=1000

ARG PACKAGE_URL=https://dl.google.com/dl/android/studio/ide-zips/3.0.0.18/android-studio-ide-171.4408382-linux.zip

# Base system

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
      apt-get install -y \
          bsdtar         \
          curl           \
          dbus-x11       \
          git            \
          libxtst6       \
          mesa-utils     \
          sudo           \
          x11-apps       \
          xkb-data

RUN apt-get clean

# Install the AndroidStudio package

RUN cd /opt && curl $PACKAGE_URL | bsdtar -xf -
RUN find /opt -name bin -type d | xargs chmod -R +x

# Prepare a regular user to launch the application

RUN useradd -u $UID -m developer
RUN echo 'developer	ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers

USER developer

# Environment for the containers

ENV HOME /home/developer
ENV JAVA_HOME /opt/android-studio/jre/

CMD /opt/android-studio/bin/studio.sh
