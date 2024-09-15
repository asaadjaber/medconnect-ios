//
//  ProceduresViewModel.swift
//  medconnect-app
//
//  Created by Asaad Jaber on 15/09/2024.
//

import Foundation

class ProceduresViewModel {
    @Published var procedureCards: [ProcedureCard] = []
    
    func fetchProcedureCards() {
        MockGraphQLService.shared.fetchProcedureCards { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self?.procedureCards = cards
                case .failure(let error):
                    print("Failed to fetch procedure cards: \(error)")
                    // Handle error (e.g., show an alert to the user)
                }
            }
        }
    }
}
