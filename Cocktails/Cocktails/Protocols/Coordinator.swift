//
//  Coordinator.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
