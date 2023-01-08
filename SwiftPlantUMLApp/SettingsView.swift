import Foundation
import SwiftUI
import SwiftPlantUMLFramework

extension Theme {
    public static var chooseable: [String] {
        var values: [String] = []
        values.append("")
        values.append(contentsOf: Theme.preferred.map { $0.rawValue })
        return values
    }
}

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
                        HStack {
                            Spacer(minLength: 19)
                            Picker("Theme", selection: $mainState.settings.theme) {
                                ForEach(Theme.chooseable, id: \.self) {
                                    Text($0)
                                }
                            }
                            Spacer(minLength: 150)
                        }
                        HStack {
                            Spacer(minLength: 19)
                            Picker("Show extensions", selection: $mainState.settings.showExtensionsValue) {
                                Text(ExtensionVisualization.all.rawValue).tag(ExtensionVisualization.all.rawValue)
                                Text(ExtensionVisualization.merged.rawValue).tag(ExtensionVisualization.merged.rawValue)
                                Text(ExtensionVisualization.none.rawValue).tag(ExtensionVisualization.none.rawValue)
                            }
                            Spacer(minLength: 150)
                        }
                        Toggle("Show generics", isOn: $mainState.settings.showGenerics)
                        Toggle("Show nested types", isOn: $mainState.settings.showNestedTypes)
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
