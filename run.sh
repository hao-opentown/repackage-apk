#!/bin/bash


CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $CURRENT_DIR

./clean.sh && mkdir dist

export PATH=$PATH:$ANDROID_HOME/build-tools/23.0.2


aapt package \
            -v \
            -f \
            -m \
            -M ./AndroidManifest.xml \
            -I $ANDROID_HOME/platforms/android-23/android.jar \
            -I ./weixin_660.apk \
            -F ./dist/dist.apk

echo
echo "==================== FILES CREATED ==================== "


cd ./dist

mv dist.apk dist.zip
unzip -o dist.zip -d .
cp ../weixin_660.apk          weixin_process.apk

aapt r weixin_process.apk \
                            META-INF/MANIFEST.MF \
                            AndroidManifest.xml \
                            META-INF/COM_TENC.SF \
                            META-INF/COM_TENC.RSA

aapt a weixin_process.apk \
                            AndroidManifest.xml


jarsigner -verbose \
          -sigalg SHA1withRSA \
          -digestalg SHA1 \
          -keystore ../opentown.keystore \
  weixin_process.apk opentown

zipalign -f \
         -v 4 \
  weixin_process.apk weixin_complete.apk

cp weixin_complete.apk weixin_complete.zip
unzip -o weixin_complete.zip -d verify_dir