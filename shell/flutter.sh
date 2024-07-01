# 切换国内源
# bash <(curl -sSL https://linuxmirrors.cn/main.sh)

# 临时变量
DIR=$HOME/.local/share

ANDROID_HOME=${DIR}/android
ANDROID_SDK_TOOLS_VERSION=11076708
ANDROID_VERSION=33

GRADLE_VERSION=7.5


echo -e "安装android sdk"
sudo apt -y install unzip openjdk-17-jdk
rm -rf /tmp/*
rm -rf ${DIR}/android
mkdir -p ${DIR}/android/cmdline-tools/latest
wget https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip -O /tmp/android-sdk-tools.zip \
&& unzip -q /tmp/android-sdk-tools.zip -d /tmp/ \
&& mv /tmp/cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/latest/ \
&& ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses \
&& ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --install "platform-tools" "platforms;android-${ANDROID_VERSION}" "build-tools;${ANDROID_VERSION}.0.0" \
echo -e '\n# android\nexport ANDROID_HOME='${DIR}'/android\nexport PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin\nexport PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source $HOME/.zshrc

echo -e "\n安装gradle"
mkdir -p ${DIR}/gradle
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip -O /tmp/gradle.zip \
&& unzip -q /tmp/gradle.zip -d /tmp/ \
&& mv /tmp/gradle-${GRADLE_VERSION}/* ${DIR}/gradle/
echo -e '\n# gradle\nexport GRADLE_HOME='${DIR}'/gradle\nexport PATH=$GRADLE_HOME/bin:$PATH' >> ~/.zshrc
source $HOME/.zshrc

echo -e "\n安装flutter"
mkdir -p ${DIR}
git clone --depth 1 https://github.com/flutter/flutter.git -b stable ${DIR}/flutter \
&& ${DIR}/flutter/bin/flutter doctor
echo -e '\n# flutter\nexport PUB_HOSTED_URL=https://pub.flutter-io.cn\nexport FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn\nexport PATH=$PATH:'${DIR}'/flutter/bin' >> ~/.zshrc
source $HOME/.zshrc