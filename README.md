# AndroidStudio in Docker Environment

## Build

    $ docker build -t androidstudio:3.0 .

## Usage

Prepare HOME:

    mkdir -p $HOME/.androidstudio/home_container

Launch IDE:

    docker run -ti --privileged --name android --rm -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix                                \
        -v $HOME/.androidstudio/home_container:/home/developer          \
        androidstudio:3.0

Launch emulator:

    $ docker exec -ti android /bin/bash
    > export PULSE_SERVER=tcp:172.17.0.1
    > cd ~/Android/Sdk/emulator
    > sudo ./emulator @Nexus_5X_API_26_x86 -use-system-libs
