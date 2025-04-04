import SwiftUI
import SpriteKit

struct GalaxyPauseView: View {
    @StateObject var galaxyPauseModel =  GalaxyPauseViewModel()
    var game: GameData
    var scene: SKScene
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black)
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Spacer()
                            
                            VStack(spacing: -13) {
                                ZStack {
                                    Image(.backButton)
                                        .resizable()
                                        .frame(width: 125, height: 60)
                                    
                                    HStack(spacing: 0) {
                                        Image(.coin)
                                            .resizable()
                                            .frame(width: 71, height: 71)
                                        
                                        
                                        Text("Coins:\n \(UserDefaultsManager.defaults.integer(forKey: Keys.coin.rawValue))")
                                            .Sans(size: 20)
                                            .multilineTextAlignment(.center)
                                        
                                    }
                                    .offset(x: -25)
                                }
                                .frame(width: 159, height: 77)
                                
                                ZStack {
                                    Image(.backButton)
                                        .resizable()
                                        .frame(width: 125, height: 60)
                                    
                                    HStack(spacing: 0) {
                                        Image(.lifes)
                                            .resizable()
                                            .frame(width: 77, height: 77)
                                        
                                        
                                        Text("Lifes:\n \(UserDefaultsManager.defaults.integer(forKey: Keys.life.rawValue))")
                                            .Sans(size: 20)
                                            .multilineTextAlignment(.center)
                                        
                                    }
                                    .offset(x: -30)
                                }
                                .frame(width: 159, height: 77)
                            }
                        }
                        .offset(y: -5)
                        
                        Spacer(minLength: 55)
                        
                        Text("Pause")
                            .Sans(size: 44)
                        
                        ZStack {
                            Image(.rulesBack)
                                .resizable()
                                .frame(width: geometry.size.width, height: 473)
                            
                            Text("Take a moment to relax and strategize. Allow yourself the space to breathe deeply and reflect on your goals. This pause is an opportunity to recharge, gain clarity, and prepare for the next steps.")
                                .Sans(size: 13, width: 0.3)
                                .frame(width: geometry.size.width * 0.7, height: 140)
                                .minimumScaleFactor(0.8)
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 40) {
                                Button(action: {
                                    galaxyPauseModel.isMenu = true
                                }) {
                                    Image(.backButton4)
                                        .resizable()
                                        .frame(width: 131, height: 80)
                                        .overlay {
                                            Text("Menu")
                                                .Sans(size: 20)
                                        }
                                }
                                
                                Button(action: {
                                    game.isPause = false
                                    scene.isPaused = false
                                }) {
                                    Image(.backButton4)
                                        .resizable()
                                        .frame(width: 131, height: 80)
                                        .overlay {
                                            Text("Continue")
                                                .Sans(size: 20)
                                        }
                                }
                            }
                            .offset(y: 110)
                        }
                        .offset(y: -50)
                    }
                }
            }
            .fullScreenCover(isPresented: $galaxyPauseModel.isMenu) {
                GalaxyMenuView()
            }
        }
    }
}

#Preview {
    let gameData = GameData()
    let scene = SKScene()
    return GalaxyPauseView(game: gameData, scene: scene)
}

