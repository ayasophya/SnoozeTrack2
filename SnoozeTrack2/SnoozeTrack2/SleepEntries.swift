import SwiftUI

struct SleepEntry: View {
    @State private var selectedSleepAmountToday: Double = 7.0
    @State private var description: String = ""
    @State private var entries: [Entry] = []
    @State private var showAlert = false
    @StateObject private var entryVM = EntriesViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Image("Bg1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    HStack {
                        Text("How much sleep did you get last night?")
                            .font(.system(size: 36, weight: .light, design: .serif))
                            .foregroundColor(Color.white)
                            .padding()
                    }

                    Slider(value: $selectedSleepAmountToday, in: 1...15, step: 0.5)
                        .padding()

                    Text("\(selectedSleepAmountToday, specifier: "%.1f") hours")
                        .font(.system(size: 36, weight: .light, design: .serif))
                        .foregroundColor(Color.white)

                    TextField("Enter a description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300, height: 150)
                        .font(.system(size: 30))

                    Button("Submit") {
                        let date = Date()
                        let newEntry = Entry(hours: selectedSleepAmountToday, desc: description, date: date)
                        entryVM.addEntry(newEntry)
                        description = ""
                        showAlert = true
                    }
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding()

                    NavigationLink(destination: SleepEntryListView(entryVM: entryVM)) {
                        Text("View Entries")
                            .font(.title)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                .padding()
                .font(.title)
                .foregroundColor(.secondary)
                .navigationTitle("Sleep Entry")
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Entry Submitted"),
                        message: Text("Your entry has been submitted successfully!!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}

struct SleepEntry_Previews: PreviewProvider {
    static var previews: some View {
        SleepEntry()
    }
}
