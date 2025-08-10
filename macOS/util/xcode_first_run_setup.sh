#!/usr/bin/env bash

#: Setup first time run for Xcode
#: 
#: PRECONDITIONS: 
#:		1) Xcode is installed, has never been run
#:
#: Author: Fastily

sudo xcode-select -s "/Applications/Xcode.app/Contents/Developer"
sudo xcodebuild -license accept
sudo xcodebuild -runFirstLaunch

## Xcode settings
XCODE_DIR=~/"Library/Developer/Xcode/UserData"
mkdir -p "$XCODE_DIR"
cat > "${XCODE_DIR}/IDETemplateMacros.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>FILEHEADER</key>
    <string></string>
</dict>
</plist>
EOF