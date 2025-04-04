import SwiftUI

@main
struct GalaxyApp: App {
    var body: some Scene {
        WindowGroup {
            GalaxyLoadingView()
                .onAppear {
                    UserDefaultsManager().firstLaunch()
                }
        }
    }
}
