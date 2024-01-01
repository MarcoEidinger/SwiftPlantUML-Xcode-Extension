import Foundation
import SwiftPlantUMLFramework

@objc class XPCService: NSObject, XPCServiceProtocol {
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.theme.key, defaultValue: "")
    var theme: String
    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showGenerics.key, defaultValue: true)
    var showGenerics: Bool
    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showNestedTypes.key, defaultValue: true)
    var showNestedTypes: Bool
    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showExtensionsValue.key, defaultValue: ExtensionVisualization.default.rawValue)
    var showExtensionsValue: String

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showEmptyMembers.key, defaultValue: true)
    var showEmptyMembers: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelOpen.key, defaultValue: true)
    var showMembersWithAccessLevelOpen: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelPublic.key, defaultValue: true)
    var showMembersWithAccessLevelPublic: Bool
    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelPackage.key, defaultValue: true)
    var showMembersWithAccessLevelPackage: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelInternal.key, defaultValue: true)
    var showMembersWithAccessLevelInternal: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelPrivate.key, defaultValue: true)
    var showMembersWithAccessLevelPrivate: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelOpen.key, defaultValue: true)
    var showElementsWithAccessLevelOpen: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelPublic.key, defaultValue: true)
    var showElementsWithAccessLevelPublic: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelPackage.key, defaultValue: true)
    var showElementsWithAccessLevelPackage: Bool

    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelInternal.key, defaultValue: true)
    var showElementsWithAccessLevelInternal: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelPrivate.key, defaultValue: true)
    var showElementsWithAccessLevelPrivate: Bool
    
    var extensionVisualization: ExtensionVisualization {
        ExtensionVisualization(rawValue: showExtensionsValue) ?? .all
    }
    
    var showElementsWithAccessLevel: [AccessLevel] {
        var showElementsWithAccessLevel: [AccessLevel] = []
        if showElementsWithAccessLevelOpen {
            showElementsWithAccessLevel.append(.open)
        }
        if showElementsWithAccessLevelPublic {
            showElementsWithAccessLevel.append(.public)
        }
        if showElementsWithAccessLevelPackage {
            showElementsWithAccessLevel.append(.package)
        }
        if showElementsWithAccessLevelInternal {
            showElementsWithAccessLevel.append(.internal)
        }
        if showElementsWithAccessLevelPrivate {
            showElementsWithAccessLevel.append(.private)
        }
        return showElementsWithAccessLevel
    }
    
    var showMembersWithAccessLevel: [AccessLevel] {
        var showMembersWithAccessLevel: [AccessLevel] = []
        if showMembersWithAccessLevelOpen {
            showMembersWithAccessLevel.append(.open)
        }
        if showMembersWithAccessLevelPublic {
            showMembersWithAccessLevel.append(.public)
        }
        if showMembersWithAccessLevelPackage {
            showMembersWithAccessLevel.append(.package)
        }
        if showMembersWithAccessLevelInternal {
            showMembersWithAccessLevel.append(.internal)
        }
        if showMembersWithAccessLevelPrivate {
            showMembersWithAccessLevel.append(.private)
        }
        return showMembersWithAccessLevel
    }
    
    var hideShowCommands: [String] {
        var hideShowCommands = [String]()
        if !showEmptyMembers {
            hideShowCommands.append("hide empty members")
        }
        return hideShowCommands
    }
    
    var selectedTheme: Theme? {
        var selTheme: Theme? = nil
        if !theme.isEmpty {
            selTheme = Theme.__directive__(theme)
        }
        return selTheme
    }

    func generateDiagram(from content: String, completionHandler: @escaping (() -> Void)) {
        let config = assembleConfig()
        ClassDiagramGenerator().generate(from: content, with: config)
        completionHandler()
    }
    
    func generateDiagram(for paths: [String], completionHandler: @escaping (() -> Void)) {
        let config = assembleConfig()
        ClassDiagramGenerator().generate(for: paths, with: config, presentedBy: PlantUMLBrowserPresenter(format: .svg))
        completionHandler()
    }
    
    func assembleConfig() -> Configuration {
        let showNestedTypes = showNestedTypes
        let extensionVisualization = extensionVisualization
        let selectedTheme = selectedTheme
        
        return Configuration(elements: ElementOptions(havingAccessLevel: showElementsWithAccessLevel, showMembersWithAccessLevel: showMembersWithAccessLevel, showNestedTypes: showNestedTypes, showGenerics: showGenerics, showExtensions: extensionVisualization, showMemberAccessLevelAttribute: true, exclude: nil), hideShowCommands: hideShowCommands, theme: selectedTheme)
    }
}
