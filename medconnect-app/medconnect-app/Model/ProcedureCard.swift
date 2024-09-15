import Foundation

// MARK: - Data Model

struct ProcedureCard: Codable {
    let id: String
    let imageName: String
    let price: Int
    let procedures: [String]
}
