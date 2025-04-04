import SwiftUI

class GalaxyWinViewModel: ObservableObject {
    let contact = GalaxyWinModel()
    @Published var isMenu = false
    @Published var isNext = false
}
