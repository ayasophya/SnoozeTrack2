import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    Image("sleepBG")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    VStack {
                        Image(systemName: "zzz")
                            .imageScale(.large)
                            .foregroundColor(.purple)
                            .padding()

                        Text("SnoozeTrack")
                            .font(.system(size: 36))
                            .font(.title)
                            .foregroundColor(.white)

                        Text("Welcome To SnoozeTrack!")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding()

                        NavigationLink("Next", destination: AgeAmountView())
                            .foregroundColor(.secondary)
                            .font(.system(size: 30))
                            .padding()
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            SleepEntry()
                .tabItem {
                    Label("Sleep Entry", systemImage: "moon.stars.fill")
                }

            SleepEntryListView()
                .tabItem {
                    Label("Entries", systemImage: "list.bullet.rectangle.fill")
                }

            TipsView()
                .tabItem {
                    Label("Tips", systemImage: "lightbulb.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
