import Foundation
import CoreData

struct Todo: Codable {
    let id: Int
    var todo: String
    var completed: Bool
    let userId: Int
}
