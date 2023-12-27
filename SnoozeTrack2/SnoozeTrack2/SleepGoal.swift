import SwiftUI

struct SleepGoalView: View {
    @State private var selectedSleepAmount: Double = 7.0
    
    var body: some View {
        ZStack{
            Image("Bg1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                HStack {
                    Text("What is your sleep amount goal per day?")
                        .font(.system(size:36, weight: .light, design: .serif))
                        .foregroundColor(Color.white)
                }
                .padding()
                
                Slider(value: $selectedSleepAmount, in: 1...15, step: 0.5)
                    .padding()
                
                Text("\(selectedSleepAmount, specifier: "%.1f") hours")
                    .font(.system(size:36, weight: .light, design: .serif))
                
                    .foregroundColor(Color.white)
                    .padding()
                NavigationLink("Next", destination: SleepEntry())
                    .font(.system(size: 25))
            }
            .padding()
            .navigationTitle("Sleep Goal")
            
        }
    }
}
struct SleepGoal_Previews: PreviewProvider {
    static var previews: some View {
        SleepGoalView()
    }
}
