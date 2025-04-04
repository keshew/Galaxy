import SwiftUI

class GalaxyGameViewModel: ObservableObject {
    let contact = GalaxyGameModel()
    func createGameScene(gameData: GameData, level: Int) -> GameSpriteKit {
        let scene = GameSpriteKit(level: level)
        scene.game  = gameData
        return scene
    }
}
