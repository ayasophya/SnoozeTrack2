

import Foundation
import SwiftUI
import Combine

class EntriesViewModel: ObservableObject {
    @Published var entriesList = [Entry]()
    @Published var entriesRepo = Repository.shared
    private var cancellables: Set<AnyCancellable> = []

    init() {
        self.entriesRepo.$list
            .assign(to: \.entriesList, on: self)
            .store(in: &cancellables)
    }
    
    var averageSleepDuration: Double {
            let totalSleep = entriesList.reduce(0.0) { $0 + $1.hoursSlept }
            let count = Double(entriesList.count)
            return count > 0 ? totalSleep / count : 0.0
        }

    func getEntry(entryId: Entry.ID) -> Entry {
        return entriesList.filter { entryId == $0.id }.first!
    }

    func addEntry(_ entry: Entry) {
        entriesRepo.add(entry) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("Failed to add entry: \(error.localizedDescription)")
            }
        }
    }
    func deleteEntry(_ entry: Entry) {
        entriesRepo.delete(entry) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("Failed to delete entry: \(error.localizedDescription)")
            }
        }
    }
    func editEntry(_ entry: Entry) {
            entriesRepo.edit(entry) { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print("Failed to edit entry: \(error.localizedDescription)")
                }
            }
        }
    }
    
