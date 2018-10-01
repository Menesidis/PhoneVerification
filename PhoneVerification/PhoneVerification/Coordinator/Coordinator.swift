//
//  Coordinator.swift
//  PhoneVerification
//
//  Created by Menesidis on 02/10/2018.
//  Copyright © 2018 Menesidis. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}


extension Coordinator {
    
    // Add a child coordinator to the parent
    func addChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    // Remove a child coordinator from the parent
    func removeChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
}
