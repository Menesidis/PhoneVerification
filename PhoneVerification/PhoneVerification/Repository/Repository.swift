//
//  Repository.swift
//  PhoneVerification
//
//  Created by Menesidis on 07/10/2018.
//  Copyright © 2018 Menesidis. All rights reserved.
//

import Foundation

struct Repository {
    
    private let network = Network()
    
    func fetchPersonData(phone: String,
                         success successCallback:@escaping (Record) -> Void,
                         error errorCallback: @escaping (Swift.Error) -> Void){
        
        
        network.fetchPersonData(phone: phone, success: { record in
            successCallback(record)
        }) { error in
            errorCallback(error)
        }
    }
}
