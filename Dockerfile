FROM openjdk:8-jdk
MAINTAINER Woraphot Chokratanasombat <guhungry@gmail.com>

ENV ANDROID_TARGET_SDK="25" \
    ANDROID_BUILD_TOOLS="25.0.0" \
    ANDROID_SDK_TOOLS="25.2.2" \
    ANDROID_HOME=$PWD/android-sdk-linux

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1

RUN mkdir $ANDROID_HOME && \
    wget --quiet --output-document=tools.zip https://dl.google.com/android/repository/tools_r${ANDROID_SDK_TOOLS}-linux.zip && \
    unzip tools.zip -d $ANDROID_HOME && \
    rm tools.zip

RUN echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_TARGET_SDK} && \
    echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter platform-tools && \
    echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS} && \
    echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository && \
    echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services && \
    echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository
