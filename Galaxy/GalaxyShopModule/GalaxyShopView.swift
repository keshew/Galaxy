import SwiftUI

struct GalaxyShopView: View {
    @StateObject var galaxyShopModel =  GalaxyShopViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("recordsBack" + "\(galaxyShopModel.currentIndex + 1)")
                    .resizable()
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.back2)
                                    .resizable()
                                    .frame(width: 87, height: 100)
                            }
                            .padding(.trailing)
                        }
                        
                        Text("Shop")
                            .Sans(size: 40)
                        
                        HStack(spacing: 30) {
                            ZStack {
                                Image(.backButton)
                                    .resizable()
                                    .frame(width: 159, height: 67)
                                HStack(spacing: 0) {
                                    Image(.coin)
                                        .resizable()
                                        .frame(width: 81, height: 81)
                                    
                                    
                                    Text("Coins:\n \(UserDefaultsManager.defaults.integer(forKey: Keys.coin.rawValue))")
                                        .Sans(size: 20)
                                        .multilineTextAlignment(.center)
                                    
                                }
                                .offset(x: -30)
                            }
                            .frame(width: 159, height: 77)
                            
                            ZStack {
                                Image(.backButton)
                                    .resizable()
                                    .frame(width: 159, height: 67)
                                
                                HStack(spacing: 0) {
                                    Image(.lifes)
                                        .resizable()
                                        .frame(width: 88, height: 88)
                                    
                                    
                                    Text("Lifes:\n \(UserDefaultsManager.defaults.integer(forKey: Keys.life.rawValue))")
                                        .Sans(size: 20)
                                        .multilineTextAlignment(.center)
                                    
                                }
                                .offset(x: -30)
                            }
                            .frame(width: 159, height: 77)
                        }
                        
                        Spacer(minLength: geometry.size.width > 850 ? 150 : geometry.size.width > 650 ? 120 : 30)
                        
                        if galaxyShopModel.currentIndex <= 4 {
                            VStack(spacing: 30) {
                                BallView(model: galaxyShopModel.balls?[galaxyShopModel.currentIndex] ?? BallModel(name: "", image: "", isAvailible: false, isSelected: false)) {
                                    galaxyShopModel.ud.manageShopItem(at: galaxyShopModel.currentIndex)
                                    galaxyShopModel.loadBalls()
                                }
                                
                                DescView(model: galaxyShopModel.tables?[galaxyShopModel.currentIndex] ?? TableModel(name: "", image: "", deskName: "", isAvailible: false, isSelected: false)) {
                                    galaxyShopModel.ud.manageDesk(at: galaxyShopModel.currentIndex)
                                    galaxyShopModel.loadTable()
                                }
                            }
                        } else {
                            LifeView() {
                                galaxyShopModel.ud.buyLife()
                                galaxyShopModel.loadTable()
                            }
                        }
                       
                        
                        Spacer(minLength: galaxyShopModel.currentIndex <= 4 ? geometry.size.width > 850 ? 150 : geometry.size.width > 650 ? 120 : 30 : 233)
                        
                        Text("\(galaxyShopModel.currentIndex + 1)\\6")
                            .Sans(size: 24)
                        
                        Text("Swipe left\\right to next\\prev page")
                            .Sans(size: 24)
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onChanged { value in
                        galaxyShopModel.dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        if abs(value.translation.width) > 50 {
                            if value.translation.width > 0 {
                                galaxyShopModel.currentIndex = max(0, galaxyShopModel.currentIndex - 1)
                            } else {
                                galaxyShopModel.currentIndex = min(5, galaxyShopModel.currentIndex + 1)
                            }
                        }
                    }
            )
        }
    }
}

#Preview {
    GalaxyShopView()
}

struct BallView: View {
    var model: BallModel
    var action: (() -> ())
    
    var body: some View {
        ZStack {
            Image(.backButton2)
                .resizable()
                .frame(width: 264, height: 134)
            
            VStack(spacing: 20) {
                ZStack {
                    Image(.backButton)
                        .resizable()
                        .frame(width: 128, height: 42)
                        .overlay {
                            Text(model.name)
                                .Sans(size: 15)
                                .offset(y: 3)
                                .multilineTextAlignment(.center)
                        }
                }
                
                HStack(spacing: 40) {
                    Image(model.image)
                        .resizable()
                        .frame(width: 74, height: 79)
                    
                    if model.isAvailible == false && model.isSelected == false {
                        VStack(spacing: -5) {
                            Text("Cost:")
                                .Sans(size: 24)
                            
                            HStack(spacing: -2) {
                                Text("30")
                                    .Sans(size: 24)
                                
                                Image(.coin)
                                    .resizable()
                                    .frame(width: 29, height: 29)
                            }
                            .offset(x: 12)
                        }
                    }
                }
                .offset(x: model.isAvailible == false && model.isSelected == false ? -30 : 0)
                
                Button(action: {
                    action()
                }) {
                    Image(.backButton3)
                        .resizable()
                        .frame(width: 99, height: 45)
                        .overlay {
                            Text(model.isSelected ? "Equipped" : model.isAvailible ? "Equip" : "Buy")
                                .Sans(size: model.isSelected ? 16 : 20)
                        }
                }
            }
        }
    }
}


struct DescView: View {
    var model: TableModel
    var action: (() -> ())
    
    var body: some View {
        ZStack {
            Image(.backButton2)
                .resizable()
                .frame(width: 264, height: 134)
            
            VStack(spacing: 20) {
                ZStack {
                    Image(.backButton)
                        .resizable()
                        .frame(width: 128, height: 42)
                        .overlay {
                            Text(model.name)
                                .Sans(size: 15)
                                .offset(y: 3)
                                .multilineTextAlignment(.center)
                        }
                }
                
                HStack(spacing: 0) {
                    Image(model.image)
                        .resizable()
                        .frame(width: 143, height: 53)
                    
                    if model.isAvailible == false && model.isSelected == false {
                        VStack(spacing: -5) {
                            Text("Cost:")
                                .Sans(size: 24)
                            
                            HStack(spacing: -2) {
                                Text("30")
                                    .Sans(size: 24)
                                
                                Image(.coin)
                                    .resizable()
                                    .frame(width: 29, height: 29)
                            }
                            .offset(x: 12)
                        }
                    }
                }
                .offset(x: model.isAvailible == false && model.isSelected == false ? -20 : 0)
                
                Button(action: {
                    action()
                }) {
                    Image(.backButton3)
                        .resizable()
                        .frame(width: 99, height: 45)
                        .overlay {
                            Text(model.isSelected ? "Equipped" : model.isAvailible ? "Equip" : "Buy")
                                .Sans(size: model.isSelected ? 16 : 20)
                        }
                }
            }
        }
    }
}

struct LifeView: View {
    var action: (() -> ())
    var body: some View {
        ZStack {
            Image(.backButton2)
                .resizable()
                .frame(width: 264, height: 134)
            
            VStack(spacing: 20) {
                ZStack {
                    Image(.backButton)
                        .resizable()
                        .frame(width: 128, height: 42)
                        .overlay {
                            Text("Extra\nlife")
                                .Sans(size: 15)
                                .offset(y: 3)
                                .multilineTextAlignment(.center)
                        }
                }
                
                HStack(spacing: 10) {
                    Image(.lifes)
                        .resizable()
                        .frame(width: 86, height: 86)
                    
                    Text("X1")
                        .Sans(size: 20)
                        .offset(y: 30)
                    
                    VStack(spacing: -5) {
                        Text("Cost:")
                            .Sans(size: 24)
                        
                        HStack(spacing: -2) {
                            Text("30")
                                .Sans(size: 24)
                            
                            Image(.coin)
                                .resizable()
                                .frame(width: 29, height: 29)
                        }
                        .offset(x: 12)
                    }
                }
                .offset(x: -15)
                
                Button(action: {
                    action()
                }) {
                    Image(.backButton3)
                        .resizable()
                        .frame(width: 99, height: 45)
                        .overlay {
                            Text("Buy")
                                .Sans(size: 20)
                        }
                }
            }
        }
    }
}
