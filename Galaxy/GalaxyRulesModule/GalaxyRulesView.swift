import SwiftUI

struct GalaxyRulesView: View {
    @StateObject var galaxyRulesModel =  GalaxyRulesViewModel()
    @Binding var isShow: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black)
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                isShow = false
                            }) {
                                Image(.back)
                                    .resizable()
                                    .frame(width: 87, height: 100)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading)
                        .offset(y: 16)
                        
                        Spacer(minLength: 55)
                        
                        Text("Rules")
                            .Sans(size: 44)
                        
                        ZStack {
                            Image(.rulesBack)
                                .resizable()
                                .frame(width: geometry.size.width, height: 473)
                            
                            Text("Pocket all your designated balls, solids or stripes, then the 8-ball to win. The game uses 15 object balls and a cue ball, with solids and stripes assigned to players. Players take turns shooting, aiming to pocket their group's balls legally. After pocketing all your balls, pocket the main to win, ensuring it's the last ball pocketed. Avoid fouls like scratching or pocketing the 8-ball early. Enjoy the game!")
                                .Sans(size: 13)
                                .frame(width: geometry.size.width * 0.7, height: 140)
                                .minimumScaleFactor(0.8)
                                .multilineTextAlignment(.center)
                        }
                        .offset(y: -30)
                    }
                }
            }
        }
    }
}

#Preview {
    GalaxyRulesView(isShow: .constant(false))
}

