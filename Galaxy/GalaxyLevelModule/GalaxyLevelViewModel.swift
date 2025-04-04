import SwiftUI

class GalaxyLevelViewModel: ObservableObject {
    let contact = GalaxyLevelModel()
    @Published var isGame = false
    @Published var level = 0
}
