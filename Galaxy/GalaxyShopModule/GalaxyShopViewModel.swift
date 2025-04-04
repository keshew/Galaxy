import SwiftUI

class GalaxyShopViewModel: ObservableObject {
    let contact = GalaxyShopModel()
    @Published var currentIndex = 0
    @Published var dragOffset: CGFloat = 0
    var ud = UserDefaultsManager()
    @Published var tables: [TableModel]?
    @Published var balls: [BallModel]?
    
    init() {
        loadBalls()
        loadTable()
    }
    
    func loadTable() {
        tables = ud.loadDesk()
    }
    
    func loadBalls() {
        balls = ud.loadBalls()
    }
}
