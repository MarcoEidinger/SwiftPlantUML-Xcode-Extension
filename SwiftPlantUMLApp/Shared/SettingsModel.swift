import Foundation

struct SettingsModel {
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.theme.key, defaultValue: "")
    var theme: String
    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showGenerics.key, defaultValue: true)
    var showGenerics: Bool
    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showNestedTypes.key, defaultValue: true)
    var showNestedTypes: Bool
    
    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showExtensionsValue.key, defaultValue: "all")
    var showExtensionsValue: String

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showEmptyMembers.key, defaultValue: true)
    var showEmptyMembers: Bool

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelOpen.key, defaultValue: true)
    var showMembersWithAccessLevelOpen

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelPublic.key, defaultValue: true)
    var showMembersWithAccessLevelPublic

    @UserDefaultsWrapper(UserDefaultsKeys.SettingsKeys.showMembersWithAccessLevelInternal.key, defaultValue: true)
    var showMembersWithAccessLevelInternal

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

    mutating func resetDefaults() {
        theme = ""
        showGenerics = true
        showNestedTypes = true
        showExtensionsValue = "all"
        showEmptyMembers = true
        showMembersWithAccessLevelOpen = true
        showMembersWithAccessLevelPublic = true
        showMembersWithAccessLevelInternal = true
        showMembersWithAccessLevelPrivate = true
        showElementsWithAccessLevelOpen = true
        showElementsWithAccessLevelPublic = true
        showElementsWithAccessLevelInternal = true
        showElementsWithAccessLevelPrivate = true
    }
}
