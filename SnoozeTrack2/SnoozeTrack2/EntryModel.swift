
import Foundation
import FirebaseFirestoreSwift

struct Entry: Identifiable, Codable {
    @DocumentID var id: String?
    var hoursSlept: Double = 0.0
    var description: String = ""
    var date: Date = Date.now
    
    init(){}
    
    init(hours: Double, desc: String, date: Date){
        self.hoursSlept = hours
        self.description = desc
        self.date = date
    }
}
