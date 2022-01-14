import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        // Insert code here to initialize your application
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(handleAppleEvent(event:replyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    func application(_: NSApplication, open _: [URL]) {
        showPreferences(self)
    }

    @objc func handleAppleEvent(event _: NSAppleEventDescriptor, replyEvent _: NSAppleEventDescriptor) {
        showPreferences(self)
    }

    @IBAction func showPreferences(_ sender: Any) {
        let settingsView = NSHostingView(rootView: SettingsView().environmentObject(ContentViewModel()))
        settingsView.translatesAutoresizingMaskIntoConstraints = false

        let controller = NSViewController()
        controller.view = settingsView

        let window = NSWindow(contentViewController: controller)
        window.title = "Preferences"

        NSWindowController(window: window).showWindow(sender)
    }

    @IBAction func showTroubleshootingHelp(_: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/MarcoEidinger/SwiftPlantUML-Xcode-Extension#troubleshooting")!)
    }

    @IBAction func showReleaseNotes(_: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/MarcoEidinger/SwiftPlantUML-Xcode-Extension/releases")!)
    }

    @IBAction func showCommandLineToolInfo(_: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/MarcoEidinger/SwiftPlantUML")!)
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}
