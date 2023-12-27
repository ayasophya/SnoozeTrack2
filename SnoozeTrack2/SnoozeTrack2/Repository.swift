import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class Repository: ObservableObject {
    
    static var shared = Repository()
    
    @Published var list: [Entry] = []
    private let path = "entries"
    private let store = Firestore.firestore()
    
    init() {
        get()
    }
    
    func get() {
        store.collection(path).addSnapshotListener { snapshot, error in
            if let error = error {
                print(error)
                return
            }
                        
            self.list = snapshot?.documents.compactMap {
                try? $0.data(as: Entry.self)
            } ?? []
        }
    }
    
    func add(_ entry: Entry, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try store.collection(path).addDocument(from: entry, completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete(_ entry: Entry, completion: @escaping (Result<Void, Error>) -> Void) {
        if let entryID = entry.id {
            store.collection(path).document(entryID).delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } else {
            completion(.failure(YourError.invalidEntry))
        }
    }
    
    func edit(_ entry: Entry, completion: @escaping (Result<Void, Error>) -> Void) {
        if let entryID = entry.id {
            do {
                try store.collection(path).document(entryID).setData(from: entry, merge: true, completion: { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                })
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(YourError.invalidEntry))
        }
    }
}

enum YourError: Error {
    case invalidEntry
}
