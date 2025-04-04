import SwiftUI

struct GalaxyRecordsView: View {
    @StateObject var galaxyRecordsModel =  GalaxyRecordsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                    Image("recordsBack" + "\(galaxyRecordsModel.currentIndex + 1)")
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
                            
                            VStack {
                                Text("Best records")
                                    .Sans(size: 40)
                                
                                Text("Level \(galaxyRecordsModel.currentIndex + 1)")
                                    .Sans(size: 40)
                            }

                            Spacer(minLength: 20)
                            
                            VStack(spacing: 0) {
                                ForEach(0...5, id: \.self) { index in
                                    HStack(spacing: 30) {
                                        Image("record\(index + 1)")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        
                                        ZStack {
                                            Image(.backButton)
                                                .resizable()
                                                .frame(width: 169, height: 62)

                                            HStack(spacing: 0) {
                                                Image(.records)
                                                    .resizable()
                                                    .frame(width: 81, height: 81)
                                                
                                                Text(galaxyRecordsModel.getScoreText(index: index))
                                                    .Sans(size: 17)
                                                    .frame(width: 120)
                                                    .multilineTextAlignment(.center)
                                                    .offset(x: -12, y: 3)
                                            }
                                            .offset(x: -25)
                                        }
                                    }
                                }
                            }
                            
                            Spacer(minLength: geometry.size.width > 850 ? 210 : geometry.size.width > 650 ? 120 : 40)
                            
                            Text("Swipe left\\right to next\\prev page")
                                .Sans(size: 24)
                        }
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 50)
                        .onChanged { value in
                            galaxyRecordsModel.dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            if abs(value.translation.width) > 50 {
                                if value.translation.width > 0 {
                                    galaxyRecordsModel.currentIndex = max(0, galaxyRecordsModel.currentIndex - 1)
                                } else {
                                    galaxyRecordsModel.currentIndex = min(11, galaxyRecordsModel.currentIndex + 1)
                                }
                            }
                        }
                )
        }
    }
}

#Preview {
    GalaxyRecordsView()
}

