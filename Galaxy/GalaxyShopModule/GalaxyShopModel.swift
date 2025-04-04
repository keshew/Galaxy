import SwiftUI

struct BallModel: Hashable, Codable {
    var name: String
    var image: String
    var isAvailible: Bool
    var isSelected: Bool
}

struct TableModel: Hashable, Codable {
    var name: String
    var image: String
    var deskName: String
    var isAvailible: Bool
    var isSelected: Bool
}

struct GalaxyShopModel {
    let arrayLabel = ["Mystical", "Esoteric", "Occult", "Spiritual", "Supernatural", "Supernatural"]
    var arrayOfBalls: [BallModel] = [
        BallModel(name: "Mystical\nball", image: GalaxyImageName.ball1.rawValue, isAvailible: false, isSelected: true),
        BallModel(name: "Esoteric\nball", image: GalaxyImageName.ball2.rawValue, isAvailible: false, isSelected: false),
        BallModel(name: "Occult\nball", image: GalaxyImageName.ball3.rawValue, isAvailible: false, isSelected: false),
        BallModel(name: "Spiritual\nball", image: GalaxyImageName.ball4.rawValue, isAvailible: false, isSelected: false),
        BallModel(name: "Supernatural\nball", image: GalaxyImageName.ball5.rawValue, isAvailible: false, isSelected: false)]
    
    var arrayOfTable: [TableModel] = [
        TableModel(name: "Mystical\nDesk", image: GalaxyImageName.ball1.rawValue, deskName: "table1", isAvailible: false, isSelected: true),
        TableModel(name: "Esoteric\nDesk", image: GalaxyImageName.ball2.rawValue, deskName: "table2", isAvailible: false, isSelected: false),
        TableModel(name: "Occult\nDesk", image: GalaxyImageName.ball3.rawValue, deskName: "table3", isAvailible: false, isSelected: false),
        TableModel(name: "Spiritual\nDesk", image: GalaxyImageName.ball4.rawValue, deskName: "table4", isAvailible: false, isSelected: false),
        TableModel(name: "Supernatural\nDesk", image: GalaxyImageName.ball5.rawValue, deskName: "table5", isAvailible: false, isSelected: false)]
}


