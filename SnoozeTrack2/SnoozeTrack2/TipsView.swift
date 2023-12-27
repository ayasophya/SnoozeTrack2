import SwiftUI

struct TipsView: View {
    var body: some View {
        ZStack {
            Image("Bg1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Text("Sleep Tips")
                    .font(.system(size: 36, weight: .light, design: .serif))
                    .foregroundColor(.white)
                    .padding()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        TipCard(title: "Be Consistent", description: "Go to bed and get up at the same time every day, even on weekends.", imageName: "clock")
                        TipCard(title: "Create a Relaxing Environment", description: "Ensure your bedroom is quiet, dark, relaxing, and at a comfortable temperature.", imageName: "moon.stars.fill")
                        TipCard(title: "Limit Electronic Devices", description: "Remove TVs, computers, and smartphones from the bedroom.", imageName: "bed.double.fill")
                        TipCard(title: "Watch Your Diet", description: "Avoid large meals, caffeine, and alcohol before bedtime.", imageName: "leaf.arrow.circlepath")
                        TipCard(title: "Get Moving", description: "Stay physically active during the day to help you fall asleep more easily at night.", imageName: "figure.walk")
                    }
                    .padding()
                }
            }
            .navigationTitle("Sleep Tips")
        }
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}


struct TipCard: View {
    var title: String
    var description: String
    var imageName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)

            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            Text(description)
                .font(.body)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(10)
    }
}

