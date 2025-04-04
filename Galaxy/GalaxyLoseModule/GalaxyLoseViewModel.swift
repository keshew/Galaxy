import SwiftUI

class GalaxyLoseViewModel: ObservableObject {
    let contact = GalaxyLoseModel()
    @Published var isMenu = false
    @Published var isNext = false
}
