BUILD_DIR=./build
ARCHIVE=$BUILD_DIR/Peekaboo.xcarchive
APP=$BUILD_DIR/App

# Cleanup old artifacts

rm -rf $ARCHIVE $APP

# Archive

xcodebuild archive \
    -project Peekaboo.xcodeproj \
    -configuration Release \
    -scheme Peekaboo \
    -archivePath $ARCHIVE

# Export

xcodebuild -exportArchive \
    -archivePath $ARCHIVE \
    -exportPath $APP \
    -exportOptionsPlist ./Scripts/ExportOptions.plist

# Delete archive

rm -rf $ARCHIVE
