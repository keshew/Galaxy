import SwiftUI

struct GalaxyLoadingView: View {
    @StateObject var galaxyLoadingModel =  GalaxyLoadingViewModel()
    @ObservedObject var audioManager = SoundManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.loadingBack)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text(galaxyLoadingModel.currentText)
                        .Sans(size: 32)
                        .padding(.bottom)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 277, height: 18)
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(red: 151/255, green: 26/255, blue: 192/255),
                                            lineWidth: 2)
                            }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 151/255, green: 26/255, blue: 192/255))
                            .frame(width: galaxyLoadingModel.width, height: 18)
                    }
                }
                .padding(.bottom)
            }
            .onAppear() {
                galaxyLoadingModel.increaseWidth()
                galaxyLoadingModel.startTimer()
                audioManager.playBackgroundMusic()
            }
            
            .fullScreenCover(isPresented: $galaxyLoadingModel.isAnimationDone) {
                GalaxyMenuView()
            }
        }
    }
}

#Preview {
    GalaxyLoadingView()
}

