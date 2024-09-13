import Foundation

// MARK: - Data Model

struct ProcedureCard: Codable {
    let id: String
    let imageName: String
    let price: Int
    let procedures: [String]
}

// MARK: - GraphQL Query

struct GraphQLQuery: Codable {
    let query: String
}

// MARK: - GraphQL Response

struct GraphQLResponse: Codable {
    let data: GraphQLData
}

struct GraphQLData: Codable {
    let procedureCards: [ProcedureCard]
}

// MARK: - Mock GraphQL Service

class MockGraphQLService {
    static let shared = MockGraphQLService()
    
    private init() {}
    
    func fetchProcedureCards(completion: @escaping (Result<[ProcedureCard], Error>) -> Void) {
        // Simulate network delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let mockData: [ProcedureCard] = [
                ProcedureCard(id: "1", imageName: "liposuction", price: 5000, procedures: ["Liposuction", "Tummy Tuck"]),
                ProcedureCard(id: "2", imageName: "rhinoplasty", price: 7500, procedures: ["Rhinoplasty", "Chin Augmentation"]),
                ProcedureCard(id: "3", imageName: "breast_augmentation", price: 10000, procedures: ["Breast Augmentation", "Breast Lift"]),
                ProcedureCard(id: "4", imageName: "facelift", price: 12500, procedures: ["Facelift", "Neck Lift"]),
                ProcedureCard(id: "5", imageName: "blepharoplasty", price: 15000, procedures: ["Blepharoplasty", "Brow Lift"])
            ]
            
            completion(.success(mockData))
        }
    }
}

// MARK: - GraphQL Query String

extension MockGraphQLService {
    static let procedureCardsQuery = """
    query {
      procedureCards {
        id
        imageName
        price
        procedures
      }
    }
    """
}
