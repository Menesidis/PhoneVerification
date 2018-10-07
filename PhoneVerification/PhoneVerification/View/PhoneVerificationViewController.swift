//
//  PhoneVerificationViewController.swift
//  PhoneVerification
//
//  Created by Menesidis on 01/10/2018.
//  Copyright © 2018 Menesidis. All rights reserved.
//

import UIKit

class PhoneVerificationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var responseResultsLabel: UILabel!
    
    let repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextField.delegate = self
        applyTheme()
        localize()
    }
    
    private func applyTheme(){
        view.backgroundColor = UIColor.darkGray
        phoneNumberLabel.textColor = UIColor.white
        phoneNumberLabel.numberOfLines = 0
        phoneNumberTextField.textColor = UIColor.white
        responseLabel.textColor = UIColor.white
        responseLabel.textColor = UIColor.white
        responseResultsLabel.numberOfLines = 0 
    }
    
    private func localize() {
        phoneNumberLabel.text = "Please enter the phone you wish to find detailed information"
        phoneNumberTextField.placeholder = "Phone number"
        responseLabel.text = "Result :"
        responseResultsLabel.text = "N/A"
    }

    /*
     1. Fetch network calls from : https://pro.whitepages.com/developer/documentation/reverse-phone-api/
     2. Inject country code
     3. Add Reactor Kit
     4. Add RXSwift
     5. Add Firebase
     6. Add Fastlane
     
     */
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let phone = textField.text, phone.count > 4 {
            repository.fetchPersonData(phone: phone, success: { record in
                
                let responseResultsValue = "Record phone: \(record.phoneNumber) \n carrier: \(record.carrier) \n countryCallingCode: \(record.countryCallingCode    ) \n carrier type: \(record.carrier)"
                DispatchQueue.main.async {
                    self.responseResultsLabel.text = responseResultsValue
                }
            }) { error in
                print("An error occured!")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

