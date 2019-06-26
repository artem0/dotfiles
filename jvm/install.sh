#!/bin/sh

echo 'Installing SDKMAN'
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo 'Installing Java'
wget -P $TMPDIR https://support.apple.com/downloads/DL1572/fr_FR/javaforosx.dmg && open $TMPDIR/javaforosx.dmg
yes | sdk install java 8.0.212.hs-adpt
yes | sdk install java 11.0.3.hs-adpt
sdk default java 11.0.3.hs-adpt

echo 'Installing Gradle'
sdk install gradle
sdk default gradle

echo 'Installing Scala'
sdk install scala
sdk default scala
sdk install sbt
sdk default sbt
