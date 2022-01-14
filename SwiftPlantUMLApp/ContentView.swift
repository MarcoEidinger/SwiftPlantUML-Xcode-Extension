import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var settings = SettingsModel()
}

struct ContentView: View {
    @EnvironmentObject private var mainState: ContentViewModel

    @State var selectedConfigurationScope: ConfigurationScope = .elements

    enum ConfigurationScope {
        case elements
        case members
        case others
    }

    var body: some View {
        HStack {
            Image("Logo")
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Step 1:")
                        Button("Open System Preferences") {
                            DispatchQueue.global().async {
                                let task = Process()
                                task.launchPath = "/usr/bin/env"
                                task.arguments = ["open", "-b", "com.apple.systempreferences", "/System/Library/PreferencePanes/Extensions.prefPane"]
                                task.launch()
                                task.waitUntilExit()
                            }
                        }
                    }.padding(5)
                    HStack {
                        Text("Step 2:")
                        Text("Enable extension in Extensions -> Xcode Source Editor").bold()
                    }.padding(5)
                    HStack {
                        Text("Step 3:")
                        Button("Set Preferences") {
                            let appDelegate = NSApplication.shared.delegate! as! AppDelegate
                            appDelegate.showPreferences(self)
                        }
                        Text("(Optional)").italic()
                    }.padding(5)
                    HStack {
                        Text("Step 4:")
                        Button("Close App") {
                            NSApplication.shared.terminate(nil)
                        }
                    }.padding(5)
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(macOS 11.0, *) {
            ForEach(ColorScheme.allCases, id: \.self, content:
                ContentView()
                    .environmentObject(ContentViewModel())
                    .preferredColorScheme)
        } else {
            ContentView().environmentObject(ContentViewModel())
        }
    }
}
