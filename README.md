<p align="center">
    <img src="./SwiftPlantUMLApp/Assets.xcassets/AppIcon.appiconset/128.png" width="100" max-width="50%" alt="SwiftPlantUML" />
</p>

![Build](https://github.com/MarcoEidinger/SwiftPlantUML-Xcode-Extension/workflows/Build/badge.svg)
[![Swift 5.3](https://img.shields.io/badge/swift-5.3-orange.svg?style=flat)](#)
[![Twitter](https://img.shields.io/badge/twitter-@MarcoEidinger-blue.svg)](http://twitter.com/MarcoEidinger)
# SwiftPlantUML-Xcode-Extension

Generate and view a class diagram for Swift code in Xcode with this extension.

This Source Editor Extension makes use of [SwiftPlantUML](https://github.com/MarcoEidinger/SwiftPlantUML) Swift package. You can also use `SwiftPlantUML` as a command-line tool.

## Features

- [X] 📊 Create class diagram from Swift file    
- [X] 🔦 Create class diagram from selected Swift code    

## Example

![SwiftPlantUML Xcode Extension - Usage Demo](.assets/usage.gif)

## Installation

- Download latest *SwiftPlantUML* package from the [Releases](https://github.com/MarcoEidinger/SwiftPlantUML-Xcode-Extension/releases).
- Copy *SwiftPlantUML* to your *Applications* folder.
- Launch *SwiftPlantUML* once. You can close it immediately afterwards (i.e. Quit from Dock).
- Go to <kbd>System Preferences</kbd> > <kbd>Extensions</kbd> > <kbd>Xcode Source Editor</kbd> > select <kbd>SwiftPlantUML</kbd>

![SwiftPlantUML Xcode Extension - Installation](.assets/installation.png)

## Troubleshooting

### The command "Open editable diagram in browser" is still busy

Xcode Source Code Extension initialization might take up ~ 30 seconds on initial launch.

If the prompt does not appear within 60 seconds 

![image](https://user-images.githubusercontent.com/37135317/118424310-f77dd000-b701-11eb-9b59-cd3c964e1885.png)

then check for a crash report related to XPC service in Console app of your MacOS.

<img width="1726" alt="CrashReportXPCServiceExample" src="https://user-images.githubusercontent.com/4176826/134083329-722a101a-4ec6-428b-9ee5-bcffec0784a8.png">

If you see such crash report related to `fatal error: Loading sourcekitd.framework/Versions/A/sourcekitd failed` please check the installation path of Xcode. If it's installed under `/Applications/Xcode.app`, please run:

```
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

If it's installed elsewhere, please replace the `/Applications/Xcode.app` path in the command above with the location where you've installed Xcode.


## Technical Details

This Source Editor Extension makes use of XPC service to run the app sandboxed and use `SwiftPlantUML` (and its dependency `SourceKitten`). Source Editor Extensions using `SourceKitten` (either directly or indirectly) have to either run in a non-sandboxed app (and could not be distributed via the App Store) or use XPC service to outsource the use of `SourceKitten` to a different process.

# Acknowledgements

These awesome blog posts helped me to dive into Xcode Source Editor Extensions and XPC services

- https://www.vadimbulavin.com/xcode-source-editor-extension-tutorial/
- https://nshipster.com/xcode-source-extensions/
- https://ilya.puchka.me/xcode-source-editor-extension-superpowered-with-sourcekitten/
- https://www.objc.io/issues/14-mac/xpc/
