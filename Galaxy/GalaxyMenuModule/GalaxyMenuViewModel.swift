import SwiftUI

class GalaxyMenuViewModel: ObservableObject {
    let contact = GalaxyMenuModel()
    @Published var isRules = false
    @Published var isPlay = false
    @Published var isShop = false
    @Published var isRecords = false
    @Published var isSettings = false
    @Published var isSound = true
    @Published var isMusic = true
    
 
}
