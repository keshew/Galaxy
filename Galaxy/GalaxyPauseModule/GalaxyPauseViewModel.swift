import SwiftUI

class GalaxyPauseViewModel: ObservableObject {
    let contact = GalaxyPauseModel()
    @Published var isMenu = false
}
