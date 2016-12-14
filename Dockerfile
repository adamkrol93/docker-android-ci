FROM openjdk:8-jdk
MAINTAINER Woraphot Chokratanasombat <guhungry@gmail.com>

ENV ANDROID_TARGET_SDK="25" \
    ANDROID_BUILD_TOOLS="25.0.2"

# Update and Install Package
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes curl tar lib32stdc++6 lib32z1

# Install Android SDK
# https://developer.android.com/studio/index.html
ENV ANDROID_SDK_ZIP https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN curl -L $ANDROID_SDK_ZIP | tar zxv -C /

ENV ANDROID_HOME /android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools

# Update Android SDK
RUN echo y | android --silent update sdk --no-ui --all --filter tools && \
    echo y | android --silent update sdk --no-ui --all --filter platform-tools && \
    echo y | android --silent update sdk --no-ui --all --filter extra-android-support && \
    echo y | android --silent update sdk --no-ui --all --filter extra-android-m2repository && \
    echo y | android --silent update sdk --no-ui --all --filter extra-google-google_play_services && \
    echo y | android --silent update sdk --no-ui --all --filter extra-google-m2repository

# Update Platform & Build Tools
RUN echo y | android --silent update sdk --no-ui --all --filter android-${ANDROID_TARGET_SDK} && \
    echo y | android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS}
