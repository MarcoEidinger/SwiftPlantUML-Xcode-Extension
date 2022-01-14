import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var mainState: ContentViewModel

    @State var selectedConfigurationScope: ConfigurationScope = .elements

    enum ConfigurationScope {
        case elements
        case members
        case others
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Choose what should be rendered by SwiftPlantUML")
                if #available(macOS 11.0, *) {
                    Button {
                        mainState.settings.resetDefaults()
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }
                } else {
                    Button("Reset") {
                        mainState.settings.resetDefaults()
                    }
                }
            }
            Text("")
            Picker("", selection: $selectedConfigurationScope) {
                Text("Elements").tag(ConfigurationScope.elements)
                Text("Members").tag(ConfigurationScope.members)
                Text("Others").tag(ConfigurationScope.others)
            }
            .pickerStyle(.segmented)

            VStack(alignment: .leading) {
                if selectedConfigurationScope == .elements {
                    VStack {
                        Text("having access level")
                        VStack(alignment: .leading) {
                            Toggle("Open", isOn: $mainState.settings.showElementsWithAccessLevelOpen)
                            Toggle("Public", isOn: $mainState.settings.showElementsWithAccessLevelPublic)
                            Toggle("Internal", isOn: $mainState.settings.showElementsWithAccessLevelPrivate)
                            Toggle("Private", isOn: $mainState.settings.showElementsWithAccessLevelInternal)
                        }
                    }
                    Toggle("with no members", isOn: $mainState.settings.showEmptyMembers)
                }
                if selectedConfigurationScope == .members {
                    VStack(alignment: .leading) {
                        Text("having access level")
                        Toggle("Open", isOn: $mainState.settings.showMembersWithAccessLevelOpen)
                        Toggle("Public", isOn: $mainState.settings.showMembersWithAccessLevelPublic)
                        Toggle("Internal", isOn: $mainState.settings.showMembersWithAccessLevelInternal)
                        Toggle("Private", isOn: $mainState.settings.showMembersWithAccessLevelPrivate)
                    }
                }
                if selectedConfigurationScope == .others {
                    VStack(alignment: .leading) {
                        Toggle("Show generics", isOn: $mainState.settings.showGenerics)
                        Toggle("Show extensions", isOn: $mainState.settings.showExtensions)
                    }
                }
            }
            .frame(height: 150)
        }
        .padding()
        .frame(width: 400, height: 250)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(macOS 11.0, *) {
            ForEach(ColorScheme.allCases, id: \.self, content:
                SettingsView()
                    .environmentObject(ContentViewModel())
                    .preferredColorScheme)
        } else {
            SettingsView()
                .environmentObject(ContentViewModel())
        }
    }
}
