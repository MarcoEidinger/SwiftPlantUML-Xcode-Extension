import Cocoa
import SwiftUI

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = NSHostingView(rootView: ContentView().environmentObject(ContentViewModel()))
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(swiftUIView)
        swiftUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        swiftUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
