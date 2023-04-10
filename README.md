# ToDo Application

## Monetization Plan
To monetize the application, you can connect ads or make the application itself paid, or both.
The app can be published on Google Play and RuStore.

## Install and run
Before start install dependencies you should install Flutter 3.7.7, Dart 2.19.4.
For this you should run these commands:

```bash
sudo apt-get update
sudo apt-get install apt-transport-https
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
sudo apt-get update
sudo apt-get install dart
export PATH="$PATH:/usr/lib/dart/bin"
echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile

sudo snap install flutter --classic
```

For start project you add all packages for app:

```bash
flutter pub add
```

## Build

### Android Studio
For build install Android Studio and run:

```bash
fvm flutter build apk --debug
```

After that select Build > Build Bundle(s) / APK(s) > Build APK(s). Project build will start.
APK file will be in ``.build/app/outputs/flutter-apk``

### Gradle CLI

If you want build with Gradle CLI you should install Java and Gradle:

```bash
sudo apt update
sudo apt install openjdk-19-jdk
```

Check, that java right installed:

```bash
java -version
```

After that run:

```bash
VERSION=7.4.2
wget https://services.gradle.org/distributions/gradle-${VERSION}-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-${VERSION}-bin.zip
sudo ln -s /opt/gradle/gradle-${VERSION} /opt/gradle/latest
sudo nano /etc/profile.d/gradle.sh
```

Insert in file this:

```
export GRADLE_HOME=/opt/gradle/latest
export PATH=${GRADLE_HOME}/bin:${PATH}
```

After insert data, run next:

```bash
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
```

Check, that Gradle right installed:

```bash
gradle -v
```

After that, open ``android`` folder and run:

```bash
source /etc/profile.d/gradle.sh
gradle
gradle assemble
```

If you have ``SDK location not found. Define a valid SDK location with an ANDROID_HOME environment variable or by setting the sdk.dir path in your project's local properties``
run this in ``android`` directory, where username - name of your user:

```bash
echo 'sdk.dir=/home/username/Android/Sdk' > local.properties
```

If you have other path to Android sdk, please set it.

APK files will be in ``./android/app/build/outputs/apk/debug`` and ``./android/app/build/outputs/apk/release``