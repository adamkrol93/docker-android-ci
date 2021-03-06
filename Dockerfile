FROM openjdk:8-jdk
MAINTAINER Woraphot Chokratanasombat <guhungry@gmail.com>

ENV ANDROID_TARGET_SDK="27" \
    ANDROID_BUILD_TOOLS="27.0.0" \
    ANDROID_SDK_TOOLS_REV="3859397"

# Update and Install Package
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes curl tar lib32stdc++6 lib32z1

# Environment
ENV ANDROID_HOME /android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools

# Install Android SDK
# https://developer.android.com/studio/index.html
ENV ANDROID_SDK_ZIP https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_REV}.zip
RUN mkdir ${ANDROID_HOME}
RUN curl -L $ANDROID_SDK_ZIP -o temp.zip && unzip -qq temp.zip -d ${ANDROID_HOME} && rm temp.zip


# Update Android SDK
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager --update && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  tools && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  platform-tools && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  'extras;android;m2repository' && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  'extras;google;google_play_services' && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  'extras;google;m2repository' && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  'platforms;android-'${ANDROID_TARGET_SDK} && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  'build-tools;'${ANDROID_BUILD_TOOLS} && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager  'ndk-bundle' 

# Accept Licenses
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager --licenses
