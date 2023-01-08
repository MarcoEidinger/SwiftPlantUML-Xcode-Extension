import Foundation

public extension Bool {
    func toString() -> String {
        self == true ? "true" : "false"
    }
}

public extension UserDefaults {
    static let swiftplantumlapp = UserDefaults(suiteName: "group.6V66CC3AN6.us.eidinger.SwiftPlantUML")!

    static func printKeyValues(group _: UserDefaults) {
        for (key, value) in UserDefaults.swiftplantumlapp.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
    }
}

@propertyWrapper struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.swiftplantumlapp.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.swiftplantumlapp.set(newValue, forKey: key)
        }
    }
}

// MARK: Settings

public enum UserDefaultsKeys {
    public enum SettingsKeys: String, CaseIterable {
        case theme
        case showGenerics
        case showNestedTypes
        case showExtensionsValue
        case showEmptyMembers
        case showMembersWithAccessLevelOpen
        case showMembersWithAccessLevelPublic
        case showMembersWithAccessLevelInternal
        case showMembersWithAccessLevelPrivate
        case showElementsWithAccessLevelOpen
        case showElementsWithAccessLevelPublic
        case showElementsWithAccessLevelInternal
        case showElementsWithAccessLevelPrivate

        var key: String {
            "us.eidinger.SwiftPlantUML." + rawValue
        }
    }
}
