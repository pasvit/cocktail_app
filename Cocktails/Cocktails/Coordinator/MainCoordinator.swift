//
//  MainCoordinator.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = CocktailListViewController.instantiate()
        vc.coordinator = self
        navigationController.navigationBar.tintColor = .lightGreen
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushDetail(with cocktailVM: CocktailViewModel) {
        let vc = CocktailDetailViewController.instantiate()
        vc.coordinator = self
        vc.cocktailViewModel = cocktailVM
        navigationController.pushViewController(vc, animated: true)
    }
}
