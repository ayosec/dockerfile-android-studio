FROM debian:sid

ARG UID=1000

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
      apt-get install -y \
          ant            \
          bsdtar         \
          curl           \
          dbus-x11       \
          git            \
          lib32ncurses5  \
          lib32stdc++6   \
          lib32z1        \
          libxtst6       \
          mesa-utils     \
          sudo           \
          vim            \
          x11-apps       \
          xkb-data

RUN apt-get clean

RUN cd /opt && \
    curl 'https://dl.google.com/dl/android/studio/ide-zips/3.0.0.18/android-studio-ide-171.4408382-linux.zip' | \
    bsdtar -xf -

RUN find /opt -name bin -type d | xargs chmod -R +x

RUN echo 'developer	ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers

RUN useradd -u $UID -m developer

USER developer

ENV HOME /home/developer
ENV JAVA_HOME /opt/android-studio/jre/

CMD /opt/android-studio/bin/studio.sh
