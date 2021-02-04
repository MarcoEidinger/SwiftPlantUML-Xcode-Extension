<p align="center">
    <img src="./SwiftPlantUMLApp/Assets.xcassets/AppIcon.appiconset/128.png" width="100" max-width="50%" alt="SwiftPlantUML" />
</p>

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
- Launch *SwiftPlantUML* once. You can close it immediately afterwards.
- Go to <kbd>System Preferences</kbd> > <kbd>Extensions</kbd> > <kbd>Xcode Source Editor</kbd> > select <kbd>SwiftPlantUML</kbd>

![Lines Sorter Xcode Extension - Installation](.assets/installation.png)

## Technicla Details

This Source Editor Extension makes use of XPC service to run the app sandboxed and use `SwiftPlantUML` (and its dependency `SourceKitten`). Source Editor Extensions using `SourceKitten` (either directly or indirectly) have to either run in a non-sandboxed app (and could not be distributed via the App Store) or use XPC service to outsource the use of `SourceKitten` to a different process.

# Acknowledgements

These awesome blog posts helped me to dive into Xcode Source Editor Extensions and XPC services

- https://www.vadimbulavin.com/xcode-source-editor-extension-tutorial/
- https://nshipster.com/xcode-source-extensions/
- https://ilya.puchka.me/xcode-source-editor-extension-superpowered-with-sourcekitten/
- https://www.objc.io/issues/14-mac/xpc/
