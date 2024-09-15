//
//  AppCoordinator.swift
//  medconnect-app
//
//  Created by Asaad Jaber on 15/09/2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = ProceduresViewModel()
        viewModel.fetchProcedureCards()
        let viewController = ProceduresViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
