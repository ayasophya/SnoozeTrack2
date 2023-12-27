import SwiftUI

struct SleepEntryListView: View {
    @StateObject var entryVM = EntriesViewModel()
    @State private var selectedAge = 18.0

    var body: some View {
        NavigationView {
            ZStack {
                Image("Bg1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.8)

                VStack {
                    Text("Your Sleep Entries")
                        .font(.system(size: 36, weight: .light, design: .serif))
                        .foregroundColor(.secondary)
                        .padding()

                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Average Sleep Duration:")
                                .font(.system(size: 36, weight: .light, design: .serif))
                                .foregroundColor(.secondary)
                            Text("\(entryVM.averageSleepDuration, specifier: "%.1f") hours")
                                .font(.title)
                                .foregroundColor(.red)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recommended Sleep Duration:")
                                .font(.system(size: 36, weight: .light, design: .serif))
                                .foregroundColor(.secondary)
                            Text("\(calculateRecommendedSleep(), specifier: "%.1f") hours")
                                .font(.title)
                                .foregroundColor(.green)
                        }

                        List(entryVM.entriesList) { entry in
                            NavigationLink(destination: EntryComponent(entry: entry, entryVM: entryVM, selectedAge: $selectedAge)) {
                                Text("\(entry.date, style: .date)")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.white.opacity(0.9))
                                            .shadow(radius: 2)
                                    )
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            .foregroundColor(Color.black.opacity(0.5))
                            .shadow(radius: 5)
                    )
                    .foregroundColor(.white)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }

    private func calculateRecommendedSleep() -> Double {
        switch selectedAge {
        case 13...18:
            return 8.0
        case 19...64:
            return 7.0
        case 65...:
            return 8.0
        default:
            return 7.0
        }
    }
}

struct EntryComponent: View {
    var entry: Entry
    @ObservedObject var entryVM: EntriesViewModel
    @Binding var selectedAge: Double
    @State private var isShowingDeleteAlert = false
    @State private var isShowingEditSheet = false

    var body: some View {
        ZStack {
            Image("Bg1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .opacity(0.8)

            VStack(alignment: .leading, spacing: 16) {
                Text("Date: \(entry.date, style: .date)")
                    .font(.headline)
                    .foregroundColor(.black)

                Text("Hours Slept: \(entry.hoursSlept, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(.black)

                Text("Description: \(entry.description)")
                    .font(.subheadline)
                    .foregroundColor(.black)

                HStack(spacing: 16) {
                    Button(action: {
                        isShowingEditSheet = true
                    }) {
                        Text("Edit")
                            .foregroundColor(.blue)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $isShowingEditSheet) {
                        EditEntryView(entry: entry, entryVM: entryVM)
                    }

                    Button(action: {
                        isShowingDeleteAlert = true
                    }) {
                        Text("Delete")
                            .foregroundColor(.red)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
                            .foregroundColor(.black)
                    }
                    .alert(isPresented: $isShowingDeleteAlert) {
                        Alert(
                            title: Text("Delete Entry"),
                            message: Text("Are you sure you want to delete this entry?"),
                            primaryButton: .destructive(Text("Delete")) {
                                entryVM.deleteEntry(entry)
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.1), lineWidth: 1))
        }
        .navigationTitle("\(entry.date, style: .date)")
    }

    
}
struct EditEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var entryVM: EntriesViewModel
    @State private var editedEntry: Entry

    init(entry: Entry, entryVM: EntriesViewModel) {
        self.entryVM = entryVM
        self._editedEntry = State(initialValue: entry)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Image("Bg1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.8)

                Form {
                    Section(header: Text("Edit Entry").foregroundColor(.black)) {
                        DatePicker("Date", selection: $editedEntry.date, displayedComponents: .date)
                            .foregroundColor(.black)

                        Stepper(value: $editedEntry.hoursSlept, in: 1...15, step: 0.5) {
                            Text("Hours Slept: \(String(format: "%.1f", editedEntry.hoursSlept))")
                                .foregroundColor(.black)
                        }

                        TextField("Description", text: $editedEntry.description)
                            .foregroundColor(.black)
                    }
                    .foregroundColor(.black)
                }
                .navigationBarTitle("Edit Entry", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button("Save") {
                        entryVM.editEntry(editedEntry)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    .foregroundColor(.black)
                )
            }
        }
    }
}
