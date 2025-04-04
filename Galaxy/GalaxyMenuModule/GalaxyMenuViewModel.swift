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
    
    func getPosition(geometry: GeometryProxy) -> CGPoint {
        if geometry.size.width > 850 {
            return CGPoint(x: geometry.size.width / 1.065, y: geometry.size.height / 5.5)
        } else if geometry.size.width > 650 {
            return CGPoint(x: geometry.size.width / 1.08, y: geometry.size.height / 5.2)
          } else if geometry.size.width > 400 {
              return CGPoint(x: geometry.size.width / 1.18, y: geometry.size.height / 3.5)
          } else if geometry.size.width < 380 {
              return CGPoint(x: geometry.size.width / 1.19, y: geometry.size.height / 3)
          } else {
              return CGPoint(x: geometry.size.width / 1.18, y: geometry.size.height / 3.5)
          }
      }
}
