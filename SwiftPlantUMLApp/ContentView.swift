import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Logo")
            Text("Go to System Settings - > Extensions -> Xcode Source Editor to enable this extension").frame(maxWidth: 200, alignment: .center).foregroundColor(.white).padding()
        }
        .frame(width: 300, height: 300, alignment: .center)
        .background(Color(red: 17 / 255, green: 69 / 255, blue: 255 / 255)
        )
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
