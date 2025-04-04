import SwiftUI

struct GalaxyMenuView: View {
    @StateObject var galaxyMenuModel =  GalaxyMenuViewModel()
    @ObservedObject var audioManager = SoundManager.shared
    
    func getPosition(geometry: GeometryProxy) -> CGPoint {
        if geometry.size.width > 850 {
            return CGPoint(x: geometry.size.width / 1.065, y: geometry.size.height / 6)
        } else if geometry.size.width > 650 {
            return CGPoint(x: geometry.size.width / 1.08, y: geometry.size.height / 5.5)
          } else if geometry.size.width > 400 {
              return CGPoint(x: geometry.size.width / 1.18, y: geometry.size.height / 3.9)
          } else if geometry.size.width < 380 {
              return CGPoint(x: geometry.size.width / 1.19, y: geometry.size.height / 3.3)
          } else {
              return CGPoint(x: geometry.size.width / 1.18, y: geometry.size.height / 3.8)
          }
      }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.loadingBack)
                    .resizable()
                    .ignoresSafeArea()
                
                if galaxyMenuModel.isSettings {
                    VStack(spacing: 0) {
                        Button(action: {
                            audioManager.toggleSound()
                            galaxyMenuModel.isSound = audioManager.isSoundEnabled
                        }) {
                            Image(audioManager.isSoundEnabled ? .sound : .soundOff)
                                .resizable()
                                .frame(width: 74, height: 87)
                        }

                        Button(action: {
                            audioManager.toggleMusic()
                            galaxyMenuModel.isMusic = audioManager.isMusicEnabled
                        }) {
                            Image(audioManager.isMusicEnabled ? .music : .musicOff)
                                .resizable()
                                .frame(width: 74, height: 87)
                        }
                    }
                    .zIndex(1)
                    .position(getPosition(geometry: geometry))
                }
                    
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                galaxyMenuModel.isRules = true
                            }) {
                                Image(.rules)
                                    .resizable()
                                    .frame(width: 87, height: 100)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                galaxyMenuModel.isSettings.toggle()
                            }) {
                                Image(.settings)
                                    .resizable()
                                    .frame(width: 87, height: 100)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 35)
                        
                        Text("Galaclinco")
                            .Sans(size: 46)
                        
                        Spacer(minLength: 95)
                        
                        VStack(spacing: 20) {
                            HStack {
                                ZStack {
                                    Image(.backButton)
                                        .resizable()
                                        .frame(width: 159, height: 67)
                                    
                                    HStack(spacing: 0) {
                                        Image(.coin)
                                            .resizable()
                                            .frame(width: 91, height: 91)
                                        
                                        
                                        Text("Coins:\n \(UserDefaultsManager.defaults.integer(forKey: Keys.coin.rawValue))")
                                            .Sans(size: 20)
                                            .multilineTextAlignment(.center)
                                        
                                    }
                                    .offset(x: -30)
                                }
                                .frame(width: 159, height: 77)
                                
                                Spacer()
                                
                                ZStack {
                                    Image(.backButton)
                                        .resizable()
                                        .frame(width: 159, height: 67)
                                    
                                    HStack(spacing: 0) {
                                        Image(.lifes)
                                            .resizable()
                                            .frame(width: 98, height: 98)
                                        
                                        
                                        Text("Lifes:\n \(UserDefaultsManager.defaults.integer(forKey: Keys.life.rawValue))")
                                            .Sans(size: 20)
                                            .multilineTextAlignment(.center)
                                        
                                    }
                                    .offset(x: -30)
                                }
                                .frame(width: 159, height: 77)
                            }
                            .padding(.horizontal, geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 20)
                            
                            ZStack {
                                Image(.backButton)
                                    .resizable()
                                    .frame(width: 159, height: 77)
                                
                                HStack(spacing: -15) {
                                    Image(.records)
                                        .resizable()
                                        .frame(width: 96, height: 96)
                                    
                                    
                                    Text("Best score:\n\(UserDefaultsManager().getBestScore() ?? 0)")
                                        .Sans(size: 20)
                                        .multilineTextAlignment(.center)
                                }
                                .offset(x: -25)
                            }
                        }
                        
                        Spacer(minLength: 75)
                        
                        VStack(spacing: 20) {
                            Button(action: {
                                galaxyMenuModel.isPlay = true
                            }) {
                                ZStack {
                                    Image(.backButton2)
                                        .resizable()
                                        .frame(width: 250, height: 100)
                                    
                                    HStack {
                                        Image(.play)
                                            .resizable()
                                            .frame(width: 88, height: 88)
                                        
                                        Spacer()
                                        
                                        Text("Play")
                                            .Sans(size: 35)
                                            .padding(.trailing, 60)
                                    }
                                }
                                .frame(width: 250, height: 100)
                            }
                            
                            HStack(spacing: 30) {
                                Button(action: {
                                    galaxyMenuModel.isRecords = true
                                }) {
                                    ZStack {
                                        Image(.backButton2)
                                            .resizable()
                                            .frame(width: 160, height: 80)
                                        
                                        HStack(spacing: -0) {
                                            Image(.records2)
                                                .resizable()
                                                .frame(width: 64, height: 67)
                                                
                                            Text("Records")
                                                .Sans(size: 23)
                                        }
                                        .offset(x: -25)
                                    }
                                }
                                
                               
                                
                                Button(action: {
                                    galaxyMenuModel.isShop = true
                                }) {
                                    ZStack {
                                        Image(.backButton2)
                                            .resizable()
                                            .frame(width: 160, height: 80)
                                        
                                        HStack(spacing: 10) {
                                            Image(.shop)
                                                .resizable()
                                                .frame(width: 64, height: 67)
                                                
                                            Text("Shop")
                                                .Sans(size: 23)
                                        }
                                        .offset(x: -25)
                                    }
                                }
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.top)
                }
                
                if galaxyMenuModel.isRules {
                    GalaxyRulesView(isShow: $galaxyMenuModel.isRules)
                }
            }
            .fullScreenCover(isPresented: $galaxyMenuModel.isPlay) {
                GalaxyLevelView()
            }
            .fullScreenCover(isPresented: $galaxyMenuModel.isShop) {
                GalaxyShopView()
            }
            .fullScreenCover(isPresented: $galaxyMenuModel.isRecords) {
                GalaxyRecordsView()
            }
        }
    }
}

#Preview {
    GalaxyMenuView()
}

