import SwiftUI

struct GalaxyLoseView: View {
    @StateObject var galaxyLoseModel =  GalaxyLoseViewModel()
    @ObservedObject var audioManager = SoundManager.shared
    var level: Int
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
                        
                        Text("GAME OVER")
                            .Sans(size: 44)
                        
                        ZStack {
                            Image(.rulesBack)
                                .resizable()
                                .frame(width: geometry.size.width, height: 473)
                            
                            VStack {
                                Text("Nice try!")
                                    .Sans(size: 28)
                                
                                HStack(spacing: 0) {
                                    Text("You lose coins:-30")
                                        .Sans(size: 28)
                                    
                                    Image(.coin)
                                        .resizable()
                                        .frame(width: 34, height: 33)
                                }
                                
                                HStack(spacing: 0) {
                                    Text("You lose life:-1")
                                        .Sans(size: 28)
                                    
                                    Image(.lifes)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .offset(y: -3)
                                }
                            }
                            
                            HStack(spacing: 40) {
                                Button(action: {
                                    galaxyLoseModel.isMenu = true
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
                                    galaxyLoseModel.isNext = true
                                }) {
                                    Image(.backButton4)
                                        .resizable()
                                        .frame(width: 131, height: 80)
                                        .overlay {
                                            Text("Retry")
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
            .onAppear {
                audioManager.stopBackgroundMusic()
                audioManager.playLoseMusic()
            }
            .onDisappear {
                audioManager.stopLoseMusic()
                audioManager.playBackgroundMusic()
            }
            
            .fullScreenCover(isPresented: $galaxyLoseModel.isMenu) {
                GalaxyMenuView()
            }
            .fullScreenCover(isPresented: $galaxyLoseModel.isNext) {
                GalaxyGameView(level: level)
            }
        }
    }
}

#Preview {
    GalaxyLoseView(level: 1)
}

