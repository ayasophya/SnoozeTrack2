import SwiftUI

struct AgeAmountView: View {
    @State private var selectedAge = 18.0

    var body: some View {
        ZStack {
            Image("Bg1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                HStack {
                    Text("Start By Inputting Your Age:")
                        .font(.system(size: 36, weight: .light, design: .serif))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }

                Slider(value: $selectedAge, in: 1...70, step: 1)
                    .padding()

                Text("\(Int(selectedAge)) years old")
                    .font(.system(size: 36, weight: .light, design: .serif))
                    .foregroundColor(Color.white)
                    .padding()

                Text("Recommended Sleep: \(calculateRecommendedSleep(age: selectedAge), specifier: "%.1f") hours")
                    .font(.system(size: 24, weight: .light, design: .serif))
                    .foregroundColor(.white)
                    .padding()

                NavigationLink("Next", destination: SleepGoalView())
                    .foregroundColor(.indigo)
                    .font(.system(size: 25))
            }
            .padding()
            .navigationTitle("Age")
        }
    }

    private func calculateRecommendedSleep(age: Double) -> Double {
        switch age {
        case 1...2:
            return 14.0
        case 3...5:
            return 12.5
        case 6...12:
            return 10.0
        case 13...18:
            return 8.0
        case 19...100:
            return 7.0
        default:
            return 7.0
        }
    }
}

struct AgeAmount_Previews: PreviewProvider {
    static var previews: some View {
        AgeAmountView()
    }
}

