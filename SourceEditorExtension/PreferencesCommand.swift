import AppKit
import XcodeKit

class PreferencesCommand: NSObject, XCSourceEditorCommand {
    func perform(with _: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        NSWorkspace.shared.open(URL(string: "swiftplantumlapp://preferences")!)
        completionHandler(nil)
    }
}
