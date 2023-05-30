//
//  DocumentsProgressBarView.swift
//  Progress
//
//  Created by Eda Barutçu on 30.05.2023.
//

import SwiftUI


struct DocumentsProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsProgressBarView()
    }
}


struct DocumentsProgressBarView: View {
    @State var progressValue: Float = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    VStack(alignment: .center) {
                        ProgressBar(progress: $progressValue)
                            .frame(width: 150.0, height: 150.0)
                            .padding(20.0)
                        
                        VStack(spacing: 25) {
                            if progressValue >= 1 {
                                Text("Kaydedildi")
                                    .font(.custom("Inter-Regular", size: 18))
                                    .foregroundColor(Color(uiColor: hexStringToUIColor(hex: "#000000"))).opacity( 0.28)
                                
                                Text("Harcama Detayına git")
                                    .font(.custom("Inter-SemiBold", size: 19))                                .foregroundColor(Color(uiColor: hexStringToUIColor(hex: "#696969")))
                            } else {
                                Text("İşleniyor")
                                    .font(.custom("Inter-Regular", size: 17))
                                    .foregroundColor(Color(uiColor: hexStringToUIColor(hex: "#696969")))
                            }
                        }
                    }
                    .frame(minHeight: 600)
                    Spacer()
                }
                .background(Color(uiColor: hexStringToUIColor(hex: "#F6F6F6")))
                .cornerRadius(30)
                .padding([.leading, .trailing], 20)
                
                Spacer()
            }
            .background(Color(uiColor: hexStringToUIColor(hex: "#EFEFEF")))
            
        }
        .navigationViewStyle(.stack)
        
    }
    
    func incrementProgress() {
        let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
        self.progressValue += randomValue
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    @State private var isComplete: Bool = false
    var body: some View {
        ZStack {
            
            
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color(uiColor: hexStringToUIColor(hex: "#DFDFDF")))
            
            if progress >= 1.0 {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color(uiColor: hexStringToUIColor(hex: "#00A507")))
            } else {
                Circle()
                    .trim(from: 0.0, to: isComplete ? 1.0 : CGFloat(min(self.progress, 1.0)))
                    .stroke(isComplete ? Color.green : Color.orange, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(Angle(degrees:270.0))
                    .animation(.linear, value: 1)
            }
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
                .opacity(progress >= 1.0 ? 0.0 : 1.0)
                .foregroundColor(isComplete ? .green : .black)
                .animation(.none, value: 1)
            
        }
        Button(action: {
            if progress >= 1 {
                progress = 0
                isComplete = false
                startProgress()
            } else {
                startProgress()
            }
        }) {
            Text("Başlat")
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    func startProgress() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.progress += 0.01
            
            if self.progress >= 1.0 {
                self.isComplete = true
                timer.invalidate()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}
