import Foundation
import SwiftPlantUMLFramework

@objc class XPCService: NSObject, XPCServiceProtocol {
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showGenerics.key, defaultValue: true)
    var showGenerics: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showExtensions.key, defaultValue: true)
    var showExtensions: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showEmptyMembers.key, defaultValue: true)
    var showEmptyMembers: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelOpen.key, defaultValue: true)
    var showMembersWithAccessLevelOpen: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelPublic.key, defaultValue: true)
    var showMembersWithAccessLevelPublic: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelInternal.key, defaultValue: true)
    var showMembersWithAccessLevelInternal: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelPrivate.key, defaultValue: true)
    var showMembersWithAccessLevelPrivate: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelOpen.key, defaultValue: true)
    var showElementsWithAccessLevelOpen: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelPublic.key, defaultValue: true)
    var showElementsWithAccessLevelPublic: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelInternal.key, defaultValue: true)
    var showElementsWithAccessLevelInternal: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showElementsWithAccessLevelPrivate.key, defaultValue: true)
    var showElementsWithAccessLevelPrivate: Bool

    func generateDiagram(from content: String, completionHandler: @escaping (() -> Void)) {
        let config = Configuration(elements: ElementOptions(havingAccessLevel: showElementsWithAccessLevel(), showMembersWithAccessLevel: showMembersWithAccessLevel(), showGenerics: showGenerics, showExtensions: showExtensions, showMemberAccessLevelAttribute: true, exclude: nil), hideShowCommands: hideShowCommands())
        ClassDiagramGenerator().generate(from: content, with: config)
        completionHandler()
    }

    private func showElementsWithAccessLevel() -> [AccessLevel] {
        var showElementsWithAccessLevel: [AccessLevel] = []
        if showElementsWithAccessLevelOpen {
            showElementsWithAccessLevel.append(.open)
        }
        if showElementsWithAccessLevelPublic {
            showElementsWithAccessLevel.append(.public)
        }
        if showElementsWithAccessLevelInternal {
            showElementsWithAccessLevel.append(.internal)
        }
        if showElementsWithAccessLevelPrivate {
            showElementsWithAccessLevel.append(.private)
        }
        return showElementsWithAccessLevel
    }

    private func showMembersWithAccessLevel() -> [AccessLevel] {
        var showMembersWithAccessLevel: [AccessLevel] = []
        if showMembersWithAccessLevelOpen {
            showMembersWithAccessLevel.append(.open)
        }
        if showMembersWithAccessLevelPublic {
            showMembersWithAccessLevel.append(.public)
        }
        if showMembersWithAccessLevelInternal {
            showMembersWithAccessLevel.append(.internal)
        }
        if showMembersWithAccessLevelPrivate {
            showMembersWithAccessLevel.append(.private)
        }
        return showMembersWithAccessLevel
    }

    private func hideShowCommands() -> [String] {
        var hideShowCommands = [String]()
        if !showEmptyMembers {
            hideShowCommands.append("hide empty members")
        }
        return hideShowCommands
    }
}
