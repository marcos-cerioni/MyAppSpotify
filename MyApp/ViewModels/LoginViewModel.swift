//
//  LoginViewModel.swift
//  MyApp
//
//  Created by Marcos Cerioni on 12/12/2021.
//

import Foundation
import CoreData

class LoginViewModel: UIViewController {
    let model: Registered = Registered()
    var validUser = Bool()
    var errorNumber = [Int()]
    
    func buttonLoginTouch(userTF: UITextField, passTF: UITextField) {

        errorNumber.removeAll()
        
        guard let user = userTF.text, let pass = passTF.text else { return }
        if model.user1.user == user, model.user1.pass == pass {
            self.validUser = true
        } else if RegisterViewController.checkMail(mailInput: user) && !pass.isEmpty {
            errorNumber.append(1)
        } else {
            if !RegisterViewController.checkMail(mailInput: user) {
                errorNumber.append(2)
            }
            if pass.isEmpty {
                errorNumber.append(3)
            }
        }
    }
    
}
