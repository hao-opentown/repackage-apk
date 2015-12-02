
DEV_HOME=.
$ANDROID_HOME/build-tools/23.0.2/aapt \
                        package \
                        -v \
                        -f \
                        -m \
                        -M $DEV_HOME/AndroidManifest.xml \
                        -I $ANDROID_HOME/platforms/android-23/android.jar \
                        -I $DEV_HOME/weixin_660.apk \
                        -F b.apk
mv b.apk b.zip
unzip -o b.zip -d test
echo
echo "==================== FILES CREATED ==================== "
