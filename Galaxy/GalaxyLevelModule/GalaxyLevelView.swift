import SwiftUI

struct GalaxyLevelView: View {
    @StateObject var galaxyLevelModel =  GalaxyLevelViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var level = UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(level <= 4 ? .levelBack1 : (level <= 8 ? .levelBack3 : .levelBack2))
                    .resizable()
                    .ignoresSafeArea()
                    
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(.back)
                        .resizable()
                        .frame(width: 87, height: 100)
                }
                .position(x: geometry.size.width / 7.45, y: geometry.size.height / 19.15)
                .zIndex(1)
                
                Text("LEVELS")
                    .Sans(size: 44)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 6)
                    .zIndex(1)
                
                ScrollView(showsIndicators: false) {
                    if level > 0, level <= 4 {
                        VStack {
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 1
                            }) {
                                Image(level >= 1 ? .level1 : .levelLocked1)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .position(x: geometry.size.width / 4, y: geometry.size.height / 3)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 2
                            }) {
                                Image(level >= 2 ? .level2: .levelLocked2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / 4)
                            .disabled(level < 2 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 3
                            }) {
                                Image(level >= 3 ? .level3 : .levelLocked3)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 3.4, y: geometry.size.height / 5)
                            .disabled(level < 3 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 4
                            }) {
                                Image(level >= 4 ? .level4 : .levelLocked4)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / 5)
                            .disabled(level < 4 ? true : false)
                        }
                    } else if level >= 5, level <= 8 {
                        VStack {
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 2
                            }) {
                                Image(level >= 2 ? .level2 : .levelLocked2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height * -0.01)
                            .disabled(level < 2 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 3
                            }) {
                                Image(level >= 3 ? .level3 : .levelLocked3)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 4.1, y: geometry.size.height / -21)
                            .disabled(level < 3 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 4
                            }) {
                                Image(level >= 4 ? .level4 : .levelLocked4)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / -8)
                            .disabled(level < 4 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 5
                            }) {
                                Image(level >= 5 ? .level5 : .levelLocked5)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 290 : geometry.size.width > 650 ? 200 : 140, height: geometry.size.width > 850 ? 290 : geometry.size.width > 650 ? 200 : 140)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 4.1, y: geometry.size.height / -5)
                            .disabled(level < 5 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 6
                            }) {
                                Image(level >= 6 ? .level6 : .levelLocked6)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / -4)
                            .disabled(level < 6 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 7
                            }) {
                                Image(level >= 7 ? .level7 : .levelLocked7)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 290 : geometry.size.width > 650 ? 190 : 130, height: geometry.size.width > 850 ? 290 : geometry.size.width > 650 ? 190 : 130)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 4.1, y: geometry.size.height / -3.5)
                            .disabled(level < 7 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 8
                            }) {
                                Image(level >= 8 ? .level8 : .levelLocked8)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 150, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 150)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / -2.9)
                            .disabled(level < 8 ? true : false)
                        }
                    } else {
                        VStack {
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 7
                            }) {
                                Image(level >= 7 ? .level7 : .levelLocked7)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 150, height: geometry.size.width > 850 ? 310 : geometry.size.width > 650 ? 220 : 150)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 4.1, y: geometry.size.height / 11)
                            .disabled(level < 7 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 8
                            }) {
                                Image(level >= 8 ? .level8 : .levelLocked8)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 150,
                                           height: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 150)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / 24)
                            .disabled(level < 8 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 9
                            }) {
                                Image(level >= 9 ? .level9 : .levelLocked9)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 240 : geometry.size.width > 650 ? 210 : 140, height: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 140)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 4.1, y: geometry.size.height / -29)
                            .disabled(level < 9 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 10
                            }) {
                                Image(level >= 10 ? .level10 : .levelLocked10)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / -15)
                            .disabled(level < 10 ? true : false)
                            
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 11
                            }) {
                                Image(level >= 11 ? .level11 : .levelLocked11)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 160, height: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 160)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 4.1, y: geometry.size.height / -8.5)
                            .disabled(level < 11 ? true : false)
                            Button(action: {
                                galaxyLevelModel.isGame = true
                                galaxyLevelModel.level = 112
                            }) {
                                Image(level >= 12 ? .level12 : .levelLocked12)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 150, height: geometry.size.width > 850 ? 250 : geometry.size.width > 650 ? 220 : 150)
                                    .clipped()
                            }
                            .clipped()
                            .position(x: geometry.size.width / 1.4, y: geometry.size.height / -5.9)
                            .disabled(level < 12 ? true : false)
                        }
                    }
                }
                .scrollDisabled(true)
            }
            .fullScreenCover(isPresented: $galaxyLevelModel.isGame) {
                GalaxyGameView(level: galaxyLevelModel.level)
            }
        }
    }
}

#Preview {
    GalaxyLevelView()
}

