import SwiftUI

class GalaxyRecordsViewModel: ObservableObject {
    let contact = GalaxyRecordsModel()
    @Published var currentIndex = 0
    @Published var dragOffset: CGFloat = 0
    var ud = UserDefaultsManager()
    
    func getScoreText(index: Int) -> String {
        let scores = ud.getScoresForLevel(level: currentIndex + 1)
        
        if index < scores.count {
            return "Best score:\n\(scores[index])"
        } else {
            return "Best score:\nNo Record yet"
        }
    }
}
