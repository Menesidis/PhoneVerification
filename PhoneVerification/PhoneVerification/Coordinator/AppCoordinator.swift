//
//  AppCoordinator.swift
//  PhoneVerification
//
//  Created by Menesidis on 02/10/2018.
//  Copyright © 2018 Menesidis. All rights reserved.
//

import Foundation
import UIKit

public class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }

    func start() {
        let phoneVerificationViewController = PhoneVerificationViewController(nibName: "PhoneVerificationViewController", bundle: nil)
        self.navigationController.pushViewController(phoneVerificationViewController, animated: true)
    }
}
