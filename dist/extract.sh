rm -rf ./verify_dir weixin_complete.zip weixin_complete.apk weixin_process.apk

mv dist.apk dist.zip
unzip -o dist.zip -d .

cp ../weixin_660.apk weixin_process.apk

$ANDROID_HOME/build-tools/23.0.2/aapt r weixin_process.apk META-INF/MANIFEST.MF META-INF/OPENTOWN.SF META-INF/OPENTOWN.RSA  AndroidManifest.xml  META-INF/COM_TENC.SF
META-INF/COM_TENC.RSA

$ANDROID_HOME/build-tools/23.0.2/aapt a weixin_process.apk AndroidManifest.xml

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore weixin_process.apk opentown

$ANDROID_HOME/build-tools/23.0.2/zipalign -f -v 4 weixin_process.apk weixin_complete.apk

cp weixin_complete.apk weixin_complete.zip
unzip -o weixin_complete.zip -d verify_dir